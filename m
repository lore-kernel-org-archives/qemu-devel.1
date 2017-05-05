Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6cDx-0006D2-JV
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6cDu-00074n-CS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:20:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippevoinov@gmail.com>)
	id 1d6cDu-00074d-2b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:20:38 -0400
Received: by mail-wm0-x241.google.com with SMTP id b10so1015971wmh.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 05:20:38 -0700 (PDT)
From: Philippe Voinov <philippevoinov@gmail.com>
Date: Fri,  5 May 2017 14:20:19 +0200
Message-Id: <20170505122019.23144-1-philippevoinov@gmail.com>
Subject: [Qemu-devel] [PATCH v2] ui: input-linux: Add absolute event support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Philippe Voinov <philippevoinov@gmail.com>

This patch adds support for absolute pointer events to the input-linux
subsystem. This support was omitted from the original input-linux patch,
however most of the code required for it is already in place.

Support for absolute events is especially useful for guests with vga
passthrough. Since they have a physical monitor, none of normal channels
for sending video output (vnc, etc) are used, meaning they also can't be
used to send absolute input events. This leaves QMP as the only option
to send absolute input into vga passthrough guests, which is not its
intended use and is not efficient.

This patch allows, for example, uinput to be used to create virtual
absolute input devices. This lets you build external systems which share
physical input devices between guests. Without absolute input
capability, such external systems can't seamlessly share pointer devices
between guests.

This patch also refactors the ui/input.c to support absolute axis
minimum values other than 0.

Signed-off-by: Philippe Voinov <philippevoinov@gmail.com>
---
 hw/input/virtio-input-hid.c |  6 ++++--
 include/ui/input.h          | 11 +++++++----
 ui/cocoa.m                  |  4 ++--
 ui/gtk.c                    |  4 ++--
 ui/input-linux.c            | 25 ++++++++++++++++++++++++-
 ui/input.c                  | 31 ++++++++++++++++++++++---------
 ui/sdl.c                    |  4 ++--
 ui/sdl2.c                   |  4 ++--
 ui/spice-input.c            |  4 ++--
 ui/vnc.c                    |  4 ++--
 10 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 3ee0c18..46c0381 100644
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
diff --git a/include/ui/input.h b/include/ui/input.h
index d06a12d..3cfd0f3 100644
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
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 207555e..3a9bc4d 100644
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
diff --git a/ui/gtk.c b/ui/gtk.c
index a86848f..0798d97 100644
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
diff --git a/ui/input-linux.c b/ui/input-linux.c
index dc0613c..49d52a6 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -169,6 +169,10 @@ struct InputLinux {
     bool        has_abs_x;
     int         num_keys;
     int         num_btns;
+    int         abs_x_min;
+    int         abs_x_max;
+    int         abs_y_min;
+    int         abs_y_max;
     struct input_event event;
     int         read_offset;
 
@@ -314,6 +318,18 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
             break;
         }
         break;
+    case EV_ABS:
+        switch (event->code) {
+        case ABS_X:
+            qemu_input_queue_abs(NULL, INPUT_AXIS_X, event->value,
+                                 il->abs_x_min, il->abs_x_max);
+            break;
+        case ABS_Y:
+            qemu_input_queue_abs(NULL, INPUT_AXIS_Y, event->value,
+                                 il->abs_y_min, il->abs_y_max);
+            break;
+        }
+        break;
     case EV_SYN:
         qemu_input_event_sync();
         if (il->wheel != 0) {
@@ -351,7 +367,7 @@ static void input_linux_event(void *opaque)
         if (il->num_keys) {
             input_linux_handle_keyboard(il, &il->event);
         }
-        if (il->has_rel_x && il->num_btns) {
+        if ((il->has_rel_x || il->has_abs_x) && il->num_btns) {
             input_linux_handle_mouse(il, &il->event);
         }
     }
@@ -364,6 +380,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
     uint8_t keymap[KEY_CNT / 8], keystate[KEY_CNT / 8];
     unsigned int i;
     int rc, ver;
+    struct input_absinfo absinfo;
 
     if (!il->evdev) {
         error_setg(errp, "no input device specified");
@@ -402,6 +419,12 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         rc = ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap);
         if (absmap & (1 << ABS_X)) {
             il->has_abs_x = true;
+            rc = ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
+            il->abs_x_min = absinfo.minimum;
+            il->abs_x_max = absinfo.maximum;
+            rc = ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
+            il->abs_y_min = absinfo.minimum;
+            il->abs_y_max = absinfo.maximum;
         }
     }
 
diff --git a/ui/input.c b/ui/input.c
index ed88cda..25e6e31 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -164,6 +164,11 @@ void qmp_input_send_event(bool has_device, const char *device,
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
@@ -173,16 +178,16 @@ static void qemu_input_transform_abs_rotate(InputEvent *evt)
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
@@ -455,12 +460,17 @@ bool qemu_input_is_absolute(void)
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
@@ -484,10 +494,13 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
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
index 37c21a0..b35a678 100644
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
index faf9bdf..21de052 100644
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
index 8eeebdb..86293dd 100644
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
index 349cfc9..60d358f 100644
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
-- 
2.12.2
