Received: from eggs.gnu.org ([2001:4830:134:3::10]:32834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwb-00089e-P8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwX-00084g-Qf
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eokwX-000843-HD
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3A3E818B137
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:05:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 08:05:11 +0100
Message-Id: <20180222070513.8740-4-kraxel@redhat.com>
In-Reply-To: <20180222070513.8740-1-kraxel@redhat.com>
References: <20180222070513.8740-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] keymap: numpad keysyms and keycodes are
 fixed
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

No need to figure them at runtime from the keymap.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/keymaps.c | 61 +++++++++---------------------------------------------=
------
 1 file changed, 9 insertions(+), 52 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 449c3dec22..cbdd65c767 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,20 +28,12 @@
 #include "trace.h"
 #include "qemu/error-report.h"
=20
-struct key_range {
-    int start;
-    int end;
-    struct key_range *next;
-};
-
 struct keysym2code {
     uint16_t keycode;
 };
=20
 struct kbd_layout_t {
     GHashTable *hash;
-    struct key_range *keypad_range;
-    struct key_range *numlock_range;
 };
=20
 static int get_keysym(const name2keysym_t *table,
@@ -64,29 +56,6 @@ static int get_keysym(const name2keysym_t *table,
 }
=20
=20
-static void add_to_key_range(struct key_range **krp, int code) {
-    struct key_range *kr;
-    for (kr =3D *krp; kr; kr =3D kr->next) {
-        if (code >=3D kr->start && code <=3D kr->end) {
-            break;
-        }
-        if (code =3D=3D kr->start - 1) {
-            kr->start--;
-            break;
-        }
-        if (code =3D=3D kr->end + 1) {
-            kr->end++;
-            break;
-        }
-    }
-    if (kr =3D=3D NULL) {
-        kr =3D g_malloc0(sizeof(*kr));
-        kr->start =3D kr->end =3D code;
-        kr->next =3D *krp;
-        *krp =3D kr;
-    }
-}
-
 static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t=
 *k)
 {
     struct keysym2code *keysym2code;
@@ -160,13 +129,6 @@ static kbd_layout_t *parse_keyboard_layout(const nam=
e2keysym_t *table,
                     const char *rest =3D line + offset + 1;
                     int keycode =3D strtol(rest, NULL, 0);
=20
-                    if (strstr(rest, "numlock")) {
-                        add_to_key_range(&k->keypad_range, keycode);
-                        add_to_key_range(&k->numlock_range, keysym);
-                        /* fprintf(stderr, "keypad keysym %04x keycode %=
d\n",
-                                   keysym, keycode); */
-                    }
-
                     if (strstr(rest, "shift")) {
                         keycode |=3D SCANCODE_SHIFT;
                     }
@@ -228,24 +190,19 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
=20
 int keycode_is_keypad(kbd_layout_t *k, int keycode)
 {
-    struct key_range *kr;
-
-    for (kr =3D k->keypad_range; kr; kr =3D kr->next) {
-        if (keycode >=3D kr->start && keycode <=3D kr->end) {
-            return 1;
-        }
+    if (keycode >=3D 0x47 && keycode <=3D 0x53) {
+        return true;
     }
-    return 0;
+    return false;
 }
=20
 int keysym_is_numlock(kbd_layout_t *k, int keysym)
 {
-    struct key_range *kr;
-
-    for (kr =3D k->numlock_range; kr; kr =3D kr->next) {
-        if (keysym >=3D kr->start && keysym <=3D kr->end) {
-            return 1;
-        }
+    switch (keysym) {
+    case 0xffb0 ... 0xffb9:  /* KP_0 .. KP_9 */
+    case 0xffac:             /* KP_Separator */
+    case 0xffae:             /* KP_Decimal   */
+        return true;
     }
-    return 0;
+    return false;
 }
--=20
2.9.3
