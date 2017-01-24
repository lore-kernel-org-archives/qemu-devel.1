Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cVxsC-0005UM-RK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cVxs9-0006cA-4f
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:58:44 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cVxs8-0006c5-Vu
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:58:41 -0500
Received: by mail-io0-x243.google.com with SMTP id c80so17982663iod.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:58:40 -0800 (PST)
Message-ID: <5887254f.863a240a.2c122.5500@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 24 Jan 2017 01:58:34 -0800
Subject: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liqiang6-s@360.cn

From: Li Qiang <liqiang6-s@360.cn>

When doing bitblt copy in backward mode, we should minus the
blt width first just like the adding in the forward mode. This
can avoid the oob access of the front of vga's vram.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/display/cirrus_vga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 379910d..fa56730 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -277,7 +277,8 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
     }
     if (pitch < 0) {
         int64_t min = addr
-            + ((int64_t)s->cirrus_blt_height-1) * pitch;
+            + ((int64_t)s->cirrus_blt_height - 1) * pitch
+            - s->cirrus_blt_width;
         int32_t max = addr
             + s->cirrus_blt_width;
         if (min < 0 || max > s->vga.vram_size) {
-- 
1.8.3.1
