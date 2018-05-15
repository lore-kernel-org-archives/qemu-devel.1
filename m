Received: from eggs.gnu.org ([2001:4830:134:3::10]:48697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6y-0004HW-Hi
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6s-0001V9-EX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:12 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:19:00 +0200
Message-Id: <20180515091901.27774-10-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] console: use linked list for QemuConsoles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180507095424.16220-1-kraxel@redhat.com
---
 ui/console.c | 105 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index b02510cdca..945f05d728 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -165,6 +165,8 @@ struct QemuConsole {
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
+
+    QTAILQ_ENTRY(QemuConsole) next;
 };
 
 struct DisplayState {
@@ -180,8 +182,8 @@ struct DisplayState {
 
 static DisplayState *display_state;
 static QemuConsole *active_console;
-static QemuConsole **consoles;
-static int nb_consoles = 0;
+static QTAILQ_HEAD(consoles_head, QemuConsole) consoles =
+    QTAILQ_HEAD_INITIALIZER(consoles);
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
@@ -197,7 +199,7 @@ static void gui_update(void *opaque)
     uint64_t dcl_interval;
     DisplayState *ds = opaque;
     DisplayChangeListener *dcl;
-    int i;
+    QemuConsole *con;
 
     ds->refreshing = true;
     dpy_refresh(ds);
@@ -212,9 +214,9 @@ static void gui_update(void *opaque)
     }
     if (ds->update_interval != interval) {
         ds->update_interval = interval;
-        for (i = 0; i < nb_consoles; i++) {
-            if (consoles[i]->hw_ops->update_interval) {
-                consoles[i]->hw_ops->update_interval(consoles[i]->hw, interval);
+        QTAILQ_FOREACH(con, &consoles, next) {
+            if (con->hw_ops->update_interval) {
+                con->hw_ops->update_interval(con->hw, interval);
             }
         }
         trace_console_refresh(interval);
@@ -1292,10 +1294,13 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
     s->ds = ds;
     s->console_type = console_type;
 
-    consoles = g_realloc(consoles, sizeof(*consoles) * (nb_consoles+1));
-    if (console_type != GRAPHIC_CONSOLE || qdev_hotplug) {
-        s->index = nb_consoles;
-        consoles[nb_consoles++] = s;
+    if (QTAILQ_EMPTY(&consoles)) {
+        s->index = 0;
+        QTAILQ_INSERT_TAIL(&consoles, s, next);
+    } else if (console_type != GRAPHIC_CONSOLE || qdev_hotplug) {
+        QemuConsole *last = QTAILQ_LAST(&consoles, consoles_head);
+        s->index = last->index + 1;
+        QTAILQ_INSERT_TAIL(&consoles, s, next);
     } else {
         /*
          * HACK: Put graphical consoles before text consoles.
@@ -1303,15 +1308,24 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
          * Only do that for coldplugged devices.  After initial device
          * initialization we will not renumber the consoles any more.
          */
-        for (i = nb_consoles; i > 0; i--) {
-            if (consoles[i - 1]->console_type == GRAPHIC_CONSOLE)
-                break;
-            consoles[i] = consoles[i - 1];
-            consoles[i]->index = i;
+        QemuConsole *c = QTAILQ_FIRST(&consoles);
+
+        while (QTAILQ_NEXT(c, next) != NULL &&
+               c->console_type == GRAPHIC_CONSOLE) {
+            c = QTAILQ_NEXT(c, next);
+        }
+        if (c->console_type == GRAPHIC_CONSOLE) {
+            /* have no text consoles */
+            s->index = c->index + 1;
+            QTAILQ_INSERT_AFTER(&consoles, c, s, next);
+        } else {
+            s->index = c->index;
+            QTAILQ_INSERT_BEFORE(c, s, next);
+            /* renumber text consoles */
+            for (i = s->index + 1; c != NULL; c = QTAILQ_NEXT(c, next), i++) {
+                c->index = i;
+            }
         }
-        s->index = i;
-        consoles[i] = s;
-        nb_consoles++;
     }
     return s;
 }
@@ -1861,21 +1875,21 @@ static DisplayState *get_alloc_displaystate(void)
 DisplayState *init_displaystate(void)
 {
     gchar *name;
-    int i;
+    QemuConsole *con;
 
     get_alloc_displaystate();
-    for (i = 0; i < nb_consoles; i++) {
-        if (consoles[i]->console_type != GRAPHIC_CONSOLE &&
-            consoles[i]->ds == NULL) {
-            text_console_do_init(consoles[i]->chr, display_state);
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (con->console_type != GRAPHIC_CONSOLE &&
+            con->ds == NULL) {
+            text_console_do_init(con->chr, display_state);
         }
 
         /* Hook up into the qom tree here (not in new_console()), once
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
-        name = g_strdup_printf("console[%d]", i);
+        name = g_strdup_printf("console[%d]", con->index);
         object_property_add_child(container_get(object_get_root(), "/backend"),
-                                  name, OBJECT(consoles[i]), &error_abort);
+                                  name, OBJECT(con), &error_abort);
         g_free(name);
     }
 
@@ -1957,33 +1971,34 @@ void graphic_console_close(QemuConsole *con)
 
 QemuConsole *qemu_console_lookup_by_index(unsigned int index)
 {
-    if (index >= nb_consoles) {
-        return NULL;
+    QemuConsole *con;
+
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (con->index == index) {
+            return con;
+        }
     }
-    return consoles[index];
+    return NULL;
 }
 
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head)
 {
+    QemuConsole *con;
     Object *obj;
     uint32_t h;
-    int i;
 
-    for (i = 0; i < nb_consoles; i++) {
-        if (!consoles[i]) {
-            continue;
-        }
-        obj = object_property_get_link(OBJECT(consoles[i]),
+    QTAILQ_FOREACH(con, &consoles, next) {
+        obj = object_property_get_link(OBJECT(con),
                                        "device", &error_abort);
         if (DEVICE(obj) != dev) {
             continue;
         }
-        h = object_property_get_uint(OBJECT(consoles[i]),
+        h = object_property_get_uint(OBJECT(con),
                                      "head", &error_abort);
         if (h != head) {
             continue;
         }
-        return consoles[i];
+        return con;
     }
     return NULL;
 }
@@ -2013,22 +2028,19 @@ QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
 
 QemuConsole *qemu_console_lookup_unused(void)
 {
+    QemuConsole *con;
     Object *obj;
-    int i;
 
-    for (i = 0; i < nb_consoles; i++) {
-        if (!consoles[i]) {
+    QTAILQ_FOREACH(con, &consoles, next) {
+        if (con->hw_ops != &unused_ops) {
             continue;
         }
-        if (consoles[i]->hw_ops != &unused_ops) {
-            continue;
-        }
-        obj = object_property_get_link(OBJECT(consoles[i]),
+        obj = object_property_get_link(OBJECT(con),
                                        "device", &error_abort);
         if (obj != NULL) {
             continue;
         }
-        return consoles[i];
+        return con;
     }
     return NULL;
 }
@@ -2130,12 +2142,11 @@ static void text_console_update_cursor_timer(void)
 static void text_console_update_cursor(void *opaque)
 {
     QemuConsole *s;
-    int i, count = 0;
+    int count = 0;
 
     cursor_visible_phase = !cursor_visible_phase;
 
-    for (i = 0; i < nb_consoles; i++) {
-        s = consoles[i];
+    QTAILQ_FOREACH(s, &consoles, next) {
         if (qemu_console_is_graphic(s) ||
             !qemu_console_is_visible(s)) {
             continue;
-- 
2.9.3
