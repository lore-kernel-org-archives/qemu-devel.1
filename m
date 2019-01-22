Received: from eggs.gnu.org ([209.51.188.92]:58893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVw-00065q-Ll
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM1-0003QD-Ue
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM1-0003PJ-M4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E31237F3F7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:13 +0100
Message-Id: <20190122092814.14919-8-kraxel@redhat.com>
In-Reply-To: <20190122092814.14919-1-kraxel@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 7/8] keymap: pass full keyboard state to
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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/keymaps.h | 3 ++-
 ui/curses.c  | 2 +-
 ui/keymaps.c | 8 ++++----
 ui/vnc.c     | 5 +----
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 4e9c87fb8f..d8652b8a5a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -26,6 +26,7 @@
 #define QEMU_KEYMAPS_H
=20
 #include "qemu-common.h"
+#include "ui/kbd-state.h"
=20
 typedef struct {
     const char* name;
@@ -55,7 +56,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    bool shift, bool altgr, bool ctrl);
+                    QKbdState *kbd);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
 int keysym_is_numlock(kbd_layout_t *k, int keysym);
=20
diff --git a/ui/curses.c b/ui/curses.c
index f4e7a12f74..54687589d4 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -273,7 +273,7 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
             }
=20
             keycode =3D keysym2scancode(kbd_layout, keysym & KEYSYM_MASK=
,
-                                      false, false, false);
+                                      NULL);
             if (keycode =3D=3D 0)
                 continue;
=20
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6e44f738ed..c8b2135340 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -188,7 +188,7 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_=
t *table,
=20
=20
 int keysym2scancode(kbd_layout_t *k, int keysym,
-                    bool shift, bool altgr, bool ctrl)
+                    QKbdState *kbd)
 {
     static const uint32_t mask =3D
         SCANCODE_SHIFT | SCANCODE_ALTGR | SCANCODE_CTRL;
@@ -220,13 +220,13 @@ int keysym2scancode(kbd_layout_t *k, int keysym,
      * If so, prefer that one.
      */
     mods =3D 0;
-    if (shift) {
+    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_SHIFT)) {
         mods |=3D SCANCODE_SHIFT;
     }
-    if (altgr) {
+    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_ALTGR)) {
         mods |=3D SCANCODE_ALTGR;
     }
-    if (ctrl) {
+    if (kbd && qkbd_state_modifier_get(kbd, QKBD_MOD_CTRL)) {
         mods |=3D SCANCODE_CTRL;
     }
=20
diff --git a/ui/vnc.c b/ui/vnc.c
index a9fe166ee8..fc41f9b318 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1954,9 +1954,6 @@ static const char *code2name(int keycode)
=20
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
-    bool shift =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_SHIFT);
-    bool altgr =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALTGR);
-    bool ctrl  =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
     int keycode;
     int lsym =3D sym;
=20
@@ -1965,7 +1962,7 @@ static void key_event(VncState *vs, int down, uint3=
2_t sym)
     }
=20
     keycode =3D keysym2scancode(vs->vd->kbd_layout, lsym & 0xFFFF,
-                              shift, altgr, ctrl) & SCANCODE_KEYMASK;
+                              vs->vd->kbd) & SCANCODE_KEYMASK;
     trace_vnc_key_event_map(down, sym, keycode, code2name(keycode));
     do_key_event(vs, down, keycode, sym);
 }
--=20
2.9.3
