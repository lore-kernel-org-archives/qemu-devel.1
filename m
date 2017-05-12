Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-0002t0-4y
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996l-00054a-P9
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996l-000543-GP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:43 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:27 +0200
Message-Id: <20170512115135.17379-3-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] ui: input-linux: Add absolute event
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe Voinov <philippevoinov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Voinov <philippevoinov@gmail.com>

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

Signed-off-by: Philippe Voinov <philippevoinov@gmail.com>
Message-id: 20170505134231.30210-1-philippevoinov@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-linux.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index dc0613ca1f..49d52a69cc 100644
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
 
-- 
2.9.3
