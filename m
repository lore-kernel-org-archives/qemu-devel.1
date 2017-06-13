Received: from eggs.gnu.org ([2001:4830:134:3::10]:38181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKq7Y-0002wV-KS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKq7V-00064c-CY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:00:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 13 Jun 2017 20:00:44 +0200
Message-Id: <1497376844-26561-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Fix build with pkg-config and
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org

The configure script prefers pkg-config over sdl-config, but
the "--static-libs" parameter only exists for the latter. With
pkg-config, "--static --libs" have to be used instead.

Buglink: https://bugs.launchpad.net/qemu/+bug/984516
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 13e040d..3b89de6 100755
--- a/configure
+++ b/configure
@@ -2671,7 +2671,11 @@ int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
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
1.8.3.1
