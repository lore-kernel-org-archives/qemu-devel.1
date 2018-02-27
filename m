Received: from eggs.gnu.org ([2001:4830:134:3::10]:46338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIM-0001dk-IS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003EF-Vj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaIJ-0003DZ-LB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F578185330
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:24 +0100
Message-Id: <20180227080724.13585-13-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] curses: build as ui module
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

Also drop curses libs from libs_softmmu.  Add CURSES_{CFLAGS,LIBS}
variables so we can use them for linking the curses module.

Shared library dependencies dropped from qemu-system-*:

libncursesw.so.5 => /lib64/libncursesw.so.5
libtinfo.so.5 => /lib64/libtinfo.so.5

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-13-kraxel@redhat.com
---
 configure        | 6 +++---
 ui/Makefile.objs | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 4cabdf8c9f..cc43a634c1 100755
--- a/configure
+++ b/configure
@@ -3269,8 +3269,6 @@ EOF
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
         curses_found=yes
-        QEMU_CFLAGS="$curses_inc $QEMU_CFLAGS"
-        libs_softmmu="$curses_lib $libs_softmmu"
         break
       fi
     done
@@ -6038,7 +6036,9 @@ if test "$cocoa" = "yes" ; then
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
index 9a0e8a94f1..dcd54a5287 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -12,7 +12,6 @@ common-obj-y += input.o input-keymap.o input-legacy.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
-common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
 
@@ -40,6 +39,11 @@ gtk.mo-objs := gtk.o
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
