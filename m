Received: from eggs.gnu.org ([2001:4830:134:3::10]:36637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPS-0005MZ-CR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSPR-0000eo-FI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSPR-000747-6p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO7-0007JI-AW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:55 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:25 +0000
Message-Id: <20181213145445.17935-18-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/37] pci-bridge/dec: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
pci_dec_21154_device_class_init().

Cc: david@gibson.dropbear.id.au
Cc: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com
Cc: qemu-ppc@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 20181130093852.20739-16-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-bridge/dec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 84492d5e5f9..8484bfd4345 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -98,9 +98,10 @@ PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devfn)
     return pci_bridge_get_sec_bus(br);
 }
 
-static int pci_dec_21154_device_init(SysBusDevice *dev)
+static void pci_dec_21154_device_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     phb = PCI_HOST_BRIDGE(dev);
 
@@ -108,9 +109,8 @@ static int pci_dec_21154_device_init(SysBusDevice *dev)
                           dev, "pci-conf-idx", 0x1000);
     memory_region_init_io(&phb->data_mem, OBJECT(dev), &pci_host_data_le_ops,
                           dev, "pci-data-idx", 0x1000);
-    sysbus_init_mmio(dev, &phb->conf_mem);
-    sysbus_init_mmio(dev, &phb->data_mem);
-    return 0;
+    sysbus_init_mmio(sbd, &phb->conf_mem);
+    sysbus_init_mmio(sbd, &phb->data_mem);
 }
 
 static void dec_21154_pci_host_realize(PCIDevice *d, Error **errp)
@@ -150,9 +150,9 @@ static const TypeInfo dec_21154_pci_host_info = {
 
 static void pci_dec_21154_device_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = pci_dec_21154_device_init;
+    dc->realize = pci_dec_21154_device_realize;
 }
 
 static const TypeInfo pci_dec_21154_device_info = {
-- 
2.19.2
