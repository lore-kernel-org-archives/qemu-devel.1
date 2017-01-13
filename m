Received: from eggs.gnu.org ([2001:4830:134:3::10]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRx0f-0005Qb-Tj
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRx0d-0000Qp-0o
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRx0c-0000QQ-Rp
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:14:50 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Jan 2017 09:14:45 +0100
Message-Id: <1484295285-8809-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: fix build failure on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>, Samuel Thibault <samuel.thibault@gnu.org>

Cc: Stefan Weil <sw@weilnetz.de>
Cc: Samuel Thibault <samuel.thibault@gnu.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9a79b17..91fb111 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -817,9 +817,15 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
         sdl2_console[i].dcl.con = con;
         register_displaychangelistener(&sdl2_console[i].dcl);
 
+#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
+#if defined(SDL_VIDEO_DRIVER_WINDOWS)
+            qemu_console_set_window_id(con, (uintptr_t)info.info.win.window);
+#elif defined(SDL_VIDEO_DRIVER_X11)
             qemu_console_set_window_id(con, info.info.x11.window);
+#endif
         }
+#endif
     }
 
     /* Load a 32x32x4 image. White pixels are transparent. */
-- 
1.8.3.1
