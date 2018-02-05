Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eigt0-0000sY-Et
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eigsx-00044M-CC
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:32:42 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1eigsx-00043P-4B
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:32:39 -0500
Received: by mail-lf0-x241.google.com with SMTP id a204so41747798lfa.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:32:38 -0800 (PST)
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Mon,  5 Feb 2018 16:32:28 +0300
Message-Id: <20180205133228.25082-1-anatoly.trosinenko@gmail.com>
Subject: [Qemu-devel] [PATCH] sdl: restore optimized redraw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

The documentation on SDL_RenderPresent function states that
"the backbuffer should be considered invalidated after each present",
so copy the entire texture on each redraw.

On the other hand, SDL_UpdateTexture function is described as
"fairly slow function", so restrict it to just the changed pixels.

Also added SDL_RenderClear call, as suggested in the documentation
page on SDL_RenderPresent.

Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
---
I managed to reproduce some flicker when using SDL 2D UI (and #if 1)
and it disappeared after this patch. I don't know the original
testcase, though. Hope I correctly calculated the offset. :)

Meanwhile, is it correct to calculate surface_data_offset before assert,
is everything always initialized enough at this point even if assert fails?

 ui/sdl2-2d.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

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
-
-    SDL_UpdateTexture(scon->texture, NULL, surface_data(surf),
+
+    SDL_UpdateTexture(scon->texture, &rect,
+                      surface_data(surf) + surface_data_offset,
                       surface_stride(surf));
-    SDL_RenderCopy(scon->real_renderer, scon->texture, &rect, &rect);
+    SDL_RenderClear(scon->real_renderer);
+    SDL_RenderCopy(scon->real_renderer, scon->texture, NULL, NULL);
     SDL_RenderPresent(scon->real_renderer);
 }
 
-- 
2.14.1
