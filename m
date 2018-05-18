Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0X-0001tk-4Z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0U-000532-1u
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa0T-00052n-Tl
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CEF781FE147
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:40:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 18 May 2018 09:40:51 +0200
Message-Id: <20180518074052.31724-3-kraxel@redhat.com>
In-Reply-To: <20180518074052.31724-1-kraxel@redhat.com>
References: <20180518074052.31724-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

x_keymap.o is common to the SDL and GTK+ modules, and it causes the
QEMU binary to link to the X11 libraries.  Add it separately to the
modules to keep the main QEMU binary smaller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1526560782-18732-1-git-send-email-pbonzini@redhat.com

[ kraxel: fix lm32 target build (milkymist-tmu2) ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/Makefile.objs |  2 ++
 ui/Makefile.objs         | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 3c7c75b94d..11321e466b 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -20,6 +20,8 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
 
 common-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
+milkymist-tmu2.o-cflags := $(X11_CFLAGS)
+milkymist-tmu2.o-libs := $(X11_LIBS)
 
 obj-$(CONFIG_OMAP) += omap_dss.o
 obj-$(CONFIG_OMAP) += omap_lcdc.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc784346cb..00f6976c30 100644
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
2.9.3
