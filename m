Received: from eggs.gnu.org ([2001:4830:134:3::10]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Src-0003lb-EK
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 18:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Sbb-0003be-D0
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:53:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:53:15 +0200
Message-Id: <20181002215315.16851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/pci-host/ppce500: Use DeviceState::realize
 rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, "open list:ppce500" <qemu-ppc@nongnu.org>

Move from the legacy SysBusDevice::init method to using DeviceState::realize.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/ppce500.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index eb75e080fc..b8f8c112e6 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -436,8 +436,9 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *bus, void *opaque,
     return &s->bm_as;
 }
 
-static int e500_pcihost_initfn(SysBusDevice *dev)
+static void e500_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     PCIHostState *h;
     PPCE500PCIState *s;
     PCIBus *b;
@@ -447,7 +448,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     s = PPC_E500_PCI_HOST_BRIDGE(dev);
 
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->irq[i]);
     }
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
@@ -460,7 +461,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     /* PIO lives at the bottom of our bus space */
     memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
 
-    b = pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
+    b = pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
                               mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
                               PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
     h->bus = b;
@@ -483,10 +484,8 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     memory_region_add_subregion(&s->container, PCIE500_CFGADDR, &h->conf_mem);
     memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->data_mem);
     memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->iomem);
-    sysbus_init_mmio(dev, &s->container);
+    sysbus_init_mmio(sbd, &s->container);
     pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
-
-    return 0;
 }
 
 static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
@@ -526,9 +525,8 @@ static Property pcihost_properties[] = {
 static void e500_pcihost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = e500_pcihost_initfn;
+    dc->realize = e500_pcihost_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->props = pcihost_properties;
     dc->vmsd = &vmstate_ppce500_pci;
-- 
2.19.0
