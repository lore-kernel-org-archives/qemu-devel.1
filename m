Received: from eggs.gnu.org ([2001:4830:134:3::10]:36820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iu-00058V-UJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Ir-0003HK-55
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Iq-0003FR-VR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5DD18553E
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:35 +0200
Message-Id: <20170913074140.5160-2-kraxel@redhat.com>
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] vga: fix display update region calculation
 (split screen)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

vga display update mis-calculated the region for the dirty bitmap
snapshot in case split screen mode is used.  This can trigger an
assert in cpu_physical_memory_snapshot_get_dirty().

Impact:  DoS for privileged guest users.

Fixes: CVE-2017-13673
Fixes: fec5e8c92becad223df9d972770522f64aafdb72
Cc: P J P <ppandit@redhat.com>
Reported-by: David Buchanan <d@vidbuchanan.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170828123307.15392-1-kraxel@redhat.com
---
 hw/display/vga.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 3433102ef3..ad7a46563c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1628,9 +1628,15 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     y1 = 0;
 
     if (!full_update) {
+        ram_addr_t region_start = addr1;
+        ram_addr_t region_end = addr1 + line_offset * height;
         vga_sync_dirty_bitmap(s);
-        snap = memory_region_snapshot_and_clear_dirty(&s->vram, addr1,
-                                                      line_offset * height,
+        if (s->line_compare < height) {
+            /* split screen mode */
+            region_start = 0;
+        }
+        snap = memory_region_snapshot_and_clear_dirty(&s->vram, region_start,
+                                                      region_end - region_start,
                                                       DIRTY_MEMORY_VGA);
     }
 
-- 
2.9.3
