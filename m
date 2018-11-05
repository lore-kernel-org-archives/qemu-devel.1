Received: from eggs.gnu.org ([2001:4830:134:3::10]:46705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTtl-00061O-0W
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTtf-0000vc-Vy
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:41:48 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:24 +0100
Message-Id: <20181105014047.26447-2-sameo@linux.intel.com>
In-Reply-To: <20181105014047.26447-1-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/24] hw: i386: Decouple the ACPI build
 from the PC machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

ACPI tables are platform and machine type and even architecture
agnostic, and as such we want to provide an internal ACPI API that
only depends on platform agnostic information.

For the x86 architecture, in order to build ACPI tables independently
from the PC or Q35 machine types, we are moving a few MachineState
structure fields into a machine type agnostic structure called
AcpiConfiguration. The structure fields we move are:

   HotplugHandler *acpi_dev
   AcpiNVDIMMState acpi_nvdimm_state;
   FWCfgState *fw_cfg
   ram_addr_t below_4g_mem_size, above_4g_mem_size
   bool apic_xrupt_override
   unsigned apic_id_limit
   uint64_t numa_nodes
   uint64_t numa_mem

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.h     |   4 +-
 include/hw/acpi/acpi.h   |  44 ++++++++++
 include/hw/i386/pc.h     |  19 ++---
 hw/acpi/cpu_hotplug.c    |   9 +-
 hw/arm/virt-acpi-build.c |  10 ---
 hw/i386/acpi-build.c     | 136 ++++++++++++++----------------
 hw/i386/pc.c             | 176 ++++++++++++++++++++++++---------------
 hw/i386/pc_piix.c        |  21 ++---
 hw/i386/pc_q35.c         |  21 ++---
 hw/i386/xen/xen-hvm.c    |  19 +++--
 10 files changed, 257 insertions(+), 202 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 007332e51c..065a1d8250 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -2,6 +2,8 @@
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
 
-void acpi_setup(void);
+#include "hw/acpi/acpi.h"
+
+void acpi_setup(MachineState *machine, AcpiConfiguration *acpi_conf);
 
 #endif
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index c20ace0d0b..254c8d0cfc 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -24,6 +24,8 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/hotplug.h"
+#include "hw/mem/nvdimm.h"
 
 /*
  * current device naming scheme supports up to 256 memory devices
@@ -186,6 +188,48 @@ extern int acpi_enabled;
 extern char unsigned *acpi_tables;
 extern size_t acpi_tables_len;
 
+typedef
+struct AcpiBuildState {
+    /* Copy of table in RAM (for patching). */
+    MemoryRegion *table_mr;
+    /* Is table patched? */
+    bool patched;
+    void *rsdp;
+    MemoryRegion *rsdp_mr;
+    MemoryRegion *linker_mr;
+} AcpiBuildState;
+
+typedef
+struct AcpiConfiguration {
+    /* Machine class ACPI settings */
+    int legacy_acpi_table_size;
+    bool rsdp_in_ram;
+    unsigned acpi_data_size;
+
+    /* Machine state ACPI settings */
+    HotplugHandler *acpi_dev;
+    AcpiNVDIMMState acpi_nvdimm_state;
+
+    /*
+     * The fields below are machine settings that
+     * are not ACPI specific. However they are needed
+     * for building ACPI tables and as such should be
+     * carried through the ACPI configuration structure.
+     */
+    bool legacy_cpu_hotplug;
+    bool linuxboot_dma_enabled;
+    FWCfgState *fw_cfg;
+    ram_addr_t below_4g_mem_size, above_4g_mem_size;;
+    uint64_t numa_nodes;
+    uint64_t *node_mem;
+    bool apic_xrupt_override;
+    unsigned apic_id_limit;
+    PCIHostState *pci_host;
+
+    /* Build state */
+    AcpiBuildState *build_state;
+} AcpiConfiguration;
+
 uint8_t *acpi_table_first(void);
 uint8_t *acpi_table_next(uint8_t *current);
 unsigned acpi_table_len(void *current);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..fed136fcdd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -12,6 +12,7 @@
 #include "qemu/range.h"
 #include "qemu/bitmap.h"
 #include "sysemu/sysemu.h"
+#include "hw/acpi/acpi.h"
 #include "hw/pci/pci.h"
 #include "hw/compat.h"
 #include "hw/mem/pc-dimm.h"
@@ -35,10 +36,8 @@ struct PCMachineState {
     Notifier machine_done;
 
     /* Pointers to devices and objects: */
-    HotplugHandler *acpi_dev;
     ISADevice *rtc;
     PCIBus *bus;
-    FWCfgState *fw_cfg;
     qemu_irq *gsi;
 
     /* Configuration options: */
@@ -46,28 +45,20 @@ struct PCMachineState {
     OnOffAuto vmport;
     OnOffAuto smm;
 
-    AcpiNVDIMMState acpi_nvdimm_state;
-
     bool acpi_build_enabled;
     bool smbus;
     bool sata;
     bool pit;
 
-    /* RAM information (sizes, addresses, configuration): */
-    ram_addr_t below_4g_mem_size, above_4g_mem_size;
-
-    /* CPU and apic information: */
-    bool apic_xrupt_override;
-    unsigned apic_id_limit;
+    /* CPU information */
     uint16_t boot_cpus;
 
-    /* NUMA information: */
-    uint64_t numa_nodes;
-    uint64_t *node_mem;
-
     /* Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space. */
     AddressSpace *ioapic_as;
+
+    /* ACPI configuration */
+    AcpiConfiguration acpi_configuration;
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5243918125..634dc3b846 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -237,9 +237,9 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     /* The current AML generator can cover the APIC ID range [0..255],
      * inclusive, for VCPU hotplug. */
     QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
-    if (pcms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
+    if (pcms->acpi_configuration.apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
         error_report("max_cpus is too large. APIC ID of last CPU is %u",
-                     pcms->apic_id_limit - 1);
+                     pcms->acpi_configuration.apic_id_limit - 1);
         exit(1);
     }
 
@@ -316,8 +316,9 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
      * ith up to 255 elements. Windows guests up to win2k8 fail when
      * VarPackageOp is used.
      */
-    pkg = pcms->apic_id_limit <= 255 ? aml_package(pcms->apic_id_limit) :
-                                       aml_varpackage(pcms->apic_id_limit);
+    pkg = pcms->acpi_configuration.apic_id_limit <= 255 ?
+        aml_package(pcms->acpi_configuration.apic_id_limit) :
+        aml_varpackage(pcms->acpi_configuration.apic_id_limit);
 
     for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
         int apic_id = apic_ids->cpus[i].arch_id;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb697c..f28a2faa53 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -790,16 +790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     free_aml_allocator();
 }
 
-typedef
-struct AcpiBuildState {
-    /* Copy of table in RAM (for patching). */
-    MemoryRegion *table_mr;
-    MemoryRegion *rsdp_mr;
-    MemoryRegion *linker_mr;
-    /* Is table patched? */
-    bool patched;
-} AcpiBuildState;
-
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1599caa7c5..d0362e1382 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -338,13 +338,14 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
 
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
+build_madt(GArray *table_data, BIOSLinker *linker,
+           MachineState *ms, AcpiConfiguration *acpi_conf)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(ms);
     int madt_start = table_data->len;
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
-    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(acpi_conf->acpi_dev);
+    AcpiDeviceIf *adev = ACPI_DEVICE_IF(acpi_conf->acpi_dev);
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
@@ -370,7 +371,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
     io_apic->interrupt = cpu_to_le32(0);
 
-    if (pcms->apic_xrupt_override) {
+    if (acpi_conf->apic_xrupt_override) {
         intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
         intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
         intsrcovr->length = sizeof(*intsrcovr);
@@ -1786,13 +1787,12 @@ static Aml *build_q35_osc_method(void)
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
-           Range *pci_hole, Range *pci_hole64, MachineState *machine)
+           Range *pci_hole, Range *pci_hole64,
+           MachineState *machine, AcpiConfiguration *acpi_conf)
 {
     CrsRangeEntry *entry;
     Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
     CrsRangeSet crs_range_set;
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
     PCIBus *bus = NULL;
@@ -1836,7 +1836,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_pci0_int(dsdt);
     }
 
-    if (pcmc->legacy_cpu_hotplug) {
+    if (acpi_conf->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
@@ -1860,7 +1860,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(scope, method);
         }
 
-        if (pcms->acpi_nvdimm_state.is_enabled) {
+        if (acpi_conf->acpi_nvdimm_state.is_enabled) {
             method = aml_method("_E04", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
                                           aml_int(0x80)));
@@ -2041,7 +2041,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
          * with half of the 16-bit control register. Hence, the total size
          * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
          * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
-        uint8_t io_size = object_property_get_bool(OBJECT(pcms->fw_cfg),
+        uint8_t io_size = object_property_get_bool(OBJECT(acpi_conf->fw_cfg),
                                                    "dma_enabled", NULL) ?
                           ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
                           FW_CFG_CTL_SIZE;
@@ -2252,7 +2252,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_END   (1 * MiB)
 
 static void
-build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
+build_srat(GArray *table_data, BIOSLinker *linker,
+           MachineState *machine, AcpiConfiguration *acpi_conf)
 {
     AcpiSystemResourceAffinityTable *srat;
     AcpiSratMemoryAffinity *numamem;
@@ -2262,9 +2263,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
-    PCMachineState *pcms = PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =
-        object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION_SIZE,
+        object_property_get_int(OBJECT(machine), PC_MACHINE_DEVMEM_REGION_SIZE,
                                 NULL);
 
     srat_start = table_data->len;
@@ -2306,9 +2306,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     next_base = 0;
     numa_start = table_data->len;
 
-    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
+    for (i = 1; i < acpi_conf->numa_nodes + 1; ++i) {
         mem_base = next_base;
-        mem_len = pcms->node_mem[i - 1];
+        mem_len = acpi_conf->node_mem[i - 1];
         next_base = mem_base + mem_len;
 
         /* Cut out the 640K hole */
@@ -2331,16 +2331,16 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         }
 
         /* Cut out the ACPI_PCI hole */
-        if (mem_base <= pcms->below_4g_mem_size &&
-            next_base > pcms->below_4g_mem_size) {
-            mem_len -= next_base - pcms->below_4g_mem_size;
+        if (mem_base <= acpi_conf->below_4g_mem_size &&
+            next_base > acpi_conf->below_4g_mem_size) {
+            mem_len -= next_base - acpi_conf->below_4g_mem_size;
             if (mem_len > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
                 build_srat_memory(numamem, mem_base, mem_len, i - 1,
                                   MEM_AFFINITY_ENABLED);
             }
             mem_base = 1ULL << 32;
-            mem_len = next_base - pcms->below_4g_mem_size;
+            mem_len = next_base - acpi_conf->below_4g_mem_size;
             next_base = mem_base + mem_len;
         }
 
@@ -2351,7 +2351,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         }
     }
     slots = (table_data->len - numa_start) / sizeof *numamem;
-    for (; slots < pcms->numa_nodes + 2; slots++) {
+    for (; slots < acpi_conf->numa_nodes + 2; slots++) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
     }
@@ -2367,7 +2367,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     if (hotplugabble_address_space_size) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, machine->device_memory->base,
-                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
+                          hotplugabble_address_space_size,
+                          acpi_conf->numa_nodes - 1,
                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
     }
 
@@ -2546,17 +2547,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
     return rsdp_table;
 }
 
-typedef
-struct AcpiBuildState {
-    /* Copy of table in RAM (for patching). */
-    MemoryRegion *table_mr;
-    /* Is table patched? */
-    uint8_t patched;
-    void *rsdp;
-    MemoryRegion *rsdp_mr;
-    MemoryRegion *linker_mr;
-} AcpiBuildState;
-
 static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
 {
     Object *pci_host;
@@ -2580,10 +2570,9 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
 }
 
 static
-void acpi_build(AcpiBuildTables *tables, MachineState *machine)
+void acpi_build(AcpiBuildTables *tables,
+                MachineState *machine, AcpiConfiguration *acpi_conf)
 {
-    PCMachineState *pcms = PC_MACHINE(machine);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     GArray *table_offsets;
     unsigned facs, dsdt, rsdt, fadt;
     AcpiPmInfo pm;
@@ -2621,7 +2610,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     /* DSDT is pointed to by FADT */
     dsdt = tables_blob->len;
     build_dsdt(tables_blob, tables->linker, &pm, &misc,
-               &pci_hole, &pci_hole64, machine);
+               &pci_hole, &pci_hole64, machine, acpi_conf);
 
     /* Count the size of the DSDT and SSDT, we will need it for legacy
      * sizing of ACPI tables.
@@ -2639,7 +2628,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, pcms);
+    build_madt(tables_blob, tables->linker, machine, acpi_conf);
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
@@ -2661,9 +2650,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             build_tpm2(tables_blob, tables->linker, tables->tcpalog);
         }
     }
-    if (pcms->numa_nodes) {
+    if (acpi_conf->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
-        build_srat(tables_blob, tables->linker, machine);
+        build_srat(tables_blob, tables->linker, machine, acpi_conf);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker);
@@ -2683,9 +2672,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             build_dmar_q35(tables_blob, tables->linker);
         }
     }
-    if (pcms->acpi_nvdimm_state.is_enabled) {
+    if (acpi_conf->acpi_nvdimm_state.is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
-                          &pcms->acpi_nvdimm_state, machine->ram_slots);
+                          &acpi_conf->acpi_nvdimm_state, machine->ram_slots);
     }
 
     /* Add tables supplied by user (if any) */
@@ -2721,13 +2710,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      *
      * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.
      */
-    if (pcmc->legacy_acpi_table_size) {
+    if (acpi_conf->legacy_acpi_table_size) {
         /* Subtracting aml_len gives the size of fixed tables.  Then add the
          * size of the PIIX4 DSDT/SSDT in QEMU 2.0.
          */
         int legacy_aml_len =
-            pcmc->legacy_acpi_table_size +
-            ACPI_BUILD_LEGACY_CPU_AML_SIZE * pcms->apic_id_limit;
+            acpi_conf->legacy_acpi_table_size +
+            ACPI_BUILD_LEGACY_CPU_AML_SIZE * acpi_conf->apic_id_limit;
         int legacy_table_size =
             ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
                      ACPI_BUILD_ALIGN_SIZE);
@@ -2772,9 +2761,17 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
 
 static void acpi_build_update(void *build_opaque)
 {
-    AcpiBuildState *build_state = build_opaque;
+    AcpiConfiguration *acpi_conf = build_opaque;
+    AcpiBuildState *build_state;
     AcpiBuildTables tables;
 
+    /* No ACPI configuration? Nothing to do. */
+    if (!acpi_conf) {
+        return;
+    }
+
+    build_state = acpi_conf->build_state;
+
     /* No state to update or already patched? Nothing to do. */
     if (!build_state || build_state->patched) {
         return;
@@ -2783,7 +2780,7 @@ static void acpi_build_update(void *build_opaque)
 
     acpi_build_tables_init(&tables);
 
-    acpi_build(&tables, MACHINE(qdev_get_machine()));
+    acpi_build(&tables, MACHINE(qdev_get_machine()), acpi_conf);
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
 
@@ -2803,12 +2800,12 @@ static void acpi_build_reset(void *build_opaque)
     build_state->patched = 0;
 }
 
-static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
+static MemoryRegion *acpi_add_rom_blob(AcpiConfiguration *acpi_conf,
                                        GArray *blob, const char *name,
                                        uint64_t max_size)
 {
     return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, acpi_build_update, build_state, NULL, true);
+                        name, acpi_build_update, acpi_conf, NULL, true);
 }
 
 static const VMStateDescription vmstate_acpi_build = {
@@ -2816,59 +2813,48 @@ static const VMStateDescription vmstate_acpi_build = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(patched, AcpiBuildState),
+        VMSTATE_BOOL(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
 };
 
-void acpi_setup(void)
+void acpi_setup(MachineState *machine, AcpiConfiguration *acpi_conf)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
 
-    if (!pcms->fw_cfg) {
-        ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
-        return;
-    }
-
-    if (!pcms->acpi_build_enabled) {
-        ACPI_BUILD_DPRINTF("ACPI build disabled. Bailing out.\n");
-        return;
-    }
-
-    if (!acpi_enabled) {
-        ACPI_BUILD_DPRINTF("ACPI disabled. Bailing out.\n");
+    if (!acpi_conf) {
+        ACPI_BUILD_DPRINTF("No ACPI config. Bailing out.\n");
         return;
     }
 
     build_state = g_malloc0(sizeof *build_state);
+    acpi_conf->build_state = build_state;
 
     acpi_build_tables_init(&tables);
-    acpi_build(&tables, MACHINE(pcms));
+    acpi_build(&tables, machine, acpi_conf);
 
     /* Now expose it all to Guest */
-    build_state->table_mr = acpi_add_rom_blob(build_state, tables.table_data,
+    build_state->table_mr = acpi_add_rom_blob(acpi_conf, tables.table_data,
                                                ACPI_BUILD_TABLE_FILE,
                                                ACPI_BUILD_TABLE_MAX_SIZE);
     assert(build_state->table_mr != NULL);
 
     build_state->linker_mr =
-        acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
+        acpi_add_rom_blob(acpi_conf, tables.linker->cmd_blob,
                           "etc/table-loader", 0);
 
-    fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
+    fw_cfg_add_file(acpi_conf->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
-        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
+        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), acpi_conf->fw_cfg,
                            tables.vmgenid);
     }
 
-    if (!pcmc->rsdp_in_ram) {
+    if (!acpi_conf->rsdp_in_ram) {
         /*
          * Keep for compatibility with old machine types.
          * Though RSDP is small, its contents isn't immutable, so
@@ -2877,13 +2863,13 @@ void acpi_setup(void)
         uint32_t rsdp_size = acpi_data_len(tables.rsdp);
 
         build_state->rsdp = g_memdup(tables.rsdp->data, rsdp_size);
-        fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
-                                 acpi_build_update, NULL, build_state,
+        fw_cfg_add_file_callback(acpi_conf->fw_cfg, ACPI_BUILD_RSDP_FILE,
+                                 acpi_build_update, NULL, acpi_conf,
                                  build_state->rsdp, rsdp_size, true);
         build_state->rsdp_mr = NULL;
     } else {
         build_state->rsdp = NULL;
-        build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
+        build_state->rsdp_mr = acpi_add_rom_blob(acpi_conf, tables.rsdp,
                                                   ACPI_BUILD_RSDP_FILE, 0);
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dba..090f969933 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -444,17 +444,18 @@ void pc_cmos_init(PCMachineState *pcms,
 {
     int val;
     static pc_cmos_init_late_arg arg;
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
     /* various important CMOS locations needed by PC/Bochs bios */
 
     /* memory size */
     /* base memory (first MiB) */
-    val = MIN(pcms->below_4g_mem_size / KiB, 640);
+    val = MIN(acpi_conf->below_4g_mem_size / KiB, 640);
     rtc_set_memory(s, 0x15, val);
     rtc_set_memory(s, 0x16, val >> 8);
     /* extended memory (next 64MiB) */
-    if (pcms->below_4g_mem_size > 1 * MiB) {
-        val = (pcms->below_4g_mem_size - 1 * MiB) / KiB;
+    if (acpi_conf->below_4g_mem_size > 1 * MiB) {
+        val = (acpi_conf->below_4g_mem_size - 1 * MiB) / KiB;
     } else {
         val = 0;
     }
@@ -465,8 +466,8 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x30, val);
     rtc_set_memory(s, 0x31, val >> 8);
     /* memory between 16MiB and 4GiB */
-    if (pcms->below_4g_mem_size > 16 * MiB) {
-        val = (pcms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
+    if (acpi_conf->below_4g_mem_size > 16 * MiB) {
+        val = (acpi_conf->below_4g_mem_size - 16 * MiB) / (64 * KiB);
     } else {
         val = 0;
     }
@@ -475,7 +476,7 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x34, val);
     rtc_set_memory(s, 0x35, val >> 8);
     /* memory above 4GiB */
-    val = pcms->above_4g_mem_size / 65536;
+    val = acpi_conf->above_4g_mem_size / 65536;
     rtc_set_memory(s, 0x5b, val);
     rtc_set_memory(s, 0x5c, val >> 8);
     rtc_set_memory(s, 0x5d, val >> 16);
@@ -714,13 +715,14 @@ static void pc_build_smbios(PCMachineState *pcms)
     unsigned i, array_count;
     MachineState *ms = MACHINE(pcms);
     X86CPU *cpu = X86_CPU(ms->possible_cpus->cpus[0].cpu);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
     smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
     if (smbios_tables) {
-        fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
+        fw_cfg_add_bytes(acpi_conf->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
     }
 
@@ -741,9 +743,9 @@ static void pc_build_smbios(PCMachineState *pcms)
     g_free(mem_array);
 
     if (smbios_anchor) {
-        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-tables",
+        fw_cfg_add_file(acpi_conf->fw_cfg, "etc/smbios/smbios-tables",
                         smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-anchor",
+        fw_cfg_add_file(acpi_conf->fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
 }
@@ -755,6 +757,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     int i;
     const CPUArchIdList *cpus;
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
     fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
@@ -771,7 +774,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
      * So for compatibility reasons with old BIOSes we are stuck with
      * "etc/max-cpus" actually being apic_id_limit
      */
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)pcms->apic_id_limit);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)acpi_conf->apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
@@ -787,20 +790,21 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
      */
-    numa_fw_cfg = g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa_nodes);
+    numa_fw_cfg = g_new0(uint64_t,
+                         1 + acpi_conf->apic_id_limit + nb_numa_nodes);
     numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
     cpus = mc->possible_cpu_arch_ids(MACHINE(pcms));
     for (i = 0; i < cpus->len; i++) {
         unsigned int apic_id = cpus->cpus[i].arch_id;
-        assert(apic_id < pcms->apic_id_limit);
+        assert(apic_id < acpi_conf->apic_id_limit);
         numa_fw_cfg[apic_id + 1] = cpu_to_le64(cpus->cpus[i].props.node_id);
     }
     for (i = 0; i < nb_numa_nodes; i++) {
-        numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
+        numa_fw_cfg[acpi_conf->apic_id_limit + 1 + i] =
             cpu_to_le64(numa_info[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
-                     (1 + pcms->apic_id_limit + nb_numa_nodes) *
+                     (1 + acpi_conf->apic_id_limit + nb_numa_nodes) *
                      sizeof(*numa_fw_cfg));
 
     return fw_cfg;
@@ -848,6 +852,7 @@ static void load_linux(PCMachineState *pcms,
     char *vmode;
     MachineState *machine = MACHINE(pcms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     struct setup_data *setup_data;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -917,8 +922,8 @@ static void load_linux(PCMachineState *pcms,
         initrd_max = 0x37ffffff;
     }
 
-    if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
-        initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+    if (initrd_max >= acpi_conf->below_4g_mem_size - pcmc->acpi_data_size) {
+        initrd_max = acpi_conf->below_4g_mem_size - pcmc->acpi_data_size - 1;
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
@@ -1154,7 +1159,8 @@ void pc_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
+    pcms->acpi_configuration.apic_id_limit =
+        x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < smp_cpus; i++) {
         pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
@@ -1188,7 +1194,8 @@ static void pc_build_feature_control_file(PCMachineState *pcms)
 
     val = g_malloc(sizeof(*val));
     *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
-    fw_cfg_add_file(pcms->fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
+    fw_cfg_add_file(pcms->acpi_configuration.fw_cfg,
+                    "etc/msr_feature_control", val, sizeof(*val));
 }
 
 static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
@@ -1204,11 +1211,26 @@ static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
     }
 }
 
+static void acpi_conf_pc_init(PCMachineState *pcms)
+{
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
+
+    /* Machine class settings */
+    acpi_conf->legacy_acpi_table_size = pcmc->legacy_acpi_table_size;
+    acpi_conf->legacy_cpu_hotplug = pcmc->legacy_cpu_hotplug;
+    acpi_conf->rsdp_in_ram = pcmc->rsdp_in_ram;
+
+    /* ACPI build state */
+    acpi_conf->build_state = NULL;
+}
+
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
     PCMachineState *pcms = container_of(notifier,
                                         PCMachineState, machine_done);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     PCIBus *bus = pcms->bus;
 
     /* set the number of CPUs */
@@ -1223,23 +1245,27 @@ void pc_machine_done(Notifier *notifier, void *data)
                 extra_hosts++;
             }
         }
-        if (extra_hosts && pcms->fw_cfg) {
+        if (extra_hosts && acpi_conf->fw_cfg) {
             uint64_t *val = g_malloc(sizeof(*val));
             *val = cpu_to_le64(extra_hosts);
-            fw_cfg_add_file(pcms->fw_cfg,
+            fw_cfg_add_file(acpi_conf->fw_cfg,
                     "etc/extra-pci-roots", val, sizeof(*val));
         }
     }
 
-    acpi_setup();
-    if (pcms->fw_cfg) {
+    if (pcms->acpi_build_enabled) {
+        acpi_conf_pc_init(pcms);
+        acpi_setup(MACHINE(pcms), acpi_conf);
+    }
+
+    if (acpi_conf->fw_cfg) {
         pc_build_smbios(pcms);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+        fw_cfg_modify_i16(acpi_conf->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
+    if (acpi_conf->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
 
         if (!iommu || !iommu->x86_iommu.intr_supported ||
@@ -1256,13 +1282,14 @@ void pc_machine_done(Notifier *notifier, void *data)
 void pc_guest_info_init(PCMachineState *pcms)
 {
     int i;
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    pcms->apic_xrupt_override = kvm_allows_irq0_override();
-    pcms->numa_nodes = nb_numa_nodes;
-    pcms->node_mem = g_malloc0(pcms->numa_nodes *
-                                    sizeof *pcms->node_mem);
+    acpi_conf->apic_xrupt_override = kvm_allows_irq0_override();
+    acpi_conf->numa_nodes = nb_numa_nodes;
+    acpi_conf->node_mem = g_malloc0(acpi_conf->numa_nodes *
+                                    sizeof *acpi_conf->node_mem);
     for (i = 0; i < nb_numa_nodes; i++) {
-        pcms->node_mem[i] = numa_info[i].node_mem;
+        acpi_conf->node_mem[i] = numa_info[i].node_mem;
     }
 
     pcms->machine_done.notify = pc_machine_done;
@@ -1323,7 +1350,7 @@ void xen_load_linux(PCMachineState *pcms)
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg = fw_cfg;
+    pcms->acpi_configuration.fw_cfg = fw_cfg;
 }
 
 void pc_memory_init(PCMachineState *pcms,
@@ -1337,9 +1364,10 @@ void pc_memory_init(PCMachineState *pcms,
     FWCfgState *fw_cfg;
     MachineState *machine = MACHINE(pcms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    assert(machine->ram_size == pcms->below_4g_mem_size +
-                                pcms->above_4g_mem_size);
+    assert(machine->ram_size == acpi_conf->below_4g_mem_size +
+                                acpi_conf->above_4g_mem_size);
 
     linux_boot = (machine->kernel_filename != NULL);
 
@@ -1353,17 +1381,17 @@ void pc_memory_init(PCMachineState *pcms,
     *ram_memory = ram;
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
     memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
-                             0, pcms->below_4g_mem_size);
+                             0, acpi_conf->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
-    e820_add_entry(0, pcms->below_4g_mem_size, E820_RAM);
-    if (pcms->above_4g_mem_size > 0) {
+    e820_add_entry(0, acpi_conf->below_4g_mem_size, E820_RAM);
+    if (acpi_conf->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
         memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
-                                 pcms->below_4g_mem_size,
-                                 pcms->above_4g_mem_size);
+                                 acpi_conf->below_4g_mem_size,
+                                 acpi_conf->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
                                     ram_above_4g);
-        e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_RAM);
+        e820_add_entry(0x100000000ULL, acpi_conf->above_4g_mem_size, E820_RAM);
     }
 
     if (!pcmc->has_reserved_memory &&
@@ -1398,7 +1426,7 @@ void pc_memory_init(PCMachineState *pcms,
         }
 
         machine->device_memory->base =
-            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1 * GiB);
+            ROUND_UP(0x100000000ULL + acpi_conf->above_4g_mem_size, 1 * GiB);
 
         if (pcmc->enforce_aligned_dimm) {
             /* size device region assuming 1G page max alignment per slot */
@@ -1455,7 +1483,7 @@ void pc_memory_init(PCMachineState *pcms,
     for (i = 0; i < nb_option_roms; i++) {
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg = fw_cfg;
+    acpi_conf->fw_cfg = fw_cfg;
 
     /* Init default IOAPIC address space */
     pcms->ioapic_as = &address_space_memory;
@@ -1478,7 +1506,8 @@ uint64_t pc_pci_hole64_start(void)
             hole64_start += memory_region_size(&ms->device_memory->mr);
         }
     } else {
-        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
+        hole64_start =
+            0x100000000ULL + pcms->acpi_configuration.above_4g_mem_size;
     }
 
     return ROUND_UP(hole64_start, 1 * GiB);
@@ -1685,21 +1714,22 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    const AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     const uint64_t legacy_align = TARGET_PAGE_SIZE;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
-     * but pcms->acpi_dev is still created. Check !acpi_enabled in
+     * but acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
-    if (!pcms->acpi_dev || !acpi_enabled) {
+    if (!acpi_conf->acpi_dev || !acpi_enabled) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
         return;
     }
 
-    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
+    if (is_nvdimm && !acpi_conf->acpi_nvdimm_state.is_enabled) {
         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
         return;
     }
@@ -1715,6 +1745,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
     if (local_err) {
@@ -1722,11 +1753,11 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     }
 
     if (is_nvdimm) {
-        nvdimm_plug(&pcms->acpi_nvdimm_state);
+        nvdimm_plug(&acpi_conf->acpi_nvdimm_state);
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
+    hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+    hhc->plug(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &error_abort);
 out:
     error_propagate(errp, local_err);
 }
@@ -1737,13 +1768,14 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
-     * but pcms->acpi_dev is still created. Check !acpi_enabled in
+     * but acpi_dev is still created. Check !acpi_enabled in
      * addition to cover this case.
      */
-    if (!pcms->acpi_dev || !acpi_enabled) {
+    if (!acpi_conf->acpi_dev || !acpi_enabled) {
         error_setg(&local_err,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
         goto out;
@@ -1755,8 +1787,8 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+    hhc->unplug_request(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &local_err);
 
 out:
     error_propagate(errp, local_err);
@@ -1766,11 +1798,12 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+    hhc->unplug(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &local_err);
 
     if (local_err) {
         goto out;
@@ -1817,10 +1850,11 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    if (pcms->acpi_dev) {
-        hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-        hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    if (acpi_conf->acpi_dev) {
+        hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+        hhc->plug(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &local_err);
         if (local_err) {
             goto out;
         }
@@ -1831,8 +1865,8 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     if (pcms->rtc) {
         rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
     }
-    if (pcms->fw_cfg) {
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    if (acpi_conf->fw_cfg) {
+        fw_cfg_modify_i16(acpi_conf->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
@@ -1848,8 +1882,9 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    if (!pcms->acpi_dev) {
+    if (!acpi_conf->acpi_dev) {
         error_setg(&local_err, "CPU hot unplug not supported without ACPI");
         goto out;
     }
@@ -1861,8 +1896,8 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+    hhc->unplug_request(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &local_err);
 
     if (local_err) {
         goto out;
@@ -1881,9 +1916,10 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
-    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
+    hhc = HOTPLUG_HANDLER_GET_CLASS(acpi_conf->acpi_dev);
+    hhc->unplug(HOTPLUG_HANDLER(acpi_conf->acpi_dev), dev, &local_err);
 
     if (local_err) {
         goto out;
@@ -1897,7 +1933,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     pcms->boot_cpus--;
     /* Update the number of CPUs in CMOS */
     rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
-    fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    fw_cfg_modify_i16(acpi_conf->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
  out:
     error_propagate(errp, local_err);
 }
@@ -2181,28 +2217,30 @@ static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->acpi_nvdimm_state.is_enabled;
+    return pcms->acpi_configuration.acpi_nvdimm_state.is_enabled;
 }
 
 static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    pcms->acpi_nvdimm_state.is_enabled = value;
+    acpi_conf->acpi_nvdimm_state.is_enabled = value;
 }
 
 static char *pc_machine_get_nvdimm_persistence(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
 
-    return g_strdup(pcms->acpi_nvdimm_state.persistence_string);
+    return g_strdup(acpi_conf->acpi_nvdimm_state.persistence_string);
 }
 
 static void pc_machine_set_nvdimm_persistence(Object *obj, const char *value,
                                                Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    AcpiNVDIMMState *nvdimm_state = &pcms->acpi_nvdimm_state;
+    AcpiNVDIMMState *nvdimm_state = &pcms->acpi_configuration.acpi_nvdimm_state;
 
     if (strcmp(value, "cpu") == 0)
         nvdimm_state->persistence = 3;
@@ -2268,7 +2306,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smm = ON_OFF_AUTO_AUTO;
     pcms->vmport = ON_OFF_AUTO_AUTO;
     /* nvdimm is disabled on default. */
-    pcms->acpi_nvdimm_state.is_enabled = false;
+    pcms->acpi_configuration.acpi_nvdimm_state.is_enabled = false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..0620d10715 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -71,6 +71,7 @@ static void pc_init1(MachineState *machine,
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     int i;
@@ -142,11 +143,11 @@ static void pc_init1(MachineState *machine,
         }
 
         if (machine->ram_size >= lowmem) {
-            pcms->above_4g_mem_size = machine->ram_size - lowmem;
-            pcms->below_4g_mem_size = lowmem;
+            acpi_conf->above_4g_mem_size = machine->ram_size - lowmem;
+            acpi_conf->below_4g_mem_size = lowmem;
         } else {
-            pcms->above_4g_mem_size = 0;
-            pcms->below_4g_mem_size = machine->ram_size;
+            acpi_conf->above_4g_mem_size = 0;
+            acpi_conf->below_4g_mem_size = machine->ram_size;
         }
     }
 
@@ -199,8 +200,8 @@ static void pc_init1(MachineState *machine,
                               pci_type,
                               &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
                               system_memory, system_io, machine->ram_size,
-                              pcms->below_4g_mem_size,
-                              pcms->above_4g_mem_size,
+                              acpi_conf->below_4g_mem_size,
+                              acpi_conf->above_4g_mem_size,
                               pci_memory, ram_memory);
         pcms->bus = pci_bus;
     } else {
@@ -289,16 +290,16 @@ static void pc_init1(MachineState *machine,
 
         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&pcms->acpi_dev,
+                                 (Object **)&acpi_conf->acpi_dev,
                                  object_property_allow_set_link,
                                  OBJ_PROP_LINK_STRONG, &error_abort);
         object_property_set_link(OBJECT(machine), OBJECT(piix4_pm),
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
     }
 
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+    if (acpi_conf->acpi_nvdimm_state.is_enabled) {
+        nvdimm_init_acpi_state(&acpi_conf->acpi_nvdimm_state, system_io,
+                               acpi_conf->fw_cfg, OBJECT(pcms));
     }
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 532241e3f8..cdde4a4beb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -63,6 +63,7 @@ static void pc_q35_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     Q35PCIHost *q35_host;
     PCIHostState *phb;
     PCIBus *host_bus;
@@ -116,11 +117,11 @@ static void pc_q35_init(MachineState *machine)
     }
 
     if (machine->ram_size >= lowmem) {
-        pcms->above_4g_mem_size = machine->ram_size - lowmem;
-        pcms->below_4g_mem_size = lowmem;
+        acpi_conf->above_4g_mem_size = machine->ram_size - lowmem;
+        acpi_conf->below_4g_mem_size = lowmem;
     } else {
-        pcms->above_4g_mem_size = 0;
-        pcms->below_4g_mem_size = machine->ram_size;
+        acpi_conf->above_4g_mem_size = 0;
+        acpi_conf->below_4g_mem_size = machine->ram_size;
     }
 
     if (xen_enabled()) {
@@ -179,9 +180,9 @@ static void pc_q35_init(MachineState *machine)
                              MCH_HOST_PROP_SYSTEM_MEM, NULL);
     object_property_set_link(OBJECT(q35_host), OBJECT(system_io),
                              MCH_HOST_PROP_IO_MEM, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->below_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), acpi_conf->below_4g_mem_size,
                             PCI_HOST_BELOW_4G_MEM_SIZE, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->above_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), acpi_conf->above_4g_mem_size,
                             PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
     /* pci */
     qdev_init_nofail(DEVICE(q35_host));
@@ -194,7 +195,7 @@ static void pc_q35_init(MachineState *machine)
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
-                             (Object **)&pcms->acpi_dev,
+                             (Object **)&acpi_conf->acpi_dev,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_link(OBJECT(machine), OBJECT(lpc),
@@ -276,9 +277,9 @@ static void pc_q35_init(MachineState *machine)
     pc_vga_init(isa_bus, host_bus);
     pc_nic_init(pcmc, isa_bus, host_bus);
 
-    if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+    if (acpi_conf->acpi_nvdimm_state.is_enabled) {
+        nvdimm_init_acpi_state(&acpi_conf->acpi_nvdimm_state, system_io,
+                               acpi_conf->fw_cfg, OBJECT(pcms));
     }
 }
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 935a3676c8..0459fb7340 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -190,6 +190,7 @@ qemu_irq *xen_interrupt_controller_init(void)
 static void xen_ram_init(PCMachineState *pcms,
                          ram_addr_t ram_size, MemoryRegion **ram_memory_p)
 {
+    AcpiConfiguration *acpi_conf = &pcms->acpi_configuration;
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t block_len;
     uint64_t user_lowmem = object_property_get_uint(qdev_get_machine(),
@@ -207,20 +208,20 @@ static void xen_ram_init(PCMachineState *pcms,
     }
 
     if (ram_size >= user_lowmem) {
-        pcms->above_4g_mem_size = ram_size - user_lowmem;
-        pcms->below_4g_mem_size = user_lowmem;
+        acpi_conf->above_4g_mem_size = ram_size - user_lowmem;
+        acpi_conf->below_4g_mem_size = user_lowmem;
     } else {
-        pcms->above_4g_mem_size = 0;
-        pcms->below_4g_mem_size = ram_size;
+        acpi_conf->above_4g_mem_size = 0;
+        acpi_conf->below_4g_mem_size = ram_size;
     }
-    if (!pcms->above_4g_mem_size) {
+    if (!acpi_conf->above_4g_mem_size) {
         block_len = ram_size;
     } else {
         /*
          * Xen does not allocate the memory continuously, it keeps a
          * hole of the size computed above or passed in.
          */
-        block_len = (1ULL << 32) + pcms->above_4g_mem_size;
+        block_len = (1ULL << 32) + acpi_conf->above_4g_mem_size;
     }
     memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
@@ -237,12 +238,12 @@ static void xen_ram_init(PCMachineState *pcms,
      */
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
                              &ram_memory, 0xc0000,
-                             pcms->below_4g_mem_size - 0xc0000);
+                             acpi_conf->below_4g_mem_size - 0xc0000);
     memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
-    if (pcms->above_4g_mem_size > 0) {
+    if (acpi_conf->above_4g_mem_size > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
                                  &ram_memory, 0x100000000ULL,
-                                 pcms->above_4g_mem_size);
+                                 acpi_conf->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
 }
-- 
2.19.1
