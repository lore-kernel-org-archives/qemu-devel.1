Received: from eggs.gnu.org ([2001:4830:134:3::10]:50876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kf-0004j8-HJ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001V2-DM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001SU-7i
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA6B9C04BD4E
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 13:26:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 14:26:43 +0100
Message-Id: <20171110132644.8069-3-kraxel@redhat.com>
In-Reply-To: <20171110132644.8069-1-kraxel@redhat.com>
References: <20171110132644.8069-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] vga: fix region checks in wraparound case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20171030102830.4469-1-kraxel@redhat.com
---
 hw/display/vga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 1d19f6bc48..a64a0942da 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1666,9 +1666,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             /* scanline wraps from end of video memory to the start */
             assert(force_shadow);
             update = memory_region_snapshot_get_dirty(&s->vram, snap,
-                                                      page0, 0);
+                                                      page0, s->vbe_size - page0);
             update |= memory_region_snapshot_get_dirty(&s->vram, snap,
-                                                       page1, 0);
+                                                       0, page1);
         } else {
             update = memory_region_snapshot_get_dirty(&s->vram, snap,
                                                       page0, page1 - page0);
-- 
2.9.3
