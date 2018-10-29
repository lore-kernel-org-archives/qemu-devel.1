Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMz-0000n3-Tj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMu-0008AK-9L
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:12971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAMt-0007zZ-LV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:26:20 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 17:24:38 +0100
Message-Id: <20181029162441.31631-17-sameo@linux.intel.com>
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 16/19] hw: acpi: Retrieve the PCI bus from
 AcpiPciHpState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Instead of using the machine type specific method find_i440fx() to
retrieve the PCI bus, this commit aims to rely on the fact that the
PCI bus is known by the structure AcpiPciHpState.

When the structure is initialized through acpi_pcihp_init() call,
it saves the PCI bus, which means there is no need to invoke a
special function later on.

Based on the fact that find_i440fx() was only used there, this
patch also removes the function find_i440fx() itself from the
entire codebase.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/acpi/pcihp.c       | 10 ++++------
 hw/pci-host/piix.c    |  8 --------
 include/hw/i386/pc.h  |  1 -
 stubs/Makefile.objs   |  1 -
 stubs/pci-host-piix.c |  6 ------
 5 files changed, 4 insertions(+), 22 deletions(-)
 delete mode 100644 stubs/pci-host-piix.c

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 80d42e12ff..254b2e50ab 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -93,10 +93,9 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return bsel_alloc;
 }
 
-static void acpi_set_pci_info(void)
+static void acpi_set_pci_info(AcpiPciHpState *s)
 {
     static bool bsel_is_set;
-    PCIBus *bus;
     unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
 
     if (bsel_is_set) {
@@ -104,10 +103,9 @@ static void acpi_set_pci_info(void)
     }
     bsel_is_set = true;
 
-    bus = find_i440fx(); /* TODO: Q35 support */
-    if (bus) {
+    if (s->root) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
-        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
+        pci_for_each_bus_depth_first(s->root, acpi_set_bsel, NULL, &bsel_alloc);
     }
 }
 
@@ -213,7 +211,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
 
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
-    acpi_set_pci_info();
+    acpi_set_pci_info(s);
     acpi_pcihp_update(s);
 }
 
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index da73743fa2..4940f59c9b 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -445,14 +445,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     return b;
 }
 
-PCIBus *find_i440fx(void)
-{
-    PCIHostState *s = OBJECT_CHECK(PCIHostState,
-                                   object_resolve_path("/machine/i440fx", NULL),
-                                   TYPE_PCI_HOST_BRIDGE);
-    return s ? s->bus : NULL;
-}
-
 /* PIIX3 PCI to ISA bridge */
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7d177cd207..f6b2649cf8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -260,7 +260,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     MemoryRegion *pci_memory,
                     MemoryRegion *ram_memory);
 
-PCIBus *find_i440fx(void);
 /* piix4.c */
 extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec6..725f78bedc 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -41,6 +41,5 @@ stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
-stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
deleted file mode 100644
index 6ed81b1f21..0000000000
--- a/stubs/pci-host-piix.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "qemu/osdep.h"
-#include "hw/i386/pc.h"
-PCIBus *find_i440fx(void)
-{
-    return NULL;
-}
-- 
2.17.2
