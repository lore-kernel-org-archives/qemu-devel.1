Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbr-0006d0-Hn
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbp-0006gU-BI
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbp-0006g7-2N
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:46:06 +0800
Message-Id: <20170909054613.19148-31-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 30/37] buildsys: Move vnc cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907082918.7299-4-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 14 ++++++++------
 ui/Makefile.objs | 21 ++++++++++++---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index a9577bb952..ffc93c7cdb 100755
--- a/configure
+++ b/configure
@@ -2833,8 +2833,8 @@ EOF
   vnc_sasl_libs=3D"-lsasl2"
   if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
     vnc_sasl=3Dyes
-    libs_softmmu=3D"$vnc_sasl_libs $libs_softmmu"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vnc_sasl_cflags"
+    vnc_libs=3D"$vnc_libs $vnc_sasl_libs"
+    vnc_cflags=3D"$vnc_cflags $vnc_sasl_cflags"
   else
     if test "$vnc_sasl" =3D "yes" ; then
       feature_not_found "vnc-sasl" "Install Cyrus SASL devel"
@@ -2855,8 +2855,8 @@ EOF
     vnc_jpeg_libs=3D"-ljpeg"
   if compile_prog "$vnc_jpeg_cflags" "$vnc_jpeg_libs" ; then
     vnc_jpeg=3Dyes
-    libs_softmmu=3D"$vnc_jpeg_libs $libs_softmmu"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vnc_jpeg_cflags"
+    vnc_libs=3D"$vnc_libs $vnc_jpeg_libs"
+    vnc_cflags=3D"$vnc_cflags $vnc_jpeg_cflags"
   else
     if test "$vnc_jpeg" =3D "yes" ; then
       feature_not_found "vnc-jpeg" "Install libjpeg-turbo devel"
@@ -2887,8 +2887,8 @@ EOF
   fi
   if compile_prog "$vnc_png_cflags" "$vnc_png_libs" ; then
     vnc_png=3Dyes
-    libs_softmmu=3D"$vnc_png_libs $libs_softmmu"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vnc_png_cflags"
+    vnc_libs=3D"$vnc_libs $vnc_png_libs"
+    vnc_cflags=3D"$vnc_cflags $vnc_png_cflags"
   else
     if test "$vnc_png" =3D "yes" ; then
       feature_not_found "vnc-png" "Install libpng devel"
@@ -5552,6 +5552,8 @@ echo "CONFIG_BDRV_RW_WHITELIST=3D$block_drv_rw_whit=
elist" >> $config_host_mak
 echo "CONFIG_BDRV_RO_WHITELIST=3D$block_drv_ro_whitelist" >> $config_hos=
t_mak
 if test "$vnc" =3D "yes" ; then
   echo "CONFIG_VNC=3Dy" >> $config_host_mak
+  echo "VNC_CFLAGS=3D$vnc_cflags" >> $config_host_mak
+  echo "VNC_LIBS=3D$vnc_libs" >> $config_host_mak
 fi
 if test "$vnc_sasl" =3D "yes" ; then
   echo "CONFIG_VNC_SASL=3Dy" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index b3e29e21f0..a0b3c15a28 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -1,11 +1,14 @@
-vnc-obj-y +=3D vnc.o
-vnc-obj-y +=3D vnc-enc-zlib.o vnc-enc-hextile.o
-vnc-obj-y +=3D vnc-enc-tight.o vnc-palette.o
-vnc-obj-y +=3D vnc-enc-zrle.o
-vnc-obj-y +=3D vnc-auth-vencrypt.o
-vnc-obj-$(CONFIG_VNC_SASL) +=3D vnc-auth-sasl.o
-vnc-obj-y +=3D vnc-ws.o
-vnc-obj-y +=3D vnc-jobs.o
+vnc.mo-objs +=3D vnc.o
+vnc.mo-objs +=3D vnc-enc-zlib.o vnc-enc-hextile.o
+vnc.mo-objs +=3D vnc-enc-tight.o vnc-palette.o
+vnc.mo-objs +=3D vnc-enc-zrle.o
+vnc.mo-objs +=3D vnc-auth-vencrypt.o
+vnc.mo-objs +=3D $(if $(CONFIG_VNC_SASL), vnc-auth-sasl.o)
+vnc.mo-objs +=3D vnc-ws.o
+vnc.mo-objs +=3D vnc-jobs.o
+
+vnc.mo-cflags :=3D $(VNC_CFLAGS)
+vnc.mo-libs :=3D $(VNC_LIBS)
=20
 common-obj-y +=3D keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y +=3D input.o input-keymap.o input-legacy.o
@@ -14,7 +17,7 @@ common-obj-$(CONFIG_SPICE) +=3D spice-core.o spice-inpu=
t.o spice-display.o
 common-obj-$(CONFIG_SDL) +=3D sdl.mo x_keymap.o
 common-obj-$(CONFIG_COCOA) +=3D cocoa.o
 common-obj-$(CONFIG_CURSES) +=3D curses.o
-common-obj-$(CONFIG_VNC) +=3D $(vnc-obj-y)
+common-obj-$(CONFIG_VNC) +=3D vnc.mo
 common-obj-$(CONFIG_GTK) +=3D gtk.o x_keymap.o
=20
 ifeq ($(CONFIG_SDLABI),1.2)
--=20
2.13.5
