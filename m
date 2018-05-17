Received: from eggs.gnu.org ([2001:4830:134:3::10]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJICG-0004KX-1c
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJICC-00040R-St
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJICC-000402-OG
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:39:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D770A87ABE
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:39:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 May 2018 14:39:42 +0200
Message-Id: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

x_keymap.o is common to the SDL and GTK+ modules, and it causes the
QEMU binary to link to the X11 libraries.  Add it separately to the
modules to keep the main QEMU binary smaller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/Makefile.objs | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc78434..00f6976 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -15,10 +15,6 @@ common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
 
-common-obj-$(CONFIG_X11) += x_keymap.o
-x_keymap.o-cflags := $(X11_CFLAGS)
-x_keymap.o-libs := $(X11_LIBS)
-
 # ui-sdl module
 common-obj-$(CONFIG_SDL) += sdl.mo
 ifeq ($(CONFIG_SDLABI),1.2)
@@ -46,6 +42,13 @@ gtk.mo-objs += gtk-gl-area.o
 endif
 endif
 
+ifeq ($(CONFIG_X11),y)
+sdl.mo-objs += x_keymap.o
+gtk.mo-objs += x_keymap.o
+x_keymap.o-cflags := $(X11_CFLAGS)
+x_keymap.o-libs := $(X11_LIBS)
+endif
+
 common-obj-$(CONFIG_CURSES) += curses.mo
 curses.mo-objs := curses.o
 curses.mo-cflags := $(CURSES_CFLAGS)
-- 
1.8.3.1
