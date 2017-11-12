Received: from eggs.gnu.org ([2001:4830:134:3::10]:53606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjg-0002Ud-UQ
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjf-00044a-Kv
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:32 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDpjf-000446-EQ
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:31 -0500
Received: by mail-wr0-x242.google.com with SMTP id y42so12041806wrd.3
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 02:43:31 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 11:42:41 +0100
Message-Id: <20171112104246.10007-4-makovick@gmail.com>
In-Reply-To: <20171112104246.10007-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171112104246.10007-1-makovick@gmail.com>
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
