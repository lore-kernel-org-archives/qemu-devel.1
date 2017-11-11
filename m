Received: from eggs.gnu.org ([2001:4830:134:3::10]:46341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eDXeq-0007FJ-KS
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eDXel-0001D7-9z
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:25:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eDXek-0001Cx-Qk
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 10:25:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B88348046F
	for <qemu-devel@nongnu.org>; Sat, 11 Nov 2017 15:25:13 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sat, 11 Nov 2017 17:25:00 +0200
Message-Id: <20171111152500.96389-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V5] hw/pci-host: Fix x86 Host Bridges 64bit PCI
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
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, lersek@redhat.com, imammedo@redhat.com, kraxel@redhat.com

Currently there is no MMIO range over 4G
reserved for PCI hotplug. Since the 32bit PCI hole
depends on the number of cold-plugged PCI devices
and other factors, it is very possible is too small
to hotplug PCI devices with large BARs.

Fix it by reserving 2G for I4400FX chipset
in order to comply with older Win32 Guest OSes
and 32G for Q35 chipset.

Even if the new defaults of pci-hole64-size will appear in
"info qtree" also for older machines, the property was
not implemented so no changes will be visible to guests.

Note this is a regression since prev QEMU versions had
some range reserved for 64bit PCI hotplug.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

V4 -> V5:
 - Renamed a local variable (Laszlo)
 - Added a comment to q35 props (Eduardo)

V3 -> V4:
 - Addressed Laszlo's comments:
    - Added defines for pci-hole64 default size props.
    - Rounded the hole64_end to 1G
    - Moved some info to commit message
 - Addressed Michael's comments:
    - Added more comments.
 - I kept Gerd's "review-by" tag since no functional changes were made.

V2 -> V3:
 - Addressed Gerd's and others comments and re-enabled the pci-hole64-size
   property defaulting it to 2G for I440FX and 32g for Q35.
 - Even if the new defaults of pci-hole64-size will appear in "info qtree"
   also for older machines, the property was not implemented so
   no changes will be visible to guests.

V1 -> V2:
 Addressed Igor's comments:
    - aligned the hole64 start to 1Gb
     (I think all the computations took care of it already,
      but it can't hurt)
    - Init compat props to "off" instead of "false"

 hw/i386/pc.c              | 22 ++++++++++++++++++++++
 hw/pci-host/piix.c        | 32 ++++++++++++++++++++++++++++++--
 hw/pci-host/q35.c         | 42 +++++++++++++++++++++++++++++++++++++++---
 include/hw/i386/pc.h      | 10 +++++++++-
 include/hw/pci-host/q35.h |  1 +
 5 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e11a65b545..fafe5ba5cd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1448,6 +1448,28 @@ void pc_memory_init(PCMachineState *pcms,
     pcms->ioapic_as = &address_space_memory;
 }
 
+/*
+ * The 64bit pci hole starts after "above 4G RAM" and
+ * potentially the space reserved for memory hotplug.
+ */
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
+    return ROUND_UP(hole64_start, 1ULL << 30);
+}
+
 qemu_irq pc_allocate_cpu_irq(void)
 {
     return qemu_allocate_irq(pic_irq_request, NULL, 0);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index a7e2256870..a684a7cca9 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -50,6 +50,7 @@ typedef struct I440FXState {
     PCIHostState parent_obj;
     Range pci_hole;
     uint64_t pci_hole64_size;
+    bool pci_hole64_fix;
     uint32_t short_root_bus;
 } I440FXState;
 
@@ -112,6 +113,9 @@ struct PCII440FXState {
 #define I440FX_PAM_SIZE 7
 #define I440FX_SMRAM    0x72
 
+/* Keep it 2G to comply with older win32 guests */
+#define I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 31)
+
 /* Older coreboot versions (4.0 and older) read a config register that doesn't
  * exist in real hardware, to get the RAM size from QEMU.
  */
@@ -238,29 +242,52 @@ static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
     visit_type_uint32(v, name, &value, errp);
 }
 
+/*
+ * The 64bit PCI hole start is set by the Guest firmware
+ * as the address of the first 64bit PCI MEM resource.
+ * If no PCI device has resources on the 64bit area,
+ * the 64bit PCI hole will start after "over 4G RAM" and the
+ * reserved space for memory hotplug if any.
+ */
 static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
                                                 const char *name,
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
 
+/*
+ * The 64bit PCI hole end is set by the Guest firmware
+ * as the address of the last 64bit PCI MEM resource.
+ * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
+ * that can be configured by the user.
+ */
 static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
                                               const char *name, void *opaque,
                                               Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start = pc_pci_hole64_start();
     Range w64;
-    uint64_t value;
+    uint64_t value, hole64_end;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
+    hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);
+    if (s->pci_hole64_fix && value < hole64_end) {
+        value = hole64_end;
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -863,8 +890,9 @@ static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
 
 static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
-                     pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
+                     pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
     DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
+    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index ddaa7d1b44..6cb9a8d121 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -37,6 +37,8 @@
  * Q35 host
  */
 
+#define Q35_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 35)
+
 static void q35_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
@@ -99,29 +101,52 @@ static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
     visit_type_uint32(v, name, &value, errp);
 }
 
+/*
+ * The 64bit PCI hole start is set by the Guest firmware
+ * as the address of the first 64bit PCI MEM resource.
+ * If no PCI device has resources on the 64bit area,
+ * the 64bit PCI hole will start after "over 4G RAM" and the
+ * reserved space for memory hotplug if any.
+ */
 static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
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
 
+/*
+ * The 64bit PCI hole end is set by the Guest firmware
+ * as the address of the last 64bit PCI MEM resource.
+ * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
+ * that can be configured by the user.
+ */
 static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
+    uint64_t hole64_start = pc_pci_hole64_start();
     Range w64;
-    uint64_t value;
+    uint64_t value, hole64_end;
 
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
+    hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);
+    if (s->pci_hole64_fix && value < hole64_end) {
+        value = hole64_end;
+    }
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -133,16 +158,25 @@ static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &e->size, errp);
 }
 
+/*
+ * NOTE: setting defaults for the mch.* fields in this table
+ * doesn't work, because mch is a separate QOM object that is
+ * zeroed by the object_initialize(&s->mch, ...) call inside
+ * q35_host_initfn().  The default values for those
+ * properties need to be initialized manually by
+ * q35_host_initfn() after the object_initialize() call.
+ */
 static Property q35_host_props[] = {
     DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, Q35PCIHost, parent_obj.base_addr,
                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, Q35PCIHost,
-                     mch.pci_hole64_size, DEFAULT_PCI_HOLE64_SIZE),
+                     mch.pci_hole64_size, Q35_PCI_HOST_HOLE64_SIZE_DEFAULT),
     DEFINE_PROP_UINT32("short_root_bus", Q35PCIHost, mch.short_root_bus, 0),
     DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, Q35PCIHost,
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
                      mch.above_4g_mem_size, 0),
+    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -174,7 +208,9 @@ static void q35_host_initfn(Object *obj)
     object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
-
+    /* mch's object_initialize resets the default value, set it again */
+    qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                         Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL, NULL);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 087d184ef5..ef438bd765 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -238,7 +238,6 @@ void pc_guest_info_init(PCMachineState *pcms);
 #define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
-#define DEFAULT_PCI_HOLE64_SIZE (~0x0ULL)
 
 
 void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
@@ -249,6 +248,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
+uint64_t pc_pci_hole64_start(void);
 qemu_irq pc_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
@@ -375,6 +375,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
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
