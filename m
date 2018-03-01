Received: from eggs.gnu.org ([2001:4830:134:3::10]:42618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL62-0005FP-Ih
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL5z-00051T-4L
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1erL5y-00050p-VD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 927A987ABA
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:05:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  1 Mar 2018 11:05:44 +0100
Message-Id: <20180301100547.18962-11-kraxel@redhat.com>
In-Reply-To: <20180301100547.18962-1-kraxel@redhat.com>
References: <20180301100547.18962-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/13] ui/gtk: build as module
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

Also drop gtk and vte libs from libs_softmmu, so the libs are not
pulled in unless the gtk module actually gets loaded.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure        |  5 ++---
 ui/Makefile.objs | 17 +++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index ab1ba9c47d..8074fc5001 100755
--- a/configure
+++ b/configure
@@ -2547,7 +2547,6 @@ if test "$gtk" != "no"; then
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
-        libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2797,7 +2796,6 @@ if test "$vte" != "no"; then
         vte_cflags=$($pkg_config --cflags $vtepackage)
         vte_libs=$($pkg_config --libs $vtepackage)
         vteversion=$($pkg_config --modversion $vtepackage)
-        libs_softmmu="$vte_libs $libs_softmmu"
         vte="yes"
     elif test "$vte" = "yes"; then
         if test "$gtkabi" = "3.0"; then
@@ -6137,7 +6135,7 @@ if test "$glib_subprocess" = "yes" ; then
   echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=y" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
-  echo "CONFIG_GTK=y" >> $config_host_mak
+  echo "CONFIG_GTK=m" >> $config_host_mak
   echo "CONFIG_GTKABI=$gtkabi" >> $config_host_mak
   echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=$gtk_libs" >> $config_host_mak
@@ -6188,6 +6186,7 @@ fi
 if test "$vte" = "yes" ; then
   echo "CONFIG_VTE=y" >> $config_host_mak
   echo "VTE_CFLAGS=$vte_cflags" >> $config_host_mak
+  echo "VTE_LIBS=$vte_libs" >> $config_host_mak
 fi
 if test "$virglrenderer" = "yes" ; then
   echo "CONFIG_VIRGL=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 9b725b07aa..49223b0573 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -16,7 +16,6 @@ common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
-common-obj-$(CONFIG_GTK) += gtk.o
 
 common-obj-$(CONFIG_X11) += x_keymap.o
 x_keymap.o-cflags := $(X11_CFLAGS)
@@ -34,6 +33,12 @@ endif
 sdl.mo-cflags := $(SDL_CFLAGS)
 sdl.mo-libs := $(SDL_LIBS)
 
+# ui-gtk module
+common-obj-$(CONFIG_GTK) += gtk.mo
+gtk.mo-objs := gtk.o
+gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
+gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
+
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y += shader.o
 common-obj-y += console-gl.o
@@ -41,17 +46,13 @@ common-obj-y += egl-helpers.o
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
