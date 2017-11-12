Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxo-0001dX-Ue
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxo-0008EK-31
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:40 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxn-0008E6-SV
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:40 -0500
Received: by mail-wm0-x242.google.com with SMTP id r68so11335343wmr.3
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:39 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:27 +0100
Message-Id: <20171112193032.9724-4-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 3/8] sdl2: Use the same pointer show/hide logic
 for absolute and relative mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

Also use a proper enum parameter for SDL_ShowCursor

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index dfbd0de791..9cf4b1772b 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -169,10 +169,10 @@ static void sdl_hide_cursor(void)
         return;
     }
 
-    if (qemu_input_is_absolute()) {
-        SDL_ShowCursor(1);
-        SDL_SetCursor(sdl_cursor_hidden);
-    } else {
+    SDL_ShowCursor(SDL_DISABLE);
+    SDL_SetCursor(sdl_cursor_hidden);
+
+    if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_TRUE);
     }
 }
@@ -185,14 +185,16 @@ static void sdl_show_cursor(void)
 
     if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_FALSE);
-        SDL_ShowCursor(1);
-        if (guest_cursor &&
-            (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
-            SDL_SetCursor(guest_sprite);
-        } else {
-            SDL_SetCursor(sdl_cursor_normal);
-        }
     }
+
+    if (guest_cursor &&
+        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
+        SDL_SetCursor(guest_sprite);
+    } else {
+        SDL_SetCursor(sdl_cursor_normal);
+    }
+
+    SDL_ShowCursor(SDL_ENABLE);
 }
 
 static void sdl_grab_start(struct sdl2_console *scon)
-- 
2.15.0
