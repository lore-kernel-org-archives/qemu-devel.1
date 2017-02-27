Received: from eggs.gnu.org ([2001:4830:134:3::10]:52233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfk-0002RX-DI
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfh-0001x4-Bj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfh-0001qs-2E
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfS-0002Jd-FP
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:33 +0000
Message-Id: <1488218699-31035-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/30] sd: sdhci: check transfer mode register
 in multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

In the SDHCI protocol, the transfer mode register value
is used during multi block transfer to check if block count
register is enabled and should be updated. Transfer mode
register could be set such that, block count register would
not be updated, thus leading to an infinite loop. Add check
to avoid it.

Reported-by: Wjjzhang <wjjzhang@tencent.com>
Reported-by: Jiang Xin <jiangxin1@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20170214185225.7994-3-ppandit@redhat.com
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a65c77d..5adeab6 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -487,6 +487,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     uint32_t boundary_chk = 1 << (((s->blksize & 0xf000) >> 12) + 12);
     uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
 
+    if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
+        qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
+        return;
+    }
+
     /* XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly */
@@ -798,11 +803,6 @@ static void sdhci_data_transfer(void *opaque)
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
-- 
2.7.4
