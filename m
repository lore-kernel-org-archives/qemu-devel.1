Received: from eggs.gnu.org ([2001:4830:134:3::10]:44711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co7he-0006HR-UM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co7hb-00047X-Q4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:06:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1co7hb-00047R-J6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:06:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A5C064F4
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 12:06:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 15 Mar 2017 13:06:46 +0100
Message-Id: <1489579606-26020-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] cirrus: fix cirrus_invalidate_region
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

off_cur_end is exclusive, so off_cur_end == cirrus_addr_mask is valid.
Fix calculation to make sure to allow that, otherwise the assert added
by commit f153b563f8cf121aebf5a2fff5f0110faf58ccb3 can trigger for valid
blits.

Test case: boot windows nt 4.0

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b9e7cb1..cdbe9a6 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -666,11 +666,11 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     }
 
     for (y = 0; y < lines; y++) {
-	off_cur = off_begin;
-	off_cur_end = (off_cur + bytesperline) & s->cirrus_addr_mask;
+        off_cur = off_begin;
+        off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
         assert(off_cur_end >= off_cur);
         memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
-	off_begin += off_pitch;
+        off_begin += off_pitch;
     }
 }
 
-- 
1.8.3.1
