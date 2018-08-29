Received: from eggs.gnu.org ([2001:4830:134:3::10]:52534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wg-0005Ig-94
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oX-0004KN-I4
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:10 +0100
Message-Id: <20180829165911.30106-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 6/7] uninorth: add ofw-addr property to allow
 correct fw path generation
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
 hw/pci-host/uninorth.c         | 16 ++++++++++++++++
 hw/ppc/mac_newworld.c          |  1 +
 include/hw/pci-host/uninorth.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index a843aa7b36..1378c5c7fb 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -118,6 +118,13 @@ static void pci_unin_init_irqs(UNINHostState *s)
     }
 }
 
+static char *pci_unin_main_ofw_unit_address(const SysBusDevice *dev)
+{
+    UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
+
+    return g_strdup_printf("%x", s->ofw_addr);
+}
+
 static void pci_unin_main_realize(DeviceState *dev, Error **errp)
 {
     UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
@@ -455,12 +462,21 @@ static const TypeInfo unin_internal_pci_host_info = {
     },
 };
 
+static Property pci_unin_main_pci_host_props[] = {
+    DEFINE_PROP_UINT32("ofw-addr", UNINHostState, ofw_addr, -1),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_main_realize;
+    dc->props = pci_unin_main_pci_host_props;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+    sbc->explicit_ofw_unit_address = pci_unin_main_ofw_unit_address;
 }
 
 static const TypeInfo pci_unin_main_info = {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a6b95f024c..325013f563 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -344,6 +344,7 @@ static void ppc_core99_init(MachineState *machine)
 
         /* Uninorth main bus */
         dev = qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
+        qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
         object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
                                  &error_abort);
         qdev_init_nofail(dev);
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index 2a1cf9f284..060324536a 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -49,6 +49,7 @@
 typedef struct UNINHostState {
     PCIHostState parent_obj;
 
+    uint32_t ofw_addr;
     OpenPICState *pic;
     qemu_irq irqs[4];
     MemoryRegion pci_mmio;
-- 
2.11.0
