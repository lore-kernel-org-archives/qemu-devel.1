Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwb-00089g-PZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwX-00084v-QJ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eokwX-000841-Gn
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AECE40753A2
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:05:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 08:05:13 +0100
Message-Id: <20180222070513.8740-6-kraxel@redhat.com>
In-Reply-To: <20180222070513.8740-1-kraxel@redhat.com>
References: <20180222070513.8740-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state when
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Pass the modifier state to the keymap lookup function.  In case multiple
keysym -> keycode mappings exist look at the modifier state and prefer
the mapping where the modifier state matches.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/keymaps.h |  3 ++-
 ui/curses.c  |  3 ++-
 ui/keymaps.c | 33 ++++++++++++++++++++++++++++++++-
 ui/sdl.c     |  6 +++++-
 ui/vnc.c     |  9 +++++++--
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 17ec03387a..0693588225 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -54,7 +54,8 @@ typedef struct kbd_layout_t kbd_layout_t;
=20
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language);
-int keysym2scancode(kbd_layout_t *k, int keysym);
+int keysym2scancode(kbd_layout_t *k, int keysym,
+                    bool shift, bool altgr, bool ctrl);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
=20
diff --git a/ui/curses.c b/ui/curses.c
index 479b77bd03..597e47fd4a 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -271,7 +271,8 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
                     keysym =3D chr;
             }
=20
-            keycode =3D keysym2scancode(kbd_layout, keysym & KEYSYM_MASK=
);
+            keycode =3D keysym2scancode(kbd_layout, keysym & KEYSYM_MASK=
,
+                                      false, false, false);
             if (keycode =3D=3D 0)
                 continue;
=20
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 1eba6d7057..43fe604724 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -176,8 +176,12 @@ kbd_layout_t *init_keyboard_layout(const name2keysym=
_t *table,
 }
=20
=20
-int keysym2scancode(kbd_layout_t *k, int keysym)
+int keysym2scancode(kbd_layout_t *k, int keysym,
+                    bool shift, bool altgr, bool ctrl)
 {
+    static const uint32_t mask =3D
+        SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
+    uint32_t mods, i;
     struct keysym2code *keysym2code;
=20
 #ifdef XK_ISO_Left_Tab
@@ -193,6 +197,33 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
         return 0;
     }
=20
+    if (keysym2code->count =3D=3D 1) {
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
+    mods =3D 0;
+    if (shift) {
+        mods |=3D SCANCODE_SHIFT;
+    }
+    if (altgr) {
+        mods |=3D SCANCODE_ALTGR;
+    }
+    if (ctrl) {
+        mods |=3D SCANCODE_CTRL;
+    }
+
+    for (i =3D 0; i < keysym2code->count; i++) {
+        if ((keysym2code->keycodes[i] & mask) =3D=3D mods) {
+            return keysym2code->keycodes[i];
+        }
+    }
     return keysym2code->keycodes[0];
 }
=20
diff --git a/ui/sdl.c b/ui/sdl.c
index 963cdf77a7..c4ae7ab05d 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -201,6 +201,9 @@ static kbd_layout_t *kbd_layout =3D NULL;
=20
 static uint8_t sdl_keyevent_to_keycode_generic(const SDL_KeyboardEvent *=
ev)
 {
+    bool shift =3D modifiers_state[0x2a] || modifiers_state[0x36];
+    bool altgr =3D modifiers_state[0xb8];
+    bool ctrl  =3D modifiers_state[0x1d] || modifiers_state[0x9d];
     int keysym;
     /* workaround for X11+SDL bug with AltGR */
     keysym =3D ev->keysym.sym;
@@ -210,7 +213,8 @@ static uint8_t sdl_keyevent_to_keycode_generic(const =
SDL_KeyboardEvent *ev)
     if (keysym =3D=3D 92 && ev->keysym.scancode =3D=3D 133) {
         keysym =3D 0xa5;
     }
-    return keysym2scancode(kbd_layout, keysym) & SCANCODE_KEYMASK;
+    return keysym2scancode(kbd_layout, keysym,
+                           shift, altgr, ctrl) & SCANCODE_KEYMASK;
 }
=20
=20
diff --git a/ui/vnc.c b/ui/vnc.c
index a77b568b57..d19f86c7f4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1734,7 +1734,8 @@ static void reset_keys(VncState *vs)
=20
 static void press_key(VncState *vs, int keysym)
 {
-    int keycode =3D keysym2scancode(vs->vd->kbd_layout, keysym) & SCANCO=
DE_KEYMASK;
+    int keycode =3D keysym2scancode(vs->vd->kbd_layout, keysym,
+                                  false, false, false) & SCANCODE_KEYMAS=
K;
     qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, true);
     qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
     qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
@@ -1993,6 +1994,9 @@ static const char *code2name(int keycode)
=20
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
+    bool shift =3D vs->modifiers_state[0x2a] || vs->modifiers_state[0x36=
];
+    bool altgr =3D vs->modifiers_state[0xb8];
+    bool ctrl  =3D vs->modifiers_state[0x1d] || vs->modifiers_state[0x9d=
];
     int keycode;
     int lsym =3D sym;
=20
@@ -2000,7 +2004,8 @@ static void key_event(VncState *vs, int down, uint3=
2_t sym)
         lsym =3D lsym - 'A' + 'a';
     }
=20
-    keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF) & SCA=
NCODE_KEYMASK;
+    keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
+                              shift, altgr, ctrl) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
--=20
2.9.3
