Received: from eggs.gnu.org ([2001:4830:134:3::10]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0000o2-Lp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvC-0007NY-2R
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvB-0007Ln-QC
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED3427C830
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:45 +0100
Message-Id: <20171117103046.15943-24-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 23/24] curses: build as module
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
 configure        | 6 +++---
 ui/Makefile.objs | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 91c9323a50..67a8c2e83a 100755
--- a/configure
+++ b/configure
@@ -3190,8 +3190,6 @@ EOF
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
         curses_found=yes
-        QEMU_CFLAGS="$curses_inc $QEMU_CFLAGS"
-        libs_softmmu="$curses_lib $libs_softmmu"
         break
       fi
     done
@@ -5761,7 +5759,9 @@ if test "$cocoa" = "yes" ; then
   echo "CONFIG_COCOA=y" >> $config_host_mak
 fi
 if test "$curses" = "yes" ; then
-  echo "CONFIG_CURSES=y" >> $config_host_mak
+  echo "CONFIG_CURSES=m" >> $config_host_mak
+  echo "CURSES_CFLAGS=$curses_inc" >> $config_host_mak
+  echo "CURSES_LIBS=$curses_lib" >> $config_host_mak
 fi
 if test "$pipe2" = "yes" ; then
   echo "CONFIG_PIPE2=y" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index be3dc44cc6..42ef071d17 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -12,7 +12,6 @@ common-obj-y += input.o input-keymap.o input-legacy.o x_keymap.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
-common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 
 common-obj-$(CONFIG_SDL) += sdl.mo
@@ -33,6 +32,11 @@ gtk.mo-objs := gtk.o
 gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk.mo-libs := $(GTK_LIBS) $(VTE_LIBS)
 
+common-obj-$(CONFIG_CURSES) += curses.mo
+curses.mo-objs := curses.o
+curses.mo-cflags := $(CURSES_CFLAGS)
+curses.mo-libs := $(CURSES_LIBS)
+
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y += shader.o
 common-obj-y += console-gl.o
-- 
2.9.3
