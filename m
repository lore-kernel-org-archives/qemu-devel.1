Received: from eggs.gnu.org ([2001:4830:134:3::10]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafE-0003LS-6g
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf6-0000BD-9F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf2-00009k-KA
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2D053DBE3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:09:03 +0100
Message-Id: <20181219120904.17643-7-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 6/7] keymap: pass full keyboard state to
 keysym2scancode
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

Pass the keyboard state tracker handle down to keysym2scancode(),
so the code can fully inspect the keyboard state as needed.  No
functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.h | 3 ++-
 ui/curses.c  | 2 +-
 ui/keymaps.c | 8 ++++----
 ui/vnc.c     | 5 +----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 98213a4191..6a2365196a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -26,6 +26,7 @@
 #define QEMU_KEYMAPS_H
 
 #include "qemu-common.h"
+#include "ui/kbd-state.h"
 
 typedef struct {
 	const char* name;
@@ -55,7 +56,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    bool shift, bool altgr, bool ctrl);
+                    KbdState *kbd);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
 
diff --git a/ui/curses.c b/ui/curses.c
index f4e7a12f74..54687589d4 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -273,7 +273,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
             }
 
             keycode = keysym2scancode(kbd_layout, keysym & KEYSYM_MASK,
-                                      false, false, false);
+                                      NULL);
             if (keycode == 0)
                 continue;
 
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 085889b555..6be87cc201 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -189,7 +189,7 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
 
 
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    bool shift, bool altgr, bool ctrl)
+                    KbdState *kbd)
 {
     static const uint32_t mask =
         SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
@@ -221,13 +221,13 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
      * If so, prefer that one.
      */
     mods = 0;
-    if (shift) {
+    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_SHIFT)) {
         mods |= SCANCODE_SHIFT;
     }
-    if (altgr) {
+    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_ALTGR)) {
         mods |= SCANCODE_ALTGR;
     }
-    if (ctrl) {
+    if (kbd && kbd_state_modifier_get(kbd, KBD_MOD_CTRL)) {
         mods |= SCANCODE_CTRL;
     }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index b56431ce3b..704a138667 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1954,9 +1954,6 @@ static const char *code2name(int keycode)
 
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
-    bool shift = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_SHIFT);
-    bool altgr = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_ALTGR);
-    bool ctrl  = kbd_state_modifier_get(vs->vd->kbd, KBD_MOD_CTRL);
     int keycode;
     int lsym = sym;
 
@@ -1965,7 +1962,7 @@ static void key_event(VncState *vs, int down, uint32_t sym)
     }
 
     keycode = keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
-                              shift, altgr, ctrl) & SCANCODE_KEYMASK;
+                              vs->vd->kbd) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
-- 
2.9.3
