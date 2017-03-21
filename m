Received: from eggs.gnu.org ([2001:4830:134:3::10]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqDqm-0001LG-B9
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqDqj-0006rO-75
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cqDqj-0006qm-15
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:04:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E04B765D01
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 07:04:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Mar 2017 08:04:48 +0100
Message-Id: <1490079888-29029-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] add opengl_cflags to QEMU_CFLAGS
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

... and drop OPENGL_CFLAGS from Makefiles.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                | 2 +-
 hw/display/Makefile.objs | 6 +-----
 ui/Makefile.objs         | 7 ++-----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 1e0d7a8..02e3b69 100755
--- a/configure
+++ b/configure
@@ -3449,6 +3449,7 @@ if test "$opengl" != "no" ; then
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
     fi
+    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" = "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
@@ -5503,7 +5504,6 @@ fi
 
 if test "$opengl" = "yes" ; then
   echo "CONFIG_OPENGL=y" >> $config_host_mak
-  echo "OPENGL_CFLAGS=$opengl_cflags" >> $config_host_mak
   echo "OPENGL_LIBS=$opengl_libs" >> $config_host_mak
   if test "$opengl_dmabuf" = "yes" ; then
     echo "CONFIG_OPENGL_DMABUF=y" >> $config_host_mak
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 3d02e8b..551c050 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -18,11 +18,7 @@ common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
 
-ifeq ($(CONFIG_MILKYMIST_TMU2),y)
-common-obj-y += milkymist-tmu2.o
-milkymist-tmu2.o-cflags := $(OPENGL_CFLAGS)
-milkymist-tmu2.o-libs += $(OPENGL_LIBS)
-endif
+common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
 
 obj-$(CONFIG_OMAP) += omap_dss.o
 obj-$(CONFIG_OMAP) += omap_lcdc.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index dc936f1..27566b3 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -41,11 +41,8 @@ endif
 endif
 
 gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
-gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS) $(OPENGL_CFLAGS)
-shader.o-cflags += $(OPENGL_CFLAGS)
-console-gl.o-cflags += $(OPENGL_CFLAGS)
-egl-helpers.o-cflags += $(OPENGL_CFLAGS)
+gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
+gtk-gl-area.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 
 gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
-- 
1.8.3.1
