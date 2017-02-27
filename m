Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfj-0002QC-Du
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfh-0001wn-2f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfg-0001ss-R5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfS-0002K0-Te
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:34 +0000
Message-Id: <1488218699-31035-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/30] sd: sdhci: conditionally invoke multi
 block transfer
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

In sdhci_write invoke multi block transfer if it is enabled
in the transfer mode register 's->trnmod'.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20170214185225.7994-4-ppandit@redhat.com
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5adeab6..c270e09 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1023,7 +1023,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Writing to last byte of sdmasysad might trigger transfer */
         if (!(mask & 0xFF000000) && TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
                 s->blksize && SDHC_DMA_TYPE(s->hostctl) == SDHC_CTRL_SDMA) {
-            sdhci_sdma_transfer_multi_blocks(s);
+            if (s->trnmod & SDHC_TRNS_MULTI) {
+                sdhci_sdma_transfer_multi_blocks(s);
+            } else {
+                sdhci_sdma_transfer_single_block(s);
+            }
         }
         break;
     case SDHC_BLKSIZE:
-- 
2.7.4
