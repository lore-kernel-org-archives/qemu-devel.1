Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2G-0003Jl-FW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-000205-E1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yL-4e
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB7F98A3DD
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:14 +0100
Message-Id: <20180222102317.25776-7-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] keymap: use glib hash for kbd_layout_t
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

Drop home-grown lookup code, which is a strange mix of a lookup table
and a list.  Use standard glib hash instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180222070513.8740-3-kraxel@redhat.com
---
 ui/keymaps.c    | 73 ++++++++++++++++++++++++---------------------------=
------
 ui/trace-events |  2 +-
 2 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 134958a197..449c3dec22 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -28,22 +28,18 @@
 #include "trace.h"
 #include "qemu/error-report.h"
=20
-#define MAX_NORMAL_KEYCODE 512
-#define MAX_EXTRA_COUNT 256
-
 struct key_range {
     int start;
     int end;
     struct key_range *next;
 };
=20
+struct keysym2code {
+    uint16_t keycode;
+};
+
 struct kbd_layout_t {
-    uint16_t keysym2keycode[MAX_NORMAL_KEYCODE];
-    struct {
-        int keysym;
-        uint16_t keycode;
-    } keysym2keycode_extra[MAX_EXTRA_COUNT];
-    int extra_count;
+    GHashTable *hash;
     struct key_range *keypad_range;
     struct key_range *numlock_range;
 };
@@ -91,23 +87,19 @@ static void add_to_key_range(struct key_range **krp, =
int code) {
     }
 }
=20
-static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t=
 *k) {
-    if (keysym < MAX_NORMAL_KEYCODE) {
-        trace_keymap_add("normal", keysym, keycode, line);
-        k->keysym2keycode[keysym] =3D keycode;
-    } else {
-        if (k->extra_count >=3D MAX_EXTRA_COUNT) {
-            warn_report("Could not assign keysym %s (0x%x)"
-                        " because of memory constraints.", line, keysym)=
;
-        } else {
-            trace_keymap_add("extra", keysym, keycode, line);
-            k->keysym2keycode_extra[k->extra_count].
-            keysym =3D keysym;
-            k->keysym2keycode_extra[k->extra_count].
-            keycode =3D keycode;
-            k->extra_count++;
-        }
+static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t=
 *k)
+{
+    struct keysym2code *keysym2code;
+
+    keysym2code =3D g_hash_table_lookup(k->hash, GINT_TO_POINTER(keysym)=
);
+    if (keysym2code) {
+        return;
     }
+
+    keysym2code =3D g_new0(struct keysym2code, 1);
+    keysym2code->keycode =3D keycode;
+    g_hash_table_replace(k->hash, GINT_TO_POINTER(keysym), keysym2code);
+    trace_keymap_add(keysym, keycode, line);
 }
=20
 static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
@@ -131,6 +123,7 @@ static kbd_layout_t *parse_keyboard_layout(const name=
2keysym_t *table,
=20
     if (!k) {
         k =3D g_new0(kbd_layout_t, 1);
+        k->hash =3D g_hash_table_new(NULL, NULL);
     }
=20
     for(;;) {
@@ -215,26 +208,22 @@ kbd_layout_t *init_keyboard_layout(const name2keysy=
m_t *table,
=20
 int keysym2scancode(kbd_layout_t *k, int keysym)
 {
-    if (keysym < MAX_NORMAL_KEYCODE) {
-        if (k->keysym2keycode[keysym] =3D=3D 0) {
-            trace_keymap_unmapped(keysym);
-            warn_report("no scancode found for keysym %d", keysym);
-        }
-        return k->keysym2keycode[keysym];
-    } else {
-        int i;
+    struct keysym2code *keysym2code;
+
 #ifdef XK_ISO_Left_Tab
-        if (keysym =3D=3D XK_ISO_Left_Tab) {
-            keysym =3D XK_Tab;
-        }
+    if (keysym =3D=3D XK_ISO_Left_Tab) {
+        keysym =3D XK_Tab;
+    }
 #endif
-        for (i =3D 0; i < k->extra_count; i++) {
-            if (k->keysym2keycode_extra[i].keysym =3D=3D keysym) {
-                return k->keysym2keycode_extra[i].keycode;
-            }
-        }
+
+    keysym2code =3D g_hash_table_lookup(k->hash, GINT_TO_POINTER(keysym)=
);
+    if (!keysym2code) {
+        trace_keymap_unmapped(keysym);
+        warn_report("no scancode found for keysym %d", keysym);
+        return 0;
     }
-    return 0;
+
+    return keysym2code->keycode;
 }
=20
 int keycode_is_keypad(kbd_layout_t *k, int keycode)
diff --git a/ui/trace-events b/ui/trace-events
index 34229e6747..861b68a305 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -78,7 +78,7 @@ qemu_spice_create_update(uint32_t left, uint32_t right,=
 uint32_t top, uint32_t b
=20
 # ui/keymaps.c
 keymap_parse(const char *file) "file %s"
-keymap_add(const char *type, int sym, int code, const char *line) "%-6s =
sym=3D0x%04x code=3D0x%04x (line: %s)"
+keymap_add(int sym, int code, const char *line) "sym=3D0x%04x code=3D0x%=
04x (line: %s)"
 keymap_unmapped(int sym) "sym=3D0x%04x"
=20
 # ui/x_keymap.c
--=20
2.9.3
