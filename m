Received: from eggs.gnu.org ([2001:4830:134:3::10]:59525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1L-0001N4-4v
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1H-0004ei-Vi
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1H-0004dE-R6
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E038F404084A
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:39:50 +0100
Message-Id: <20180207124009.12376-2-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/20] vnc: use stubs for CONFIG_VNC=n dummy
 functions
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

From: Gerd Hoffmann <kraxel@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20180202064546.21746-1-kraxel@redhat.com>
---
 include/ui/console.h | 21 ---------------------
 ui/Makefile.objs     |  1 +
 ui/vnc-stubs.c       | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 ui/vnc-stubs.c

diff --git a/include/ui/console.h b/include/ui/console.h
index 7b35778444..de57e8363a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -468,31 +468,10 @@ static inline void cocoa_display_init(DisplayState *ds, int full_screen)
 void vnc_display_init(const char *id);
 void vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
-#ifdef CONFIG_VNC
 int vnc_display_password(const char *id, const char *password);
 int vnc_display_pw_expire(const char *id, time_t expires);
 QemuOpts *vnc_parse(const char *str, Error **errp);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
-#else
-static inline int vnc_display_password(const char *id, const char *password)
-{
-    return -ENODEV;
-}
-static inline int vnc_display_pw_expire(const char *id, time_t expires)
-{
-    return -ENODEV;
-};
-static inline QemuOpts *vnc_parse(const char *str, Error **errp)
-{
-    error_setg(errp, "VNC support is disabled");
-    return NULL;
-}
-static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    error_setg(errp, "VNC support is disabled");
-    return -1;
-}
-#endif
 
 /* curses.c */
 #ifdef CONFIG_CURSES
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 99195884b0..ced7d91a63 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -15,6 +15,7 @@ common-obj-$(CONFIG_SDL) += sdl.mo
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
+common-obj-$(call lnot,$(CONFIG_VNC)) += vnc-stubs.o
 common-obj-$(CONFIG_GTK) += gtk.o
 common-obj-$(if $(CONFIG_WIN32),n,$(if $(CONFIG_SDL),y,$(CONFIG_GTK))) += x_keymap.o
 
diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
new file mode 100644
index 0000000000..f51280549a
--- /dev/null
+++ b/ui/vnc-stubs.c
@@ -0,0 +1,21 @@
+#include "qemu/osdep.h"
+#include "ui/console.h"
+
+int vnc_display_password(const char *id, const char *password)
+{
+    return -ENODEV;
+}
+int vnc_display_pw_expire(const char *id, time_t expires)
+{
+    return -ENODEV;
+};
+QemuOpts *vnc_parse(const char *str, Error **errp)
+{
+    error_setg(errp, "VNC support is disabled");
+    return NULL;
+}
+int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    error_setg(errp, "VNC support is disabled");
+    return -1;
+}
-- 
2.13.6
