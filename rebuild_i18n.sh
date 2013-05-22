#! /bin/sh

I18NDOMAIN=$1
PACKAGEDIR=$2

DIR="$( cd -P "$( dirname "$0" )" && pwd )"
#DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DUDE=$DIR/bin/i18ndude

cd $PACKAGEDIR

# Synchronise the templates and scripts with the .pot.
# All on one line normally:
if [ -e "locales/${I18NDOMAIN}-manual.pot" ]
then
  echo "MANUAL POT PRESENT"
  $DUDE rebuild-pot --pot locales/${I18NDOMAIN}.pot \
    --merge locales/${I18NDOMAIN}-manual.pot \
    --create ${I18NDOMAIN} \
   .
else
  echo "NO MANUAL POT"
  $DUDE rebuild-pot --pot locales/${I18NDOMAIN}.pot \
    --create ${I18NDOMAIN} \
   .
fi

# Synchronise the resulting .pot with all .po files
for po in locales/*/LC_MESSAGES/${I18NDOMAIN}.po; do
    $DUDE sync --pot locales/${I18NDOMAIN}.pot $po
done
