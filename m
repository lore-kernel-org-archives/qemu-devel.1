Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J1-JN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-0001zf-Cy
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yO-5R
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8AFF4040855
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:13 +0100
Message-Id: <20180222102317.25776-6-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] keymap: make struct kbd_layout_t private to
 ui/keymaps.c
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

Also use kbd_layout_t pointers instead of void pointers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180222070513.8740-2-kraxel@redhat.com
---
 ui/keymaps.h | 29 ++++++-----------------------
 ui/keymaps.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 8757465529..17ec03387a 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -32,25 +32,6 @@ typedef struct {
 	int keysym;
 } name2keysym_t;
=20
-struct key_range {
-    int start;
-    int end;
-    struct key_range *next;
-};
-
-#define MAX_NORMAL_KEYCODE 512
-#define MAX_EXTRA_COUNT 256
-typedef struct {
-    uint16_t keysym2keycode[MAX_NORMAL_KEYCODE];
-    struct {
-	int keysym;
-	uint16_t keycode;
-    } keysym2keycode_extra[MAX_EXTRA_COUNT];
-    int extra_count;
-    struct key_range *keypad_range;
-    struct key_range *numlock_range;
-} kbd_layout_t;
-
 /* scancode without modifiers */
 #define SCANCODE_KEYMASK 0xff
 /* scancode without grey or up bit */
@@ -69,10 +50,12 @@ typedef struct {
 #define SCANCODE_ALT    0x400
 #define SCANCODE_ALTGR  0x800
=20
+typedef struct kbd_layout_t kbd_layout_t;
=20
-void *init_keyboard_layout(const name2keysym_t *table, const char *langu=
age);
-int keysym2scancode(void *kbd_layout, int keysym);
-int keycode_is_keypad(void *kbd_layout, int keycode);
-int keysym_is_numlock(void *kbd_layout, int keysym);
+kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
+                                   const char *language);
+int keysym2scancode(kbd_layout_t *k, int keysym);
+int keycode_is_keypad(kbd_layout_t *k, int keycode);
+int keysym_is_numlock(kbd_layout_t *k, int keysym);
=20
 #endif /* QEMU_KEYMAPS_H */
diff --git a/ui/keymaps.c b/ui/keymaps.c
index f9762d1497..134958a197 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,6 +28,26 @@
 #include "trace.h"
 #include "qemu/error-report.h"
=20
+#define MAX_NORMAL_KEYCODE 512
+#define MAX_EXTRA_COUNT 256
+
+struct key_range {
+    int start;
+    int end;
+    struct key_range *next;
+};
+
+struct kbd_layout_t {
+    uint16_t keysym2keycode[MAX_NORMAL_KEYCODE];
+    struct {
+        int keysym;
+        uint16_t keycode;
+    } keysym2keycode_extra[MAX_EXTRA_COUNT];
+    int extra_count;
+    struct key_range *keypad_range;
+    struct key_range *numlock_range;
+};
+
 static int get_keysym(const name2keysym_t *table,
                       const char *name)
 {
@@ -186,15 +206,15 @@ static kbd_layout_t *parse_keyboard_layout(const na=
me2keysym_t *table,
 }
=20
=20
-void *init_keyboard_layout(const name2keysym_t *table, const char *langu=
age)
+kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
+                                   const char *language)
 {
     return parse_keyboard_layout(table, language, NULL);
 }
=20
=20
-int keysym2scancode(void *kbd_layout, int keysym)
+int keysym2scancode(kbd_layout_t *k, int keysym)
 {
-    kbd_layout_t *k =3D kbd_layout;
     if (keysym < MAX_NORMAL_KEYCODE) {
         if (k->keysym2keycode[keysym] =3D=3D 0) {
             trace_keymap_unmapped(keysym);
@@ -217,9 +237,8 @@ int keysym2scancode(void *kbd_layout, int keysym)
     return 0;
 }
=20
-int keycode_is_keypad(void *kbd_layout, int keycode)
+int keycode_is_keypad(kbd_layout_t *k, int keycode)
 {
-    kbd_layout_t *k =3D kbd_layout;
     struct key_range *kr;
=20
     for (kr =3D k->keypad_range; kr; kr =3D kr->next) {
@@ -230,9 +249,8 @@ int keycode_is_keypad(void *kbd_layout, int keycode)
     return 0;
 }
=20
-int keysym_is_numlock(void *kbd_layout, int keysym)
+int keysym_is_numlock(kbd_layout_t *k, int keysym)
 {
-    kbd_layout_t *k =3D kbd_layout;
     struct key_range *kr;
=20
     for (kr =3D k->numlock_range; kr; kr =3D kr->next) {
--=20
2.9.3
