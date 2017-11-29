Received: from eggs.gnu.org ([2001:4830:134:3::10]:58873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJy0v-00022g-75
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJy0u-0005iD-5t
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:41 -0500
Received: from ozlabs.org ([103.22.144.67]:35463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eJy0t-0005db-P6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 29 Nov 2017 19:46:28 +1100
Message-Id: <20171129084628.12336-8-david@gibson.dropbear.id.au>
In-Reply-To: <20171129084628.12336-1-david@gibson.dropbear.id.au>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [for-2.12 7/7] pci: Eliminate pci_find_primary_bus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

pci_find_primary_bus() only has one user, in pc_xen_hvm_init().  That's
inside the machine construction code, so it already has easy access to the
machine's primary PCI bus.

Get it directly, and thereby remove pci_find_primary_bus().  This removes
one of only a handful of users of the ugly pci_host_bridges global.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc_piix.c    |  8 ++------
 hw/pci/pci.c         | 16 ----------------
 include/hw/pci/pci.h |  1 -
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528993..2febd0e136 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -394,7 +394,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
 
 static void pc_xen_hvm_init(MachineState *machine)
 {
-    PCIBus *bus;
+    PCMachineState *pcms = PC_MACHINE(machine);
 
     if (!xen_enabled()) {
         error_report("xenfv machine requires the xen accelerator");
@@ -402,11 +402,7 @@ static void pc_xen_hvm_init(MachineState *machine)
     }
 
     pc_xen_hvm_init_pci(machine);
-
-    bus = pci_find_primary_bus();
-    if (bus != NULL) {
-        pci_create_simple(bus, -1, "xen-platform");
-    }
+    pci_create_simple(pcms->bus, -1, "xen-platform");
 }
 #endif
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cd4d9d7ecd..ab76c4f3f1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -324,22 +324,6 @@ static void pci_host_bus_register(DeviceState *host)
     QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
 }
 
-PCIBus *pci_find_primary_bus(void)
-{
-    PCIBus *primary_bus = NULL;
-    PCIHostState *host;
-
-    QLIST_FOREACH(host, &pci_host_bridges, next) {
-        if (primary_bus) {
-            /* We have multiple root buses, refuse to select a primary */
-            return NULL;
-        }
-        primary_bus = host->bus;
-    }
-
-    return primary_bus;
-}
-
 PCIBus *pci_device_root_bus(const PCIDevice *d)
 {
     PCIBus *bus = pci_get_bus(d);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 50034157fd..867b1ee175 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -519,7 +519,6 @@ void pci_for_each_bus(PCIBus *bus,
     pci_for_each_bus_depth_first(bus, NULL, fn, opaque);
 }
 
-PCIBus *pci_find_primary_bus(void);
 PCIBus *pci_device_root_bus(const PCIDevice *d);
 const char *pci_root_bus_path(PCIDevice *dev);
 PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
-- 
2.14.3
