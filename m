Received: from eggs.gnu.org ([2001:4830:134:3::10]:35482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBs-0006wh-D9
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBn-0001lt-LA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBn-0001lk-Cr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74D4080461
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:30 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:12 +0800
Message-Id: <20170907082918.7299-4-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] buildsys: Move vnc cflags/libs to per
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 14 ++++++++------
 ui/Makefile.objs | 21 ++++++++++++---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 812a1ce615..9b0eb91a9b 100755
--- a/configure
+++ b/configure
@@ -2834,8 +2834,8 @@ EOF
   vnc_sasl_libs="-lsasl2"
   if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
     vnc_sasl=yes
-    libs_softmmu="$vnc_sasl_libs $libs_softmmu"
-    QEMU_CFLAGS="$QEMU_CFLAGS $vnc_sasl_cflags"
+    vnc_libs="$vnc_libs $vnc_sasl_libs"
+    vnc_cflags="$vnc_cflags $vnc_sasl_cflags"
   else
     if test "$vnc_sasl" = "yes" ; then
       feature_not_found "vnc-sasl" "Install Cyrus SASL devel"
@@ -2856,8 +2856,8 @@ EOF
     vnc_jpeg_libs="-ljpeg"
   if compile_prog "$vnc_jpeg_cflags" "$vnc_jpeg_libs" ; then
     vnc_jpeg=yes
-    libs_softmmu="$vnc_jpeg_libs $libs_softmmu"
-    QEMU_CFLAGS="$QEMU_CFLAGS $vnc_jpeg_cflags"
+    vnc_libs="$vnc_libs $vnc_jpeg_libs"
+    vnc_cflags="$vnc_cflags $vnc_jpeg_cflags"
   else
     if test "$vnc_jpeg" = "yes" ; then
       feature_not_found "vnc-jpeg" "Install libjpeg-turbo devel"
@@ -2888,8 +2888,8 @@ EOF
   fi
   if compile_prog "$vnc_png_cflags" "$vnc_png_libs" ; then
     vnc_png=yes
-    libs_softmmu="$vnc_png_libs $libs_softmmu"
-    QEMU_CFLAGS="$QEMU_CFLAGS $vnc_png_cflags"
+    vnc_libs="$vnc_libs $vnc_png_libs"
+    vnc_cflags="$vnc_cflags $vnc_png_cflags"
   else
     if test "$vnc_png" = "yes" ; then
       feature_not_found "vnc-png" "Install libpng devel"
@@ -5558,6 +5558,8 @@ echo "CONFIG_BDRV_RW_WHITELIST=$block_drv_rw_whitelist" >> $config_host_mak
 echo "CONFIG_BDRV_RO_WHITELIST=$block_drv_ro_whitelist" >> $config_host_mak
 if test "$vnc" = "yes" ; then
   echo "CONFIG_VNC=y" >> $config_host_mak
+  echo "VNC_CFLAGS=$vnc_cflags" >> $config_host_mak
+  echo "VNC_LIBS=$vnc_libs" >> $config_host_mak
 fi
 if test "$vnc_sasl" = "yes" ; then
   echo "CONFIG_VNC_SASL=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index b3e29e21f0..a0b3c15a28 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -1,11 +1,14 @@
-vnc-obj-y += vnc.o
-vnc-obj-y += vnc-enc-zlib.o vnc-enc-hextile.o
-vnc-obj-y += vnc-enc-tight.o vnc-palette.o
-vnc-obj-y += vnc-enc-zrle.o
-vnc-obj-y += vnc-auth-vencrypt.o
-vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o
-vnc-obj-y += vnc-ws.o
-vnc-obj-y += vnc-jobs.o
+vnc.mo-objs += vnc.o
+vnc.mo-objs += vnc-enc-zlib.o vnc-enc-hextile.o
+vnc.mo-objs += vnc-enc-tight.o vnc-palette.o
+vnc.mo-objs += vnc-enc-zrle.o
+vnc.mo-objs += vnc-auth-vencrypt.o
+vnc.mo-objs += $(if $(CONFIG_VNC_SASL), vnc-auth-sasl.o)
+vnc.mo-objs += vnc-ws.o
+vnc.mo-objs += vnc-jobs.o
+
+vnc.mo-cflags := $(VNC_CFLAGS)
+vnc.mo-libs := $(VNC_LIBS)
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o
@@ -14,7 +17,7 @@ common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_SDL) += sdl.mo x_keymap.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
-common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
+common-obj-$(CONFIG_VNC) += vnc.mo
 common-obj-$(CONFIG_GTK) += gtk.o x_keymap.o
 
 ifeq ($(CONFIG_SDLABI),1.2)
-- 
2.13.5
