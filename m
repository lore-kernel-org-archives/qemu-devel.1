Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXx-0006Lv-8A
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjXu-0007UQ-2U
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjXt-0007Tn-QA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:05 -0300
Message-Id: <20180507170315.11497-3-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's allow to query the MemoryHotplugState directly from the machine.
If the pointer is NULL, the machine does not support memory devices. If
the pointer is !NULL, the machine supports memory devices and the
data structure contains information about the applicable physical
guest address space region.

This allows us to generically detect if a certain machine has support
for memory devices, and to generically manage it (find free address
range, plug/unplug a memory region).

We will rename "MemoryHotplugState" to something more meaningful
("DeviceMemory") after we completed factoring out the pc-dimm code into
MemoryDevice code.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
[ehabkost: rebased series, solved conflicts at spapr.c]
[ehabkost: squashed fix to use g_malloc0()]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h      | 12 ++++++++++++
 include/hw/i386/pc.h     |  1 -
 include/hw/mem/pc-dimm.h | 12 +-----------
 include/hw/ppc/spapr.h   |  1 -
 hw/i386/acpi-build.c     |  2 +-
 hw/i386/pc.c             | 35 ++++++++++++++++++++---------------
 hw/ppc/spapr.c           | 43 ++++++++++++++++++++++++-------------------
 hw/ppc/spapr_hcall.c     |  2 +-
 hw/ppc/spapr_rtas_ddw.c  |  2 +-
 9 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5c5eee55e6..e27c28b514 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -213,6 +213,17 @@ struct MachineClass {
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
 };
 
+/**
+ * MemoryHotplugState:
+ * @base: address in guest physical address space where the memory
+ * address space for memory devices starts
+ * @mr: address space container for memory devices
+ */
+typedef struct MemoryHotplugState {
+    hwaddr base;
+    MemoryRegion mr;
+} MemoryHotplugState;
+
 /**
  * MachineState:
  */
@@ -243,6 +254,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
+    MemoryHotplugState *device_memory;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee8413f0..07b596ee76 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -32,7 +32,6 @@ struct PCMachineState {
     /* <public> */
 
     /* State for other subsystems/APIs: */
-    MemoryHotplugState hotplug_memory;
     Notifier machine_done;
 
     /* Pointers to devices and objects: */
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index e88073321f..8bda37adab 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -19,6 +19,7 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "hw/qdev.h"
+#include "hw/boards.h"
 
 #define TYPE_PC_DIMM "pc-dimm"
 #define PC_DIMM(obj) \
@@ -75,17 +76,6 @@ typedef struct PCDIMMDeviceClass {
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-/**
- * MemoryHotplugState:
- * @base: address in guest physical address space where hotplug memory
- * address space begins.
- * @mr: hotplug memory address space container
- */
-typedef struct MemoryHotplugState {
-    hwaddr base;
-    MemoryRegion mr;
-} MemoryHotplugState;
-
 uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
                                uint64_t address_space_size,
                                uint64_t *hint, uint64_t align, uint64_t size,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d60b7c6d7a..56ff02d32a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -162,7 +162,6 @@ struct sPAPRMachineState {
 
     /*< public >*/
     char *kvm_type;
-    MemoryHotplugState hotplug_memory;
 
     const char *icp_type;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 624e955e29..b1eddeb204 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2411,7 +2411,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
      * providing _PXM method if necessary.
      */
     if (hotplugabble_address_space_size) {
-        build_srat_hotpluggable_memory(table_data, pcms->hotplug_memory.base,
+        build_srat_hotpluggable_memory(table_data, machine->device_memory->base,
                                        hotplugabble_address_space_size,
                                        pcms->numa_nodes - 1);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b297a5d63b..0aa7885798 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1371,6 +1371,9 @@ void pc_memory_init(PCMachineState *pcms,
         exit(EXIT_FAILURE);
     }
 
+    /* always allocate the device memory information */
+    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
+
     /* initialize hotplug memory address space */
     if (pcmc->has_reserved_memory &&
         (machine->ram_size < machine->maxram_size)) {
@@ -1390,7 +1393,7 @@ void pc_memory_init(PCMachineState *pcms,
             exit(EXIT_FAILURE);
         }
 
-        pcms->hotplug_memory.base =
+        machine->device_memory->base =
             ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
 
         if (pcmc->enforce_aligned_dimm) {
@@ -1398,17 +1401,17 @@ void pc_memory_init(PCMachineState *pcms,
             hotplug_mem_size += (1ULL << 30) * machine->ram_slots;
         }
 
-        if ((pcms->hotplug_memory.base + hotplug_mem_size) <
+        if ((machine->device_memory->base + hotplug_mem_size) <
             hotplug_mem_size) {
             error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
                          machine->maxram_size);
             exit(EXIT_FAILURE);
         }
 
-        memory_region_init(&pcms->hotplug_memory.mr, OBJECT(pcms),
+        memory_region_init(&machine->device_memory->mr, OBJECT(pcms),
                            "hotplug-memory", hotplug_mem_size);
-        memory_region_add_subregion(system_memory, pcms->hotplug_memory.base,
-                                    &pcms->hotplug_memory.mr);
+        memory_region_add_subregion(system_memory, machine->device_memory->base,
+                                    &machine->device_memory->mr);
     }
 
     /* Initialize PC system firmware */
@@ -1429,13 +1432,13 @@ void pc_memory_init(PCMachineState *pcms,
 
     rom_set_fw(fw_cfg);
 
-    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
+    if (pcmc->has_reserved_memory && machine->device_memory->base) {
         uint64_t *val = g_malloc(sizeof(*val));
         PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-        uint64_t res_mem_end = pcms->hotplug_memory.base;
+        uint64_t res_mem_end = machine->device_memory->base;
 
         if (!pcmc->broken_reserved_end) {
-            res_mem_end += memory_region_size(&pcms->hotplug_memory.mr);
+            res_mem_end += memory_region_size(&machine->device_memory->mr);
         }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 0x1ULL << 30));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
@@ -1462,12 +1465,13 @@ uint64_t pc_pci_hole64_start(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
     uint64_t hole64_start = 0;
 
-    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
-        hole64_start = pcms->hotplug_memory.base;
+    if (pcmc->has_reserved_memory && ms->device_memory->base) {
+        hole64_start = ms->device_memory->base;
         if (!pcmc->broken_reserved_end) {
-            hole64_start += memory_region_size(&pcms->hotplug_memory.mr);
+            hole64_start += memory_region_size(&ms->device_memory->mr);
         }
     } else {
         hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
@@ -1711,7 +1715,8 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(pcms)->device_memory, mr, align,
+                        &local_err);
     if (local_err) {
         goto out;
     }
@@ -1779,7 +1784,7 @@ static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_unplug(dev, &pcms->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(pcms)->device_memory, mr);
     object_unparent(OBJECT(dev));
 
  out:
@@ -2072,8 +2077,8 @@ pc_machine_get_hotplug_memory_region_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(obj);
-    int64_t value = memory_region_size(&pcms->hotplug_memory.mr);
+    MachineState *ms = MACHINE(obj);
+    int64_t value = memory_region_size(&ms->device_memory->mr);
 
     visit_type_int(v, name, &value, errp);
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 640a66a21a..30d634a8a3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -703,13 +703,14 @@ spapr_get_drconf_cell(uint32_t seq_lmbs, uint64_t base_addr,
 static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dimms)
 {
+    MachineState *machine = MACHINE(spapr);
     uint8_t *int_buf, *cur_index, buf_len;
     int ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint64_t addr, cur_addr, size;
-    uint32_t nr_boot_lmbs = (spapr->hotplug_memory.base / lmb_size);
-    uint64_t mem_end = spapr->hotplug_memory.base +
-                       memory_region_size(&spapr->hotplug_memory.mr);
+    uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
+    uint64_t mem_end = machine->device_memory->base +
+                       memory_region_size(&machine->device_memory->mr);
     uint32_t node, nr_entries = 0;
     sPAPRDRConnector *drc;
     DrconfCellQueue *elem, *next;
@@ -724,7 +725,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
     QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
     nr_entries++;
 
-    cur_addr = spapr->hotplug_memory.base;
+    cur_addr = machine->device_memory->base;
     for (info = dimms; info; info = info->next) {
         PCDIMMDeviceInfo *di = info->value->u.dimm.data;
 
@@ -787,11 +788,12 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
 static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dimms)
 {
+    MachineState *machine = MACHINE(spapr);
     int i, ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint32_t hotplug_lmb_start = spapr->hotplug_memory.base / lmb_size;
-    uint32_t nr_lmbs = (spapr->hotplug_memory.base +
-                       memory_region_size(&spapr->hotplug_memory.mr)) /
+    uint32_t hotplug_lmb_start = machine->device_memory->base / lmb_size;
+    uint32_t nr_lmbs = (machine->device_memory->base +
+                       memory_region_size(&machine->device_memory->mr)) /
                        lmb_size;
     uint32_t *int_buf, *cur_index, buf_len;
 
@@ -1034,8 +1036,8 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
     uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
-    uint64_t max_hotplug_addr = spapr->hotplug_memory.base +
-        memory_region_size(&spapr->hotplug_memory.mr);
+    uint64_t max_hotplug_addr = MACHINE(spapr)->device_memory->base +
+        memory_region_size(&MACHINE(spapr)->device_memory->mr);
     uint32_t lrdr_capacity[] = {
         cpu_to_be32(max_hotplug_addr >> 32),
         cpu_to_be32(max_hotplug_addr & 0xffffffff),
@@ -2297,7 +2299,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
     for (i = 0; i < nr_lmbs; i++) {
         uint64_t addr;
 
-        addr = i * lmb_size + spapr->hotplug_memory.base;
+        addr = i * lmb_size + machine->device_memory->base;
         spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
                                addr / lmb_size);
     }
@@ -2634,6 +2636,9 @@ static void spapr_machine_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, 0, ram);
 
+    /* always allocate the device memory information */
+    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
+
     /* initialize hotplug memory address space */
     if (machine->ram_size < machine->maxram_size) {
         ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
@@ -2655,12 +2660,12 @@ static void spapr_machine_init(MachineState *machine)
             exit(1);
         }
 
-        spapr->hotplug_memory.base = ROUND_UP(machine->ram_size,
+        machine->device_memory->base = ROUND_UP(machine->ram_size,
                                               SPAPR_HOTPLUG_MEM_ALIGN);
-        memory_region_init(&spapr->hotplug_memory.mr, OBJECT(spapr),
+        memory_region_init(&machine->device_memory->mr, OBJECT(spapr),
                            "hotplug-memory", hotplug_mem_size);
-        memory_region_add_subregion(sysmem, spapr->hotplug_memory.base,
-                                    &spapr->hotplug_memory.mr);
+        memory_region_add_subregion(sysmem, machine->device_memory->base,
+                                    &machine->device_memory->mr);
     }
 
     if (smc->dr_lmb_enabled) {
@@ -3148,7 +3153,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
+    pc_dimm_memory_plug(dev, MACHINE(ms)->device_memory, mr, align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3169,7 +3174,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(ms)->device_memory, mr);
 out:
     error_propagate(errp, local_err);
 }
@@ -3309,7 +3314,7 @@ void spapr_lmb_release(DeviceState *dev)
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
-    pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
+    pc_dimm_memory_unplug(dev, MACHINE(spapr)->device_memory, mr);
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
@@ -4265,8 +4270,8 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
         /* Can't just use maxram_size, because there may be an
          * alignment gap between normal and hotpluggable memory
          * regions */
-        ram_top = spapr->hotplug_memory.base +
-            memory_region_size(&spapr->hotplug_memory.mr);
+        ram_top = MACHINE(spapr)->device_memory->base +
+            memory_region_size(&MACHINE(spapr)->device_memory->mr);
     }
 
     phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5f6e6249ba..52b8f40955 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -67,7 +67,7 @@ static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
 static bool is_ram_address(sPAPRMachineState *spapr, hwaddr addr)
 {
     MachineState *machine = MACHINE(spapr);
-    MemoryHotplugState *hpms = &spapr->hotplug_memory;
+    MemoryHotplugState *hpms = machine->device_memory;
 
     if (addr < machine->ram_size) {
         return true;
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 177dcffc9b..d3666c1921 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -122,7 +122,7 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
     if (machine->ram_size == machine->maxram_size) {
         max_window_size = machine->ram_size;
     } else {
-        MemoryHotplugState *hpms = &spapr->hotplug_memory;
+        MemoryHotplugState *hpms = machine->device_memory;
 
         max_window_size = hpms->base + memory_region_size(&hpms->mr);
     }
-- 
2.14.3
