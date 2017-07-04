Received: from eggs.gnu.org ([2001:4830:134:3::10]:41821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZY-0004LT-HO
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZT-0003AQ-Jx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZT-00039w-BC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DF438553F
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:26 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:43 +0800
Message-Id: <20170704064347.7022-17-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 16/20] xilinx_axienet: Convert to
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
 hw/net/xilinx_axienet.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index b670184..e92762b 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -341,8 +341,10 @@ struct XilinxAXIEnet {
     SysBusDevice busdev;
     MemoryRegion iomem;
     qemu_irq irq;
-    StreamSlave *tx_data_dev;
-    StreamSlave *tx_control_dev;
+    /* StreamSlave pointers for data and control tx devices, to be filled by
+     * link property. */
+    Object *tx_data_dev;
+    Object *tx_control_dev;
     XilinxAXIEnetStreamSlave rx_data_dev;
     XilinxAXIEnetStreamSlave rx_control_dev;
     NICState *nic;
@@ -688,17 +690,18 @@ static void axienet_eth_rx_notify(void *opaque)
 {
     XilinxAXIEnet *s = XILINX_AXI_ENET(opaque);
 
-    while (s->rxappsize && stream_can_push(s->tx_control_dev,
+    while (s->rxappsize && stream_can_push(STREAM_SLAVE(s->tx_control_dev),
                                            axienet_eth_rx_notify, s)) {
-        size_t ret = stream_push(s->tx_control_dev,
+        size_t ret = stream_push(STREAM_SLAVE(s->tx_control_dev),
                                  (void *)s->rxapp + CONTROL_PAYLOAD_SIZE
                                  - s->rxappsize, s->rxappsize);
         s->rxappsize -= ret;
     }
 
-    while (s->rxsize && stream_can_push(s->tx_data_dev,
+    while (s->rxsize && stream_can_push(STREAM_SLAVE(s->tx_data_dev),
                                         axienet_eth_rx_notify, s)) {
-        size_t ret = stream_push(s->tx_data_dev, (void *)s->rxmem + s->rxpos,
+        size_t ret = stream_push(STREAM_SLAVE(s->tx_data_dev),
+                                 (void *)s->rxmem + s->rxpos,
                                  s->rxsize);
         s->rxsize -= ret;
         s->rxpos += ret;
@@ -991,18 +994,6 @@ static void xilinx_enet_init(Object *obj)
     XilinxAXIEnet *s = XILINX_AXI_ENET(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
-                             (Object **) &s->tx_data_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-    object_property_add_link(obj, "axistream-control-connected",
-                             TYPE_STREAM_SLAVE,
-                             (Object **) &s->tx_control_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
                       TYPE_XILINX_AXI_ENET_DATA_STREAM);
     object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
@@ -1023,6 +1014,10 @@ static Property xilinx_enet_properties[] = {
     DEFINE_PROP_UINT32("rxmem", XilinxAXIEnet, c_rxmem, 0x1000),
     DEFINE_PROP_UINT32("txmem", XilinxAXIEnet, c_txmem, 0x1000),
     DEFINE_NIC_PROPERTIES(XilinxAXIEnet, conf),
+    DEFINE_PROP_LINK("axistream-connected", XilinxAXIEnet,
+                     tx_data_dev, TYPE_STREAM_SLAVE),
+    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIEnet,
+                     tx_control_dev, TYPE_STREAM_SLAVE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
