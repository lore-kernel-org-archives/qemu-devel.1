Received: from eggs.gnu.org ([2001:4830:134:3::10]:44542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gk-0000CC-5V
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gg-0007fe-Qc
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:06 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:43:11 -0500
Message-Id: <20180619014319.28272-106-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 105/113] vga: fix region calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Typically the scanline length and the line offset are identical.  But
in case they are not our calculation for region_end is incorrect.  Using
line_offset is fine for all scanlines, except the last one where we have
to use the actual scanline length.

Fixes: CVE-2018-7550
Reported-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Tested-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-id: 20180309143704.13420-1-kraxel@redhat.com
(cherry picked from commit 7cdc61becd095b64a786b2625f321624e7111f3d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/vga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index d150a3a3eb..1fa66d597d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1489,6 +1489,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     region_start = (s->start_addr * 4);
     region_end = region_start + (ram_addr_t)s->line_offset * height;
+    region_end += width * s->get_bpp(s) / 8; /* scanline length */
+    region_end -= s->line_offset;
     if (region_end > s->vbe_size) {
         /* wraps around (can happen with cirrus vbe modes) */
         region_start = 0;
-- 
2.11.0
