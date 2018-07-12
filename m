Received: from eggs.gnu.org ([2001:4830:134:3::10]:42802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fdhEH-0002lo-9I
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1fdhEC-0003kw-8Z
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:26:17 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Thu, 12 Jul 2018 21:26:03 +0200
Message-Id: <20180712192603.11599-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] configure: Support pkg-config for zlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>

This is needed for builds with the mingw64-* packages from Cygwin,
but also works for Linux.

Move the zlib test also more to the end because users should
get information on the really important missing packages
(which also require zlib) first.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 configure | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index 2a7796ea80..dcaab01729 100755
--- a/configure
+++ b/configure
@@ -2140,23 +2140,6 @@ EOF
   fi
 fi
 
-#########################################
-# zlib check
-
-if test "$zlib" != "no" ; then
-    cat > $TMPC << EOF
-#include <zlib.h>
-int main(void) { zlibVersion(); return 0; }
-EOF
-    if compile_prog "" "-lz" ; then
-        :
-    else
-        error_exit "zlib check failed" \
-            "Make sure to have the zlib libs and headers installed."
-    fi
-fi
-LIBS="$LIBS -lz"
-
 ##########################################
 # lzo check
 
@@ -3525,6 +3508,29 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     fi
 fi
 
+#########################################
+# zlib check
+
+if test "$zlib" != "no" ; then
+    if $pkg_config --exists zlib; then
+        zlib_cflags=$($pkg_config --cflags zlib)
+        zlib_libs=$($pkg_config --libs zlib)
+        QEMU_CFLAGS="$zlib_cflags $QEMU_CFLAGS"
+        LIBS="$zlib_libs $LIBS"
+    else
+        cat > $TMPC << EOF
+#include <zlib.h>
+int main(void) { zlibVersion(); return 0; }
+EOF
+        if compile_prog "" "-lz" ; then
+            LIBS="$LIBS -lz"
+        else
+            error_exit "zlib check failed" \
+                "Make sure to have the zlib libs and headers installed."
+        fi
+    fi
+fi
+
 ##########################################
 # SHA command probe for modules
 if test "$modules" = yes; then
-- 
2.11.0
