Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGy-0006EC-2P
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGx-0001Vl-5Y
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:12 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:44606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e9nGw-0001VC-Uz
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:11 -0400
Received: by mail-lf0-x243.google.com with SMTP id 75so1491676lfx.1
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 00:17:10 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed,  1 Nov 2017 08:16:49 +0100
Message-Id: <20171101071652.19375-11-frasse.iglesias@gmail.com>
In-Reply-To: <20171101071652.19375-1-frasse.iglesias@gmail.com>
References: <20171101071652.19375-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v6 10/13] xilinx_spips: Add support for 4 byte
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
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Add support for 4 byte addresses in the LQSPI and correct LQSPI_CFG_SEP_BUS.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 3a98799..7f0f317 100644
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
2.9.3
