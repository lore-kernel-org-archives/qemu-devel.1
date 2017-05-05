Received: from eggs.gnu.org ([2001:4830:134:3::10]:48668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6YB5-0007oa-RU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippevoinov@gmail.com>) id 1d6YB1-0007JW-16
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:01:27 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippevoinov@gmail.com>)
	id 1d6YB0-0007JI-Q8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:01:22 -0400
Received: by mail-wm0-x241.google.com with SMTP id z129so8115668wmb.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:01:21 -0700 (PDT)
From: Philippe Voinov <philippevoinov@gmail.com>
Date: Fri,  5 May 2017 09:59:18 +0200
Message-Id: <20170505075918.4033-1-philippevoinov@gmail.com>
Subject: [Qemu-devel] [PATCH] ui: input-linux: Add absolute event support
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
however almost all the code required for it is already in place.

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

Signed-off-by: Philippe Voinov <philippevoinov@gmail.com>
---
 ui/input-linux.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index dc0613c..7946b87 100644
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
 
@@ -268,6 +272,11 @@ static void input_linux_event_mouse_button(int button)
     qemu_input_event_sync();
 }
 
+static void input_linux_event_abs(InputAxis axis, int value, int min, int max)
+{
+    qemu_input_queue_abs(NULL, axis, value - min, max - min);
+}
+
 static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
 {
     if (!il->grab_active) {
@@ -314,6 +323,18 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
             break;
         }
         break;
+    case EV_ABS:
+        switch (event->code) {
+        case ABS_X:
+            input_linux_event_abs(INPUT_AXIS_X, event->value,
+                                  il->abs_x_min, il->abs_x_max);
+            break;
+        case ABS_Y:
+            input_linux_event_abs(INPUT_AXIS_Y, event->value,
+                                  il->abs_y_min, il->abs_y_max);
+            break;
+        }
+        break;
     case EV_SYN:
         qemu_input_event_sync();
         if (il->wheel != 0) {
@@ -351,12 +372,18 @@ static void input_linux_event(void *opaque)
         if (il->num_keys) {
             input_linux_handle_keyboard(il, &il->event);
         }
-        if (il->has_rel_x && il->num_btns) {
+        if ((il->has_rel_x || il->has_abs_x) && il->num_btns) {
             input_linux_handle_mouse(il, &il->event);
         }
     }
 }
 
+static bool input_linux_abs_range_is_valid(int min, int max)
+{
+  int64_t difference = ((int64_t) max) - ((int64_t) min);
+  return difference > 0 && difference <= INT_MAX;
+}
+
 static void input_linux_complete(UserCreatable *uc, Error **errp)
 {
     InputLinux *il = INPUT_LINUX(uc);
@@ -364,6 +391,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
     uint8_t keymap[KEY_CNT / 8], keystate[KEY_CNT / 8];
     unsigned int i;
     int rc, ver;
+    struct input_absinfo absinfo;
 
     if (!il->evdev) {
         error_setg(errp, "no input device specified");
@@ -402,6 +430,17 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         rc = ioctl(il->fd, EVIOCGBIT(EV_ABS, sizeof(absmap)), &absmap);
         if (absmap & (1 << ABS_X)) {
             il->has_abs_x = true;
+            rc = ioctl(il->fd, EVIOCGABS(ABS_X), &absinfo);
+            il->abs_x_min = absinfo.minimum;
+            il->abs_x_max = absinfo.maximum;
+            rc = ioctl(il->fd, EVIOCGABS(ABS_Y), &absinfo);
+            il->abs_y_min = absinfo.minimum;
+            il->abs_y_max = absinfo.maximum;
+            if (!input_linux_abs_range_is_valid(il->abs_x_min, il->abs_x_max) ||
+                !input_linux_abs_range_is_valid(il->abs_y_min, il->abs_y_max)) {
+                error_setg(errp, "incompatible evdev absolute axis range");
+                goto err_close;
+            }
         }
     }
 
-- 
2.12.2
