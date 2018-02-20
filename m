Received: from eggs.gnu.org ([2001:4830:134:3::10]:35034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9Sp-0007s2-2D
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9Sj-0006Py-EJ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo9Sj-0006PT-A4
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 803E8402315A
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:04:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 16:03:56 +0100
Message-Id: <20180220150357.324-5-kraxel@redhat.com>
In-Reply-To: <20180220150357.324-1-kraxel@redhat.com>
References: <20180220150357.324-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] keymap: record multiple keysym ->
 keycode mappings
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

Sometimes the same keysym can be created using different key
combinations.  Record them all in the reverse keymap, not only
the first one.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index d71ae389e0..26a85ff207 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -29,7 +29,8 @@
 #include "qemu/error-report.h"
 
 struct keysym2code {
-    uint16_t keycode;
+    uint32_t count;
+    uint16_t keycodes[4];
 };
 
 struct kbd_layout_t {
@@ -68,11 +69,18 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
 
     keysym2code = g_hash_table_lookup(k->hash, hashkey(keysym));
     if (keysym2code) {
+        if (keysym2code->count < ARRAY_SIZE(keysym2code->keycodes)) {
+            keysym2code->keycodes[keysym2code->count++] = keycode;
+        } else {
+            warn_report("more than %zd keycodes for keysym %d",
+                        ARRAY_SIZE(keysym2code->keycodes), keysym);
+        }
         return;
     }
 
     keysym2code = g_new0(struct keysym2code, 1);
-    keysym2code->keycode = keycode;
+    keysym2code->keycodes[0] = keycode;
+    keysym2code->count = 1;
     g_hash_table_replace(k->hash, hashkey(keysym), keysym2code);
     trace_keymap_add(keysym, keycode, line);
 }
@@ -191,7 +199,7 @@ int keysym2scancode(kbd_layout_t *k, int keysym)
         return 0;
     }
 
-    return keysym2code->keycode;
+    return keysym2code->keycodes[0];
 }
 
 int keycode_is_keypad(kbd_layout_t *k, int keycode)
-- 
2.9.3
