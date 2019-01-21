Received: from eggs.gnu.org ([209.51.188.92]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ2-0008EZ-U3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ1-0000kS-P4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ1-0000jn-FL
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA588811DE
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:12:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:49 +0100
Message-Id: <20190121141152.948-4-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
References: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] sdl: add support for high resolution window
 icon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Modern desktop environments can render icons at very large sizes,
especially with high DPI screens. Providing a 32x32 pixel bitmap is
nowhere near sufficient anymore.

When displayed in GNOME shell the QEMU icon looks awful, having been
scaled up to at least x4 its base size. This is compounded by the fact
that the BMP file doesn't do transparency, so while we've removed white
pixels, we still have anti-aliased nearly-white pixels which make the
logo look appalling on black backgrounds.

Loading a high resolution PNG icon addresses both problems, but requires
use of the extra SDL2_image library.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190110120047.25369-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure         | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/ui/sdl2.h |  3 +++
 ui/sdl2.c         | 18 ++++++++++++------
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 7f1426ed0c..9bdcedc87a 100755
--- a/configure
+++ b/configure
@@ -346,6 +346,7 @@ fdt=3D""
 netmap=3D"no"
 sdl=3D""
 sdlabi=3D""
+sdl_image=3D""
 virtfs=3D""
 mpath=3D""
 vnc=3D"yes"
@@ -1042,6 +1043,10 @@ for opt do
   ;;
   --with-sdlabi=3D*) sdlabi=3D"$optarg"
   ;;
+  --disable-sdl-image) sdl_image=3D"no"
+  ;;
+  --enable-sdl-image) sdl_image=3D"yes"
+  ;;
   --disable-qom-cast-debug) qom_cast_debug=3D"no"
   ;;
   --enable-qom-cast-debug) qom_cast_debug=3D"yes"
@@ -1704,6 +1709,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   gcrypt          libgcrypt cryptography support
   sdl             SDL UI
   --with-sdlabi     select preferred SDL ABI 1.2 or 2.0
+  sdl_image       SDL Image support for icons
   gtk             gtk UI
   vte             vte support for the gtk UI
   curses          curses UI
@@ -3002,11 +3008,44 @@ EOF
   fi # sdl compile test
 }
=20
+sdl_image_probe ()
+{
+    if test "$sdl_image" !=3D "no" ; then
+        if $pkg_config SDL2_image --exists; then
+            if test "$static" =3D "yes"; then
+                sdl_image_libs=3D$($pkg_config SDL2_image --libs --stati=
c 2>/dev/null)
+            else
+                sdl_image_libs=3D$($pkg_config SDL2_image --libs 2>/dev/=
null)
+            fi
+            sdl_image_cflags=3D$($pkg_config SDL2_image --cflags 2>/dev/=
null)
+            sdl_image=3Dyes
+
+            sdl_cflags=3D"$sdl_cflags $sdl_image_cflags"
+            sdl_libs=3D"$sdl_libs $sdl_image_libs"
+        else
+            if test "$sdl_image" =3D "yes" ; then
+                feature_not_found "sdl_image" "Install SDL Image devel"
+            else
+                sdl_image=3Dno
+            fi
+        fi
+    fi
+}
+
 if test "$sdl" !=3D "no" ; then
   sdl_probe
 fi
=20
 if test "$sdl" =3D "yes" ; then
+  sdl_image_probe
+else
+  if test "$sdl_image" =3D "yes"; then
+    echo "warning: SDL Image requested, but SDL is not available, disabl=
ing"
+  fi
+  sdl_image=3Dno
+fi
+
+if test "$sdl" =3D "yes" ; then
   cat > $TMPC <<EOF
 #include <SDL.h>
 #if defined(SDL_VIDEO_DRIVER_X11)
@@ -6029,6 +6068,7 @@ if test "$darwin" =3D "yes" ; then
     echo "Cocoa support     $cocoa"
 fi
 echo "SDL support       $sdl $(echo_version $sdl $sdlversion)"
+echo "SDL image support $sdl_image"
 echo "GTK support       $gtk $(echo_version $gtk $gtk_version)"
 echo "GTK GL support    $gtk_gl"
 echo "VTE support       $vte $(echo_version $vte $vteversion)"
@@ -6368,6 +6408,9 @@ if test "$sdl" =3D "yes" ; then
   echo "CONFIG_SDLABI=3D$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=3D$sdl_cflags" >> $config_host_mak
   echo "SDL_LIBS=3D$sdl_libs" >> $config_host_mak
+  if test "$sdl_image" =3D "yes" ; then
+      echo "CONFIG_SDL_IMAGE=3Dy" >> $config_host_mak
+  fi
 fi
 if test "$cocoa" =3D "yes" ; then
   echo "CONFIG_COCOA=3Dy" >> $config_host_mak
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index f43eecdbd6..f6db642b65 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -6,6 +6,9 @@
=20
 #include <SDL.h>
 #include <SDL_syswm.h>
+#ifdef CONFIG_SDL_IMAGE
+# include <SDL_image.h>
+#endif
=20
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4c0d5db473..cde7feba91 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -764,6 +764,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
     uint8_t data =3D 0;
     int i;
     SDL_SysWMinfo info;
+    SDL_Surface *icon =3D NULL;
=20
     assert(o->type =3D=3D DISPLAY_TYPE_SDL);
=20
@@ -835,13 +836,18 @@ static void sdl2_display_init(DisplayState *ds, Dis=
playOptions *o)
 #endif
     }
=20
+#ifdef CONFIG_SDL_IMAGE
+    icon =3D IMG_Load(CONFIG_QEMU_ICONDIR "/hicolor/128x128/apps/qemu.pn=
g");
+#else
     /* Load a 32x32x4 image. White pixels are transparent. */
-    SDL_Surface *image =3D SDL_LoadBMP(CONFIG_QEMU_ICONDIR
-                                     "/hicolor/32x32/apps/qemu.bmp");
-    if (image) {
-        uint32_t colorkey =3D SDL_MapRGB(image->format, 255, 255, 255);
-        SDL_SetColorKey(image, SDL_TRUE, colorkey);
-        SDL_SetWindowIcon(sdl2_console[0].real_window, image);
+    icon =3D SDL_LoadBMP(CONFIG_QEMU_ICONDIR "/hicolor/32x32/apps/qemu.b=
mp");
+    if (icon) {
+        uint32_t colorkey =3D SDL_MapRGB(icon->format, 255, 255, 255);
+        SDL_SetColorKey(icon, SDL_TRUE, colorkey);
+    }
+#endif
+    if (icon) {
+        SDL_SetWindowIcon(sdl2_console[0].real_window, icon);
     }
=20
     gui_grab =3D 0;
--=20
2.9.3
