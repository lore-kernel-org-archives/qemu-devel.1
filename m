Received: from eggs.gnu.org ([2001:4830:134:3::10]:45592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLBL-0002PZ-CD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evLBI-0008Fi-AM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:59:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evLBI-0008Es-6C
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:59:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F52E8E684
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:59:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:59:41 +0100
Message-Id: <20180312105941.15439-2-kraxel@redhat.com>
In-Reply-To: <20180312105941.15439-1-kraxel@redhat.com>
References: <20180312105941.15439-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] vga: fix region calculation
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
