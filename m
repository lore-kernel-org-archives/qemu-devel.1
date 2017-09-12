Received: from eggs.gnu.org ([2001:4830:134:3::10]:51721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRF-0003sB-N0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmR9-0001lx-3g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:21 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:50 +0200
Message-Id: <20170912144459.11359-2-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/10] qemu-iotests: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This includes shell function, shell variables and command line options
(randomize.awk does not exist).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check         | 28 -----------------
 tests/qemu-iotests/common        | 23 --------------
 tests/qemu-iotests/common.config | 26 ---------------
 tests/qemu-iotests/common.rc     | 68 ----------------------------------------
 4 files changed, 145 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index d504b6e455..4a6ed67b42 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -65,7 +65,6 @@ then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
 fi
 
-# if ./qemu exists, it should be prioritized and will be chosen by common.config
 if [[ -z "$QEMU_PROG" && ! -x './qemu' ]]
 then
     arch=$(uname -m 2> /dev/null)
@@ -140,12 +139,6 @@ _timestamp()
 
 _wrapup()
 {
-    # for hangcheck ...
-    # remove files that were used by hangcheck
-    #
-    [ -f "${TEST_DIR}"/check.pid ] && rm -rf "${TEST_DIR}"/check.pid
-    [ -f "${TEST_DIR}"/check.sts ] && rm -rf "${TEST_DIR}"/check.sts
-
     if $showme
     then
         :
@@ -201,24 +194,6 @@ END        { if (NR > 0) {
 
 trap "_wrapup; exit \$status" 0 1 2 3 15
 
-# for hangcheck ...
-# Save pid of check in a well known place, so that hangcheck can be sure it
-# has the right pid (getting the pid from ps output is not reliable enough).
-#
-rm -rf "${TEST_DIR}"/check.pid
-echo $$ > "${TEST_DIR}"/check.pid
-
-# for hangcheck ...
-# Save the status of check in a well known place, so that hangcheck can be
-# sure to know where check is up to (getting test number from ps output is
-# not reliable enough since the trace stuff has been introduced).
-#
-rm -rf "${TEST_DIR}"/check.sts
-echo "preamble" > "${TEST_DIR}"/check.sts
-
-# don't leave old full output behind on a clean run
-rm -f check.full
-
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
 FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
@@ -276,9 +251,6 @@ do
         fi
         rm -f core $seq.notrun
 
-        # for hangcheck ...
-        echo "$seq" > "${TEST_DIR}"/check.sts
-
         start=`_wallclock`
         $timestamp && printf %s "        [$(date "+%T")]"
 
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index d34c11c056..867918895b 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -19,17 +19,6 @@
 # common procedures for QA scripts
 #
 
-_setenvironment()
-{
-    MSGVERB="text:action"
-    export MSGVERB
-}
-
-rm -f "$OUTPUT_DIR/$iam.out"
-_setenvironment
-
-check=${check-true}
-
 diff="diff -u"
 verbose=false
 debug=false
@@ -40,7 +29,6 @@ showme=false
 sortme=false
 expunge=true
 have_test_arg=false
-randomize=false
 cachemode=false
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
@@ -170,7 +158,6 @@ other options
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
     -T                  output timestamps
-    -r                  randomize test order
     -c mode             cache mode
 
 testlist options
@@ -327,11 +314,6 @@ testlist options
             cachemode=true
             xpand=false
             ;;
-        -r)        # randomize test order
-            randomize=true
-            xpand=false
-            ;;
-
         -T)        # turn on timestamp output
             timestamp=true
             xpand=false
@@ -445,11 +427,6 @@ fi
 list=`sort $tmp.list`
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
-if $randomize
-then
-    list=`echo $list | awk -f randomize.awk`
-fi
-
 [ "$QEMU" = "" ] && _fatal "qemu not found"
 [ "$QEMU_IMG" = "" ] && _fatal "qemu-img not found"
 [ "$QEMU_IO" = "" ] && _fatal "qemu-io not found"
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index e0883a0c65..b599c72211 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -15,33 +15,14 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-#
-# setup and check for config parameters, and in particular
-#
-# EMAIL -           email of the script runner.
-# TEST_DIR -        scratch test directory
-#
-# - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
-#   below or a separate local configuration file can be used (using
-#   the HOST_OPTIONS variable).
-# - This script is shared by the stress test system and the auto-qa
-#   system (includes both regression test and benchmark components).
-# - this script shouldn't make any assertions about filesystem
-#   validity or mountedness.
-#
-
 # all tests should use a common language setting to prevent golden
 # output mismatches.
 export LANG=C
 
 PATH=".:$PATH"
 
-HOST=`hostname -s 2> /dev/null`
 HOSTOS=`uname -s`
 
-EMAIL=root@localhost    # where auto-qa will send its status messages
-export HOST_OPTIONS=${HOST_OPTIONS:=local.config}
-export CHECK_OPTIONS=${CHECK_OPTIONS:="-g auto"}
 export PWD=`pwd`
 
 export _QEMU_HANDLE=0
@@ -78,11 +59,6 @@ _fatal()
 export AWK_PROG="`set_prog_path awk`"
 [ "$AWK_PROG" = "" ] && _fatal "awk not found"
 
-export SED_PROG="`set_prog_path sed`"
-[ "$SED_PROG" = "" ] && _fatal "sed not found"
-
-export PS_ALL_FLAGS="-ef"
-
 if [ -z "$QEMU_PROG" ]; then
     export QEMU_PROG="`set_prog_path qemu`"
 fi
@@ -198,8 +174,6 @@ fi
 
 export QEMU_DEFAULT_MACHINE="$default_machine"
 
-[ -f /etc/qemu-iotest.config ]       && . /etc/qemu-iotest.config
-
 if [ -z "$TEST_DIR" ]; then
         TEST_DIR=`pwd`/scratch
 fi
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 8d486dbeb4..5938d5145f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -293,51 +293,6 @@ _img_info()
         done
 }
 
-_get_pids_by_name()
-{
-    if [ $# -ne 1 ]
-    then
-        echo "Usage: _get_pids_by_name process-name" 1>&2
-        exit 1
-    fi
-
-    # Algorithm ... all ps(1) variants have a time of the form MM:SS or
-    # HH:MM:SS before the psargs field, use this as the search anchor.
-    #
-    # Matches with $1 (process-name) occur if the first psarg is $1
-    # or ends in /$1 ... the matching uses sed's regular expressions,
-    # so passing a regex into $1 will work.
-
-    ps $PS_ALL_FLAGS \
-    | sed -n \
-        -e 's/$/ /' \
-        -e 's/[         ][         ]*/ /g' \
-        -e 's/^ //' \
-        -e 's/^[^ ]* //' \
-        -e "/[0-9]:[0-9][0-9]  *[^ ]*\/$1 /s/ .*//p" \
-        -e "/[0-9]:[0-9][0-9]  *$1 /s/ .*//p"
-}
-
-# fqdn for localhost
-#
-_get_fqdn()
-{
-    host=`hostname`
-    $NSLOOKUP_PROG $host | $AWK_PROG '{ if ($1 == "Name:") print $2 }'
-}
-
-# check if run as root
-#
-_need_to_be_root()
-{
-    id=`id | $SED_PROG -e 's/(.*//' -e 's/.*=//'`
-    if [ "$id" -ne 0 ]
-    then
-        echo "Arrgh ... you need to be root (not uid=$id) to run this test"
-        exit 1
-    fi
-}
-
 # bail out, setting up .notrun file
 #
 _notrun()
@@ -491,28 +446,5 @@ _full_platform_details()
     echo "$os/$platform $host $kernel"
 }
 
-_link_out_file()
-{
-   if [ -z "$1" ]; then
-      echo Error must pass \$seq.
-      exit
-   fi
-   rm -f $1
-   if [ "`uname`" == "IRIX64" ] || [ "`uname`" == "IRIX" ]; then
-      ln -s $1.irix $1
-   elif [ "`uname`" == "Linux" ]; then
-      ln -s $1.linux $1
-   else
-      echo Error test $seq does not run on the operating system: `uname`
-      exit
-   fi
-}
-
-_die()
-{
-        echo $@
-        exit 1
-}
-
 # make sure this script returns success
 true
-- 
2.13.5
