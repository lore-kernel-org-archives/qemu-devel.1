Received: from eggs.gnu.org ([2001:4830:134:3::10]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkH-00049H-9w
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkF-0003j4-OQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coRkF-0003im-IQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:55 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 10:30:36 +0100
Message-Id: <1489656642-12925-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/7] fix :cirrus_vga fix OOB read case
 qemu Segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: hangaohuai <hangaohuai@huawei.com>, fangying <fangying1@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>

From: hangaohuai <hangaohuai@huawei.com>

check the validity of parameters in cirrus_bitblt_rop_fwd_transp_xxx
and cirrus_bitblt_rop_fwd_xxx to avoid the OOB read which causes qemu Segmentation fault.

After the fix, we will touch the assert in
cirrus_invalidate_region:
assert(off_cur_end >= off_cur);

Signed-off-by: fangying <fangying1@huawei.com>
Signed-off-by: hangaohuai <hangaohuai@huawei.com>
Message-id: 20170314063919.16200-1-hangaohuai@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga_rop.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
index 0925a00..b7447f8 100644
--- a/hw/display/cirrus_vga_rop.h
+++ b/hw/display/cirrus_vga_rop.h
@@ -97,6 +97,11 @@ glue(glue(cirrus_bitblt_rop_fwd_transp_, ROP_NAME),_8)(CirrusVGAState *s,
     uint8_t p;
     dstpitch -= bltwidth;
     srcpitch -= bltwidth;
+
+    if (bltheight > 1 && (dstpitch < 0 || srcpitch < 0)) {
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
+    if (bltheight > 1 && (dstpitch < 0 || srcpitch < 0)) {
+        return;
+    }
+
     for (y = 0; y < bltheight; y++) {
         for (x = 0; x < bltwidth; x+=2) {
 	    p1 = *dst;
-- 
1.8.3.1
