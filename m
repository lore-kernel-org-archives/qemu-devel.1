Received: from eggs.gnu.org ([2001:4830:134:3::10]:60905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996p-0002tF-0G
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-00055p-J2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996n-00055B-8q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:26 +0200
Message-Id: <20170512115135.17379-2-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] ui: Support non-zero minimum values for
 absolute input axes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe Voinov <philippevoinov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Philippe Voinov <philippevoinov@gmail.com>

This patch refactors ui/input.c to support absolute axis
minimum values other than 0. All dependent calls to qemu_input_queue_abs
have been updated to explicitly supply 0 as the axis minimum value.

Signed-off-by: Philippe Voinov <philippevoinov@gmail.com>
Message-id: 20170505133952.29885-1-philippevoinov@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/input.h          | 11 +++++++----
 hw/input/virtio-input-hid.c |  6 ++++--
 ui/gtk.c                    |  4 ++--
 ui/input.c                  | 31 ++++++++++++++++++++++---------
 ui/sdl.c                    |  4 ++--
 ui/sdl2.c                   |  4 ++--
 ui/spice-input.c            |  4 ++--
 ui/vnc.c                    |  4 ++--
 ui/cocoa.m                  |  4 ++--
 9 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index d06a12dd4c..3cfd0f3363 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -8,7 +8,8 @@
 #define INPUT_EVENT_MASK_REL   (1<<INPUT_EVENT_KIND_REL)
 #define INPUT_EVENT_MASK_ABS   (1<<INPUT_EVENT_KIND_ABS)
 
-#define INPUT_EVENT_ABS_SIZE   0x8000
+#define INPUT_EVENT_ABS_MIN    0x0000
+#define INPUT_EVENT_ABS_MAX    0x7FFF
 
 typedef struct QemuInputHandler QemuInputHandler;
 typedef struct QemuInputHandlerState QemuInputHandlerState;
@@ -54,12 +55,14 @@ void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
 
 bool qemu_input_is_absolute(void);
-int qemu_input_scale_axis(int value, int size_in, int size_out);
+int qemu_input_scale_axis(int value,
+                          int min_in, int max_in,
+                          int min_out, int max_out);
 InputEvent *qemu_input_event_new_move(InputEventKind kind,
                                       InputAxis axis, int value);
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
-void qemu_input_queue_abs(QemuConsole *src, InputAxis axis,
-                          int value, int size);
+void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
+                          int min_in, int max_in);
 
 void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 3ee0c1814a..46c038110c 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -484,12 +484,14 @@ static struct virtio_input_config virtio_tablet_config[] = {
         .select    = VIRTIO_INPUT_CFG_ABS_INFO,
         .subsel    = ABS_X,
         .size      = sizeof(virtio_input_absinfo),
-        .u.abs.max = const_le32(INPUT_EVENT_ABS_SIZE - 1),
+        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
     },{
         .select    = VIRTIO_INPUT_CFG_ABS_INFO,
         .subsel    = ABS_Y,
         .size      = sizeof(virtio_input_absinfo),
-        .u.abs.max = const_le32(INPUT_EVENT_ABS_SIZE - 1),
+        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
     },
     { /* end of list */ },
 };
diff --git a/ui/gtk.c b/ui/gtk.c
index 7479ceef35..0213ad0efc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -912,9 +912,9 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
             return TRUE;
         }
         qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_X, x,
-                             surface_width(vc->gfx.ds));
+                             0, surface_width(vc->gfx.ds));
         qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_Y, y,
-                             surface_height(vc->gfx.ds));
+                             0, surface_height(vc->gfx.ds));
         qemu_input_event_sync();
     } else if (s->last_set && s->ptr_owner == vc) {
         qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_X, x - s->last_x);
diff --git a/ui/input.c b/ui/input.c
index 830f912f99..290ca9f54d 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -166,6 +166,11 @@ void qmp_input_send_event(bool has_device, const char *device,
     qemu_input_event_sync();
 }
 
+static int qemu_input_transform_invert_abs_value(int value)
+{
+  return (int64_t)INPUT_EVENT_ABS_MAX - value + INPUT_EVENT_ABS_MIN;
+}
+
 static void qemu_input_transform_abs_rotate(InputEvent *evt)
 {
     InputMoveEvent *move = evt->u.abs.data;
@@ -175,16 +180,16 @@ static void qemu_input_transform_abs_rotate(InputEvent *evt)
             move->axis = INPUT_AXIS_Y;
         } else if (move->axis == INPUT_AXIS_Y) {
             move->axis = INPUT_AXIS_X;
-            move->value = INPUT_EVENT_ABS_SIZE - 1 - move->value;
+            move->value = qemu_input_transform_invert_abs_value(move->value);
         }
         break;
     case 180:
-        move->value = INPUT_EVENT_ABS_SIZE - 1 - move->value;
+        move->value = qemu_input_transform_invert_abs_value(move->value);
         break;
     case 270:
         if (move->axis == INPUT_AXIS_X) {
             move->axis = INPUT_AXIS_Y;
-            move->value = INPUT_EVENT_ABS_SIZE - 1 - move->value;
+            move->value = qemu_input_transform_invert_abs_value(move->value);
         } else if (move->axis == INPUT_AXIS_Y) {
             move->axis = INPUT_AXIS_X;
         }
@@ -467,12 +472,17 @@ bool qemu_input_is_absolute(void)
     return (s != NULL) && (s->handler->mask & INPUT_EVENT_MASK_ABS);
 }
 
-int qemu_input_scale_axis(int value, int size_in, int size_out)
+int qemu_input_scale_axis(int value,
+                          int min_in, int max_in,
+                          int min_out, int max_out)
 {
-    if (size_in < 2) {
-        return size_out / 2;
+    int64_t range_in = (int64_t)max_in - min_in;
+    int64_t range_out = (int64_t)max_out - min_out;
+
+    if (range_in < 1) {
+        return min_out + range_out / 2;
     }
-    return (int64_t)value * (size_out - 1) / (size_in - 1);
+    return ((int64_t)value - min_in) * range_out / range_in + min_out;
 }
 
 InputEvent *qemu_input_event_new_move(InputEventKind kind,
@@ -496,10 +506,13 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
     qapi_free_InputEvent(evt);
 }
 
-void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value, int size)
+void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
+                          int min_in, int max_in)
 {
     InputEvent *evt;
-    int scaled = qemu_input_scale_axis(value, size, INPUT_EVENT_ABS_SIZE);
+    int scaled = qemu_input_scale_axis(value, min_in, max_in,
+                                       INPUT_EVENT_ABS_MIN,
+                                       INPUT_EVENT_ABS_MAX);
     evt = qemu_input_event_new_move(INPUT_EVENT_KIND_ABS, axis, scaled);
     qemu_input_event_send(src, evt);
     qapi_free_InputEvent(evt);
diff --git a/ui/sdl.c b/ui/sdl.c
index 37c21a00fb..b35a67855f 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -490,9 +490,9 @@ static void sdl_send_mouse_event(int dx, int dy, int x, int y, int state)
 
     if (qemu_input_is_absolute()) {
         qemu_input_queue_abs(dcl->con, INPUT_AXIS_X, x,
-                             real_screen->w);
+                             0, real_screen->w);
         qemu_input_queue_abs(dcl->con, INPUT_AXIS_Y, y,
-                             real_screen->h);
+                             0, real_screen->h);
     } else {
         if (guest_cursor) {
             x -= guest_x;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index faf9bdff5c..21de05200e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -298,8 +298,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
                 }
             }
         }
-        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X, off_x + x, max_w);
-        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y, off_y + y, max_h);
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X, off_x + x, 0, max_w);
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y, off_y + y, 0, max_h);
     } else {
         if (guest_cursor) {
             x -= guest_x;
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 8eeebdbb2e..86293dd2ce 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -172,8 +172,8 @@ static void tablet_position(SpiceTabletInstance* sin, int x, int y,
     QemuSpicePointer *pointer = container_of(sin, QemuSpicePointer, tablet);
 
     spice_update_buttons(pointer, 0, buttons_state);
-    qemu_input_queue_abs(NULL, INPUT_AXIS_X, x, pointer->width);
-    qemu_input_queue_abs(NULL, INPUT_AXIS_Y, y, pointer->height);
+    qemu_input_queue_abs(NULL, INPUT_AXIS_X, x, 0, pointer->width);
+    qemu_input_queue_abs(NULL, INPUT_AXIS_Y, y, 0, pointer->height);
     qemu_input_event_sync();
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9c4edcdbf5..601f9ec539 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1556,8 +1556,8 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
     }
 
     if (vs->absolute) {
-        qemu_input_queue_abs(con, INPUT_AXIS_X, x, width);
-        qemu_input_queue_abs(con, INPUT_AXIS_Y, y, height);
+        qemu_input_queue_abs(con, INPUT_AXIS_X, x, 0, width);
+        qemu_input_queue_abs(con, INPUT_AXIS_Y, y, 0, height);
     } else if (vnc_has_feature(vs, VNC_FEATURE_POINTER_TYPE_CHANGE)) {
         qemu_input_queue_rel(con, INPUT_AXIS_X, x - 0x7FFF);
         qemu_input_queue_rel(con, INPUT_AXIS_Y, y - 0x7FFF);
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 207555edf7..3a9bc4da5f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -749,8 +749,8 @@ QemuCocoaView *cocoaView;
                  * clicks in the titlebar.
                  */
                 if ([self screenContainsPoint:p]) {
-                    qemu_input_queue_abs(dcl->con, INPUT_AXIS_X, p.x, screen.width);
-                    qemu_input_queue_abs(dcl->con, INPUT_AXIS_Y, screen.height - p.y, screen.height);
+                    qemu_input_queue_abs(dcl->con, INPUT_AXIS_X, p.x, 0, screen.width);
+                    qemu_input_queue_abs(dcl->con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
                 }
             } else {
                 qemu_input_queue_rel(dcl->con, INPUT_AXIS_X, (int)[event deltaX]);
-- 
2.9.3
