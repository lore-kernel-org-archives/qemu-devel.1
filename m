Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWV-0004ck-G8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWU-0007ej-H9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWU-0007cv-Aj
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWT-0007cq-BO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:08 +0000
Message-Id: <1513188761-20784-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/43] xilinx_spips: Add support for 4 byte
 addresses in the LQSPI
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

Add support for 4 byte addresses in the LQSPI and correct LQSPI_CFG_SEP_BUS.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-11-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 878b17e..ab54da8 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -92,8 +92,9 @@
 #define R_LQSPI_CFG_RESET       0x03A002EB
 #define LQSPI_CFG_LQ_MODE       (1U << 31)
 #define LQSPI_CFG_TWO_MEM       (1 << 30)
-#define LQSPI_CFG_SEP_BUS       (1 << 30)
+#define LQSPI_CFG_SEP_BUS       (1 << 29)
 #define LQSPI_CFG_U_PAGE        (1 << 28)
+#define LQSPI_CFG_ADDR4         (1 << 27)
 #define LQSPI_CFG_MODE_EN       (1 << 25)
 #define LQSPI_CFG_MODE_WIDTH    8
 #define LQSPI_CFG_MODE_SHIFT    16
@@ -702,6 +703,9 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
         fifo8_push(&s->tx_fifo, s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE);
         /* read address */
         DB_PRINT_L(0, "pushing read address %06x\n", flash_addr);
+        if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_ADDR4) {
+            fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 24));
+        }
         fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 16));
         fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 8));
         fifo8_push(&s->tx_fifo, (uint8_t)flash_addr);
-- 
2.7.4
