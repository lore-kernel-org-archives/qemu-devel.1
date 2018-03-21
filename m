Received: from eggs.gnu.org ([2001:4830:134:3::10]:53031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8i-00070a-Cm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8h-0007vg-Hg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8h-0007vH-DL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:37 +0100
Message-Id: <20180321135041.15768-3-kraxel@redhat.com>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
References: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] sdl2: track kbd modifier state
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, balaton@eik.bme.hu

For both grapical and text consoles.

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
