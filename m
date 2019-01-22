Received: from eggs.gnu.org ([209.51.188.92]:59398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVw-0006NI-Jg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM7-0003Xa-T7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM7-0003UX-HZ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B96DAC079C4B
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:14 +0100
Message-Id: <20190122092814.14919-9-kraxel@redhat.com>
In-Reply-To: <20190122092814.14919-1-kraxel@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 8/8] keymap: fix keyup mappings
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
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1658676
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/keymaps.h |  2 +-
 ui/curses.c  |  2 +-
 ui/keymaps.c | 55 ++++++++++++++++++++++++++++++++++--------------------=
-
 ui/vnc.c     |  2 +-
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index d8652b8a5a..b6d48aac40 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -56,7 +56,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    QKbdState *kbd);
+                    QKbdState *kbd, bool down);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
=20
diff --git a/ui/curses.c b/ui/curses.c
index 54687589d4..6e0091c3b2 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -273,7 +273,7 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
             }
=20
             keycode =3D keysym2scancode(kbd_layout, keysym & KEYSYM_MASK=
,
-                                      NULL);
+                                      NULL, false);
             if (keycode =3D=3D 0)
                 continue;
=20
diff --git a/ui/keymaps.c b/ui/keymaps.c
index c8b2135340..544b55c27b 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "ui/input.h"
=20
 struct keysym2code {
     uint32_t count;
@@ -188,7 +189,7 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_=
t *table,
=20
=20
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    QKbdState *kbd)
+                    QKbdState *kbd, bool down)
 {
     static const uint32_t mask =3D
         SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
@@ -212,27 +213,39 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
         return keysym2code->keycodes[0];
     }
=20
-    /*
-     * We have multiple keysym -> keycode mappings.
-     *
-     * Check whenever we find one mapping where the modifier state of
-     * the mapping matches the current user interface modifier state.
-     * If so, prefer that one.
-     */
-    mods =3D 0;
-    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_SHIFT)) {
-        mods |=3D SCANCODE_SHIFT;
-    }
-    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_ALTGR)) {
-        mods |=3D SCANCODE_ALTGR;
-    }
-    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_CTRL)) {
-        mods |=3D SCANCODE_CTRL;
-    }
+    /* We have multiple keysym -> keycode mappings. */
+    if (down) {
+        /*
+         * On keydown: Check whenever we find one mapping where the
+         * modifier state of the mapping matches the current user
+         * interface modifier state.  If so, prefer that one.
+         */
+        mods =3D 0;
+        if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_SHIFT)) {
+            mods |=3D SCANCODE_SHIFT;
+        }
+        if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_ALTGR)) {
+            mods |=3D SCANCODE_ALTGR;
+        }
+        if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_CTRL)) {
+            mods |=3D SCANCODE_CTRL;
+        }
=20
-    for (i =3D 0; i < keysym2code->count; i++) {
-        if ((keysym2code->keycodes[i] & mask) =3D=3D mods) {
-            return keysym2code->keycodes[i];
+        for (i =3D 0; i < keysym2code->count; i++) {
+            if ((keysym2code->keycodes[i] & mask) =3D=3D mods) {
+                return keysym2code->keycodes[i];
+            }
+        }
+    } else {
+        /*
+         * On keyup: Try find a key which is actually down.
+         */
+        for (i =3D 0; i < keysym2code->count; i++) {
+            QKeyCode qcode =3D qemu_input_key_number_to_qcode
+                (keysym2code->keycodes[i]);
+            if (kbd && qkbd_state_key_get(kbd, qcode)) {
+                return keysym2code->keycodes[i];
+            }
         }
     }
     return keysym2code->keycodes[0];
diff --git a/ui/vnc.c b/ui/vnc.c
index fc41f9b318..bc730496ae 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1962,7 +1962,7 @@ static void key_event(VncState *vs, int down, uint3=
2_t sym)
     }
=20
     keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
-                              vs->vd->kbd) & SCANCODE_KEYMASK;
+                              vs->vd->kbd, down) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
--=20
2.9.3
