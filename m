Received: from eggs.gnu.org ([2001:4830:134:3::10]:39888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR2-0002mR-MG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR1-0001d7-HR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeR1-0001XB-8N
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-00037G-4o
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:15 +0100
Message-Id: <20180426104715.21702-20-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/19] xilinx_spips: Correct SNOOP_NONE state
 when flushing the txfifo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

SNOOP_NONE state handle is moved above in the if ladder, as it's same
as SNOOP_STRIPPING during data cycles.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 1524119244-1240-1-git-send-email-saipava@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 426f971311..03f5faee4b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -616,7 +616,8 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         if (fifo8_is_empty(&s->tx_fifo)) {
             xilinx_spips_update_ixr(s);
             return;
-        } else if (s->snoop_state == SNOOP_STRIPING) {
+        } else if (s->snoop_state == SNOOP_STRIPING ||
+                   s->snoop_state == SNOOP_NONE) {
             for (i = 0; i < num_effective_busses(s); ++i) {
                 tx_rx[i] = fifo8_pop(&s->tx_fifo);
             }
-- 
2.17.0
