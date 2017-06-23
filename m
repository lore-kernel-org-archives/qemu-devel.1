Received: from eggs.gnu.org ([2001:4830:134:3::10]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nj-Ra
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0B-00054y-O9
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOM0B-00054T-GP
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 799A343A22
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:39:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:39 +0200
Message-Id: <20170623103945.7014-2-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] keymaps: add tracing
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

Drop commented debug logging, add trace points instead.

Also cleanup parser code a bit, the key name is copied into a new
variable instead of patching the input line, that way we can log
the unmodified line.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170606134736.26080-1-kraxel@redhat.com
---
 ui/keymaps.c    | 33 ++++++++++++++++++---------------
 ui/trace-events |  5 +++++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 8899a0b31e..fa00b82027 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 static int get_keysym(const name2keysym_t *table,
                       const char *name)
@@ -71,18 +72,14 @@ static void add_to_key_range(struct key_range **krp, int code) {
 
 static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k) {
     if (keysym < MAX_NORMAL_KEYCODE) {
-        /* fprintf(stderr,"Setting keysym %s (%d) to %d\n",
-                   line, keysym, keycode); */
+        trace_keymap_add("normal", keysym, keycode, line);
         k->keysym2keycode[keysym] = keycode;
     } else {
         if (k->extra_count >= MAX_EXTRA_COUNT) {
             fprintf(stderr, "Warning: Could not assign keysym %s (0x%x)"
                     " because of memory constraints.\n", line, keysym);
         } else {
-#if 0
-            fprintf(stderr, "Setting %d: %d,%d\n",
-                    k->extra_count, keysym, keycode);
-#endif
+            trace_keymap_add("extra", keysym, keycode, line);
             k->keysym2keycode_extra[k->extra_count].
             keysym = keysym;
             k->keysym2keycode_extra[k->extra_count].
@@ -99,9 +96,11 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
     FILE *f;
     char * filename;
     char line[1024];
+    char keyname[64];
     int len;
 
     filename = qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
+    trace_keymap_parse(filename);
     f = filename ? fopen(filename, "r") : NULL;
     g_free(filename);
     if (!f) {
@@ -130,18 +129,21 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
         if (!strncmp(line, "include ", 8)) {
             parse_keyboard_layout(table, line + 8, k);
         } else {
-            char *end_of_keysym = line;
-            while (*end_of_keysym != 0 && *end_of_keysym != ' ') {
-                end_of_keysym++;
+            int offset = 0;
+            while (line[offset] != 0 &&
+                   line[offset] != ' ' &&
+                   offset < sizeof(keyname) - 1) {
+                keyname[offset] = line[offset];
+                offset++;
             }
-            if (*end_of_keysym) {
+            keyname[offset] = 0;
+            if (strlen(keyname)) {
                 int keysym;
-                *end_of_keysym = 0;
-                keysym = get_keysym(table, line);
+                keysym = get_keysym(table, keyname);
                 if (keysym == 0) {
                     /* fprintf(stderr, "Warning: unknown keysym %s\n", line);*/
                 } else {
-                    const char *rest = end_of_keysym + 1;
+                    const char *rest = line + offset + 1;
                     int keycode = strtol(rest, NULL, 0);
 
                     if (strstr(rest, "numlock")) {
@@ -165,10 +167,10 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
 
                     if (strstr(rest, "addupper")) {
                         char *c;
-                        for (c = line; *c; c++) {
+                        for (c = keyname; *c; c++) {
                             *c = qemu_toupper(*c);
                         }
-                        keysym = get_keysym(table, line);
+                        keysym = get_keysym(table, keyname);
                         if (keysym) {
                             add_keysym(line, keysym,
                                        keycode | SCANCODE_SHIFT, k);
@@ -194,6 +196,7 @@ int keysym2scancode(void *kbd_layout, int keysym)
     kbd_layout_t *k = kbd_layout;
     if (keysym < MAX_NORMAL_KEYCODE) {
         if (k->keysym2keycode[keysym] == 0) {
+            trace_keymap_unmapped(keysym);
             fprintf(stderr, "Warning: no scancode found for keysym %d\n",
                     keysym);
         }
diff --git a/ui/trace-events b/ui/trace-events
index 93fe5482e6..19ce5f85f6 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -46,3 +46,8 @@ qemu_spice_create_primary_surface(int qid, uint32_t sid, void *surface, int asyn
 qemu_spice_destroy_primary_surface(int qid, uint32_t sid, int async) "%d sid=%u async=%d"
 qemu_spice_wakeup(uint32_t qid) "%d"
 qemu_spice_create_update(uint32_t left, uint32_t right, uint32_t top, uint32_t bottom) "lr %d -> %d,  tb -> %d -> %d"
+
+# ui/keymaps.c
+keymap_parse(const char *file) "file %s"
+keymap_add(const char *type, int sym, int code, const char *line) "%-6s sym=0x%04x code=0x%04x (line: %s)"
+keymap_unmapped(int sym) "sym=0x%04x"
-- 
2.9.3
