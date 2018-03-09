Received: from eggs.gnu.org ([2001:4830:134:3::10]:33701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euJ91-0000nr-BB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euJ8y-0003HK-6b
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:37:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euJ8y-0003HC-1t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:37:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87693406E8A4
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 14:37:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  9 Mar 2018 15:37:04 +0100
Message-Id: <20180309143704.13420-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] vga: fix region calculation
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
