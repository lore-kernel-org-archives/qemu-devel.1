Received: from eggs.gnu.org ([2001:4830:134:3::10]:44562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIC-0007wX-AU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIB-0005F6-B9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:28 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIB-0005Ec-0F
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:27 -0400
Received: by mail-pl0-x241.google.com with SMTP id f23-v6so9824183plr.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:26 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:33:59 +1000
Message-Id: <4d4ea2e1b6632474660bf4e46126984256b8db3f.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 14/30] pc/q35: Apply PCI bus BSEL property
 for Xen PCI device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Q35 we still need to assign BSEL property to bus(es) for PCI device
add/hotplug to work.
Extend acpi_set_pci_info() function to support Q35 as well. Previously
it was limited to find_i440fx() call, this patch adds new (trivial)
function find_q35() which returns root PCIBus object on Q35, in a way
similar to what find_i440fx does.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/acpi/pcihp.c      | 6 +++++-
 hw/pci-host/q35.c    | 8 ++++++++
 include/hw/i386/pc.h | 3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 91c82fdc7a..f70d8620d7 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -105,7 +105,11 @@ static void acpi_set_pci_info(void)
     }
     bsel_is_set = true;
 
-    bus = find_i440fx(); /* TODO: Q35 support */
+    bus = find_i440fx();
+    if (!bus) {
+        bus = find_q35();
+    }
+
     if (bus) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
         pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a36a1195e4..8c1603fce9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -258,6 +258,14 @@ static void q35_host_initfn(Object *obj)
             IO_APIC_DEFAULT_ADDRESS - 1);
 }
 
+PCIBus *find_q35(void)
+{
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/q35", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    return s ? s->bus : NULL;
+}
+
 static const TypeInfo q35_host_info = {
     .name       = TYPE_Q35_HOST_DEVICE,
     .parent     = TYPE_PCIE_HOST_BRIDGE,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0..96d74b35bd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,6 +302,9 @@ PCIBus *find_i440fx(void);
 extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
 
+/* q35.c */
+PCIBus *find_q35(void);
+
 /* pc_sysfw.c */
 void pc_system_firmware_init(MemoryRegion *rom_memory,
                              bool isapc_ram_fw);
-- 
2.11.0
