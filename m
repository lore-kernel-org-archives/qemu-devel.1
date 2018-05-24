Received: from eggs.gnu.org ([2001:4830:134:3::10]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRG-0000LW-OC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRE-00030n-4L
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRE-00030Q-00
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B3DD805A531
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:50 +0200
Message-Id: <20180524154556.17876-2-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] vga: catch depth 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

depth == 0 is used to indicate 256 color modes.  Our region calculation
goes wrong in that case.  So detect that and just take the safe code
path we already have for the wraparound case.

While being at it also catch depth == 15 (where our region size
calculation goes wrong too).  And make the comment more verbose,
explaining what is going on here.

Without this windows guest install might trigger an assert due to trying
to check dirty bitmap outside the snapshot region.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1575541
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180514103117.21059-1-kraxel@redhat.com
---
 hw/display/vga.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 72181330b8..a7794f6d1f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1480,13 +1480,28 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     s->get_resolution(s, &width, &height);
     disp_width = width;
+    depth = s->get_bpp(s);
 
     region_start = (s->start_addr * 4);
     region_end = region_start + (ram_addr_t)s->line_offset * height;
-    region_end += width * s->get_bpp(s) / 8; /* scanline length */
+    region_end += width * depth / 8; /* scanline length */
     region_end -= s->line_offset;
-    if (region_end > s->vbe_size) {
-        /* wraps around (can happen with cirrus vbe modes) */
+    if (region_end > s->vbe_size || depth == 0 || depth == 15) {
+        /*
+         * We land here on:
+         *  - wraps around (can happen with cirrus vbe modes)
+         *  - depth == 0 (256 color palette video mode)
+         *  - depth == 15
+         *
+         * Take the safe and slow route:
+         *   - create a dirty bitmap snapshot for all vga memory.
+         *   - force shadowing (so all vga memory access goes
+         *     through vga_read_*() helpers).
+         *
+         * Given this affects only vga features which are pretty much
+         * unused by modern guests there should be no performance
+         * impact.
+         */
         region_start = 0;
         region_end = s->vbe_size;
         force_shadow = true;
@@ -1520,8 +1535,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         }
     }
 
-    depth = s->get_bpp(s);
-
     /*
      * Check whether we can share the surface with the backend
      * or whether we need a shadow surface. We share native
-- 
2.9.3
