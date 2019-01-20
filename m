Received: from eggs.gnu.org ([209.51.188.92]:43607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gl4Vj-00085Z-VN
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 23:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <relkochta@gmail.com>) id 1gl4Vi-0001Gr-VO
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 23:15:03 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <relkochta@gmail.com>) id 1gl4Vi-0001G7-QO
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 23:15:02 -0500
Received: by mail-qt1-x841.google.com with SMTP id d19so19569587qtq.9
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 20:15:02 -0800 (PST)
From: Ryan El Kochta <relkochta@gmail.com>
Date: Sat, 19 Jan 2019 23:14:27 -0500
Message-Id: <20190120041427.21602-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] input-linux: customizable grab toggle keys v4
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

This patch adds a new option to the input-linux object:

grab-toggle=[key-combo]

The key combination can be one of the following:

* ctrl-ctrl
* alt-alt
* meta-meta
* ctrl-alt
* scrolllock
* ctrl-scrolllock
* ctrl-backtick

The user can pick any of these key combinations. The VM's grab
of the evdev device will be toggled when the key combination is
pressed.

Any invalid setting will result in an error. No setting will
result in the current default of ctrl-ctrl.

If scrolllock is selected as one of the grab-toggle keys, it
will be entirely disabled and not passed to the guest at all.
This is to prevent enabling it while attempting to leave or enter
the VM. On the host, scrolllock can be disabled using xmodmap.

First, find the modifier that Scroll_Lock is bound to:

$ xmodmap -pm

Then, remove Scroll_Lock from it, replacing modX with the modifier:

$ xmodmap -e 'remove modX = Scroll_Lock'

If Scroll_Lock is not bound to any modifier, it is already disabled.

To save the changes, add them to your xinitrc.

Side note - I have changed e-mail addresses from
lightn1ngstr1ke@protonmail.com due to issues with git send-mail.
I am the same person.

Signed-off-by: Ryan El Kochta <relkochta@gmail.com>
---
 qapi/ui.json     | 10 +++++++
 ui/input-linux.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 5ad1324..487653a 100644
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
+  'data': [ 'ctrl-ctrl', 'alt-alt', 'meta-meta', 'ctrl-alt', 'scrolllock', 'ctrl-scrolllock', 'ctrl-backtick' ] }
 
 ##
 # @DisplayGTK:
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333..65d1fb9 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -63,6 +63,8 @@ struct InputLinux {
     struct input_event event;
     int         read_offset;
 
+    enum GrabToggleKeys grab_toggle;
+
     QTAILQ_ENTRY(InputLinux) next;
 };
 
@@ -98,6 +100,51 @@ static void input_linux_toggle_grab(InputLinux *il)
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
+    case GRAB_TOGGLE_KEYS_CTRL_ALT:
+        return il->keydown[KEY_LEFTCTRL] &&
+            il->keydown[KEY_LEFTALT];
+
+    case GRAB_TOGGLE_KEYS_SCROLLLOCK:
+        return il->keydown[KEY_SCROLLLOCK];
+
+    case GRAB_TOGGLE_KEYS_CTRL_SCROLLLOCK:
+        return il->keydown[KEY_LEFTCTRL] &&
+            il->keydown[KEY_SCROLLLOCK];
+
+    case GRAB_TOGGLE_KEYS_CTRL_BACKTICK:
+        return il->keydown[KEY_LEFTCTRL] &&
+            il->keydown[KEY_GRAVE];
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
@@ -128,14 +175,13 @@ static void input_linux_handle_keyboard(InputLinux *il,
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
 
@@ -410,6 +456,21 @@ static void input_linux_set_repeat(Object *obj, bool value,
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
@@ -421,6 +482,10 @@ static void input_linux_instance_init(Object *obj)
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
