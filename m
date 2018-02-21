Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsY-0000TY-En
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsU-0005b5-BE
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoXsU-0005an-5v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:22 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 18:08:17 +0100
Message-Id: <20180221170820.15365-3-kraxel@redhat.com>
In-Reply-To: <20180221170820.15365-1-kraxel@redhat.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/5] kbd-state: add hotkey registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, berrange@redhat.com, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

Add support to register hotkeys and to check whenever a given QKeyCode
combined with the current modifier state is a hotkey.  A hotkey can be
any key combined with up to three modifier keys.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/kbd-state.h | 27 +++++++++++++++++++++++++++
 ui/kbd-state.c         | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index c961da45b2..3f13649b63 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -20,3 +20,30 @@ bool kbd_state_key_get(KbdState *kbd, QKeyCode qcode);
 void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down);
 void kbd_state_lift_all_keys(KbdState *kbd);
 KbdState *kbd_state_init(QemuConsole *con);
+
+/* ------------------------------------------------------------------ */
+
+typedef enum KbdHotkey KbdHotkey;
+
+enum KbdHotkey {
+    KBD_HOTKEY_NONE = 0,
+
+    KBD_HOTKEY_GRAB,
+    KBD_HOTKEY_FULLSCREEN,
+    KBD_HOTKEY_REDRAW,
+
+    KBD_HOTKEY_CONSOLE_1,
+    KBD_HOTKEY_CONSOLE_2,
+    KBD_HOTKEY_CONSOLE_3,
+    KBD_HOTKEY_CONSOLE_4,
+    KBD_HOTKEY_CONSOLE_5,
+    KBD_HOTKEY_CONSOLE_6,
+    KBD_HOTKEY_CONSOLE_7,
+    KBD_HOTKEY_CONSOLE_8,
+    KBD_HOTKEY_CONSOLE_9,
+};
+
+void kbd_state_hotkey_register(KbdState *kbd, KbdHotkey, QKeyCode qcode,
+                               KbdModifier mod1, KbdModifier mod2,
+                               KbdModifier mod3);
+KbdHotkey kbd_state_hotkey_get(KbdState *kbd, QKeyCode qcode);
diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index 7a9fe268c2..812cb368e3 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -6,20 +6,20 @@
 #include "ui/input.h"
 #include "ui/kbd-state.h"
 
-typedef struct KbdHotkey KbdHotkey;
+typedef struct KbdHotkeyEntry KbdHotkeyEntry;
 
-struct KbdHotkey {
+struct KbdHotkeyEntry {
     uint32_t id;
     QKeyCode qcode;
     DECLARE_BITMAP(mods, KBD_MOD__MAX);
-    QTAILQ_ENTRY(KbdHotkey) next;
+    QTAILQ_ENTRY(KbdHotkeyEntry) next;
 };
 
 struct KbdState {
     QemuConsole *con;
     DECLARE_BITMAP(keys, Q_KEY_CODE__MAX);
     DECLARE_BITMAP(mods, KBD_MOD__MAX);
-    QTAILQ_HEAD(,KbdHotkey) hotkeys;
+    QTAILQ_HEAD(, KbdHotkeyEntry) hotkeys;
 };
 
 static void kbd_state_modifier_update(KbdState *kbd,
@@ -117,3 +117,36 @@ KbdState *kbd_state_init(QemuConsole *con)
 
     return kbd;
 }
+
+void kbd_state_hotkey_register(KbdState *kbd, KbdHotkey id, QKeyCode qcode,
+                               KbdModifier mod1, KbdModifier mod2,
+                               KbdModifier mod3)
+{
+    KbdHotkeyEntry *hotkey = g_new0(KbdHotkeyEntry, 1);
+
+    hotkey->id    = id;
+    hotkey->qcode = qcode;
+    if (mod1 != KBD_MOD_NONE) {
+        set_bit(mod1, hotkey->mods);
+    }
+    if (mod2 != KBD_MOD_NONE) {
+        set_bit(mod2, hotkey->mods);
+    }
+    if (mod3 != KBD_MOD_NONE) {
+        set_bit(mod3, hotkey->mods);
+    }
+    QTAILQ_INSERT_TAIL(&kbd->hotkeys, hotkey, next);
+}
+
+KbdHotkey kbd_state_hotkey_get(KbdState *kbd, QKeyCode qcode)
+{
+    KbdHotkeyEntry *hotkey;
+
+    QTAILQ_FOREACH(hotkey, &kbd->hotkeys, next) {
+        if (qcode == hotkey->qcode &&
+            bitmap_equal(kbd->mods, hotkey->mods, KBD_MOD__MAX)) {
+            return hotkey->id;
+        }
+    }
+    return KBD_HOTKEY_NONE;
+}
-- 
2.9.3
