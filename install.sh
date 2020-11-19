#!/usr/bin/env bash

###############################################################################
# Homebrew
###############################################################################

# Install Homebrew if not installed - brew.sh
if ! hash brew 2>/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

# Schedule Homebrew Updates
# This is better than HOMEBREW_AUTO_UPDATE_SECS
# Consider disabling auto-updates with
# export HOMEBREW_NO_AUTO_UPDATE=1
cron_entry='0 */6 * * * /usr/local/bin/brew update &>/dev/null'
if ! crontab -l | fgrep "$cron_entry" >/dev/null; then
  (crontab -l 2>/dev/null; echo "$cron_entry") | \
    crontab -
fi

# Install Homebrew Bundle & Cask Drivers
brew tap homebrew/bundle
brew tap homebrew/cask-drivers

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we are using the latest Homebrew
brew update

# Upgrade existing packages
brew upgrade

# Install CLI tools & GUI applications
# brew bundle --file=installers/homebrew/Brewfile

brew install git terragrunt azure-cli kubernetes-cli octant zsh iperf3 kubernetes-helm pre-commit zsh-completions bitwarden-cli helm terraform gh k9s terraform-docs wget
brew cask install firefox logitech-options plex protonvpn brave-browser db-browser-for-sqlite loupedeck plexamp steam visual-studio-code brooklyn sdformatter disk-inventory-x notion postman tunnelblick vlc bitwarden calibre figma iterm2 philips-hue-sync protonmail-unofficial typora yubico-yubikey-manager adobe-creative-cloud synology-drive

# Remove outdated versions from the cellar including casks
brew cleanup && brew prune


sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 1091189122 Bear (1.7.21)
# 1230249825 VMware Remote Console (11.2.0)
# 1295203466 Microsoft Remote Desktop (10.4.1)
# 747648890 Telegram (7.2)
# 1319778037 iStat Menus (6.51)
# 441258766 Magnet (2.5.0)