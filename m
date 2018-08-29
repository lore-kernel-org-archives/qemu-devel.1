Received: from eggs.gnu.org ([2001:4830:134:3::10]:52142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wg-0004K1-UJ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oV-0004JW-TF
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:08 +0100
Message-Id: <20180829165911.30106-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/7] grackle: set device fw_name and address
 for correct fw path generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/grackle.c | 17 +++++++++++++++++
 hw/ppc/mac_oldworld.c |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 4810a4de79..5a151e93e9 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -37,6 +37,7 @@
 typedef struct GrackleState {
     PCIHostState parent_obj;
 
+    uint32_t ofw_addr;
     HeathrowState *pic;
     qemu_irq irqs[4];
     MemoryRegion pci_mmio;
@@ -146,12 +147,28 @@ static const TypeInfo grackle_pci_info = {
     },
 };
 
+static char *grackle_ofw_unit_address(const SysBusDevice *dev)
+{
+    GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
+
+    return g_strdup_printf("%x", s->ofw_addr);
+}
+
+static Property grackle_properties[] = {
+    DEFINE_PROP_UINT32("ofw-addr", GrackleState, ofw_addr, -1),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void grackle_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = grackle_realize;
+    dc->props = grackle_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+    sbc->explicit_ofw_unit_address = grackle_ofw_unit_address;
 }
 
 static const TypeInfo grackle_host_info = {
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 80b5525775..c7b73e274f 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -254,6 +254,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     /* Grackle PCI host bridge */
     dev = qdev_create(NULL, TYPE_GRACKLE_PCI_HOST_BRIDGE);
+    qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
     object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                              &error_abort);
     qdev_init_nofail(dev);
-- 
2.11.0
