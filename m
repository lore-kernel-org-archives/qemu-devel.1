Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZY-0004LX-Hf
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZV-0003Aw-QX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZV-0003Ak-IU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8425F8E771
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:28 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:44 +0800
Message-Id: <20170704064347.7022-18-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/20] xilinx_axidma: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/dma/xilinx_axidma.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6065689..df293d3 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -124,8 +124,11 @@ struct XilinxAXIDMA {
     SysBusDevice busdev;
     MemoryRegion iomem;
     uint32_t freqhz;
-    StreamSlave *tx_data_dev;
-    StreamSlave *tx_control_dev;
+
+    /* StreamSlave pointers to be fille by link property */
+    Object *tx_data_dev;
+    Object *tx_control_dev;
+
     XilinxAXIDMAStreamSlave rx_data_dev;
     XilinxAXIDMAStreamSlave rx_control_dev;
 
@@ -491,7 +494,8 @@ static void axidma_write(void *opaque, hwaddr addr,
             s->regs[addr] = value;
             s->regs[R_DMASR] &= ~DMASR_IDLE; /* Not idle.  */
             if (!sid) {
-                stream_process_mem2s(s, d->tx_data_dev, d->tx_control_dev);
+                stream_process_mem2s(s, STREAM_SLAVE(d->tx_data_dev),
+                                     STREAM_SLAVE(d->tx_control_dev));
             }
             break;
         default:
@@ -564,18 +568,6 @@ static void xilinx_axidma_init(Object *obj)
     XilinxAXIDMA *s = XILINX_AXI_DMA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
-                             (Object **)&s->tx_data_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-    object_property_add_link(obj, "axistream-control-connected",
-                             TYPE_STREAM_SLAVE,
-                             (Object **)&s->tx_control_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
                       TYPE_XILINX_AXI_DMA_DATA_STREAM);
     object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
@@ -595,6 +587,10 @@ static void xilinx_axidma_init(Object *obj)
 
 static Property axidma_properties[] = {
     DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
+    DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
+                     tx_data_dev, TYPE_STREAM_SLAVE),
+    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
+                     tx_control_dev, TYPE_STREAM_SLAVE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
