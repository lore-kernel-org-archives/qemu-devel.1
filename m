Received: from eggs.gnu.org ([2001:4830:134:3::10]:35843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPt-0008Kr-Uc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPp-00030y-An
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dpEPp-0002zu-5p
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:21 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Sep 2017 16:01:16 +0200
Message-Id: <20170905140116.28181-3-kraxel@redhat.com>
In-Reply-To: <20170905140116.28181-1-kraxel@redhat.com>
References: <20170905140116.28181-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] pixman: drop configure switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Remove pixman switches from configure, should not be needed any more,
configure can figure by itself whenever pixman is needed or not.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index 73760430b0..fdef7e138b 100755
--- a/configure
+++ b/configure
@@ -282,7 +282,6 @@ curses=""
 docs=""
 fdt=""
 netmap="no"
-pixman=""
 sdl=""
 sdlabi=""
 virtfs=""
@@ -928,10 +927,6 @@ for opt do
     # configure to be used by RPM and similar macros that set
     # lots of directory switches by default.
   ;;
-  --with-system-pixman) pixman="system"
-  ;;
-  --without-pixman) pixman="none"
-  ;;
   --disable-sdl) sdl="no"
   ;;
   --enable-sdl) sdl="yes"
@@ -3298,24 +3293,10 @@ fi
 ##########################################
 # pixman support probe
 
-if test "$pixman" = ""; then
-  if test "$want_tools" = "no" -a "$softmmu" = "no"; then
-    pixman="none"
-  elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
-    pixman="system"
-  fi
-fi
-if test "$pixman" = "none"; then
-  if test "$want_tools" != "no" -o "$softmmu" != "no"; then
-    error_exit "pixman disabled but system emulation or tools build" \
-        "enabled.  You can turn off pixman only if you also" \
-        "disable all system emulation targets and the tools" \
-        "build with '--disable-tools --disable-system'."
-  fi
+if test "$want_tools" = "no" -a "$softmmu" = "no"; then
   pixman_cflags=
   pixman_libs=
-elif test "$pixman" = "system"; then
-  # pixman version has been checked above
+elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
   pixman_cflags=$($pkg_config --cflags pixman-1)
   pixman_libs=$($pkg_config --libs pixman-1)
 else
@@ -5293,7 +5274,6 @@ echo "static build      $static"
 if test "$darwin" = "yes" ; then
     echo "Cocoa support     $cocoa"
 fi
-echo "pixman            $pixman"
 echo "SDL support       $sdl $(echo_version $sdl $sdlversion)"
 echo "GTK support       $gtk $(echo_version $gtk $gtk_version)"
 echo "GTK GL support    $gtk_gl"
-- 
2.9.3
