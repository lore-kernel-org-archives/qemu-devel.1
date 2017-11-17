Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvG-0000ps-FH
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0007QO-A2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvD-0007OU-SR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03117C058EDD
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:44 +0100
Message-Id: <20171117103046.15943-23-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 22/24] gtk: build as module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure        |  5 ++---
 ui/Makefile.objs | 16 ++++++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 7d1e9b187d..91c9323a50 100755
--- a/configure
+++ b/configure
@@ -2470,7 +2470,6 @@ if test "$gtk" != "no"; then
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
-        libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2720,7 +2719,6 @@ if test "$vte" != "no"; then
         vte_cflags=$($pkg_config --cflags $vtepackage)
         vte_libs=$($pkg_config --libs $vtepackage)
         vteversion=$($pkg_config --modversion $vtepackage)
-        libs_softmmu="$vte_libs $libs_softmmu"
         vte="yes"
     elif test "$vte" = "yes"; then
         if test "$gtkabi" = "3.0"; then
@@ -5860,7 +5858,7 @@ if test "$glib_subprocess" = "yes" ; then
   echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=y" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
-  echo "CONFIG_GTK=y" >> $config_host_mak
+  echo "CONFIG_GTK=m" >> $config_host_mak
   echo "CONFIG_GTKABI=$gtkabi" >> $config_host_mak
   echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=$gtk_libs" >> $config_host_mak
@@ -5911,6 +5909,7 @@ fi
 if test "$vte" = "yes" ; then
   echo "CONFIG_VTE=y" >> $config_host_mak
   echo "VTE_CFLAGS=$vte_cflags" >> $config_host_mak
+  echo "VTE_LIBS=$vte_libs" >> $config_host_mak
 fi
 if test "$virglrenderer" = "yes" ; then
   echo "CONFIG_VIRGL=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 6c13d7e5ed..be3dc44cc6 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -14,7 +14,6 @@ common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
-common-obj-$(CONFIG_GTK) += gtk.o
 
 common-obj-$(CONFIG_SDL) += sdl.mo
 ifeq ($(CONFIG_SDLABI),1.2)
@@ -29,6 +28,11 @@ endif
 sdl.mo-cflags := $(SDL_CFLAGS)
 sdl.mo-libs := $(SDL_LIBS)
 
+common-obj-$(CONFIG_GTK) += gtk.mo
+gtk.mo-objs := gtk.o
+gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
+gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
+
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y += shader.o
 common-obj-y += console-gl.o
@@ -36,17 +40,13 @@ common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
-common-obj-$(CONFIG_GTK) += gtk-gl-area.o
+gtk.mo-objs += gtk-gl-area.o
 else
-common-obj-$(CONFIG_GTK) += gtk-egl.o
+gtk.mo-objs += gtk-egl.o
+gtk.mo-libs += $(OPENGL_LIBS)
 endif
 endif
 
-gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-
-gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
-- 
2.9.3
