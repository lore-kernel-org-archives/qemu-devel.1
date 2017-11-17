Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY4-0006eT-Cj
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY1-00064F-QU
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdY1-000637-Jj
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:06:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:06:50 +0100
Message-Id: <20171117100653.13015-3-kraxel@redhat.com>
In-Reply-To: <20171117100653.13015-1-kraxel@redhat.com>
References: <20171117100653.13015-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] sdl2: Use the same pointer show/hide logic
 for absolute and relative mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jindrich Makovicka <makovick@gmail.com>

Also use a proper enum parameter for SDL_ShowCursor

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171112193032.9724-4-makovick@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 05729af971..d0f16f60f4 100644
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
2.9.3
