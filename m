Received: from eggs.gnu.org ([2001:4830:134:3::10]:40782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2BE1-0004a9-Mu
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2BDx-0000Y1-HT
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2BDx-0000Xn-BT
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:14:37 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Oct 2017 09:14:23 +0200
Message-Id: <20171011071423.20179-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] cirrus: fix oob access in mode4and5 write
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: niuguoxiang@huawei.com, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

Move dst calculation into the loop, so we apply the mask on each
interation and will not overflow vga memory.

Cc: Prasad J Pandit <pjp@fedoraproject.org>
Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index afc290ab91..cf096df90f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2038,15 +2038,14 @@ static void cirrus_mem_writeb_mode4and5_8bpp(CirrusVGAState * s,
     unsigned val = mem_value;
     uint8_t *dst;
 
-    dst = s->vga.vram_ptr + (offset &= s->cirrus_addr_mask);
     for (x = 0; x < 8; x++) {
+	dst = s->vga.vram_ptr + ((offset+x) & s->cirrus_addr_mask);
 	if (val & 0x80) {
 	    *dst = s->cirrus_shadow_gr1;
 	} else if (mode == 5) {
 	    *dst = s->cirrus_shadow_gr0;
 	}
 	val <<= 1;
-	dst++;
     }
     memory_region_set_dirty(&s->vga.vram, offset, 8);
 }
@@ -2060,8 +2059,8 @@ static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
     unsigned val = mem_value;
     uint8_t *dst;
 
-    dst = s->vga.vram_ptr + (offset &= s->cirrus_addr_mask);
     for (x = 0; x < 8; x++) {
+	dst = s->vga.vram_ptr + ((offset + 2 * x) & s->cirrus_addr_mask & ~1);
 	if (val & 0x80) {
 	    *dst = s->cirrus_shadow_gr1;
 	    *(dst + 1) = s->vga.gr[0x11];
@@ -2070,7 +2069,6 @@ static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
 	    *(dst + 1) = s->vga.gr[0x10];
 	}
 	val <<= 1;
-	dst += 2;
     }
     memory_region_set_dirty(&s->vga.vram, offset, 16);
 }
-- 
2.9.3
