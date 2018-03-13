Received: from eggs.gnu.org ([2001:4830:134:3::10]:50110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqNA-0005X0-St
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqN7-0003nG-Mj
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqN7-0003mA-DF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B948B61471
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:18:08 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:18:04 -0600
Message-ID: <20180313201804.2327.81754.stgit@gimli.home>
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 03/11] console: minimal hotplug suport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

This patch allows to unbind devices from QemuConsoles, using the new
graphic_console_close() function.  The QemuConsole will show a static
display then, saying the device was unplugged.  When re-plugging a
display later on the QemuConsole will be reused.

Eventually we will allocate and release QemuConsoles dynamically at some
point in the future, that'll need more infrastructure though to notify
user interfaces (gtk, sdl, spice, ...) about QemuConsoles coming and
going.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/ui/console.h |    2 +
 ui/console.c         |   79 ++++++++++++++++++++++++++++++++++++++++++++++----
 ui/trace-events      |    2 +
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 5fca9afcbc9a..6d2c052068de 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -386,6 +386,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
 void graphic_console_set_hwops(QemuConsole *con,
                                const GraphicHwOps *hw_ops,
                                void *opaque);
+void graphic_console_close(QemuConsole *con);
 
 void graphic_hw_update(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
@@ -398,6 +399,7 @@ QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
                                                 uint32_t head, Error **errp);
+QemuConsole *qemu_console_lookup_unused(void);
 bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
 bool qemu_console_is_fixedsize(QemuConsole *con);
diff --git a/ui/console.c b/ui/console.c
index a8868fc04fbd..530a49198726 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1282,11 +1282,16 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
     s->console_type = console_type;
 
     consoles = g_realloc(consoles, sizeof(*consoles) * (nb_consoles+1));
-    if (console_type != GRAPHIC_CONSOLE) {
+    if (console_type != GRAPHIC_CONSOLE || qdev_hotplug) {
         s->index = nb_consoles;
         consoles[nb_consoles++] = s;
     } else {
-        /* HACK: Put graphical consoles before text consoles.  */
+        /*
+         * HACK: Put graphical consoles before text consoles.
+         *
+         * Only do that for coldplugged devices.  After initial device
+         * initialization we will not renumber the consoles any more.
+         */
         for (i = nb_consoles; i > 0; i--) {
             if (consoles[i - 1]->console_type == GRAPHIC_CONSOLE)
                 break;
@@ -1874,21 +1879,61 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
     int height = 480;
     QemuConsole *s;
     DisplayState *ds;
+    DisplaySurface *surface;
 
     ds = get_alloc_displaystate();
-    trace_console_gfx_new();
-    s = new_console(ds, GRAPHIC_CONSOLE, head);
-    s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME, dpy_set_ui_info_timer, s);
+    s = qemu_console_lookup_unused();
+    if (s) {
+        trace_console_gfx_reuse(s->index);
+        if (s->surface) {
+            width = surface_width(s->surface);
+            height = surface_height(s->surface);
+        }
+    } else {
+        trace_console_gfx_new();
+        s = new_console(ds, GRAPHIC_CONSOLE, head);
+        s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                   dpy_set_ui_info_timer, s);
+    }
     graphic_console_set_hwops(s, hw_ops, opaque);
     if (dev) {
         object_property_set_link(OBJECT(s), OBJECT(dev), "device",
                                  &error_abort);
     }
 
-    s->surface = qemu_create_message_surface(width, height, noinit);
+    surface = qemu_create_message_surface(width, height, noinit);
+    dpy_gfx_replace_surface(s, surface);
     return s;
 }
 
+static const GraphicHwOps unused_ops = {
+    /* no callbacks */
+};
+
+void graphic_console_close(QemuConsole *con)
+{
+    static const char unplugged[] =
+        "Guest display has been unplugged";
+    DisplaySurface *surface;
+    int width = 640;
+    int height = 480;
+
+    if (con->surface) {
+        width = surface_width(con->surface);
+        height = surface_height(con->surface);
+    }
+
+    trace_console_gfx_close(con->index);
+    object_property_set_link(OBJECT(con), NULL, "device", &error_abort);
+    graphic_console_set_hwops(con, &unused_ops, NULL);
+
+    if (con->gl) {
+        dpy_gl_scanout_disable(con);
+    }
+    surface = qemu_create_message_surface(width, height, unplugged);
+    dpy_gfx_replace_surface(con, surface);
+}
+
 QemuConsole *qemu_console_lookup_by_index(unsigned int index)
 {
     if (index >= nb_consoles) {
@@ -1945,6 +1990,28 @@ QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
     return con;
 }
 
+QemuConsole *qemu_console_lookup_unused(void)
+{
+    Object *obj;
+    int i;
+
+    for (i = 0; i < nb_consoles; i++) {
+        if (!consoles[i]) {
+            continue;
+        }
+        if (consoles[i]->hw_ops != &unused_ops) {
+            continue;
+        }
+        obj = object_property_get_link(OBJECT(consoles[i]),
+                                       "device", &error_abort);
+        if (obj != NULL) {
+            continue;
+        }
+        return consoles[i];
+    }
+    return NULL;
+}
+
 bool qemu_console_is_visible(QemuConsole *con)
 {
     return (con == active_console) || (con->dcls > 0);
diff --git a/ui/trace-events b/ui/trace-events
index a957f363f146..eb4bf7f00da5 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -2,6 +2,8 @@
 
 # ui/console.c
 console_gfx_new(void) ""
+console_gfx_reuse(int index) "%d"
+console_gfx_close(int index) "%d"
 console_putchar_csi(int esc_param0, int esc_param1, int ch, int nb_esc_params) "escape sequence CSI%d;%d%c, %d parameters"
 console_putchar_unhandled(int ch) "unhandled escape character '%c'"
 console_txt_new(int w, int h) "%dx%d"
