Received: from eggs.gnu.org ([2001:4830:134:3::10]:41233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cO9du-000444-Te
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cO9dq-0008HM-UM
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:55:42 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cO9dq-0008Gs-Mz
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:55:38 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon,  2 Jan 2017 21:55:21 +0100
Message-Id: <20170102205521.4101-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] [i.MX] fix CS handling during SPI access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mar.krzeminski@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

The i.MX SPI device was not de-asserting the CS line at the end of
memory access.

This triggered a SIGSEGV in Qemu when the sabrelite emulator was acessing
a SPI flash memory.

Whit this path the CS signal is correctly asserted and deasserted arround
memory access.

This was tested by:
* booting linux on Sabrelite Qemu emulator.
* booting xvisor on Sabrelite Qemu emultor.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/ssi/imx_spi.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index e4e395f..c2d293c 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -152,13 +152,20 @@ static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
 
 static void imx_spi_flush_txfifo(IMXSPIState *s)
 {
-    uint32_t tx;
-    uint32_t rx;
+    uint32_t i;
 
     DPRINTF("Begin: TX Fifo Size = %d, RX Fifo Size = %d\n",
             fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
 
+    /* Activate the requested CS line */
+    for (i = 0; i < 4; i++) {
+        qemu_set_irq(s->cs_lines[i],
+                     i == imx_spi_selected_channel(s) ? 0 : 1);
+    }
+
     while (!fifo32_is_empty(&s->tx_fifo)) {
+        uint32_t tx;
+        uint32_t rx = 0;
         int tx_burst = 0;
         int index = 0;
 
@@ -178,8 +185,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 
         tx_burst = MIN(s->burst_length, 32);
 
-        rx = 0;
-
         while (tx_burst) {
             uint8_t byte = tx & 0xff;
 
@@ -221,6 +226,13 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
     }
 
+    /* Deselect all SS lines if transfert if completed */
+    if (s->regs[ECSPI_STATREG] & ECSPI_STATREG_TC) {
+        for (i = 0; i < 4; i++) {
+            qemu_set_irq(s->cs_lines[i], 1);
+        }
+    }
+
     /* TODO: We should also use TDR and RDR bits */
 
     DPRINTF("End: TX Fifo Size = %d, RX Fifo Size = %d\n",
@@ -230,6 +242,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 static void imx_spi_reset(DeviceState *dev)
 {
     IMXSPIState *s = IMX_SPI(dev);
+    uint32_t i;
 
     DPRINTF("\n");
 
@@ -243,6 +256,11 @@ static void imx_spi_reset(DeviceState *dev)
     imx_spi_update_irq(s);
 
     s->burst_length = 0;
+
+    /* Disable all CS lines */
+    for (i = 0; i < 4; i++) {
+       qemu_set_irq(s->cs_lines[i], 1);
+    }
 }
 
 static uint64_t imx_spi_read(void *opaque, hwaddr offset, unsigned size)
@@ -359,15 +377,8 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         if (imx_spi_channel_is_master(s)) {
-            int i;
-
             /* We are in master mode */
 
-            for (i = 0; i < 4; i++) {
-                qemu_set_irq(s->cs_lines[i],
-                             i == imx_spi_selected_channel(s) ? 0 : 1);
-            }
-
             if ((value & change_mask & ECSPI_CONREG_SMC) &&
                 !fifo32_is_empty(&s->tx_fifo)) {
                 /* SMC bit is set and TX FIFO has some slots filled in */
-- 
2.9.3
