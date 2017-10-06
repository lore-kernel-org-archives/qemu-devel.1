Received: from eggs.gnu.org ([2001:4830:134:3::10]:55990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxz-0000er-8F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxy-0003Ow-AW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:53 +0200
Message-Id: <20171006155422.10135-26-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/54] qemu-iotests: move "check" code out of
 common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Some functions in common.rc are never used by the tests.  Move
them out of that file and into common, which is already included
only by "check".

Code that actually *is* common to "check" and tests can be placed in
common.config.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common        | 25 ++++++++++++++++++++++++-
 tests/qemu-iotests/common.config | 12 ++++++++++++
 tests/qemu-iotests/common.rc     | 40 ----------------------------------------
 3 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 130f647a4d..2e98e64d5c 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -19,6 +19,24 @@
 # common procedures for QA scripts
 #
 
+_full_imgfmt_details()
+{
+    if [ -n "$IMGOPTS" ]; then
+        echo "$IMGFMT ($IMGOPTS)"
+    else
+        echo "$IMGFMT"
+    fi
+}
+
+_full_platform_details()
+{
+    os=`uname -s`
+    host=`hostname -s`
+    kernel=`uname -r`
+    platform=`uname -m`
+    echo "$os/$platform $host $kernel"
+}
+
 diff="diff -u"
 verbose=false
 debug=false
@@ -404,7 +422,12 @@ if [ "$IMGOPTSSYNTAX" != "true" ]; then
 fi
 
 # Set default options for qemu-img create -o if they were not specified
-_set_default_imgopts
+if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
+    IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
+fi
+if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
+    IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
+fi
 
 if [ -s $tmp.list ]
 then
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 0f571d46eb..91da65f3dc 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -27,6 +27,9 @@ export PWD=`pwd`
 
 export _QEMU_HANDLE=0
 
+# make sure we have a standard umask
+umask 022
+
 # $1 = prog to look for, $2* = default pathnames if not found in $PATH
 set_prog_path()
 {
@@ -49,6 +52,15 @@ set_prog_path()
     return 1
 }
 
+_optstr_add()
+{
+    if [ -n "$1" ]; then
+        echo "$1,$2"
+    else
+        echo "$2"
+    fi
+}
+
 _fatal()
 {
     echo "$*"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 5938d5145f..6f6e03366f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -50,9 +50,6 @@ then
     fi
 fi
 
-# make sure we have a standard umask
-umask 022
-
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     DRIVER="driver=$IMGFMT"
     if [ "$IMGFMT" = "luks" ]; then
@@ -94,25 +91,6 @@ else
 fi
 ORIG_TEST_IMG="$TEST_IMG"
 
-_optstr_add()
-{
-    if [ -n "$1" ]; then
-        echo "$1,$2"
-    else
-        echo "$2"
-    fi
-}
-
-_set_default_imgopts()
-{
-    if [ "$IMGFMT" == "qcow2" ] && ! (echo "$IMGOPTS" | grep "compat=" > /dev/null); then
-        IMGOPTS=$(_optstr_add "$IMGOPTS" "compat=1.1")
-    fi
-    if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
-        IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
-    fi
-}
-
 _use_sample_img()
 {
     SAMPLE_IMG_FILE="${1%\.bz2}"
@@ -428,23 +406,5 @@ _require_command()
     [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
 }
 
-_full_imgfmt_details()
-{
-    if [ -n "$IMGOPTS" ]; then
-        echo "$IMGFMT ($IMGOPTS)"
-    else
-        echo "$IMGFMT"
-    fi
-}
-
-_full_platform_details()
-{
-    os=`uname -s`
-    host=`hostname -s`
-    kernel=`uname -r`
-    platform=`uname -m`
-    echo "$os/$platform $host $kernel"
-}
-
 # make sure this script returns success
 true
-- 
2.13.6
