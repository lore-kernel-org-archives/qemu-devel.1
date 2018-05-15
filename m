Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIf9O-0001ll-E7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIf9N-0005ED-LL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:58:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIf9N-0005Du-Ek
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:58:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 19:58:14 +0100
Message-Id: <20180515185814.1374-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] sdl: Move use of surface pointer below check
 for whether it is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

In commit 2ab858c6c38ee1 we added a use of the 'surf' variable
in sdl2_2d_update() that was unfortunately placed above the
early-exit-if-NULL check. Move it to where it ought to be.

Fixes: Coverity CID 1390598
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/sdl2-2d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 1f34817bae..85484407be 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -36,9 +36,7 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
     DisplaySurface *surf = qemu_console_surface(dcl->con);
     SDL_Rect rect;
-    size_t surface_data_offset = surface_bytes_per_pixel(surf) * x +
-                                 surface_stride(surf) * y;
-
+    size_t surface_data_offset;
     assert(!scon->opengl);
 
     if (!surf) {
@@ -48,6 +46,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
         return;
     }
 
+    surface_data_offset = surface_bytes_per_pixel(surf) * x +
+                          surface_stride(surf) * y;
     rect.x = x;
     rect.y = y;
     rect.w = w;
-- 
2.17.0
