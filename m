Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9Su-0007vk-4O
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9So-0006Rg-0x
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo9Sn-0006RX-Ro
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C952EB709
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:04:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 16:03:55 +0100
Message-Id: <20180220150357.324-4-kraxel@redhat.com>
In-Reply-To: <20180220150357.324-1-kraxel@redhat.com>
References: <20180220150357.324-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] keymap: numpad keysyms and keycodes are
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

No need to figure them at runtime from the keymap.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.c | 61 +++++++++---------------------------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index bef1405576..d71ae389e0 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,20 +28,12 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 
-struct key_range {
-    int start;
-    int end;
-    struct key_range *next;
-};
-
 struct keysym2code {
     uint16_t keycode;
 };
 
 struct kbd_layout_t {
     GHashTable *hash;
-    struct key_range *keypad_range;
-    struct key_range *numlock_range;
 };
 
 static inline gpointer hashkey(int keysym)
@@ -70,29 +62,6 @@ static int get_keysym(const name2keysym_t *table,
 }
 
 
-static void add_to_key_range(struct key_range **krp, int code) {
-    struct key_range *kr;
-    for (kr = *krp; kr; kr = kr->next) {
-        if (code >= kr->start && code <= kr->end) {
-            break;
-        }
-        if (code == kr->start - 1) {
-            kr->start--;
-            break;
-        }
-        if (code == kr->end + 1) {
-            kr->end++;
-            break;
-        }
-    }
-    if (kr == NULL) {
-        kr = g_malloc0(sizeof(*kr));
-        kr->start = kr->end = code;
-        kr->next = *krp;
-        *krp = kr;
-    }
-}
-
 static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
 {
     struct keysym2code *keysym2code;
@@ -166,13 +135,6 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
                     const char *rest = line + offset + 1;
                     int keycode = strtol(rest, NULL, 0);
 
-                    if (strstr(rest, "numlock")) {
-                        add_to_key_range(&k->keypad_range, keycode);
-                        add_to_key_range(&k->numlock_range, keysym);
-                        /* fprintf(stderr, "keypad keysym %04x keycode %d\n",
-                                   keysym, keycode); */
-                    }
-
                     if (strstr(rest, "shift")) {
                         keycode |= SCANCODE_SHIFT;
                     }
@@ -234,24 +196,19 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
 
 int keycode_is_keypad(kbd_layout_t *k, int keycode)
 {
-    struct key_range *kr;
-
-    for (kr = k->keypad_range; kr; kr = kr->next) {
-        if (keycode >= kr->start && keycode <= kr->end) {
-            return 1;
-        }
+    if (keycode >= 0x47 && keycode <= 0x53) {
+        return true;
     }
-    return 0;
+    return false;
 }
 
 int keysym_is_numlock(kbd_layout_t *k, int keysym)
 {
-    struct key_range *kr;
-
-    for (kr = k->numlock_range; kr; kr = kr->next) {
-        if (keysym >= kr->start && keysym <= kr->end) {
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
-- 
2.9.3
