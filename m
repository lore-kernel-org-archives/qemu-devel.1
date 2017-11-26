Received: from eggs.gnu.org ([2001:4830:134:3::10]:57012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xz-0007CO-0j
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xy-00030H-28
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:59 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:11 -0600
Message-Id: <15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 13/17] e500: move PCI host bridge into CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      | 13 ++++---------
 hw/ppc/e500_ccsr.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index cfd5ed0152..b0c8495aef 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -769,6 +769,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
     qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
     qdev_prop_set_uint32(dev, "ram-size", ram_size);
+    qdev_prop_set_uint32(dev, "pci_first_slot", params->pci_first_slot);
+    qdev_prop_set_uint32(dev, "pci_first_pin_irq", pci_irq_nrs[0]);
     qdev_init_nofail(dev);
     ccsr_addr_space = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
 
@@ -778,20 +780,13 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
 
 
     /* PCI */
-    dev = qdev_create(NULL, "e500-pcihost");
-    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev),
-                              &error_abort);
-    qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
-    qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
-    qdev_init_nofail(dev);
+    dev = DEVICE(object_resolve_path("/machine/pci-host", 0));
+    assert(dev);
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i]));
     }
 
-    memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
-                                sysbus_mmio_get_region(s, 0));
-
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pci_bus)
         printf("couldn't create PCI controller!\n");
diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index cd8216daaf..4ec8f7524d 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -50,6 +50,8 @@
 
 #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
 
+#define E500_PCI_OFFSET  (0x8000ULL)
+
 #define E500_PORPLLSR    (0xE0000)
 #define E500_PVR         (0xE00A0)
 #define E500_SVR         (0xE00A4)
@@ -75,6 +77,7 @@ typedef struct {
 
     DeviceState *pic;
     DeviceState *i2c;
+    DeviceState *pcihost;
 } CCSRState;
 
 #define TYPE_E500_CCSR "e500-ccsr"
@@ -201,6 +204,7 @@ static void e500_ccsr_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     CCSRState *ccsr = E500_CCSR(dev);
 
+    /* prepare MPIC */
     assert(current_machine);
     if (kvm_enabled()) {
 
@@ -228,6 +232,18 @@ static void e500_ccsr_init(Object *obj)
     object_property_add_alias(obj, "mpic-model",
                               OBJECT(ccsr->pic), "model",
                               &error_fatal);
+
+    /* prepare PCI host bridge */
+    ccsr->pcihost = qdev_create(NULL, "e500-pcihost");
+    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(ccsr->pcihost),
+                              &error_abort);
+
+    object_property_add_alias(obj, "pci_first_slot",
+                              OBJECT(ccsr->pcihost), "first_slot",
+                              &error_fatal);
+    object_property_add_alias(obj, "pci_first_pin_irq",
+                              OBJECT(ccsr->pcihost), "first_pin_irq",
+                              &error_fatal);
 }
 
 static void e500_ccsr_realize(DeviceState *dev, Error **errp)
@@ -240,6 +256,7 @@ static void e500_ccsr_realize(DeviceState *dev, Error **errp)
                           ccsr, "e500-ccsr", 1024 * 1024);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &ccsr->iomem);
 
+    /* realize MPIC */
     qdev_init_nofail(ccsr->pic);
     pic = SYS_BUS_DEVICE(ccsr->pic);
 
@@ -275,6 +292,13 @@ static void e500_ccsr_realize(DeviceState *dev, Error **errp)
                                 sysbus_mmio_get_region(pic, 0));
     /* Note: MPIC internal interrupts are offset by 16 */
 
+    /* realize PCI host bridge*/
+    qdev_init_nofail(ccsr->pcihost);
+
+    memory_region_add_subregion(&ccsr->iomem, E500_PCI_OFFSET,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(ccsr->pcihost), 0));
+
     /* attach I2C controller */
     ccsr->i2c = qdev_create(NULL, "mpc8540-i2c");
     object_property_add_child(qdev_get_machine(), "i2c[*]",
@@ -314,6 +338,9 @@ static Property e500_ccsr_props[] = {
     DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
     DEFINE_PROP_UINT32("ccb-freq", CCSRState, ccb_freq, 333333333u),
     /* "mpic-model" aliased from MPIC */
+    /* "pci_first_slot"
+     * "pci_first_pin_irq" aliased from PCI host bridge
+     */
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.11.0
