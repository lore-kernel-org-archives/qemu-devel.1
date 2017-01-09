Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhw-0004yV-Fx
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZht-0008R2-8Q
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZht-0008Ql-2Z
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AF8B90226
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 13:09:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:36 +0100
Message-Id: <1483967385-12891-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/11] ui: use evdev keymap when running
 under wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Wayland always uses evdev as its input source, so QEMU
can use the existing evdev keymap data

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20161201094117.16407-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
1.8.3.1
