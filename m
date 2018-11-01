Received: from eggs.gnu.org ([2001:4830:134:3::10]:59792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAX-0005jb-C9
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAW-0003xT-93
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:61548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIAAV-0003Hf-Vs
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:40 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:23:01 +0100
Message-Id: <20181101102303.16439-22-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 21/23] hw: pci-host: piix: Return PCI host
 pointer instead of PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

For building the MCFG table, we need to track a given machine
type PCI host pointer, and we can't get it from the bus pointer alone.
As piix returns a PCI bus pointer, we simply modify its builder to
return a PCI host pointer instead.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/pc_piix.c    | 18 +++++++++++-------
 hw/pci-host/piix.c   | 24 ++++++++++++------------
 include/hw/i386/pc.h | 21 +++++++++++----------
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0620d10715..f5b139a3eb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -32,6 +32,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/smbios/smbios.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
@@ -75,6 +76,7 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     int i;
+    struct PCIHostState *pci_host;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     PCII440FXState *i440fx_state;
@@ -196,15 +198,17 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcmc->pci_enabled) {
-        pci_bus = i440fx_init(host_type,
-                              pci_type,
-                              &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
-                              system_memory, system_io, machine->ram_size,
-                              acpi_conf->below_4g_mem_size,
-                              acpi_conf->above_4g_mem_size,
-                              pci_memory, ram_memory);
+        pci_host = i440fx_init(host_type,
+                               pci_type,
+                               &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
+                               system_memory, system_io, machine->ram_size,
+                               acpi_conf->below_4g_mem_size,
+                               acpi_conf->above_4g_mem_size,
+                               pci_memory, ram_memory);
+        pci_bus = pci_host->bus;
         pcms->bus = pci_bus;
     } else {
+        pci_host = NULL;
         pci_bus = NULL;
         i440fx_state = NULL;
         isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 658460264b..4a412db44c 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -342,17 +342,17 @@ static void i440fx_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-                    PCII440FXState **pi440fx_state,
-                    int *piix3_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_address_space,
-                    MemoryRegion *ram_memory)
+struct PCIHostState *i440fx_init(const char *host_type, const char *pci_type,
+                                 PCII440FXState **pi440fx_state,
+                                 int *piix3_devfn,
+                                 ISABus **isa_bus, qemu_irq *pic,
+                                 MemoryRegion *address_space_mem,
+                                 MemoryRegion *address_space_io,
+                                 ram_addr_t ram_size,
+                                 ram_addr_t below_4g_mem_size,
+                                 ram_addr_t above_4g_mem_size,
+                                 MemoryRegion *pci_address_space,
+                                 MemoryRegion *ram_memory)
 {
     DeviceState *dev;
     PCIBus *b;
@@ -442,7 +442,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
 
     i440fx_update_memory_mappings(f);
 
-    return b;
+    return s;
 }
 
 /* PIIX3 PCI to ISA bridge */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4d5d8d0340..b9d9eafd0c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -244,16 +244,17 @@ typedef struct PCII440FXState PCII440FXState;
  */
 #define RCR_IOPORT 0xcf9
 
-PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-                    PCII440FXState **pi440fx_state, int *piix_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_memory,
-                    MemoryRegion *ram_memory);
+struct PCIHostState *i440fx_init(const char *host_type, const char *pci_type,
+                                 PCII440FXState **pi440fx_state,
+                                 int *piix_devfn,
+                                 ISABus **isa_bus, qemu_irq *pic,
+                                 MemoryRegion *address_space_mem,
+                                 MemoryRegion *address_space_io,
+                                 ram_addr_t ram_size,
+                                 ram_addr_t below_4g_mem_size,
+                                 ram_addr_t above_4g_mem_size,
+                                 MemoryRegion *pci_memory,
+                                 MemoryRegion *ram_memory);
 
 /* piix4.c */
 extern PCIDevice *piix4_dev;
-- 
2.19.1
