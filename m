Received: from eggs.gnu.org ([2001:4830:134:3::10]:51870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-000241-0v
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-0007E6-1d
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHD-00079F-Qx
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH5-0008UW-Nw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:31 +0100
Message-Id: <20180626165658.31394-6-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/32] xilinx_spips: Make dma transactions as
 per dma_burst_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Sai Pavan Boddu <saipava@xilinx.com>

Qspi dma has a burst length of 64 bytes, So limit the transactions w.r.t
dma-burst-size property.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1529660880-30376-1-git-send-email-sai.pavan.boddu@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/xilinx_spips.h |  5 ++++-
 hw/ssi/xilinx_spips.c         | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index d398a4e81c3..a0a0ae7584a 100644
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
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f599025956d..c052bfc4b3c 100644
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
-- 
2.17.1
