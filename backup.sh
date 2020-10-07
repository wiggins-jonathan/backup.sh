#!/usr/bin/env bash
# This script is meant to be ran once a day to backup specific directories

base_dir=$HOME/backup

main () {
  check_deps
  backup
}

# See if rysnnc is installed otherwise error out
check_deps () {
  command -v rsync &> /dev/null || error "rsync is required for this script to run."
}

backup () {
  today=$(date +%Y-%m-%d\ %T)
  echo ":::Starting backup for "${today}":::"
  dirs_to_backup=(
    documents
    games
    music
    pictures
    video
  )
  for dir in "${dirs_to_backup[@]}"; do
    echo -e "---Backing up "${dir}" to "${base_dir}/${dir}"---"
    rsync -azv --delete "$HOME/${dir}" "${base_dir}/"
  done

  echo -e ":::Done:::\n"
}

# Common  error handling function
error () {
  printf "ERROR: $1" && exit 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi
