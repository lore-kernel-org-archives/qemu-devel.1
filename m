Received: from eggs.gnu.org ([2001:4830:134:3::10]:37783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnm-0003qn-Hd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnj-0003aA-92
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslnj-0003Z0-2d
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4D6340FB648
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:41 +0100
Message-Id: <20180305084844.18222-11-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] ui/gtk: build as module
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

Also drop gtk and vte libs from libs_softmmu, so the libs are not
pulled in unless the gtk module actually gets loaded.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180301100547.18962-11-kraxel@redhat.com
---
 configure        |  5 ++---
 ui/Makefile.objs | 17 +++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index fbfbb64029..ad36320a4c 100755
--- a/configure
+++ b/configure
@@ -2558,7 +2558,6 @@ if test "$gtk" != "no"; then
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
-        libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2808,7 +2807,6 @@ if test "$vte" != "no"; then
         vte_cflags=$($pkg_config --cflags $vtepackage)
         vte_libs=$($pkg_config --libs $vtepackage)
         vteversion=$($pkg_config --modversion $vtepackage)
-        libs_softmmu="$vte_libs $libs_softmmu"
         vte="yes"
     elif test "$vte" = "yes"; then
         if test "$gtkabi" = "3.0"; then
@@ -6149,7 +6147,7 @@ if test "$glib_subprocess" = "yes" ; then
   echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=y" >> $config_host_mak
 fi
 if test "$gtk" = "yes" ; then
-  echo "CONFIG_GTK=y" >> $config_host_mak
+  echo "CONFIG_GTK=m" >> $config_host_mak
   echo "CONFIG_GTKABI=$gtkabi" >> $config_host_mak
   echo "GTK_CFLAGS=$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=$gtk_libs" >> $config_host_mak
@@ -6200,6 +6198,7 @@ fi
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
