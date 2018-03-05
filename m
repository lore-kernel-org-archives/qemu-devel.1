Received: from eggs.gnu.org ([2001:4830:134:3::10]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnm-0003qt-Hw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnj-0003ac-9s
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslnj-0003Z3-3K
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E52587ABA
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:39 +0100
Message-Id: <20180305084844.18222-9-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] configure: add X11 vars to config-host.mak
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

Simplifies handling the X11 dependency,
also makes ui/Makefile.objs more readable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180301100547.18962-9-kraxel@redhat.com
---
 configure        | 10 ++++++++--
 ui/Makefile.objs |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 00c4b63cfa..3d2aef95f8 100755
--- a/configure
+++ b/configure
@@ -2520,9 +2520,8 @@ fi
 
 ##########################################
 # X11 probe
-x11_cflags=
-x11_libs=-lX11
 if $pkg_config --exists "x11"; then
+    have_x11=yes
     x11_cflags=$($pkg_config --cflags x11)
     x11_libs=$($pkg_config --libs x11)
 fi
@@ -2555,6 +2554,7 @@ if test "$gtk" != "no"; then
         gtk_libs=$($pkg_config --libs $gtkpackage)
         gtk_version=$($pkg_config --modversion $gtkpackage)
         if $pkg_config --exists "$gtkx11package >= $gtkversion"; then
+            need_x11=yes
             gtk_cflags="$gtk_cflags $x11_cflags"
             gtk_libs="$gtk_libs $x11_libs"
         fi
@@ -2923,6 +2923,7 @@ if test "$sdl" = "yes" ; then
 int main(void) { return 0; }
 EOF
   if compile_prog "$sdl_cflags $x11_cflags" "$sdl_libs $x11_libs" ; then
+    need_x11=yes
     sdl_cflags="$sdl_cflags $x11_cflags"
     sdl_libs="$sdl_libs $x11_libs"
   fi
@@ -6036,6 +6037,11 @@ if test "$modules" = "yes"; then
   echo "CONFIG_STAMP=_$( (echo $qemu_version; echo $pkgversion; cat $0) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
   echo "CONFIG_MODULES=y" >> $config_host_mak
 fi
+if test "$have_x11" = "yes" -a "$need_x11" = "yes"; then
+  echo "CONFIG_X11=y" >> $config_host_mak
+  echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
+  echo "X11_LIBS=$x11_libs" >> $config_host_mak
+fi
 if test "$sdl" = "yes" ; then
   echo "CONFIG_SDL=y" >> $config_host_mak
   echo "CONFIG_SDLABI=$sdlabi" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ced7d91a63..9b725b07aa 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -17,7 +17,10 @@ common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
 common-obj-$(CONFIG_GTK) += gtk.o
-common-obj-$(if $(CONFIG_WIN32),n,$(if $(CONFIG_SDL),y,$(CONFIG_GTK))) += x_keymap.o
+
+common-obj-$(CONFIG_X11) += x_keymap.o
+x_keymap.o-cflags := $(X11_CFLAGS)
+x_keymap.o-libs := $(X11_LIBS)
 
 ifeq ($(CONFIG_SDLABI),1.2)
 sdl.mo-objs := sdl.o sdl_zoom.o
-- 
2.9.3
