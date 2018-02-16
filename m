Received: from eggs.gnu.org ([2001:4830:134:3::10]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dP-Pg
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003ff-JR
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eO-DL
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:05 +0100
Message-Id: <20180216115410.27287-5-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] sdl: restore optimized redraw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

The documentation on SDL_RenderPresent function states that
"the backbuffer should be considered invalidated after each present",
so copy the entire texture on each redraw.

On the other hand, SDL_UpdateTexture function is described as
"fairly slow function", so restrict it to just the changed pixels.

Also added SDL_RenderClear call, as suggested in the documentation
page on SDL_RenderPresent.

Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Message-id: 20180205133228.25082-1-anatoly.trosinenko@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-2d.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 8ab68d67b9..1f34817bae 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -36,6 +36,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
     DisplaySurface *surf = qemu_console_surface(dcl->con);
     SDL_Rect rect;
+    size_t surface_data_offset = surface_bytes_per_pixel(surf) * x +
+                                 surface_stride(surf) * y;
 
     assert(!scon->opengl);
 
@@ -46,27 +48,16 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
         return;
     }
 
-    /*
-     * SDL2 seems to do some double-buffering, and trying to only
-     * update the changed areas results in only one of the two buffers
-     * being updated.  Which flickers alot.  So lets not try to be
-     * clever do a full update every time ...
-     */
-#if 0
     rect.x = x;
     rect.y = y;
     rect.w = w;
     rect.h = h;
-#else
-    rect.x = 0;
-    rect.y = 0;
-    rect.w = surface_width(surf);
-    rect.h = surface_height(surf);
-#endif
 
-    SDL_UpdateTexture(scon->texture, NULL, surface_data(surf),
+    SDL_UpdateTexture(scon->texture, &rect,
+                      surface_data(surf) + surface_data_offset,
                       surface_stride(surf));
-    SDL_RenderCopy(scon->real_renderer, scon->texture, &rect, &rect);
+    SDL_RenderClear(scon->real_renderer);
+    SDL_RenderCopy(scon->real_renderer, scon->texture, NULL, NULL);
     SDL_RenderPresent(scon->real_renderer);
 }
 
-- 
2.9.3
