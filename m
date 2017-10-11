Received: from eggs.gnu.org ([2001:4830:134:3::10]:51904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1e29Lf-0005f7-7o
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1e29Lc-0005LD-26
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:14:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1e29Lb-0005Kp-RX
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 01:14:23 -0400
From: P J P <ppandit@redhat.com>
Date: Wed, 11 Oct 2017 10:44:14 +0530
Message-Id: <20171011051414.2826-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] cirrus: keep vga vram pointer within bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, niuguoxiang@huawei.com, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

'dst' pointer could exceed vga vram size when writing to the
cirrus memory area; it'd lead to an OOB access issue. Add check
to avoid it.

Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/display/cirrus_vga.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Update: fixed coding style error, add space around '<<' operator.

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index afc290ab91..9f1f856679 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2047,8 +2047,11 @@ static void cirrus_mem_writeb_mode4and5_8bpp(CirrusVGAState * s,
 	}
 	val <<= 1;
 	dst++;
+        if (dst >= s->vga.vram_ptr + s->vga.vram_size) {
+            break;
+        }
     }
-    memory_region_set_dirty(&s->vga.vram, offset, 8);
+    memory_region_set_dirty(&s->vga.vram, offset, x);
 }
 
 static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
@@ -2071,8 +2074,11 @@ static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
 	}
 	val <<= 1;
 	dst += 2;
+        if (dst >= s->vga.vram_ptr + s->vga.vram_size) {
+            break;
+        }
     }
-    memory_region_set_dirty(&s->vga.vram, offset, 16);
+    memory_region_set_dirty(&s->vga.vram, offset, x << 1);
 }
 
 /***************************************
-- 
2.13.6
