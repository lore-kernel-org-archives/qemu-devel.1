Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0000ll-IP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdv9-0007JM-5i
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdv8-0007Il-Tj
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D13380473
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:25 +0100
Message-Id: <20171117103046.15943-4-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 03/24] sdl: use ctrl-alt-g as grab hotkey
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Be consistent with gtk and cocoa.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl.c  | 26 +++++++++++---------------
 ui/sdl2.c | 22 +++++++++-------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/ui/sdl.c b/ui/sdl.c
index 2c85482b5e..6ce67eeb5a 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -364,7 +364,7 @@ static void sdl_update_caption(void)
     if (!runstate_is_running())
         status = " [Stopped]";
     else if (gui_grab) {
-        status = " - Press Ctrl-Alt to exit mouse grab";
+        status = " - Press Ctrl-Alt-G to exit mouse grab";
     }
 
     if (qemu_name) {
@@ -561,6 +561,16 @@ static void handle_keydown(SDL_Event *ev)
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
@@ -692,20 +702,6 @@ static void handle_keyup(SDL_Event *ev)
     mod_state = (ev->key.keysym.mod & gui_grab_code);
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
index e15566877b..105c461b21 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -139,7 +139,7 @@ static void sdl_update_caption(struct sdl2_console *scon)
     if (!runstate_is_running()) {
         status = " [Stopped]";
     } else if (gui_grab) {
-        status = " - Press Ctrl-Alt to exit grab";
+        status = " - Press Ctrl-Alt-G to exit grab";
     }
 
     if (qemu_name) {
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
@@ -410,18 +418,6 @@ static void handle_keyup(SDL_Event *ev)
     mod_state = (ev->key.keysym.mod & gui_grab_code);
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
         gui_keysym = 0;
     }
     if (!gui_keysym) {
-- 
2.9.3
