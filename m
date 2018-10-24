Received: from eggs.gnu.org ([2001:4830:134:3::10]:51974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <seba.dos1@gmail.com>) id 1gFKXp-0000E7-QB
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 10:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <seba.dos1@gmail.com>) id 1gFKIE-0002zm-4P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 10:37:56 -0400
From: Sebastian Krzyszkowiak <dos@dosowisko.net>
Date: Wed, 24 Oct 2018 16:37:48 +0200
Message-Id: <20181024143748.4425-1-dos@dosowisko.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] SDL: set a hint to not bypass the window
 compositor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, dos@dosowisko.net

Without that, window effects in KWin get suspended as soon as any
qemu-sdl window becomes visible. While the SDL default makes sense
for games, it's not really suitable for QEMU.

Signed-off-by: Sebastian Krzyszkowiak <dos@dosowisko.net>
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
2.19.1
