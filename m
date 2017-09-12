Received: from eggs.gnu.org ([2001:4830:134:3::10]:51862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRP-00040b-VO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRO-0001ul-P6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:32 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:56 +0200
Message-Id: <20170912144459.11359-8-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] qemu-iotests: disintegrate more parts of
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org

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
index abacc24114..ee313af92f 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -48,6 +48,14 @@ set_prog_path()
     fi
 }
 
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
@@ -440,6 +448,13 @@ if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null
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
@@ -524,3 +539,12 @@ if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
 fi
+
+default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
+default_alias_machine=$($QEMU_PROG -machine help | \
+   sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
+if [[ "$default_alias_machine" ]]; then
+    default_machine="$default_alias_machine"
+fi
+
+export QEMU_DEFAULT_MACHINE="$default_machine"
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index c7f0a7a7e0..cdcda54546 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -26,8 +26,6 @@ arch=`uname -m`
 
 export PWD=`pwd`
 
-export _QEMU_HANDLE=0
-
 # make sure we have a standard umask
 umask 022
 
@@ -40,52 +38,5 @@ _optstr_add()
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
index 20f6821a69..f4dc0104e6 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -114,6 +114,10 @@ export QEMU_VXHS=_qemu_vxhs_wrapper
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
+    QEMU_IMG_EXTRA_ARGS="--image-opts $QEMU_IMG_EXTRA_ARGS"
+    if [ -n "$IMGKEYSECRET" ]; then
+        QEMU_IMG_EXTRA_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IMG_EXTRA_ARGS"
+    fi
     if [ "$IMGFMT" = "luks" ]; then
         DRIVER="$DRIVER,key-secret=keysec0"
     fi
@@ -133,6 +137,7 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
         TEST_IMG="$DRIVER,file.driver=$IMGPROTO,file.filename=$TEST_DIR/t.$IMGFMT"
     fi
 else
+    QEMU_IMG_EXTRA_ARGS=
     if [ "$IMGPROTO" = "file" ]; then
         TEST_IMG=$TEST_DIR/t.$IMGFMT
     elif [ "$IMGPROTO" = "nbd" ]; then
@@ -153,6 +158,26 @@ else
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
2.13.5
