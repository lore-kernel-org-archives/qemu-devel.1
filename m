Received: from eggs.gnu.org ([2001:4830:134:3::10]:57545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx5MC-0006SU-Dp
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx5M0-0003xl-4z
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:02:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  4 Sep 2018 09:02:18 +0200
Message-Id: <1536044538-22507-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and WINDRES
 in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org

When cross-compiling QEMU for a target that significantly differs from
the host, the current information in config.status is not enough to
properly re-create the configuration. For example when I try to test
my build with the mingw32 cross-compiler, I regularly get this error
after the build system tried to re-create the configuration with the
config.status file:

ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
       You probably need to set PKG_CONFIG_LIBDIR
       to point to the right pkg-config files for your
       build target

A similar problem exists for the "windres" tool, where you have to
set the WINDRES variable in case it has a different name.
So let's fix these issues by storing the configuration for these
variables in the config.status file, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index 58862d2..4d8888f 100755
--- a/configure
+++ b/configure
@@ -7534,6 +7534,12 @@ cat <<EOD >config.status
 # Compiler output produced by configure, useful for debugging
 # configure, is in config.log if it exists.
 EOD
+if [ -n "$PKG_CONFIG_LIBDIR" ]; then
+    echo "export PKG_CONFIG_LIBDIR=\"$PKG_CONFIG_LIBDIR\"" >>config.status
+fi
+if [ -n "$WINDRES" ]; then
+    echo "export WINDRES=\"$WINDRES\"" >>config.status
+fi
 printf "exec" >>config.status
 printf " '%s'" "$0" "$@" >>config.status
 echo ' "$@"' >>config.status
-- 
1.8.3.1
