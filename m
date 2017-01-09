Received: from eggs.gnu.org ([2001:4830:134:3::10]:54550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZi0-00053E-Gu
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhv-0008SC-Di
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZhv-0008Rk-8H
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:39 +0100
Message-Id: <1483967385-12891-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/11] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This uses the console API to record the window ID of the SDL2 windows.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20161221003806.22412-4-samuel.thibault@ens-lyon.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 30d2a3c..9a79b17 100644
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
1.8.3.1
