Received: from eggs.gnu.org ([2001:4830:134:3::10]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cnPlH-00022O-PA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cnPlD-0003AO-PQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:11:43 -0400
Received: from [45.249.212.187] (port=2998 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cnPlD-00032T-1Q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:11:39 -0400
From: hangaohuai <hangaohuai@huawei.com>
Date: Mon, 13 Mar 2017 21:10:29 +0800
Message-ID: <20170313131029.14044-1-hangaohuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] fix :cirrus_vga fix OOB read case qemu
 Segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, arei.gonglei@huawei.com, hangaohuai@huawei.com, fangying1@huawei.com

check the validity of parameters in cirrus_bitblt_rop_fwd_transp_xxx
and cirrus_bitblt_rop_fwd_xxx to avoid the OOB read which causes qemu Segmentation fault.

After the fix, we will touch the assert in
cirrus_invalidate_region:
assert(off_cur_end >= off_cur);

Signed-off-by: fangying <fangying1@huawei.com>
Signed-off-by: hangaohuai <hangaohuai@huawei.com>
---
 hw/display/cirrus_vga_rop.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
index 0925a00..12a15e0 100644
--- a/hw/display/cirrus_vga_rop.h
+++ b/hw/display/cirrus_vga_rop.h
@@ -97,6 +97,11 @@ glue(glue(cirrus_bitblt_rop_fwd_transp_, ROP_NAME),_8)(CirrusVGAState *s,
     uint8_t p;
     dstpitch -= bltwidth;
     srcpitch -= bltwidth;
+
+    if (dstpitch < 0 || srcpitch < 0) {
+        return;
+    }
+
     for (y = 0; y < bltheight; y++) {
         for (x = 0; x < bltwidth; x++) {
 	    p = *dst;
@@ -143,6 +148,11 @@ glue(glue(cirrus_bitblt_rop_fwd_transp_, ROP_NAME),_16)(CirrusVGAState *s,
     uint8_t p1, p2;
     dstpitch -= bltwidth;
     srcpitch -= bltwidth;
+
+    if (srcpitch < 0 || dstpitch < 0) {
+        return;
+    }
+
     for (y = 0; y < bltheight; y++) {
         for (x = 0; x < bltwidth; x+=2) {
 	    p1 = *dst;
-- 
1.8.3.1
