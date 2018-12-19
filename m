Received: from eggs.gnu.org ([2001:4830:134:3::10]:44768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafA-0003Ig-5F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf2-0000AH-ID
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf0-00009A-JO
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB1592D2BD5
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:09 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:08:58 +0100
Message-Id: <20181219120904.17643-2-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/7] kbd-state: add keyboard state
 tracker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Now that most user interfaces are using QKeyCodes it is easier to have
common keyboard code useable by all user interfaces.

This patch adds helper code to track the state of all keyboard keys,
using a bitmap indexed by QKeyCode.  Modifier state is tracked too,
as separate bitmap.  That makes checking modifier state easier.
Likewise we can easily apply special handling for capslock & numlock
(toggles on keypress) and ctrl + shift (we have two keys for that).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/kbd-state.h |  32 +++++++++++++
 ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 ui/Makefile.objs       |   2 +-
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 include/ui/kbd-state.h
 create mode 100644 ui/kbd-state.c

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
new file mode 100644
index 0000000000..0bef75a5d5
--- /dev/null
+++ b/include/ui/kbd-state.h
@@ -0,0 +1,32 @@
+#ifndef QEMU_UI_KBD_STATE_H
+#define QEMU_UI_KBD_STATE_H 1
+
+#include "qapi/qapi-types-ui.h"
+
+typedef enum KbdModifier KbdModifier;
+
+enum KbdModifier {
+    KBD_MOD_NONE = 0,
+
+    KBD_MOD_SHIFT,
+    KBD_MOD_CTRL,
+    KBD_MOD_ALT,
+    KBD_MOD_ALTGR,
+
+    KBD_MOD_NUMLOCK,
+    KBD_MOD_CAPSLOCK,
+
+    KBD_MOD__MAX
+};
+
+typedef struct KbdState KbdState;
+
+bool kbd_state_modifier_get(KbdState *kbd, KbdModifier mod);
+bool kbd_state_key_get(KbdState *kbd, QKeyCode qcode);
+void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down);
+void kbd_state_lift_all_keys(KbdState *kbd);
+void kbd_state_set_delay(KbdState *kbd, int delay_ms);
+void kbd_state_free(KbdState *kbd);
+KbdState *kbd_state_init(QemuConsole *con);
+
+#endif /* QEMU_UI_KBD_STATE_H */
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
new file mode 100644
index 0000000000..00eb1df7fd
--- /dev/null
+++ b/ui/kbd-state.c
@@ -0,0 +1,125 @@
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "qemu/queue.h"
+#include "ui/console.h"
+#include "ui/input.h"
+#include "ui/kbd-state.h"
+
+struct KbdState {
+    QemuConsole *con;
+    int key_delay_ms;
+    DECLARE_BITMAP(keys, Q_KEY_CODE__MAX);
+    DECLARE_BITMAP(mods, KBD_MOD__MAX);
+};
+
+static void kbd_state_modifier_update(KbdState *kbd,
+                                      QKeyCode qcode1, QKeyCode qcode2,
+                                      KbdModifier mod)
+{
+    if (test_bit(qcode1, kbd->keys) || test_bit(qcode2, kbd->keys)) {
+        set_bit(mod, kbd->mods);
+    } else {
+        clear_bit(mod, kbd->mods);
+    }
+}
+
+bool kbd_state_modifier_get(KbdState *kbd, KbdModifier mod)
+{
+    return test_bit(mod, kbd->mods);
+}
+
+bool kbd_state_key_get(KbdState *kbd, QKeyCode qcode)
+{
+    return test_bit(qcode, kbd->keys);
+}
+
+void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down)
+{
+    bool state = test_bit(qcode, kbd->keys);
+
+    if (state == down) {
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
+        kbd_state_modifier_update(kbd, Q_KEY_CODE_SHIFT, Q_KEY_CODE_SHIFT_R,
+                                  KBD_MOD_SHIFT);
+        break;
+    case Q_KEY_CODE_CTRL:
+    case Q_KEY_CODE_CTRL_R:
+        kbd_state_modifier_update(kbd, Q_KEY_CODE_CTRL, Q_KEY_CODE_CTRL_R,
+                                  KBD_MOD_CTRL);
+        break;
+    case Q_KEY_CODE_ALT:
+        kbd_state_modifier_update(kbd, Q_KEY_CODE_ALT, Q_KEY_CODE_ALT,
+                                  KBD_MOD_ALT);
+        break;
+    case Q_KEY_CODE_ALT_R:
+        kbd_state_modifier_update(kbd, Q_KEY_CODE_ALT_R, Q_KEY_CODE_ALT_R,
+                                  KBD_MOD_ALTGR);
+        break;
+    case Q_KEY_CODE_CAPS_LOCK:
+        if (down) {
+            change_bit(KBD_MOD_CAPSLOCK, kbd->mods);
+        }
+        break;
+    case Q_KEY_CODE_NUM_LOCK:
+        if (down) {
+            change_bit(KBD_MOD_NUMLOCK, kbd->mods);
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
+void kbd_state_lift_all_keys(KbdState *kbd)
+{
+    int qcode;
+
+    for (qcode = 0; qcode < Q_KEY_CODE__MAX; qcode++) {
+        if (test_bit(qcode, kbd->keys)) {
+            kbd_state_key_event(kbd, qcode, false);
+        }
+    }
+}
+
+void kbd_state_set_delay(KbdState *kbd, int delay_ms)
+{
+    kbd->key_delay_ms = delay_ms;
+}
+
+void kbd_state_free(KbdState *kbd)
+{
+    g_free(kbd);
+}
+
+KbdState *kbd_state_init(QemuConsole *con)
+{
+    KbdState *kbd = g_new0(KbdState, 1);
+
+    kbd->con = con;
+
+    return kbd;
+}
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 00f6976c30..3c04bdda94 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -8,7 +8,7 @@ vnc-obj-y += vnc-ws.o
 vnc-obj-y += vnc-jobs.o
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
-common-obj-y += input.o input-keymap.o input-legacy.o
+common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
-- 
2.9.3
