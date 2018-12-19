Received: from eggs.gnu.org ([2001:4830:134:3::10]:44807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafC-0003Ju-DE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafA-0000G5-6x
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf6-0000Aa-Eg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05CB989AE7
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:09:04 +0100
Message-Id: <20181219120904.17643-8-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 7/7] keymap: fix keyup mappings
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

It is possible that the modifier state on keyup is different from the
modifier state on keydown.  In that case the keycode lookup can end up
with different keys in case multiple keysym -> keycode mappings exist,
because it picks the mapping depending on modifier state.

To fix that change the lookup logic for keyup events.  Instead of
looking at the modifier state check the key state and prefer a keycodes
where the key is in "down" state right now.

Fixes: abb4f2c965 keymap: consider modifier state when picking a mapping
Buglink: https://bugs.launchpad.net/bugs/1738283
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1658676
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.h |  2 +-
 ui/curses.c  |  2 +-
 ui/keymaps.c | 55 ++++++++++++++++++++++++++++++++++---------------------
 ui/vnc.c     |  2 +-
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 6a2365196a..97deec3437 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -56,7 +56,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    KbdState *kbd);
+                    KbdState *kbd, bool down);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
 
diff --git a/ui/curses.c b/ui/curses.c
index 54687589d4..6e0091c3b2 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -273,7 +273,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
             }
 
             keycode = keysym2scancode(kbd_layout, keysym & KEYSYM_MASK,
-                                      NULL);
+                                      NULL, false);
             if (keycode == 0)
                 continue;
 
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6be87cc201..9ec0bc5333 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "ui/input.h"
 
 struct keysym2code {
     uint32_t count;
@@ -189,7 +190,7 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
 
 
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    KbdState *kbd)
+                    KbdState *kbd, bool down)
 {
     static const uint32_t mask =
         SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
@@ -213,27 +214,39 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
         return keysym2code->keycodes[0];
     }
 
-    /*
-     * We have multiple keysym -> keycode mappings.
-     *
-     * Check whenever we find one mapping where the modifier state of
-     * the mapping matches the current user interface modifier state.
-     * If so, prefer that one.
-     */
-    mods = 0;
-    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_SHIFT)) {
-        mods |= SCANCODE_SHIFT;
-    }
-    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_ALTGR)) {
-        mods |= SCANCODE_ALTGR;
-    }
-    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_CTRL)) {
-        mods |= SCANCODE_CTRL;
-    }
+    /* We have multiple keysym -> keycode mappings. */
+    if (down) {
+        /*
+         * On keydown: Check whenever we find one mapping where the
+         * modifier state of the mapping matches the current user
+         * interface modifier state.  If so, prefer that one.
+         */
+        mods = 0;
+        if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_SHIFT)) {
+            mods |= SCANCODE_SHIFT;
+        }
+        if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_ALTGR)) {
+            mods |= SCANCODE_ALTGR;
+        }
+        if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_CTRL)) {
+            mods |= SCANCODE_CTRL;
+        }
 
-    for (i = 0; i < keysym2code->count; i++) {
-        if ((keysym2code->keycodes[i] & mask) == mods) {
-            return keysym2code->keycodes[i];
+        for (i = 0; i < keysym2code->count; i++) {
+            if ((keysym2code->keycodes[i] & mask) == mods) {
+                return keysym2code->keycodes[i];
+            }
+        }
+    } else {
+        /*
+         * On keyup: Try find a key which is actually down.
+         */
+        for (i = 0; i < keysym2code->count; i++) {
+            QKeyCode qcode = qemu_input_key_number_to_qcode
+                (keysym2code->keycodes[i]);
+            if (kbd && kbd_state_key_get(kbd, qcode)) {
+                return keysym2code->keycodes[i];
+            }
         }
     }
     return keysym2code->keycodes[0];
diff --git a/ui/vnc.c b/ui/vnc.c
index 704a138667..08eba8b6ed 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1962,7 +1962,7 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     }
 
     keycode = keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
-                              vs->vd->kbd) & SCANCODE_KEYMASK;
+                              vs->vd->kbd, down) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
-- 
2.9.3
