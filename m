Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaO-0002jM-Jy
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaN-0001Pm-RH
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaN-0001PR-L3
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaM-0003xR-Qr
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:13 +0000
Message-Id: <1482852077-19397-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/25] aspeed/smc: improve segment register
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The HW does not enforce all the rules in the specs and allows a few
"curious" setups like zero size segments and overlaps. So change the
model to be in sync but keep the warnings which are always interesting
for debug.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 1480434248-27138-13-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 6e8403e..78f5aed 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -253,7 +253,8 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Tried to change CS0 start address to 0x%"
                       HWADDR_PRIx "\n", s->ctrl->name, seg.addr);
-        return;
+        seg.addr = s->ctrl->flash_window_base;
+        new = aspeed_smc_segment_to_reg(&seg);
     }
 
     /*
@@ -267,8 +268,10 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
         s->ctrl->segments[cs].size) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Tried to change CS%d end address to 0x%"
-                      HWADDR_PRIx "\n", s->ctrl->name, cs, seg.addr);
-        return;
+                      HWADDR_PRIx "\n", s->ctrl->name, cs, seg.addr + seg.size);
+        seg.size = s->ctrl->segments[cs].addr + s->ctrl->segments[cs].size -
+            seg.addr;
+        new = aspeed_smc_segment_to_reg(&seg);
     }
 
     /* Keep the segment in the overall flash window */
@@ -281,16 +284,14 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
     }
 
     /* Check start address vs. alignment */
-    if (seg.addr % seg.size) {
+    if (seg.size && !QEMU_IS_ALIGNED(seg.addr, seg.size)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: new segment for CS%d is not "
                       "aligned : [ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
                       s->ctrl->name, cs, seg.addr, seg.addr + seg.size);
     }
 
-    /* And segments should not overlap */
-    if (aspeed_smc_flash_overlap(s, &seg, cs)) {
-        return;
-    }
+    /* And segments should not overlap (in the specs) */
+    aspeed_smc_flash_overlap(s, &seg, cs);
 
     /* All should be fine now to move the region */
     memory_region_transaction_begin();
-- 
2.7.4
