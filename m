Received: from eggs.gnu.org ([2001:4830:134:3::10]:59295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqN-0008UW-Er
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHqJ-0005KO-Cw
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:38:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:37:59 +0300
Message-Id: <5f37e6d4a7b22ccf1bb8fa4eb35784d90ff78fbc.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/13] configure: Fix build with pkg-config and
 --static --enable-sdl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

The configure script prefers pkg-config over sdl-config, but
the "--static-libs" parameter only exists for the latter. With
pkg-config, "--static --libs" have to be used instead.

Buglink: https://bugs.launchpad.net/qemu/+bug/984516
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 806658c98b..ce7e8aa842 100755
--- a/configure
+++ b/configure
@@ -2733,7 +2733,11 @@ int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
 EOF
   sdl_cflags=$($sdlconfig --cflags 2>/dev/null)
   if test "$static" = "yes" ; then
-    sdl_libs=$($sdlconfig --static-libs 2>/dev/null)
+    if $pkg_config $sdlname --exists; then
+      sdl_libs=$($pkg_config $sdlname --static --libs 2>/dev/null)
+    else
+      sdl_libs=$($sdlconfig --static-libs 2>/dev/null)
+    fi
   else
     sdl_libs=$($sdlconfig --libs 2>/dev/null)
   fi
-- 
2.11.0
