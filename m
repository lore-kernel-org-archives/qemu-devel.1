Received: from eggs.gnu.org ([2001:4830:134:3::10]:36103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e4mKn-00065g-Dy
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e4mKk-0003vZ-4e
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1e4mKj-0003uu-S4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F096B883BA
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 11:16:20 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 18 Oct 2017 14:16:12 +0300
Message-Id: <20171018111612.112912-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2] hw/pci-host: Fix x86 Host Bridges 64bit PCI
 hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, lersek@redhat.com, imammedo@redhat.com

Currently there is no MMIO range over 4G
reserved for PCI hotplug. Since the 32bit PCI hole
depends on the number of cold-plugged PCI devices
and other factors, it is very possible is too small
to hotplug PCI devices with large BARs.

Fix it by reserving all the address space after
RAM (and the reserved space for RAM hotplug),
but no more than 40bits. The later seems to be
QEMU's magic number for the Guest physical CPU addressable
bits and is safe with respect to migration.

Note this is a regression since prev QEMU versions had
some range reserved for 64bit PCI hotplug.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

V1 -> V2:
 Addressed Igor's comments:
    - aligned the hole64 start to 1Gb
     (I think all the computations took care of it already,
      but it can't hurt)
    - Init compat props to "off" instead of "false"

Thanks,
Marcel

 hw/i386/pc.c              | 22 ++++++++++++++++++++++
 hw/pci-host/piix.c        | 10 ++++++++++
 hw/pci-host/q35.c         |  9 +++++++++
 include/hw/i386/pc.h      | 10 ++++++++++
 include/hw/pci-host/q35.h |  1 +
 5 files changed, 52 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..d11eeacead 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1448,6 +1448,28 @@ void pc_memory_init(PCMachineState *pcms,
     pcms->ioapic_as = &address_space_memory;
 }
 
+uint64_t pc_pci_hole64_start(void)
+{
+    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    uint64_t hole64_start = 0;
+
+    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
+        hole64_start = pcms->hotplug_memory.base;
+        if (!pcmc->broken_reserved_end) {
+            hole64_start += memory_region_size(&pcms->hotplug_memory.mr);
+        }
+    } else {
+        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
+    }
+
+    if (hole64_start > PCI_HOST_PCI_HOLE64_END) {
+        hole64_start = PCI_HOST_PCI_HOLE64_END;
+    }
+
+    return ROUND_UP(hole64_start, 1ULL << 30);
+}
+
 qemu_irq pc_allocate_cpu_irq(void)
 {
     return qemu_allocate_irq(pic_irq_request, NULL, 0);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index dec345fd24..317a232972 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -50,6 +50,7 @@ typedef struct I440FXState {
     PCIHostState parent_obj;
     Range pci_hole;
     uint64_t pci_hole64_size;
+    bool pci_hole64_fix;
     uint32_t short_root_bus;
 } I440FXState;
 
@@ -243,11 +244,15 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
                                                 void *opaque, Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
+    if (!value && s->pci_hole64_fix) {
+        value = pc_pci_hole64_start();
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -256,11 +261,15 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
                                               Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
+    if (s->pci_hole64_fix && value < PCI_HOST_PCI_HOLE64_END) {
+        value = PCI_HOST_PCI_HOLE64_END;
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -857,6 +866,7 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
                      pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
     DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
+    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1ff648e80c..641213f177 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -104,11 +104,15 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_lob(&w64);
+    if (!value && s->pci_hole64_fix) {
+        value = pc_pci_hole64_start();
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -117,11 +121,15 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
                                         Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
     Range w64;
     uint64_t value;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
+    if (s->pci_hole64_fix && value < PCI_HOST_PCI_HOLE64_END) {
+        value = PCI_HOST_PCI_HOLE64_END;
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -143,6 +151,7 @@ static Property q35_host_props[] = {
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
                      mch.above_4g_mem_size, 0),
+    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 087d184ef5..82ea8f67f4 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -239,6 +239,7 @@ void pc_guest_info_init(PCMachineState *pcms);
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
 #define DEFAULT_PCI_HOLE64_SIZE (~0x0ULL)
+#define PCI_HOST_PCI_HOLE64_END (0x1ULL << 40)
 
 
 void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
@@ -249,6 +250,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
+uint64_t pc_pci_hole64_start(void);
 qemu_irq pc_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
@@ -375,6 +377,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "x-hv-max-vps",\
         .value    = "0x40",\
+    },{\
+        .driver   = "i440FX-pcihost",\
+        .property = "x-pci-hole64-fix",\
+        .value    = "off",\
+    },{\
+        .driver   = "q35-pcihost",\
+        .property = "x-pci-hole64-fix",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_9 \
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 58983c00b3..8f4ddde393 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -68,6 +68,7 @@ typedef struct Q35PCIHost {
     PCIExpressHost parent_obj;
     /*< public >*/
 
+    bool pci_hole64_fix;
     MCHPCIState mch;
 } Q35PCIHost;
 
-- 
2.13.5
