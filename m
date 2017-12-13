Received: from eggs.gnu.org ([2001:4830:134:3::10]:51458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWW-0004dv-Jl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWV-0007gx-HO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWV-0007cv-9K
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWU-0007dB-1L
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:09 +0000
Message-Id: <1513188761-20784-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/43] xilinx_spips: Don't set TX FIFO UNDERFLOW
 at cmd done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Don't set TX FIFO UNDERFLOW interrupt after transmitting the commands.
Also update interrupts after reading out the interrupt status.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-12-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index ab54da8..3805d8b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -329,9 +329,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
-            if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
-                s->regs[R_INTR_STATUS] |= IXR_TX_FIFO_UNDERFLOW;
-            }
             xilinx_spips_update_ixr(s);
             return;
         } else if (s->snoop_state == SNOOP_STRIPING) {
@@ -530,6 +527,7 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
         ret = s->regs[addr] & IXR_ALL;
         s->regs[addr] = 0;
         DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
+        xilinx_spips_update_ixr(s);
         return ret;
     case R_INTR_MASK:
         mask = IXR_ALL;
-- 
2.7.4
