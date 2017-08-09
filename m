Received: from eggs.gnu.org ([2001:4830:134:3::10]:51579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwm-0002Rw-Jm
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwl-0006Wa-3X
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:24 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:05 +0200
Message-Id: <20170809215510.22802-8-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/12] qemu-iotests: disintegrate more parts of
 common.config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Split "check" parts from tests part.

For the directory setup, the actual computation of directories goes
in "check", while the sanity checks go in the tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/common        | 24 ++++++++++++++++++++
 tests/qemu-iotests/common.config | 49 ----------------------------------------
 tests/qemu-iotests/common.qemu   |  1 +
 tests/qemu-iotests/common.rc     | 25 ++++++++++++++++++++
 4 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 33557abe6c..adf427501e 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -61,6 +61,14 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
   export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
 fi
 
+if [ -z "$TEST_DIR" ]; then
+        TEST_DIR=`pwd`/scratch
+fi
+
+if [ ! -e "$TEST_DIR" ]; then
+        mkdir "$TEST_DIR"
+fi
+
 diff="diff -u"
 verbose=false
 debug=false
@@ -87,6 +95,15 @@ export VALGRIND_QEMU=
 export IMGKEYSECRET=
 export IMGOPTSSYNTAX=false
 
+default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
+default_alias_machine=$($QEMU_PROG -machine help | \
+   sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
+if [[ "$default_alias_machine" ]]; then
+    default_machine="$default_alias_machine"
+fi
+
+export QEMU_DEFAULT_MACHINE="$default_machine"
+
 for r
 do
 
@@ -453,6 +470,13 @@ if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null
     IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
 fi
 
+if [ -z "$SAMPLE_IMG_DIR" ]; then
+        SAMPLE_IMG_DIR="$source_iotests/sample_images"
+fi
+
+export TEST_DIR
+export SAMPLE_IMG_DIR
+
 if [ -s $tmp.list ]
 then
     # found some valid test numbers ... this is good
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 9d535415b5..dd2ffe034d 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -25,8 +25,6 @@ HOSTOS=`uname -s`
 
 export PWD=`pwd`
 
-export _QEMU_HANDLE=0
-
 # make sure we have a standard umask
 umask 022
 
@@ -39,52 +37,5 @@ _optstr_add()
     fi
 }
 
-QEMU_IMG_EXTRA_ARGS=
-if [ "$IMGOPTSSYNTAX" = "true" ]; then
-    QEMU_IMG_EXTRA_ARGS="--image-opts $QEMU_IMG_EXTRA_ARGS"
-    if [ -n "$IMGKEYSECRET" ]; then
-        QEMU_IMG_EXTRA_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IMG_EXTRA_ARGS"
-    fi
-fi
-export QEMU_IMG_EXTRA_ARGS
-
-
-default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
-default_alias_machine=$($QEMU_PROG -machine help | \
-   sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
-if [[ "$default_alias_machine" ]]; then
-    default_machine="$default_alias_machine"
-fi
-
-export QEMU_DEFAULT_MACHINE="$default_machine"
-
-if [ -z "$TEST_DIR" ]; then
-        TEST_DIR=`pwd`/scratch
-fi
-
-QEMU_TEST_DIR="${TEST_DIR}"
-
-if [ ! -e "$TEST_DIR" ]; then
-        mkdir "$TEST_DIR"
-fi
-
-if [ ! -d "$TEST_DIR" ]; then
-    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
-    exit 1
-fi
-
-export TEST_DIR
-
-if [ -z "$SAMPLE_IMG_DIR" ]; then
-        SAMPLE_IMG_DIR="$source_iotests/sample_images"
-fi
-
-if [ ! -d "$SAMPLE_IMG_DIR" ]; then
-    echo "common.config: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
-    exit 1
-fi
-
-export SAMPLE_IMG_DIR
-
 # make sure this script returns success
 true
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7645f1dc72..9f9aecc9df 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -31,6 +31,7 @@ QEMU_FIFO_IN="${QEMU_TEST_DIR}/qmp-in-$$"
 QEMU_FIFO_OUT="${QEMU_TEST_DIR}/qmp-out-$$"
 
 QEMU_HANDLE=0
+export _QEMU_HANDLE=0
 
 # If bash version is >= 4.1, these will be overwritten and dynamic
 # file descriptor values assigned.
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 390aa81224..7046a83974 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -129,6 +129,10 @@ export QEMU_VXHS=_qemu_vxhs_wrapper
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
+    QEMU_IMG_EXTRA_ARGS="--image-opts $QEMU_IMG_EXTRA_ARGS"
+    if [ -n "$IMGKEYSECRET" ]; then
+        QEMU_IMG_EXTRA_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IMG_EXTRA_ARGS"
+    fi
     if [ "$IMGFMT" = "luks" ]; then
         DRIVER="$DRIVER,key-secret=keysec0"
     fi
@@ -148,6 +152,7 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
         TEST_IMG="$DRIVER,file.driver=$IMGPROTO,file.filename=$TEST_DIR/t.$IMGFMT"
     fi
 else
+    QEMU_IMG_EXTRA_ARGS=
     if [ "$IMGPROTO" = "file" ]; then
         TEST_IMG=$TEST_DIR/t.$IMGFMT
     elif [ "$IMGPROTO" = "nbd" ]; then
@@ -168,6 +173,26 @@ else
 fi
 ORIG_TEST_IMG="$TEST_IMG"
 
+if [ -z "$TEST_DIR" ]; then
+        TEST_DIR=`pwd`/scratch
+fi
+
+QEMU_TEST_DIR="${TEST_DIR}"
+
+if [ ! -e "$TEST_DIR" ]; then
+        mkdir "$TEST_DIR"
+fi
+
+if [ ! -d "$TEST_DIR" ]; then
+    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
+    exit 1
+fi
+
+if [ ! -d "$SAMPLE_IMG_DIR" ]; then
+    echo "common.config: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
+    exit 1
+fi
+
 _use_sample_img()
 {
     SAMPLE_IMG_FILE="${1%\.bz2}"
-- 
2.13.3
