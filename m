Received: from eggs.gnu.org ([209.51.188.92]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQz-0007Vz-KE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQw-0006Mh-6S
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQt-0006Ba-9H
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:51 +0100
Message-Id: <20190205105758.4230-8-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] kbd-state: add keyboard state tracker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Now that most user interfaces are using QKeyCodes it is easier to have
common keyboard code useable by all user interfaces.

This patch adds helper code to track the state of all keyboard keys,
using a bitmap indexed by QKeyCode.  Modifier state is tracked too,
as separate bitmap.  That makes checking modifier state easier.
Likewise we can easily apply special handling for capslock & numlock
(toggles on keypress) and ctrl + shift (we have two keys for that).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190122092814.14919-2-kraxel@redhat.com

[ kraxel: added license boilerplate header ]

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/ui/kbd-state.h | 101 ++++++++++++++++++++++++++++++++++++++
 ui/kbd-state.c         | 130 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 ui/Makefile.objs       |   2 +-
 3 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 include/ui/kbd-state.h
 create mode 100644 ui/kbd-state.c

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
new file mode 100644
index 0000000000..d87833553a
--- /dev/null
+++ b/include/ui/kbd-state.h
@@ -0,0 +1,101 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#ifndef QEMU_UI_KBD_STATE_H
+#define QEMU_UI_KBD_STATE_H 1
+
+#include "qapi/qapi-types-ui.h"
+
+typedef enum QKbdModifier QKbdModifier;
+
+enum QKbdModifier {
+    QKBD_MOD_NONE =3D 0,
+
+    QKBD_MOD_SHIFT,
+    QKBD_MOD_CTRL,
+    QKBD_MOD_ALT,
+    QKBD_MOD_ALTGR,
+
+    QKBD_MOD_NUMLOCK,
+    QKBD_MOD_CAPSLOCK,
+
+    QKBD_MOD__MAX
+};
+
+typedef struct QKbdState QKbdState;
+
+/**
+ * qkbd_state_init: init keyboard state tracker.
+ *
+ * Allocates and initializes keyboard state struct.
+ *
+ * @con: QemuConsole for this state tracker.  Gets passed down to
+ * qemu_input_*() functions when sending key events to the guest.
+ */
+QKbdState *qkbd_state_init(QemuConsole *con);
+
+/**
+ * qkbd_state_free: free keyboard tracker state.
+ *
+ * @kbd: state tracker state.
+ */
+void qkbd_state_free(QKbdState *kbd);
+
+/**
+ * qkbd_state_key_event: process key event.
+ *
+ * Update keyboard state, send event to the guest.
+ *
+ * This function takes care to not send suspious events (keyup event
+ * for a key not pressed for example).
+ *
+ * @kbd: state tracker state.
+ * @qcode: the key pressed or released.
+ * @down: true for key down events, false otherwise.
+ */
+void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
+
+/**
+ * qkbd_state_set_delay: set key press delay.
+ *
+ * When set the specified delay will be added after each key event,
+ * using qemu_input_event_send_key_delay().
+ *
+ * @kbd: state tracker state.
+ * @delay_ms: the delay in miliseconds.
+ */
+void qkbd_state_set_delay(QKbdState *kbd, int delay_ms);
+
+/**
+ * qkbd_state_key_get: get key state.
+ *
+ * Returns true when the key is down.
+ *
+ * @kbd: state tracker state.
+ * @qcode: the key to query.
+ */
+bool qkbd_state_key_get(QKbdState *kbd, QKeyCode qcode);
+
+/**
+ * qkbd_state_modifier_get: get modifier state.
+ *
+ * Returns true when the modifier is active.
+ *
+ * @kbd: state tracker state.
+ * @mod: the modifier to query.
+ */
+bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod);
+
+/**
+ * qkbd_state_lift_all_keys: lift all pressed keys.
+ *
+ * This sends key up events to the guest for all keys which are in
+ * down state.
+ *
+ * @kbd: state tracker state.
+ */
+void qkbd_state_lift_all_keys(QKbdState *kbd);
+
+#endif /* QEMU_UI_KBD_STATE_H */
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
new file mode 100644
index 0000000000..ac14add70e
--- /dev/null
+++ b/ui/kbd-state.c
@@ -0,0 +1,130 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "qemu/queue.h"
+#include "ui/console.h"
+#include "ui/input.h"
+#include "ui/kbd-state.h"
+
+struct QKbdState {
+    QemuConsole *con;
+    int key_delay_ms;
+    DECLARE_BITMAP(keys, Q_KEY_CODE__MAX);
+    DECLARE_BITMAP(mods, QKBD_MOD__MAX);
+};
+
+static void qkbd_state_modifier_update(QKbdState *kbd,
+                                      QKeyCode qcode1, QKeyCode qcode2,
+                                      QKbdModifier mod)
+{
+    if (test_bit(qcode1, kbd->keys) || test_bit(qcode2, kbd->keys)) {
+        set_bit(mod, kbd->mods);
+    } else {
+        clear_bit(mod, kbd->mods);
+    }
+}
+
+bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod)
+{
+    return test_bit(mod, kbd->mods);
+}
+
+bool qkbd_state_key_get(QKbdState *kbd, QKeyCode qcode)
+{
+    return test_bit(qcode, kbd->keys);
+}
+
+void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
+{
+    bool state =3D test_bit(qcode, kbd->keys);
+
+    if (state =3D=3D down) {
+        /*
+         * Filter out events which don't change the keyboard state.
+         *
+         * Most notably this allows to simply send along all key-up
+         * events, and this function will filter out everything where
+         * the corresponding key-down event wasn't send to the guest,
+         * for example due to being a host hotkey.
+         */
+        return;
+    }
+
+    /* update key and modifier state */
+    change_bit(qcode, kbd->keys);
+    switch (qcode) {
+    case Q_KEY_CODE_SHIFT:
+    case Q_KEY_CODE_SHIFT_R:
+        qkbd_state_modifier_update(kbd, Q_KEY_CODE_SHIFT, Q_KEY_CODE_SHI=
FT_R,
+                                   QKBD_MOD_SHIFT);
+        break;
+    case Q_KEY_CODE_CTRL:
+    case Q_KEY_CODE_CTRL_R:
+        qkbd_state_modifier_update(kbd, Q_KEY_CODE_CTRL, Q_KEY_CODE_CTRL=
_R,
+                                   QKBD_MOD_CTRL);
+        break;
+    case Q_KEY_CODE_ALT:
+        qkbd_state_modifier_update(kbd, Q_KEY_CODE_ALT, Q_KEY_CODE_ALT,
+                                   QKBD_MOD_ALT);
+        break;
+    case Q_KEY_CODE_ALT_R:
+        qkbd_state_modifier_update(kbd, Q_KEY_CODE_ALT_R, Q_KEY_CODE_ALT=
_R,
+                                   QKBD_MOD_ALTGR);
+        break;
+    case Q_KEY_CODE_CAPS_LOCK:
+        if (down) {
+            change_bit(QKBD_MOD_CAPSLOCK, kbd->mods);
+        }
+        break;
+    case Q_KEY_CODE_NUM_LOCK:
+        if (down) {
+            change_bit(QKBD_MOD_NUMLOCK, kbd->mods);
+        }
+        break;
+    default:
+        /* keep gcc happy */
+        break;
+    }
+
+    /* send to guest */
+    if (qemu_console_is_graphic(kbd->con)) {
+        qemu_input_event_send_key_qcode(kbd->con, qcode, down);
+        if (kbd->key_delay_ms) {
+            qemu_input_event_send_key_delay(kbd->key_delay_ms);
+        }
+    }
+}
+
+void qkbd_state_lift_all_keys(QKbdState *kbd)
+{
+    int qcode;
+
+    for (qcode =3D 0; qcode < Q_KEY_CODE__MAX; qcode++) {
+        if (test_bit(qcode, kbd->keys)) {
+            qkbd_state_key_event(kbd, qcode, false);
+        }
+    }
+}
+
+void qkbd_state_set_delay(QKbdState *kbd, int delay_ms)
+{
+    kbd->key_delay_ms =3D delay_ms;
+}
+
+void qkbd_state_free(QKbdState *kbd)
+{
+    g_free(kbd);
+}
+
+QKbdState *qkbd_state_init(QemuConsole *con)
+{
+    QKbdState *kbd =3D g_new0(QKbdState, 1);
+
+    kbd->con =3D con;
+
+    return kbd;
+}
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 9b6f0c6b67..7f8b3da791 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -8,7 +8,7 @@ vnc-obj-y +=3D vnc-ws.o
 vnc-obj-y +=3D vnc-jobs.o
=20
 common-obj-y +=3D keymaps.o console.o cursor.o qemu-pixman.o
-common-obj-y +=3D input.o input-keymap.o input-legacy.o
+common-obj-y +=3D input.o input-keymap.o input-legacy.o kbd-state.o
 common-obj-$(CONFIG_LINUX) +=3D input-linux.o
 common-obj-$(CONFIG_SPICE) +=3D spice-core.o spice-input.o spice-display=
.o
 common-obj-$(CONFIG_COCOA) +=3D cocoa.o
--=20
2.9.3
