Received: from eggs.gnu.org ([2001:4830:134:3::10]:37725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHd-0003Ys-Bl
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHa-0004ia-Lb
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzJHa-0004aQ-3l
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Oct 2017 20:14:21 +1100
Message-Id: <20171003091423.28704-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171003091423.28704-1-david@gibson.dropbear.id.au>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 3/5] pci: Fold pci_bus.h into pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, ehabkost@redhat.com, marcel@redhat.com
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, David Gibson <david@gibson.dropbear.id.au>

include/hw/pci/pci_bus.h is now very small and can only safely be included
after hw/pci/pci.h.  So, just fold it into pci.h.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/acpi/pcihp.c                     |  1 -
 hw/i386/acpi-build.c                |  1 -
 hw/i386/amd_iommu.h                 |  1 -
 hw/i386/intel_iommu.c               |  1 -
 hw/i386/pc.c                        |  1 -
 hw/isa/lpc_ich9.c                   |  1 -
 hw/pci-bridge/dec.c                 |  1 -
 hw/pci-bridge/pci_bridge_dev.c      |  1 -
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 hw/pci-bridge/pcie_pci_bridge.c     |  1 -
 hw/pci-host/apb.c                   |  1 -
 hw/pci-host/prep.c                  |  1 -
 hw/pci-host/versatile.c             |  1 -
 hw/pci/pci.c                        |  1 -
 hw/pci/pci_bridge.c                 |  1 -
 hw/pci/pci_host.c                   |  1 -
 hw/pci/pcie.c                       |  1 -
 hw/pci/pcie_aer.c                   |  1 -
 hw/pci/shpc.c                       |  1 -
 hw/ppc/spapr_pci.c                  |  1 -
 hw/s390x/s390-pci-bus.c             |  1 -
 include/hw/i386/ich9.h              |  1 -
 include/hw/pci/pci.h                | 44 ++++++++++++++++++++++++++++++++--
 include/hw/pci/pci_bridge.h         |  1 -
 include/hw/pci/pci_bus.h            | 47 -------------------------------------
 include/hw/pci/pcie_port.h          |  1 -
 26 files changed, 42 insertions(+), 73 deletions(-)
 delete mode 100644 include/hw/pci/pci_bus.h

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7da51c0569..0da905ab3a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -34,7 +34,6 @@
 #include "sysemu/sysemu.h"
 #include "exec/ioport.h"
 #include "exec/address-spaces.h"
-#include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2af37a9129..6ad54e1e5b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -51,7 +51,6 @@
 #include "hw/acpi/piix4.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/i386/ich9.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/q35.h"
 #include "hw/i386/x86-iommu.h"
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index d370ae3549..b587f6b49f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -27,7 +27,6 @@
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
 #include "hw/i386/pc.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/i386/x86-iommu.h"
 
 /* Capability registers */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0bc2e..3ef4bfbe05 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -26,7 +26,6 @@
 #include "exec/address-spaces.h"
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/boards.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..5fd778a627 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,7 +31,6 @@
 #include "hw/block/fdc.h"
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/smbios/smbios.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 39f56ba44e..7b4ebbc0c7 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -44,7 +44,6 @@
 #include "hw/i386/ich9.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
-#include "hw/pci/pci_bus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "qom/cpu.h"
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 84492d5e5f..ae4b9697ed 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -29,7 +29,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 
 /* debug DEC */
 //#define DEBUG_DEC
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index d56f6638c2..bc3c8d9f57 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -27,7 +27,6 @@
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
 #include "exec/memory.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/hotplug.h"
 
 #define TYPE_PCI_BRIDGE_DEV      "pci-bridge"
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index b2fa829e29..5652cf06e9 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/i386/pc.h"
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 88db143633..85fd053fbd 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/shpc.h"
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 20c4be36ff..0e0c1ce0bc 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -32,7 +32,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/apb.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 01f67f9db1..56920914c6 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
 #include "hw/loader.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 8803ada925..b5bf4dce55 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 62601a5596..ffaa449ec1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,7 +25,6 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 17feae5ed8..63b0adac15 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -31,7 +31,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935cb5..3a26880f18 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "hw/pci/pci_bus.h"
 #include "trace.h"
 
 /* debug PCI */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 32191f2a55..28ba4a0a72 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -25,7 +25,6 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
 #include "qemu/range.h"
 
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 97200742b4..171955195f 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -27,7 +27,6 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
 #include "qapi/error.h"
 
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 69fc14b218..7d25e5dc78 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -5,7 +5,6 @@
 #include "qemu/error-report.h"
 #include "hw/pci/shpc.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/msi.h"
 
 /* TODO: model power only and disabled slot states. */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 58b9cfbafd..70d0ad56f4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -42,7 +42,6 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/ppc/spapr_drc.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e24ba781bd..69ac2d812d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -18,7 +18,6 @@
 #include "cpu.h"
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 673d13d28f..c613f85b11 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -12,7 +12,6 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
-#include "hw/pci/pci_bus.h"
 
 void ich9_lpc_set_irq(void *opaque, int irq_num, int level);
 int ich9_lpc_map_irq(PCIDevice *pci_dev, int intx);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 870ebcfd4b..77d92a3dc4 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -392,12 +392,54 @@ typedef void (*pci_set_irq_fn)(void *opaque, int irq_num, int level);
 typedef int (*pci_map_irq_fn)(PCIDevice *pci_dev, int irq_num);
 typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
+typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
+
+/*
+ * PCI Bus datastructures.
+ */
+
 #define TYPE_PCI_BUS "PCI"
 #define PCI_BUS(obj) OBJECT_CHECK(PCIBus, (obj), TYPE_PCI_BUS)
 #define PCI_BUS_CLASS(klass) OBJECT_CLASS_CHECK(PCIBusClass, (klass), TYPE_PCI_BUS)
 #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TYPE_PCI_BUS)
 #define TYPE_PCIE_BUS "PCIE"
 
+typedef struct PCIBusClass {
+    /*< private >*/
+    BusClass parent_class;
+    /*< public >*/
+
+    bool (*is_root)(PCIBus *bus);
+    int (*bus_num)(PCIBus *bus);
+    uint16_t (*numa_node)(PCIBus *bus);
+} PCIBusClass;
+
+struct PCIBus {
+    BusState qbus;
+    PCIIOMMUFunc iommu_fn;
+    void *iommu_opaque;
+    uint8_t devfn_min;
+    uint32_t slot_reserved_mask;
+    pci_set_irq_fn set_irq;
+    pci_map_irq_fn map_irq;
+    pci_route_irq_fn route_intx_to_irq;
+    void *irq_opaque;
+    PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
+    PCIDevice *parent_dev;
+    MemoryRegion *address_space_mem;
+    MemoryRegion *address_space_io;
+
+    QLIST_HEAD(, PCIBus) child; /* this will be replaced by qdev later */
+    QLIST_ENTRY(PCIBus) sibling;/* this will be replaced by qdev later */
+
+    /* The bus IRQ state is the logical OR of the connected devices.
+       Keep a count of the number of devices with raised IRQs.  */
+    int nirq;
+    int *irq_count;
+
+    Notifier machine_done;
+};
+
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
@@ -468,8 +510,6 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
-typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
-
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 9b44ffd22a..454bb09951 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -27,7 +27,6 @@
 #define QEMU_PCI_BRIDGE_H
 
 #include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
 
 typedef struct PCIBridgeWindows PCIBridgeWindows;
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
deleted file mode 100644
index b7da8f555b..0000000000
--- a/include/hw/pci/pci_bus.h
+++ /dev/null
@@ -1,47 +0,0 @@
-#ifndef QEMU_PCI_BUS_H
-#define QEMU_PCI_BUS_H
-
-/*
- * PCI Bus datastructures.
- *
- * Do not access the following members directly;
- * use accessor functions in pci.h
- */
-
-typedef struct PCIBusClass {
-    /*< private >*/
-    BusClass parent_class;
-    /*< public >*/
-
-    bool (*is_root)(PCIBus *bus);
-    int (*bus_num)(PCIBus *bus);
-    uint16_t (*numa_node)(PCIBus *bus);
-} PCIBusClass;
-
-struct PCIBus {
-    BusState qbus;
-    PCIIOMMUFunc iommu_fn;
-    void *iommu_opaque;
-    uint8_t devfn_min;
-    uint32_t slot_reserved_mask;
-    pci_set_irq_fn set_irq;
-    pci_map_irq_fn map_irq;
-    pci_route_irq_fn route_intx_to_irq;
-    void *irq_opaque;
-    PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
-    PCIDevice *parent_dev;
-    MemoryRegion *address_space_mem;
-    MemoryRegion *address_space_io;
-
-    QLIST_HEAD(, PCIBus) child; /* this will be replaced by qdev later */
-    QLIST_ENTRY(PCIBus) sibling;/* this will be replaced by qdev later */
-
-    /* The bus IRQ state is the logical OR of the connected devices.
-       Keep a count of the number of devices with raised IRQs.  */
-    int nirq;
-    int *irq_count;
-
-    Notifier machine_done;
-};
-
-#endif /* QEMU_PCI_BUS_H */
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 0736014bfd..bda76d79e0 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -22,7 +22,6 @@
 #define QEMU_PCIE_PORT_H
 
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci/pci_bus.h"
 
 #define TYPE_PCIE_PORT "pcie-port"
 #define PCIE_PORT(obj) OBJECT_CHECK(PCIEPort, (obj), TYPE_PCIE_PORT)
-- 
2.13.6
