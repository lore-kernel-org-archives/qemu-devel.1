Received: from eggs.gnu.org ([2001:4830:134:3::10]:41387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qt-0001t1-LG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qm-00055B-Qx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40089
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qm-00054e-Kg
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8X0e028763
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t7da-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:39 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:39 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:16 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-53-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 52/81] ui: use evdev keymap when running under
 wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Wayland always uses evdev as its input source, so QEMU
can use the existing evdev keymap data

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20161201094117.16407-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit a8ffb372a2202c65f42fdb69891ea68a2f274b55)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/ui/gtk.h | 4 ++++
 ui/gtk.c         | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 42ca0fe..b3b5005 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -18,6 +18,10 @@
 #include <X11/XKBlib.h>
 #endif
 
+#ifdef GDK_WINDOWING_WAYLAND
+#include <gdk/gdkwayland.h>
+#endif
+
 #if defined(CONFIG_OPENGL)
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index 406de4f..356f400 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -90,6 +90,9 @@
 #ifndef GDK_IS_X11_DISPLAY
 #define GDK_IS_X11_DISPLAY(dpy) (dpy == dpy)
 #endif
+#ifndef GDK_IS_WAYLAND_DISPLAY
+#define GDK_IS_WAYLAND_DISPLAY(dpy) (dpy == dpy)
+#endif
 #ifndef GDK_IS_WIN32_DISPLAY
 #define GDK_IS_WIN32_DISPLAY(dpy) (dpy == dpy)
 #endif
@@ -1054,6 +1057,10 @@ static int gd_map_keycode(GtkDisplayState *s, GdkDisplay *dpy, int gdk_keycode)
             qemu_keycode = translate_xfree86_keycode(gdk_keycode - 97);
         }
 #endif
+#ifdef GDK_WINDOWING_WAYLAND
+    } else if (GDK_IS_WAYLAND_DISPLAY(dpy) && gdk_keycode < 158) {
+        qemu_keycode = translate_evdev_keycode(gdk_keycode - 97);
+#endif
     } else if (gdk_keycode == 208) { /* Hiragana_Katakana */
         qemu_keycode = 0x70;
     } else if (gdk_keycode == 211) { /* backslash */
-- 
2.7.4
