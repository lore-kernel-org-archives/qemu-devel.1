Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fWIgP-00080Y-9N
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fWIgK-0008NM-Bm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:48:45 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com
	([104.47.40.57]:64960
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1fWIgJ-0008Mu-V6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:48:40 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Fri, 22 Jun 2018 15:17:58 +0530
Message-ID: <1529660880-30376-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4] xilinx_spips: Make dma transactions as per
 dma_burst_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <saipava@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Sai Pavan Boddu <saipava@xilinx.com>

Qspi dma has a burst length of 64 bytes, So limit the transactions w.r.t
dma-burst-size property.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
Changes for V2:
   Remove dynamic allocation of dma_buf and limit burst size to 2k 
Changes for V3:
   Instead of proceeding with max burst size, report user the error.
Changes for V4:
   move dma_buf to the bottom of XlnxZynqMPQSPIPS

 hw/ssi/xilinx_spips.c         | 23 ++++++++++++++++++++---
 include/hw/ssi/xilinx_spips.h |  5 ++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 03f5fae..d6ca36e 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -851,12 +851,17 @@ static void xlnx_zynqmp_qspips_notify(void *opaque)
     {
         size_t ret;
         uint32_t num;
-        const void *rxd = pop_buf(recv_fifo, 4, &num);
+        const void *rxd;
+        int len;
+
+        len = recv_fifo->num >= rq->dma_burst_size ? rq->dma_burst_size :
+                                                   recv_fifo->num;
+        rxd = pop_buf(recv_fifo, len, &num);
 
         memcpy(rq->dma_buf, rxd, num);
 
-        ret = stream_push(rq->dma, rq->dma_buf, 4);
-        assert(ret == 4);
+        ret = stream_push(rq->dma, rq->dma_buf, num);
+        assert(ret == num);
         xlnx_zynqmp_qspips_check_flush(rq);
     }
 }
@@ -1333,6 +1338,12 @@ static void xlnx_zynqmp_qspips_realize(DeviceState *dev, Error **errp)
     XlnxZynqMPQSPIPS *s = XLNX_ZYNQMP_QSPIPS(dev);
     XilinxSPIPSClass *xsc = XILINX_SPIPS_GET_CLASS(s);
 
+    if (s->dma_burst_size > QSPI_DMA_MAX_BURST_SIZE) {
+        error_setg(errp,
+                   "qspi dma burst size %u exceeds maximum limit %d",
+                   s->dma_burst_size, QSPI_DMA_MAX_BURST_SIZE);
+        return;
+    }
     xilinx_qspips_realize(dev, errp);
     fifo8_create(&s->rx_fifo_g, xsc->rx_fifo_size);
     fifo8_create(&s->tx_fifo_g, xsc->tx_fifo_size);
@@ -1411,6 +1422,11 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
     }
 };
 
+static Property xilinx_zynqmp_qspips_properties[] = {
+    DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS, dma_burst_size, 64),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static Property xilinx_qspips_properties[] = {
     /* We had to turn this off for 2.10 as it is not compatible with migration.
      * It can be enabled but will prevent the device to be migrated.
@@ -1463,6 +1479,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
     dc->realize = xlnx_zynqmp_qspips_realize;
     dc->reset = xlnx_zynqmp_qspips_reset;
     dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
+    dc->props = xilinx_zynqmp_qspips_properties;
     xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index d398a4e..a0a0ae7 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -37,6 +37,8 @@ typedef struct XilinxSPIPS XilinxSPIPS;
 /* Bite off 4k chunks at a time */
 #define LQSPI_CACHE_SIZE 1024
 
+#define QSPI_DMA_MAX_BURST_SIZE 2048
+
 typedef enum {
     READ = 0x3,         READ_4 = 0x13,
     FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
@@ -95,7 +97,6 @@ typedef struct {
     XilinxQSPIPS parent_obj;
 
     StreamSlave *dma;
-    uint8_t dma_buf[4];
     int gqspi_irqline;
 
     uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
@@ -113,6 +114,8 @@ typedef struct {
     uint8_t rx_fifo_g_align;
     uint8_t tx_fifo_g_align;
     bool man_start_com_g;
+    uint32_t dma_burst_size;
+    uint8_t dma_buf[QSPI_DMA_MAX_BURST_SIZE];
 } XlnxZynqMPQSPIPS;
 
 typedef struct XilinxSPIPSClass {
-- 
2.7.4
