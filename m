Received: from eggs.gnu.org ([2001:4830:134:3::10]:51522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwk-0002QT-Tr
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwj-0006Uv-Js
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:23 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:04 +0200
Message-Id: <20170809215510.22802-7-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/12] qemu-iotests: do not do useless search
 for QEMU_*_PROG
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

With the exception of qnio_server, all the variables are initialized
by "check" prior to "common" being sourced.  They cannot be empty.
Only the "realpath" invocation is useful, and can be done just once
in "check" rather than in the tests.

For qnio_server, move the detection to "common", simplifying
set_prog_path to stop handling the unused second argument, and
embedding the "realpath" pass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/common        | 19 ++++++++++++++
 tests/qemu-iotests/common.config | 54 ----------------------------------------
 2 files changed, 19 insertions(+), 54 deletions(-)

diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index f58e56fc40..33557abe6c 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -42,6 +42,25 @@ _full_platform_details()
     echo "$os/$platform $host $kernel"
 }
 
+# $1 = prog to look for
+set_prog_path()
+{
+    p=`command -v $1 2> /dev/null`
+    if [ -n "$p" -a -x "$p" ]; then
+        realpath -- "$(type -p "$p")"
+    else
+        return 1
+    fi
+}
+
+export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
+export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
+export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
+export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
+if [ -z "$QEMU_VXHS_PROG" ]; then
+  export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
+fi
+
 diff="diff -u"
 verbose=false
 debug=false
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index ee10c23672..9d535415b5 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -30,28 +30,6 @@ export _QEMU_HANDLE=0
 # make sure we have a standard umask
 umask 022
 
-# $1 = prog to look for, $2* = default pathnames if not found in $PATH
-set_prog_path()
-{
-    p=`command -v $1 2> /dev/null`
-    if [ -n "$p" -a -x "$p" ]; then
-        echo $p
-        return 0
-    fi
-    p=$1
-
-    shift
-    for f; do
-        if [ -x $f ]; then
-            echo $f
-            return 0
-        fi
-    done
-
-    echo ""
-    return 1
-}
-
 _optstr_add()
 {
     if [ -n "$1" ]; then
@@ -61,38 +39,6 @@ _optstr_add()
     fi
 }
 
-if [ -z "$QEMU_PROG" ]; then
-    export QEMU_PROG="`set_prog_path qemu`"
-fi
-
-if [ -z "$QEMU_IMG_PROG" ]; then
-    export QEMU_IMG_PROG="`set_prog_path qemu-img`"
-fi
-
-if [ -z "$QEMU_IO_PROG" ]; then
-    export QEMU_IO_PROG="`set_prog_path qemu-io`"
-fi
-
-if [ -z "$QEMU_NBD_PROG" ]; then
-    export QEMU_NBD_PROG="`set_prog_path qemu-nbd`"
-fi
-
-if [ -z "$QEMU_VXHS_PROG" ]; then
-    export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
-fi
-
-export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
-export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
-export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
-export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
-
-# This program is not built as part of qemu but (possibly) provided by the
-# system, so it may not be present at all
-if [ -n "$QEMU_VXHS_PROG" ]; then
-    export QEMU_VXHS_PROG=$(realpath -- "$(type -p "$QEMU_VXHS_PROG")")
-fi
-
-
 QEMU_IMG_EXTRA_ARGS=
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     QEMU_IMG_EXTRA_ARGS="--image-opts $QEMU_IMG_EXTRA_ARGS"
-- 
2.13.3
