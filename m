Received: from eggs.gnu.org ([2001:4830:134:3::10]:56381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36N-0001LS-0H
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36L-0005P2-VC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35138
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36L-0005OY-OG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:49 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:25 +0100
Message-Id: <1499810007-28613-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 6/8] apb: add busA qdev property to PBM PCI
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

As future sun4u PCI topologies place the ebus containing the in-built devices
behind a PCI bridge, add a busA property to the PBM PCI bridge that is then
used to allow IO accesses by default.

This allows early fw_cfg/NVRAM/serial access to occur even before OpenBIOS
has had a chance to configure the PCI bridges.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 5ad7678..f9badad 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -153,6 +153,18 @@ typedef struct APBState {
     unsigned int nr_resets;
 } APBState;
 
+#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
+#define PBM_PCI_BRIDGE(obj) \
+    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
+
+typedef struct PBMPCIBridge {
+    /*< private >*/
+    PCIBridge parent_obj;
+
+    /* Is this busA with in-built devices (ebus)? */
+    bool busA;
+} PBMPCIBridge;
+
 static inline void pbm_set_request(APBState *s, unsigned int irq_num)
 {
     APB_DPRINTF("%s: request irq %d\n", __func__, irq_num);
@@ -634,8 +646,6 @@ static void pci_apb_set_irq(void *opaque, int irq_num, int level)
 
 static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
 {
-    pci_bridge_initfn(dev, TYPE_PCI_BUS);
-
     /*
      * command register:
      * According to PCI bridge spec, after reset
@@ -645,11 +655,23 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
      *   the reset value should be zero unless the boot pin is tied high
      *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
      */
-    pci_set_word(dev->config + PCI_COMMAND,
-                 PCI_COMMAND_MEMORY);
+    uint16_t cmd = PCI_COMMAND_MEMORY;
+    PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
+
+    pci_bridge_initfn(dev, TYPE_PCI_BUS);
+
+    /* If initialising busA, ensure that we allow IO transactions so that
+       we get the early serial console until OpenBIOS configures the bridge */
+    if (br->busA) {
+        cmd |= PCI_COMMAND_IO;
+    }
+
+    pci_set_word(dev->config + PCI_COMMAND, cmd);
     pci_set_word(dev->config + PCI_STATUS,
                  PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
                  PCI_STATUS_DEVSEL_MEDIUM);
+
+    pci_bridge_update_mappings(PCI_BRIDGE(br));
 }
 
 PCIBus *pci_apb_init(hwaddr special_base,
@@ -702,16 +724,17 @@ PCIBus *pci_apb_init(hwaddr special_base,
 
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
-                                   "pbm-bridge");
+                                   TYPE_PBM_PCI_BRIDGE);
     br = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(br, "pciB", pci_apb_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
     *busB = pci_bridge_get_sec_bus(br);
 
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
-                                   "pbm-bridge");
+                                   TYPE_PBM_PCI_BRIDGE);
     br = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(br, "pciA", pci_apb_map_irq);
+    qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
     qdev_init_nofail(&pci_dev->qdev);
     *busA = pci_bridge_get_sec_bus(br);
 
@@ -833,6 +856,11 @@ static const TypeInfo pbm_host_info = {
     .class_init    = pbm_host_class_init,
 };
 
+static Property pbm_pci_properties[] = {
+    DEFINE_PROP_BOOL("busA", PBMPCIBridge, busA, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -848,12 +876,14 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = pci_bridge_reset;
     dc->vmsd = &vmstate_pci_device;
+    dc->props = pbm_pci_properties;
 }
 
 static const TypeInfo pbm_pci_bridge_info = {
-    .name          = "pbm-bridge",
+    .name          = TYPE_PBM_PCI_BRIDGE,
     .parent        = TYPE_PCI_BRIDGE,
     .class_init    = pbm_pci_bridge_class_init,
+    .instance_size = sizeof(PBMPCIBridge),
 };
 
 static void pbm_register_types(void)
-- 
1.7.10.4
