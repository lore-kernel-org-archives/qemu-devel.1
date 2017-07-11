Received: from eggs.gnu.org ([2001:4830:134:3::10]:54256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV2xf-0006HW-Ee
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV2xc-00007A-D6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35089
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV2xc-00006Q-5m
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:44:33 +0100
Message-Id: <1499809473-28481-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 2/2] pci: add reserved slot check to
 do_pci_register_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

Add a new slot_reserved_mask bitmask to PCIBus indicating whether or not each
PCI slot on the bus is reserved. Ensure that it is initialised to zero to
maintain the existing behaviour that all slots are available by default, and
add the additional check with appropriate error reporting to
do_pci_register_device().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci.c             |   22 +++++++++++++++++++---
 include/hw/pci/pci_bus.h |    1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 04e6edb..3ce25f7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -371,6 +371,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
 {
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
+    bus->slot_reserved_mask = 0x0;
     bus->address_space_mem = address_space_mem;
     bus->address_space_io = address_space_io;
 
@@ -960,6 +961,15 @@ static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
     }
 }
 
+static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
+{
+    if (bus->slot_reserved_mask & (1UL << PCI_SLOT(devfn))) {
+        return true;
+    } else {
+        return false;
+    }
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -983,14 +993,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (devfn < 0) {
         for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
             devfn += PCI_FUNC_MAX) {
-            if (pci_bus_devfn_available(bus, devfn)) {
+            if (pci_bus_devfn_available(bus, devfn) &&
+                   !pci_bus_devfn_reserved(bus, devfn)) {
                 goto found;
             }
         }
-        error_setg(errp, "PCI: no slot/function available for %s, all in use",
-                   name);
+        error_setg(errp, "PCI: no slot/function available for %s, all in use "
+                   "or reserved", name);
         return NULL;
     found: ;
+    } else if (pci_bus_devfn_reserved(bus, devfn)) {
+        error_setg(errp, "PCI: slot %d function %d not available for %s,"
+                   " reserved",
+                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
+        return NULL;
     } else if (!pci_bus_devfn_available(bus, devfn)) {
         error_setg(errp, "PCI: slot %d function %d not available for %s,"
                    " in use by %s",
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 5484a9b..bc34fd0 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -23,6 +23,7 @@ struct PCIBus {
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
+    uint32_t slot_reserved_mask;
     pci_set_irq_fn set_irq;
     pci_map_irq_fn map_irq;
     pci_route_irq_fn route_intx_to_irq;
-- 
1.7.10.4
