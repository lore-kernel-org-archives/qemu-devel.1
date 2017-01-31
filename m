Received: from eggs.gnu.org ([2001:4830:134:3::10]:46942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU5-000676-AE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cYXU2-00058K-HU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cYXU2-000587-BJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:24:26 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 31 Jan 2017 17:54:15 +0530
Message-Id: <20170131122416.10284-2-ppandit@redhat.com>
In-Reply-To: <20170131122416.10284-1-ppandit@redhat.com>
References: <20170131122416.10284-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] sd: sdhci: check transfer mode register in
 multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

In SDHCI device emulation the transfer mode register value
is used during multi block transfer to check if block count
register is enabled and should be updated. Transfer mode
register could be set such that, block count register would
not be updated, thus leading to an infinite loop. Add check
to avoid it.

Reported-by: Wjjzhang <wjjzhang@tencent.com>
Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sd/sdhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5bd5ab6..150464f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -486,6 +486,12 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
     uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
 
+    if (!(s->trnmod & SDHC_TRNS_MULTI)
+        || !(s->trnmod & SDHC_TRNS_BLK_CNT_EN)
+        || !s->blkcnt) {
+        return;
+    }
+
     /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly */
@@ -797,11 +803,6 @@ static void sdhci_data_transfer(void *opaque)
     if (s->trnmod & SDHC_TRNS_DMA) {
         switch (SDHC_DMA_TYPE(s->hostctl)) {
         case SDHC_CTRL_SDMA:
-            if ((s->trnmod & SDHC_TRNS_MULTI) &&
-                    (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || s->blkcnt == 0)) {
-                break;
-            }
-
             if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
                 sdhci_sdma_transfer_single_block(s);
             } else {
@@ -1050,7 +1051,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!(s->capareg & SDHC_CAN_DO_DMA)) {
             value &= ~SDHC_TRNS_DMA;
         }
-        MASKED_WRITE(s->trnmod, mask, value);
+        MASKED_WRITE(s->trnmod, mask, value & 0x0037);
         MASKED_WRITE(s->cmdreg, mask >> 16, value >> 16);
 
         /* Writing to the upper byte of CMDREG triggers SD command generation */
-- 
2.9.3
