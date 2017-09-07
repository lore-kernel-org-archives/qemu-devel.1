Received: from eggs.gnu.org ([2001:4830:134:3::10]:35539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsC3-00074p-BU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsBy-0001pV-R2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsBy-0001p6-LF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:29:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B47757E428
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:29:41 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:29:15 +0800
Message-Id: <20170907082918.7299-7-famz@redhat.com>
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] buildsys: Move opengl cflags to per object
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

Opengl libs are already moved to per object, do so for the cflags as
well.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 2 +-
 ui/Makefile.objs | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index b08cb4ce02..b1320b1994 100755
--- a/configure
+++ b/configure
@@ -3623,7 +3623,6 @@ if test "$opengl" != "no" ; then
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
     fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" = "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
@@ -5844,6 +5843,7 @@ fi
 
 if test "$opengl" = "yes" ; then
   echo "CONFIG_OPENGL=y" >> $config_host_mak
+  echo "OPENGL_CFLAGS=$opengl_cflags" >> $config_host_mak
   echo "OPENGL_LIBS=$opengl_libs" >> $config_host_mak
   if test "$opengl_dmabuf" = "yes" ; then
     echo "CONFIG_OPENGL_DMABUF=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index e3403b698b..95943d9c33 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -53,10 +53,10 @@ gtk.o-libs := $(GTK_LIBS) $(VTE_LIBS)
 gtk-egl.o-libs := $(GTK_LIBS) $(VTE_LIBS)
 gtk-gl-area.o-libs := $(GTK_LIBS) $(VTE_LIBS)
 
-gtk-egl.o-libs += $(OPENGL_LIBS)
-shader.o-libs += $(OPENGL_LIBS)
-console-gl.o-libs += $(OPENGL_LIBS)
-egl-helpers.o-libs += $(OPENGL_LIBS)
+$(foreach x, gtk-egl shader console egl-helpers, \
+	$(eval $x.o-libs += $(OPENGL_LIBS)) \
+	$(eval $x.o-cflags += $(OPENGL_CFLAGS)) \
+)
 
 curses.o-cflags := $(CURSES_CFLAGS)
 curses.o-libs := $(CURSES_LIBS)
-- 
2.13.5
