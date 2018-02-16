Received: from eggs.gnu.org ([2001:4830:134:3::10]:45574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emhFZ-0000M6-Ml
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emhFW-0003lS-Ja
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emhFW-0003l0-F0
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF1578424D
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 14:44:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 15:44:18 +0100
Message-Id: <20180216144418.21986-6-kraxel@redhat.com>
In-Reply-To: <20180216144418.21986-1-kraxel@redhat.com>
References: <20180216144418.21986-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] keymap: consider modifier state when
 picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Pass the modifier state to the keymap lookup function.  In case multiple
keysym -> keycode mappings exist look at the modifier state and prefer
the mapping where the modifier state matches.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.h |  3 ++-
 ui/curses.c  |  3 ++-
 ui/keymaps.c | 33 ++++++++++++++++++++++++++++++++-
 ui/sdl.c     |  6 +++++-
 ui/vnc.c     |  9 +++++++--
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 5c0898bfcf..142e40a2a4 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -53,7 +53,8 @@ typedef struct {
 typedef struct kbd_layout_t kbd_layout_t;
 
 kbd_layout_t* init_keyboard_layout(const name2keysym_t *table, const char *language);
-int keysym2scancode(kbd_layout_t *k, int keysym);
+int keysym2scancode(kbd_layout_t *k, int keysym,
+                    bool shift, bool altgr, bool ctrl);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
 
diff --git a/ui/curses.c b/ui/curses.c
index 85503876c0..31cd43e73c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -271,7 +271,8 @@ static void curses_refresh(DisplayChangeListener *dcl)
                     keysym = chr;
             }
 
-            keycode = keysym2scancode(kbd_layout, keysym & KEYSYM_MASK);
+            keycode = keysym2scancode(kbd_layout, keysym & KEYSYM_MASK,
+                                      false, false, false);
             if (keycode == 0)
                 continue;
 
diff --git a/ui/keymaps.c b/ui/keymaps.c
index d22b3555dd..eb6c15b61f 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -181,8 +181,12 @@ kbd_layout_t* init_keyboard_layout(const name2keysym_t *table, const char *langu
 }
 
 
-int keysym2scancode(kbd_layout_t *k, int keysym)
+int keysym2scancode(kbd_layout_t *k, int keysym,
+                    bool shift, bool altgr, bool ctrl)
 {
+    static const uint32_t mask =
+        SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
+    uint32_t mods, i;
     struct keysym2code *keysym2code;
 
 #ifdef XK_ISO_Left_Tab
@@ -198,6 +202,33 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
         return 0;
     }
 
+    if (keysym2code->count == 1) {
+        return keysym2code->keycodes[0];
+    }
+
+    /*
+     * We have multiple keysym -> keycode mappings.
+     *
+     * Check whenever we find one mapping where the modifier state of
+     * the mapping matches the current user interface modifier state.
+     * If so, prefer that one.
+     */
+    mods = 0;
+    if (shift) {
+        mods |= SCANCODE_SHIFT;
+    }
+    if (altgr) {
+        mods |= SCANCODE_ALTGR;
+    }
+    if (ctrl) {
+        mods |= SCANCODE_CTRL;
+    }
+
+    for (i = 0; i < keysym2code->count; i++) {
+        if ((keysym2code->keycodes[i] & mask) == mods) {
+            return keysym2code->keycodes[i];
+        }
+    }
     return keysym2code->keycodes[0];
 }
 
diff --git a/ui/sdl.c b/ui/sdl.c
index a6bff301eb..4c46c40a7f 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -200,6 +200,9 @@ static kbd_layout_t *kbd_layout = NULL;
 
 static uint8_t sdl_keyevent_to_keycode_generic(const SDL_KeyboardEvent *ev)
 {
+    bool shift = modifiers_state[0x2a] || modifiers_state[0x36];
+    bool altgr = modifiers_state[0xb8];
+    bool ctrl  = modifiers_state[0x1d] || modifiers_state[0x9d];
     int keysym;
     /* workaround for X11+SDL bug with AltGR */
     keysym = ev->keysym.sym;
@@ -209,7 +212,8 @@ static uint8_t sdl_keyevent_to_keycode_generic(const SDL_KeyboardEvent *ev)
     if (keysym == 92 && ev->keysym.scancode == 133) {
         keysym = 0xa5;
     }
-    return keysym2scancode(kbd_layout, keysym) & SCANCODE_KEYMASK;
+    return keysym2scancode(kbd_layout, keysym,
+                           shift, altgr, ctrl) & SCANCODE_KEYMASK;
 }
 
 
diff --git a/ui/vnc.c b/ui/vnc.c
index c715bae1cf..52762f3e99 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1728,7 +1728,8 @@ static void reset_keys(VncState *vs)
 
 static void press_key(VncState *vs, int keysym)
 {
-    int keycode = keysym2scancode(vs->vd->kbd_layout, keysym) & SCANCODE_KEYMASK;
+    int keycode = keysym2scancode(vs->vd->kbd_layout, keysym,
+                                  false, false, false) & SCANCODE_KEYMASK;
     qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, true);
     qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
     qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
@@ -1987,6 +1988,9 @@ static const char *code2name(int keycode)
 
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
+    bool shift = vs->modifiers_state[0x2a] || vs->modifiers_state[0x36];
+    bool altgr = vs->modifiers_state[0xb8];
+    bool ctrl  = vs->modifiers_state[0x1d] || vs->modifiers_state[0x9d];
     int keycode;
     int lsym = sym;
 
@@ -1994,7 +1998,8 @@ static void key_event(VncState *vs, int down, uint32_t sym)
         lsym = lsym - 'A' + 'a';
     }
 
-    keycode = keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF) & SCANCODE_KEYMASK;
+    keycode = keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
+                              shift, altgr, ctrl) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
-- 
2.9.3
