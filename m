Received: from eggs.gnu.org ([2001:4830:134:3::10]:51743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRG-0003st-DM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRE-0001q3-Sj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:53 +0200
Message-Id: <20170912144459.11359-5-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] qemu-iotests: cleanup and fix search for
 programs
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

Instead of ./check failing when a binary is missing, we try each test
case now and each one fails with tons of test case diffs.  Also, all the
variables were initialized by "check" prior to "common" being sourced,
and then (uselessly) checked for emptiness again in "check".

Centralize the search for programs in "common" (which will soon be
one with "check"), including the "realpath" invocation which can be done
just once in "check" rather than in the tests.

For qnio_server, move the detection to "common", simplifying
set_prog_path to stop handling the unused second argument, and
embedding the "realpath" pass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check         | 41 ---------------------
 tests/qemu-iotests/common        | 77 +++++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/common.config | 61 +------------------------------
 3 files changed, 73 insertions(+), 106 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 5c0d0c51dc..b7c54390d3 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -60,47 +60,6 @@ fi
 
 build_root="$build_iotests/../.."
 
-if [ -x "$build_iotests/socket_scm_helper" ]
-then
-    export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
-fi
-
-if [[ -z "$QEMU_PROG" && ! -x './qemu' ]]
-then
-    arch=$(uname -m 2> /dev/null)
-
-    if [[ -n $arch && -x "$build_root/$arch-softmmu/qemu-system-$arch" ]]
-    then
-        export QEMU_PROG="$build_root/$arch-softmmu/qemu-system-$arch"
-    else
-        pushd "$build_root" > /dev/null
-        for binary in *-softmmu/qemu-system-*
-        do
-            if [ -x "$binary" ]
-            then
-                export QEMU_PROG="$build_root/$binary"
-                break
-            fi
-        done
-        popd > /dev/null
-    fi
-fi
-
-if [[ -z $QEMU_IMG_PROG && -x "$build_root/qemu-img" && ! -x './qemu-img' ]]
-then
-    export QEMU_IMG_PROG="$build_root/qemu-img"
-fi
-
-if [[ -z $QEMU_IO_PROG && -x "$build_root/qemu-io" && ! -x './qemu-io' ]]
-then
-    export QEMU_IO_PROG="$build_root/qemu-io"
-fi
-
-if [[ -z $QEMU_NBD_PROG && -x "$build_root/qemu-nbd" && ! -x './qemu-nbd' ]]
-then
-    export QEMU_NBD_PROG="$build_root/qemu-nbd"
-fi
-
 # we need common.env
 if ! . "$build_iotests/common.env"
 then
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 2e98e64d5c..abacc24114 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -37,6 +37,17 @@ _full_platform_details()
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
 diff="diff -u"
 verbose=false
 debug=false
@@ -450,10 +461,66 @@ fi
 list=`sort $tmp.list`
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
-[ "$QEMU" = "" ] && _fatal "qemu not found"
-[ "$QEMU_IMG" = "" ] && _fatal "qemu-img not found"
-[ "$QEMU_IO" = "" ] && _fatal "qemu-io not found"
+if [ -z "$QEMU_PROG" ]
+then
+    if [ -x "$build_iotests/qemu" ]; then
+        export QEMU_PROG="$build_iotests/qemu"
+    elif [ -x "$build_root/$arch-softmmu/qemu-system-$arch" ]; then
+        export QEMU_PROG="$build_root/$arch-softmmu/qemu-system-$arch"
+    else
+        pushd "$build_root" > /dev/null
+        for binary in *-softmmu/qemu-system-*
+        do
+            if [ -x "$binary" ]
+            then
+                export QEMU_PROG="$build_root/$binary"
+                break
+            fi
+        done
+        popd > /dev/null
+        [ "$QEMU_PROG" = "" ] && _init_error "qemu not found"
+    fi
+fi
+export QEMU_PROG=$(realpath -- "$(type -p "$QEMU_PROG")")
+
+if [ -z "$QEMU_IMG_PROG" ]; then
+    if [ -x "$build_iotests/qemu-img" ]; then
+        export QEMU_IMG_PROG="$build_iotests/qemu-img"
+    elif [ -x "$build_root/qemu-img" ]; then
+        export QEMU_IMG_PROG="$build_root/qemu-img"
+    else
+        _init_error "qemu-img not found"
+    fi
+fi
+export QEMU_IMG_PROG=$(realpath -- "$(type -p "$QEMU_IMG_PROG")")
+
+if [ -z "$QEMU_IO_PROG" ]; then
+    if [ -x "$build_iotests/qemu-io" ]; then
+        export QEMU_IO_PROG="$build_iotests/qemu-io"
+    elif [ -x "$build_root/qemu-io" ]; then
+        export QEMU_IO_PROG="$build_root/qemu-io"
+    else
+        _init_error "qemu-io not found"
+    fi
+fi
+export QEMU_IO_PROG=$(realpath -- "$(type -p "$QEMU_IO_PROG")")
 
-if [ "$IMGPROTO" = "nbd" ] ; then
-    [ "$QEMU_NBD" = "" ] && _fatal "qemu-nbd not found"
+if [ -z $QEMU_NBD_PROG ]; then
+    if [ -x "$build_iotests/qemu-nbd" ]; then
+        export QEMU_NBD_PROG="$build_iotests/qemu-nbd"
+    elif [ -x "$build_root/qemu-nbd" ]; then
+        export QEMU_NBD_PROG="$build_root/qemu-nbd"
+    else
+        _init_error "qemu-nbd not found"
+    fi
+fi
+export QEMU_NBD_PROG=$(realpath -- "$(type -p "$QEMU_NBD_PROG")")
+
+if [ -z "$QEMU_VXHS_PROG" ]; then
+  export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
+fi
+
+if [ -x "$build_iotests/socket_scm_helper" ]
+then
+    export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
 fi
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index 91da65f3dc..c97c63983f 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -22,6 +22,7 @@ export LANG=C
 PATH=".:$PATH"
 
 HOSTOS=`uname -s`
+arch=`uname -m`
 
 export PWD=`pwd`
 
@@ -30,28 +31,6 @@ export _QEMU_HANDLE=0
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
@@ -61,44 +40,6 @@ _optstr_add()
     fi
 }
 
-_fatal()
-{
-    echo "$*"
-    status=1
-    exit 1
-}
-
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
 _qemu_wrapper()
 {
     (
-- 
2.13.5
