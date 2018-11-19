Received: from eggs.gnu.org ([2001:4830:134:3::10]:52706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mY-1w
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMN-0002wb-Bx
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:13 +0800
Message-Id: <20181119120820.29878-16-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 15/22] pci-bridge/dec: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, david@gibson.dropbear.id.au, mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-ppc@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
pci_dec_21154_device_class_init().

Cc: david@gibson.dropbear.id.au
Cc: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com
Cc: qemu-ppc@nongnu.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/pci-bridge/dec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 84492d5e5f..5b21c20e50 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -98,7 +98,7 @@ PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devfn)
     return pci_bridge_get_sec_bus(br);
 }
 
-static int pci_dec_21154_device_init(SysBusDevice *dev)
+static void pci_dec_21154_device_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb;
 
@@ -108,9 +108,8 @@ static int pci_dec_21154_device_init(SysBusDevice *dev)
                           dev, "pci-conf-idx", 0x1000);
     memory_region_init_io(&phb->data_mem, OBJECT(dev), &pci_host_data_le_ops,
                           dev, "pci-data-idx", 0x1000);
-    sysbus_init_mmio(dev, &phb->conf_mem);
-    sysbus_init_mmio(dev, &phb->data_mem);
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->conf_mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->data_mem);
 }
 
 static void dec_21154_pci_host_realize(PCIDevice *d, Error **errp)
@@ -150,9 +149,9 @@ static const TypeInfo dec_21154_pci_host_info = {
 
 static void pci_dec_21154_device_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = pci_dec_21154_device_init;
+    dc->realize = pci_dec_21154_device_realize;
 }
 
 static const TypeInfo pci_dec_21154_device_info = {
-- 
2.17.1
