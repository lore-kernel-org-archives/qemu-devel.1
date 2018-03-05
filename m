Received: from eggs.gnu.org ([2001:4830:134:3::10]:37879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnp-0003sx-Ic
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslno-0003dU-KY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslno-0003dD-Ek
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:42 +0100
Message-Id: <20180305084844.18222-12-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] ui/curses: build as module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Also drop curses libs from libs_softmmu.  Add CURSES_{CFLAGS,LIBS}
variables so we can use them for linking the curses module.

Also make target/unicore32/helper.o depend on curses which uses curses
directly for some reason ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180301100547.18962-12-kraxel@redhat.com
---
 configure                      | 6 +++---
 target/unicore32/Makefile.objs | 4 ++++
 ui/Makefile.objs               | 6 +++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index ad36320a4c..e651533466 100755
--- a/configure
+++ b/configure
@@ -3280,8 +3280,6 @@ EOF
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
         curses_found=yes
-        QEMU_CFLAGS="$curses_inc $QEMU_CFLAGS"
-        libs_softmmu="$curses_lib $libs_softmmu"
         break
       fi
     done
@@ -6050,7 +6048,9 @@ if test "$cocoa" = "yes" ; then
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
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
index 6b41b1e9ef..35d8bf530d 100644
--- a/target/unicore32/Makefile.objs
+++ b/target/unicore32/Makefile.objs
@@ -2,3 +2,7 @@ obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += ucf64_helper.o
 
 obj-$(CONFIG_SOFTMMU) += softmmu.o
+
+# Huh? Uses curses directly instead of using ui/console.h interfaces ...
+helper.o-cflags := $(CURSES_CFLAGS)
+helper.o-libs := $(CURSES_LIBS)
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 49223b0573..a37232762b 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -13,7 +13,6 @@ common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_SDL) += sdl.mo
 common-obj-$(CONFIG_COCOA) += cocoa.o
-common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
 
@@ -39,6 +38,11 @@ gtk.mo-objs := gtk.o
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
