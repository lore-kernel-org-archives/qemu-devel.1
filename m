Received: from eggs.gnu.org ([2001:4830:134:3::10]:51701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUvA-0001h1-7n
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv7-00087h-EH
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:16 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:59703)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv7-00087R-7W
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:13 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Dec 2016 01:38:06 +0100
Message-Id: <20161221003806.22412-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
References: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH 3/3] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

This uses the console API to record the window ID of the SDL2 windows.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 ui/sdl2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 30d2a3c35d..9a79b17b92 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -761,6 +761,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     uint8_t data = 0;
     char *filename;
     int i;
+    SDL_SysWMinfo info;
 
     if (no_frame) {
         gui_noframe = 1;
@@ -786,6 +787,8 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
         exit(1);
     }
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
+    memset(&info, 0, sizeof(info));
+    SDL_VERSION(&info.version);
 
     for (i = 0;; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
@@ -813,6 +816,10 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
 #endif
         sdl2_console[i].dcl.con = con;
         register_displaychangelistener(&sdl2_console[i].dcl);
+
+        if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
+            qemu_console_set_window_id(con, info.info.x11.window);
+        }
     }
 
     /* Load a 32x32x4 image. White pixels are transparent. */
-- 
2.11.0
