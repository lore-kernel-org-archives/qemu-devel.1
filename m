Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIP-0005dU-NX
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIL-0003ar-UO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TIL-0003aa-Px
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53E89401CC41
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 09:41:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Apr 2018 11:40:57 +0200
Message-Id: <20180409094100.27650-4-kraxel@redhat.com>
In-Reply-To: <20180409094100.27650-1-kraxel@redhat.com>
References: <20180409094100.27650-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] sdl2: track kbd modifier state
 unconditionally
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

For both grapical and text consoles.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180321135041.15768-3-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 35d35c14c4..8d0d9ba17c 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -60,23 +60,7 @@ void sdl2_process_key(struct sdl2_console *scon,
 
     qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
 
-    if (!qemu_console_is_graphic(con)) {
-        if (ev->type == SDL_KEYDOWN) {
-            switch (ev->keysym.scancode) {
-            case SDL_SCANCODE_RETURN:
-                kbd_put_keysym_console(con, '\n');
-                break;
-            case SDL_SCANCODE_BACKSPACE:
-                kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
-                break;
-            default:
-                kbd_put_qcode_console(con, qcode, false);
-                break;
-            }
-        }
-        return;
-    }
-
+    /* modifier state tracking */
     switch (ev->keysym.scancode) {
 #if 0
     case SDL_SCANCODE_NUMLOCKCLEAR:
@@ -99,8 +83,27 @@ void sdl2_process_key(struct sdl2_console *scon,
         } else {
             modifiers_state[ev->keysym.scancode] = 1;
         }
-        /* fall though */
+        break;
     default:
+        /* nothing */
+        break;
+    }
+
+    if (!qemu_console_is_graphic(con)) {
+        if (ev->type == SDL_KEYDOWN) {
+            switch (ev->keysym.scancode) {
+            case SDL_SCANCODE_RETURN:
+                kbd_put_keysym_console(con, '\n');
+                break;
+            case SDL_SCANCODE_BACKSPACE:
+                kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
+                break;
+            default:
+                kbd_put_qcode_console(con, qcode, false);
+                break;
+            }
+        }
+    } else {
         qemu_input_event_send_key_qcode(con, qcode,
                                         ev->type == SDL_KEYDOWN);
     }
-- 
2.9.3
