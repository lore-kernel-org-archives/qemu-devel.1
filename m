Received: from eggs.gnu.org ([2001:4830:134:3::10]:45795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb70S-0008Ng-Ur
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb70P-0005bP-4H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb70O-0005az-SP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2D28C047B91
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 15:48:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Jan 2018 16:48:54 +0100
Message-Id: <20180115154855.30850-2-kraxel@redhat.com>
In-Reply-To: <20180115154855.30850-1-kraxel@redhat.com>
References: <20180115154855.30850-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] sdl: use ctrl-alt-g as grab hotkey
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

Be consistent with gtk and cocoa.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl.c  | 30 +++++++++++++-----------------
 ui/sdl2.c | 27 +++++++++++----------------
 2 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/ui/sdl.c b/ui/sdl.c
index 7b71a9ac58..9c664c86a0 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -368,11 +368,11 @@ static void sdl_update_caption(void)
         status = " [Stopped]";
     else if (gui_grab) {
         if (alt_grab)
-            status = " - Press Ctrl-Alt-Shift to exit mouse grab";
+            status = " - Press Ctrl-Alt-Shift-G to exit mouse grab";
         else if (ctrl_grab)
-            status = " - Press Right-Ctrl to exit mouse grab";
+            status = " - Press Right-Ctrl-G to exit mouse grab";
         else
-            status = " - Press Ctrl-Alt to exit mouse grab";
+            status = " - Press Ctrl-Alt-G to exit mouse grab";
     }
 
     if (qemu_name) {
@@ -576,6 +576,16 @@ static void handle_keydown(SDL_Event *ev)
             toggle_full_screen();
             gui_keysym = 1;
             break;
+        case 0x22: /* 'g' key */
+            if (!gui_grab) {
+                if (qemu_console_is_graphic(NULL)) {
+                    sdl_grab_start();
+                }
+            } else if (!gui_fullscreen) {
+                sdl_grab_end();
+            }
+            gui_keysym = 1;
+            break;
         case 0x16: /* 'u' key on US keyboard */
             if (scaling_active) {
                 scaling_active = 0;
@@ -711,20 +721,6 @@ static void handle_keyup(SDL_Event *ev)
     }
     if (!mod_state && gui_key_modifier_pressed) {
         gui_key_modifier_pressed = 0;
-        if (gui_keysym == 0) {
-            /* exit/enter grab if pressing Ctrl-Alt */
-            if (!gui_grab) {
-                if (qemu_console_is_graphic(NULL)) {
-                    sdl_grab_start();
-                }
-            } else if (!gui_fullscreen) {
-                sdl_grab_end();
-            }
-            /* SDL does not send back all the modifiers key, so we must
-             * correct it. */
-            reset_keys();
-            return;
-        }
         gui_keysym = 0;
     }
     if (qemu_console_is_graphic(NULL) && !gui_keysym) {
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 89c6a2633c..1db5dd6f5f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -141,11 +141,11 @@ static void sdl_update_caption(struct sdl2_console *scon)
         status = " [Stopped]";
     } else if (gui_grab) {
         if (alt_grab) {
-            status = " - Press Ctrl-Alt-Shift to exit grab";
+            status = " - Press Ctrl-Alt-Shift-G to exit grab";
         } else if (ctrl_grab) {
-            status = " - Press Right-Ctrl to exit grab";
+            status = " - Press Right-Ctrl-G to exit grab";
         } else {
-            status = " - Press Ctrl-Alt to exit grab";
+            status = " - Press Ctrl-Alt-G to exit grab";
         }
     }
 
@@ -364,6 +364,14 @@ static void handle_keydown(SDL_Event *ev)
             toggle_full_screen(scon);
             gui_keysym = 1;
             break;
+        case SDL_SCANCODE_G:
+            gui_keysym = 1;
+            if (!gui_grab) {
+                sdl_grab_start(scon);
+            } else if (!gui_fullscreen) {
+                sdl_grab_end(scon);
+            }
+            break;
         case SDL_SCANCODE_U:
             sdl2_window_destroy(scon);
             sdl2_window_create(scon);
@@ -416,19 +424,6 @@ static void handle_keyup(SDL_Event *ev)
     }
     if (!mod_state && gui_key_modifier_pressed) {
         gui_key_modifier_pressed = 0;
-        if (gui_keysym == 0) {
-            /* exit/enter grab if pressing Ctrl-Alt */
-            if (!gui_grab) {
-                sdl_grab_start(scon);
-            } else if (!gui_fullscreen) {
-                sdl_grab_end(scon);
-            }
-            /* SDL does not send back all the modifiers key, so we must
-             * correct it. */
-            sdl2_reset_keys(scon);
-            return;
-        }
-        sdl2_reset_keys(scon);
         gui_keysym = 0;
     }
     if (!gui_keysym) {
-- 
2.9.3
