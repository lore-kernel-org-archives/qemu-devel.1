Received: from eggs.gnu.org ([2001:4830:134:3::10]:48979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOthe-0004aA-Lm
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOthb-0008De-Dy
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:06:38 -0500
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:53215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cOthb-0008Da-4g
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:06:35 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed,  4 Jan 2017 23:06:24 +0100
Message-Id: <20170104220624.26557-1-jcd@tribudubois.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4] [i.MX] fix CS handling during SPI access.
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

Whith this path the CS signal is correctly asserted and deasserted arround
memory access.

Assertion level is now based on SPI device configuration.

This was tested by:
* booting linux on Sabrelite Qemu emulator.
* booting xvisor on Sabrelite Qemu emultor.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
---

Changes since v1:
* Fix coding style issue.

Changes since v2:
* get SS line polarity from config reg.

Changes since v3:
* Fix imx_spi_channel_pol() after review

 hw/ssi/imx_spi.c         | 42 ++++++++++++++++++++++++++++++------------
 include/hw/ssi/imx_spi.h |  2 ++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index e4e395f..e57cb9a 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -141,6 +141,18 @@ static bool imx_spi_channel_is_master(IMXSPIState *s)
     return (mode & (1 << imx_spi_selected_channel(s))) ? true : false;
 }
 
+static uint8_t imx_spi_channel_pol(IMXSPIState *s, uint8_t channel)
+{
+    uint8_t pol = EXTRACT(s->regs[ECSPI_CONFIGREG], ECSPI_CONFIGREG_SS_POL);
+
+    return pol & (1 << channel) ? 1 : 0;
+}
+
+static uint8_t imx_spi_current_channel_pol(IMXSPIState *s)
+{
+    return imx_spi_channel_pol(s, imx_spi_selected_channel(s));
+}
+
 static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
 {
     uint8_t wave = EXTRACT(s->regs[ECSPI_CONFIGREG], ECSPI_CONFIGREG_SS_CTL);
@@ -152,13 +164,16 @@ static bool imx_spi_is_multiple_master_burst(IMXSPIState *s)
 
 static void imx_spi_flush_txfifo(IMXSPIState *s)
 {
-    uint32_t tx;
-    uint32_t rx;
-
     DPRINTF("Begin: TX Fifo Size = %d, RX Fifo Size = %d\n",
             fifo32_num_used(&s->tx_fifo), fifo32_num_used(&s->rx_fifo));
 
+    /* Activate the requested CS line */
+    qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
+                 imx_spi_current_channel_pol(s));
+
     while (!fifo32_is_empty(&s->tx_fifo)) {
+        uint32_t tx;
+        uint32_t rx = 0;
         int tx_burst = 0;
         int index = 0;
 
@@ -178,8 +193,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 
         tx_burst = MIN(s->burst_length, 32);
 
-        rx = 0;
-
         while (tx_burst) {
             uint8_t byte = tx & 0xff;
 
@@ -221,6 +234,12 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
     }
 
+    /* Deselect all SS lines if transfert if completed */
+    if (s->regs[ECSPI_STATREG] & ECSPI_STATREG_TC) {
+        qemu_set_irq(s->cs_lines[imx_spi_selected_channel(s)],
+                     !imx_spi_current_channel_pol(s));
+    }
+
     /* TODO: We should also use TDR and RDR bits */
 
     DPRINTF("End: TX Fifo Size = %d, RX Fifo Size = %d\n",
@@ -230,6 +249,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 static void imx_spi_reset(DeviceState *dev)
 {
     IMXSPIState *s = IMX_SPI(dev);
+    uint32_t i;
 
     DPRINTF("\n");
 
@@ -243,6 +263,11 @@ static void imx_spi_reset(DeviceState *dev)
     imx_spi_update_irq(s);
 
     s->burst_length = 0;
+
+    /* Disable all CS lines */
+    for (i = 0; i < 4; i++) {
+        qemu_set_irq(s->cs_lines[i], !imx_spi_channel_pol(s, i));
+    }
 }
 
 static uint64_t imx_spi_read(void *opaque, hwaddr offset, unsigned size)
@@ -359,15 +384,8 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
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
diff --git a/include/hw/ssi/imx_spi.h b/include/hw/ssi/imx_spi.h
index 7103953..b9b9819 100644
--- a/include/hw/ssi/imx_spi.h
+++ b/include/hw/ssi/imx_spi.h
@@ -46,6 +46,8 @@
 /* ECSPI_CONFIGREG */
 #define ECSPI_CONFIGREG_SS_CTL_SHIFT 8
 #define ECSPI_CONFIGREG_SS_CTL_LENGTH 4
+#define ECSPI_CONFIGREG_SS_POL_SHIFT 12
+#define ECSPI_CONFIGREG_SS_POL_LENGTH 4
 
 /* ECSPI_INTREG */
 #define ECSPI_INTREG_TEEN (1 << 0)
-- 
2.9.3
