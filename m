Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNDa0-0005Xf-N4
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNDZt-0006vg-Of
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:04:50 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gNDZn-0006py-WF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:04:41 -0500
Received: by mail-pg1-x542.google.com with SMTP id 70so8714335pgh.8
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 01:04:30 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 01:04:23 -0800
Message-Id: <1542272663-6619-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] keymaps: detect recursive keyboard layout file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

When the parse_keyboard_layout() find a "include " line
in the keyboard layout file, it will call parse_keyboard_layout()
to perform a recursive parse. If the keyboard layout is malformed
by adding a line include itself, this can cause an infinite parse.
Thus cause qemu a segv. This patch avoid this.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 ui/keymaps.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 085889b555..564893a9f3 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -38,6 +38,8 @@ struct kbd_layout_t {
     GHashTable *hash;
 };
 
+GList *keyboard_files;
+
 static int get_keysym(const name2keysym_t *table,
                       const char *name)
 {
@@ -80,6 +82,11 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
     trace_keymap_add(keysym, keycode, line);
 }
 
+static gint compare_string(gconstpointer a, gconstpointer b)
+{
+    return g_strcmp0(a, b);
+}
+
 static int parse_keyboard_layout(kbd_layout_t *k,
                                  const name2keysym_t *table,
                                  const char *language, Error **errp)
@@ -94,12 +101,18 @@ static int parse_keyboard_layout(kbd_layout_t *k,
     filename = qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
     trace_keymap_parse(filename);
     f = filename ? fopen(filename, "r") : NULL;
-    g_free(filename);
     if (!f) {
+        g_free(filename);
         error_setg(errp, "could not read keymap file: '%s'", language);
         return -1;
     }
 
+    if (g_list_find_custom(keyboard_files, filename, compare_string)) {
+        error_setg(errp, "find recursive keyboard layout: %s'", filename);
+        g_free(filename);
+        return -1;
+    }
+    keyboard_files = g_list_append(keyboard_files, filename);
     for(;;) {
         if (fgets(line, 1024, f) == NULL) {
             break;
@@ -168,6 +181,8 @@ static int parse_keyboard_layout(kbd_layout_t *k,
     ret = 0;
 out:
     fclose(f);
+    keyboard_files = g_list_remove(keyboard_files, filename);
+    g_free(filename);
     return ret;
 }
 
-- 
2.11.0
