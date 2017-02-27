Received: from eggs.gnu.org ([2001:4830:134:3::10]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfj-0002QR-HW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfg-0001wV-NL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfg-0001lG-Dm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfT-0002KN-DF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:35 +0000
Message-Id: <1488218699-31035-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/30] sd: sdhci: Remove block count enable
 check in single block transfers
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

In SDHCI protocol, the 'Block count enable' bit of the Transfer
Mode register is relevant only in multi block transfers. We need
not check it in single block transfers.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20170214185225.7994-5-ppandit@redhat.com
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c270e09..6d6a791 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -570,7 +570,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 }
 
 /* single block SDMA transfer */
-
 static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 {
     int n;
@@ -589,10 +588,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
             sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
         }
     }
-
-    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-        s->blkcnt--;
-    }
+    s->blkcnt--;
 
     sdhci_end_transfer(s);
 }
-- 
2.7.4
