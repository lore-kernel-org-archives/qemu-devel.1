Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthoine.bourgeois@gmail.com>) id 1dyxdw-0001qK-7E
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 06:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthoine.bourgeois@gmail.com>) id 1dyxds-0004Nc-CJ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 06:08:08 -0400
From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Date: Mon,  2 Oct 2017 12:07:46 +0200
Message-Id: <20171002100746.9408-1-anthoine.bourgeois@blade-group.com>
Subject: [Qemu-devel] [PATCH] gtk: fix wrong id between texture and
 framebuffer
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
List-ID: <qemu-devel.nongnu.org>

The gd_gl_area_scanout_texture must destroy framebuffer if there is
no texture id instead of no framebuffer id.
The effect was a black screen with "-vga virtio -display gtk,gl=on"
options.
The bug was introduce by a4f113fd "gtk: use framebuffer helper functions."

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
---
 ui/gtk-gl-area.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 18b298f..026b7d7 100644
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
