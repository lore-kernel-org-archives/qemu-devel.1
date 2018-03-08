Received: from eggs.gnu.org ([2001:4830:134:3::10]:56492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etq2G-00077z-JQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etq2D-0002Ou-Fz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:32:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etq2D-0002Om-Br
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:32:17 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 08:31:59 +0100
Message-Id: <20180308073159.1068-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vga: fix region calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

Typically the scanline length and the line offset are identical.  But
case they are not our calculation for region_end is incorrect.  Using
line_offset is fine for all scanlines, except the last one where we have
to use the actual scanline length.

Fixes: CVE-2018-<to-be-filled>
Cc: P J P <ppandit@redhat.com>
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 28f298b342..72181330b8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1483,6 +1483,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     region_start = (s->start_addr * 4);
     region_end = region_start + (ram_addr_t)s->line_offset * height;
+    region_end += width * s->get_bpp(s) / 8; /* scanline length */
+    region_end -= s->line_offset;
     if (region_end > s->vbe_size) {
         /* wraps around (can happen with cirrus vbe modes) */
         region_start = 0;
-- 
2.9.3
