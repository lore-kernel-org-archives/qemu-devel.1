Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75F2-0002vv-Sx
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75F1-0003aI-Rj
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:52:00 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:47341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e75F1-0003Yj-Kl
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:59 -0400
Received: by mail-lf0-x243.google.com with SMTP id k40so25316146lfi.4
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:51:59 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Tue, 24 Oct 2017 21:51:37 +0200
Message-Id: <20171024195139.28179-12-frasse.iglesias@gmail.com>
In-Reply-To: <20171024195139.28179-1-frasse.iglesias@gmail.com>
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 11/13] xilinx_spips: Don't set TX FIFO
 UNDERFLOW at cmd done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Don't set TX FIFO UNDERFLOW interrupt after done transmiting the commands.
Also update interrupts after reading out the interrupt status.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 5e5e8cc..ffed5ba 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -324,9 +324,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
-            if (!(s->regs[R_LQSPI_CFG] & LQSPI_CFG_LQ_MODE)) {
-                s->regs[R_INTR_STATUS] |= IXR_TX_FIFO_UNDERFLOW;
-            }
             xilinx_spips_update_ixr(s);
             return;
         } else if (s->snoop_state == SNOOP_STRIPING) {
@@ -525,6 +522,7 @@ static uint64_t xilinx_spips_read(void *opaque, hwaddr addr,
         ret = s->regs[addr] & IXR_ALL;
         s->regs[addr] = 0;
         DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr * 4, ret);
+        xilinx_spips_update_ixr(s);
         return ret;
     case R_INTR_MASK:
         mask = IXR_ALL;
-- 
2.9.3
