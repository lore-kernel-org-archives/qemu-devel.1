Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NT-0003Wd-3x
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NP-00043E-Rd
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH8NO-00040H-Os
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:43 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 15:18:33 +0100
Message-Id: <20181029141834.8794-2-kraxel@redhat.com>
In-Reply-To: <20181029141834.8794-1-kraxel@redhat.com>
References: <20181029141834.8794-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] SDL: set a hint to not bypass the window
 compositor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Sebastian Krzyszkowiak <dos@dosowisko.net>

From: Sebastian Krzyszkowiak <dos@dosowisko.net>

Without that, window effects in KWin get suspended as soon as any
qemu-sdl window becomes visible. While the SDL default makes sense
for games, it's not really suitable for QEMU.

Signed-off-by: Sebastian Krzyszkowiak <dos@dosowisko.net>
Message-id: 20181024143748.4425-1-dos@dosowisko.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 2696b95c79..a10b6e3a08 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -786,6 +786,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
                 SDL_GetError());
         exit(1);
     }
+#ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
+    SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
+#endif
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
-- 
2.9.3
