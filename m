Received: from eggs.gnu.org ([2001:4830:134:3::10]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9TP-0008LT-74
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9TJ-00071B-JF
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo9TJ-00070x-Eu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:04:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1107F402314E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:04:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 16:04:44 +0100
Message-Id: <20180220150444.784-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: fix hotkey keyup
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

After some hotkey was pressed sdl2 doesn't forward the first modifier
keyup event to the guest, resulting in stuck modifier keys.

Fix the logic in handle_keyup().  Also gui_key_modifier_pressed doesn't
need to be a global variable.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 858e04d7c0..488e10269c 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -38,7 +38,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_key_modifier_pressed;
 static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
@@ -330,8 +329,7 @@ static void handle_keydown(SDL_Event *ev)
 {
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
-
-    gui_key_modifier_pressed = get_mod_state();
+    int gui_key_modifier_pressed = get_mod_state();
 
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
@@ -412,18 +410,12 @@ static void handle_keydown(SDL_Event *ev)
 
 static void handle_keyup(SDL_Event *ev)
 {
-    int mod_state;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    int gui_key_modifier_pressed = get_mod_state();
 
     scon->ignore_hotkeys = false;
 
-    if (!alt_grab) {
-        mod_state = (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state = (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT));
-    }
-    if (!mod_state && gui_key_modifier_pressed) {
-        gui_key_modifier_pressed = 0;
+    if (!gui_key_modifier_pressed) {
         gui_keysym = 0;
     }
     if (!gui_keysym) {
-- 
2.9.3
