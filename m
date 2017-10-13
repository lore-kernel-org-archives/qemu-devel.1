Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v7T-0003BK-U2
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v7S-0004M0-R8
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2v7S-0004LU-Ll
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:14:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Oct 2017 10:14:50 +0200
Message-Id: <20171013081450.29647-12-kraxel@redhat.com>
In-Reply-To: <20171013081450.29647-1-kraxel@redhat.com>
References: <20171013081450.29647-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] gtk: fix wrong id between texture and
 framebuffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>

The gd_gl_area_scanout_texture must destroy framebuffer if there is
no texture id instead of no framebuffer id.
The effect was a black screen with "-vga virtio -display gtk,gl=on"
options.
The bug was introduce by a4f113fd "gtk: use framebuffer helper functions."

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Message-id: 20171002124052.13829-1-anthoine.bourgeois@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk-gl-area.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 01ebf2c7de..7080f4e14f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -178,8 +178,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
 
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
-    if (vc->gfx.guest_fb.framebuffer  == 0 ||
-        vc->gfx.w == 0 || vc->gfx.h == 0) {
+    if (backing_id == 0 || vc->gfx.w == 0 || vc->gfx.h == 0) {
         gtk_gl_area_set_scanout_mode(vc, false);
         return;
     }
-- 
2.9.3
