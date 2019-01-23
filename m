Received: from eggs.gnu.org ([209.51.188.92]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gmQNR-0002Pc-In
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gmQMG-0000oL-QK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:46:53 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <relkochta@gmail.com>) id 1gmQMG-0000nj-Mf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:46:52 -0500
Received: by mail-qt1-x844.google.com with SMTP id l11so4273198qtp.0
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:46:52 -0800 (PST)
From: Ryan El Kochta <relkochta@gmail.com>
Date: Wed, 23 Jan 2019 16:45:55 -0500
Message-Id: <20190123214555.12712-2-relkochta@gmail.com>
In-Reply-To: <20190123214555.12712-1-relkochta@gmail.com>
References: <20190123214555.12712-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] input-linux: customizable grab toggle keys
 v5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Ryan El Kochta <relkochta@gmail.com>

The latest revision of the input-linux customizable grab toggle keys
patch.

Signed-off-by: Ryan El Kochta <relkochta@gmail.com>
---
 qapi/ui.json     | 10 ++++++++
 ui/input-linux.c | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 5ad1324..7d9c4bd 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1016,6 +1016,16 @@
             '*head'  : 'int',
             'events' : [ 'InputEvent' ] } }
 
+##
+# @GrabToggleKeys:
+#
+# Keys to toggle input-linux between host and guest.
+#
+# Since: 4.0
+#
+##
+{ 'enum': 'GrabToggleKeys',
+  'data': [ 'ctrl-ctrl', 'alt-alt', 'meta-meta', 'scrolllock', 'ctrl-scrolllock' ] }
 
 ##
 # @DisplayGTK:
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333..ba550dd 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -12,6 +12,8 @@
 #include "sysemu/sysemu.h"
 #include "ui/input.h"
 #include "qom/object_interfaces.h"
+#include "sysemu/iothread.h"
+#include "block/aio.h"
 
 #include <sys/ioctl.h>
 #include "standard-headers/linux/input.h"
@@ -63,6 +65,8 @@ struct InputLinux {
     struct input_event event;
     int         read_offset;
 
+    enum GrabToggleKeys grab_toggle;
+
     QTAILQ_ENTRY(InputLinux) next;
 };
 
@@ -98,6 +102,44 @@ static void input_linux_toggle_grab(InputLinux *il)
     }
 }
 
+static bool input_linux_check_toggle(InputLinux *il)
+{
+    switch (il->grab_toggle) {
+    case GRAB_TOGGLE_KEYS_CTRL_CTRL:
+        return il->keydown[KEY_LEFTCTRL] &&
+            il->keydown[KEY_RIGHTCTRL];
+
+    case GRAB_TOGGLE_KEYS_ALT_ALT:
+        return il->keydown[KEY_LEFTALT] &&
+            il->keydown[KEY_RIGHTALT];
+
+    case GRAB_TOGGLE_KEYS_META_META:
+        return il->keydown[KEY_LEFTMETA] &&
+            il->keydown[KEY_RIGHTMETA];
+
+    case GRAB_TOGGLE_KEYS_SCROLLLOCK:
+        return il->keydown[KEY_SCROLLLOCK];
+
+    case GRAB_TOGGLE_KEYS_CTRL_SCROLLLOCK:
+        return (il->keydown[KEY_LEFTCTRL] ||
+                il->keydown[KEY_RIGHTCTRL]) &&
+            il->keydown[KEY_SCROLLLOCK];
+
+    case GRAB_TOGGLE_KEYS__MAX:
+        /* avoid gcc error */
+        break;
+    }
+    return false;
+}
+
+static bool input_linux_should_skip(InputLinux *il,
+                                    struct input_event *event)
+{
+    return (il->grab_toggle == GRAB_TOGGLE_KEYS_SCROLLLOCK ||
+            il->grab_toggle == GRAB_TOGGLE_KEYS_CTRL_SCROLLLOCK) &&
+            event->code == KEY_SCROLLLOCK;
+}
+
 static void input_linux_handle_keyboard(InputLinux *il,
                                         struct input_event *event)
 {
@@ -128,14 +170,13 @@ static void input_linux_handle_keyboard(InputLinux *il,
         }
 
         /* send event to guest when grab is active */
-        if (il->grab_active) {
+        if (il->grab_active && !input_linux_should_skip(il, event)) {
             int qcode = qemu_input_linux_to_qcode(event->code);
             qemu_input_event_send_key_qcode(NULL, qcode, event->value);
         }
 
         /* hotkey -> record switch request ... */
-        if (il->keydown[KEY_LEFTCTRL] &&
-            il->keydown[KEY_RIGHTCTRL]) {
+        if (input_linux_check_toggle(il)) {
             il->grab_request = true;
         }
 
@@ -410,6 +451,21 @@ static void input_linux_set_repeat(Object *obj, bool value,
     il->repeat = value;
 }
 
+static int input_linux_get_grab_toggle(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    return il->grab_toggle;
+}
+
+static void input_linux_set_grab_toggle(Object *obj, int value,
+                                       Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    il->grab_toggle = value;
+}
+
 static void input_linux_instance_init(Object *obj)
 {
     object_property_add_str(obj, "evdev",
@@ -421,6 +477,10 @@ static void input_linux_instance_init(Object *obj)
     object_property_add_bool(obj, "repeat",
                              input_linux_get_repeat,
                              input_linux_set_repeat, NULL);
+    object_property_add_enum(obj, "grab-toggle", "GrabToggleKeys",
+                             &GrabToggleKeys_lookup,
+                             input_linux_get_grab_toggle,
+                             input_linux_set_grab_toggle, NULL);
 }
 
 static void input_linux_class_init(ObjectClass *oc, void *data)
-- 
2.20.1
