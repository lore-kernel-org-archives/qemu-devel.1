Received: from eggs.gnu.org ([2001:4830:134:3::10]:56990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMP-0006L0-PQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTME-0000MX-6X
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTMD-0000JY-J6
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2A48C049E3A
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:45 +0200
Message-Id: <20181016174158.15229-26-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 25/38] ui/keymaps: Fix handling of erroneous
 include files
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

While errors in the keyboard layout named with -k are fatal, errors in
included files are reported, but otherwise ignored:

    $ cat worst
    include bad
    include worse
    $ ls -l bad worse
    ls: cannot access 'bad': No such file or directory
    ls: cannot access 'worse': No such file or directory
    $ qemu-system-x86_64 -nodefaults -S -monitor stdio -display vnc=:0 -k bad
    QEMU 3.0.50 monitor - type 'help' for more information
    (qemu) Could not read keymap file: 'bad'
    $ qemu-system-x86_64 -nodefaults -S -monitor stdio -display vnc=:0 -k worst
    QEMU 3.0.50 monitor - type 'help' for more information
    (qemu) Could not read keymap file: 'bad'
    Could not read keymap file: 'worse'

Fix that.

Note that parse_keyboard_layout() allocates the keymap, except when
it's parsing an include file.  To keep error handling simple, move the
memory management to its caller init_keyboard_layout().

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/keymaps.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 43fe604724..b05fb028dc 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -79,10 +79,11 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
     trace_keymap_add(keysym, keycode, line);
 }
 
-static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
-                                           const char *language,
-                                           kbd_layout_t *k)
+static int parse_keyboard_layout(kbd_layout_t *k,
+                                 const name2keysym_t *table,
+                                 const char *language)
 {
+    int ret;
     FILE *f;
     char * filename;
     char line[1024];
@@ -95,12 +96,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
     g_free(filename);
     if (!f) {
         fprintf(stderr, "Could not read keymap file: '%s'\n", language);
-        return NULL;
-    }
-
-    if (!k) {
-        k = g_new0(kbd_layout_t, 1);
-        k->hash = g_hash_table_new(NULL, NULL);
+        return -1;
     }
 
     for(;;) {
@@ -118,7 +114,10 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
             continue;
         }
         if (!strncmp(line, "include ", 8)) {
-            parse_keyboard_layout(table, line + 8, k);
+            if (parse_keyboard_layout(k, table, line + 8) < 0) {
+                ret = -1;
+                goto out;
+            }
         } else {
             int offset = 0;
             while (line[offset] != 0 &&
@@ -164,15 +163,27 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
             }
         }
     }
+
+    ret = 0;
+out:
     fclose(f);
-    return k;
+    return ret;
 }
 
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language)
 {
-    return parse_keyboard_layout(table, language, NULL);
+    kbd_layout_t *k;
+
+    k = g_new0(kbd_layout_t, 1);
+    k->hash = g_hash_table_new(NULL, NULL);
+    if (parse_keyboard_layout(k, table, language) < 0) {
+        g_hash_table_unref(k->hash);
+        g_free(k);
+        return NULL;
+    }
+    return k;
 }
 
 
-- 
2.17.1
