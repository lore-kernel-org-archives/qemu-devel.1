Received: from eggs.gnu.org ([209.51.188.92]:56989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB6-0000xs-AQ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB4-0000Dx-IL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:25553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hBtB4-0008F1-77
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:34 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Thu,  4 Apr 2019 11:34:29 +0800
Message-Id: <20190404033429.17232-4-tao3.xu@intel.com>
In-Reply-To: <20190404033429.17232-1-tao3.xu@intel.com>
References: <20190404033429.17232-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 3/3] numa: move numa global variable numa_info
 into MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, jingqi.liu@intel.com, tao3.xu@intel.com

The aim of this patch is to move existing numa global numa_info
into NumaState.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 exec.c                   |  1 +
 hw/acpi/aml-build.c      |  1 +
 hw/arm/boot.c            |  1 +
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  1 +
 hw/i386/pc.c             |  2 ++
 hw/ppc/spapr.c           |  4 +++-
 hw/ppc/spapr_pci.c       |  2 ++
 include/hw/boards.h      | 11 +++++++++++
 include/sysemu/numa.h    |  8 --------
 numa.c                   | 12 ++++++++----
 11 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/exec.c b/exec.c
index 97314b3ba7..a4a2fc899a 100644
--- a/exec.c
+++ b/exec.c
@@ -1710,6 +1710,7 @@ long qemu_getrampagesize(void)
     Object *memdev_root;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     mainrampagesize = qemu_mempath_getpagesize(mem_path);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index e4f062ca3f..9193246e61 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1732,6 +1732,7 @@ void build_slit(GArray *table_data, BIOSLinker *linker)
     slit_start = table_data->len;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d2326d76bb..c0d273c22c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -534,6 +534,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     Error *err = NULL;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     if (binfo->dtb_filename) {
         char *filename;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2a6dab6706..f071292b80 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -519,6 +519,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     srat_start = table_data->len;
     srat = acpi_data_push(table_data, sizeof(*srat));
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8a07f0442f..3135c54c8a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -198,6 +198,7 @@ static void create_fdt(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
     bool have_numa_distance = ms->numa_state->have_numa_distance;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
     void *fdt = create_device_tree(&vms->fdt_size);
 
     if (!fdt) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 02c799f5b9..661f1a9a1f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -998,6 +998,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     MachineState *ms = MACHINE(pcms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
@@ -1676,6 +1677,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     int i;
     MachineState *ms = MACHINE(pcms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     pcms->apic_xrupt_override = kvm_allows_irq0_override();
     pcms->numa_nodes = nb_numa_nodes;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 28a6f18fde..a9f4b8e3fa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -347,6 +347,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     int nb_numa_nodes = machine->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = machine->numa_state->numa_info;
 
     if (nb_numa_nodes) {
         int i;
@@ -397,7 +398,7 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
     int nb_numa_nodes = machine->numa_state->nb_numa_nodes;
     hwaddr mem_start, node_size;
     int i, nb_nodes = nb_numa_nodes;
-    NodeInfo *nodes = numa_info;
+    NodeInfo *nodes = machine->numa_state->numa_info;
     NodeInfo ramnode;
 
     /* No NUMA nodes, assume there is just one node with whole RAM */
@@ -2476,6 +2477,7 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
 static void spapr_validate_node_memory(MachineState *machine, Error **errp)
 {
     int i;
+    NodeInfo *numa_info = machine->numa_state->numa_info;
 
     if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b63ed9d8da..8dcd95535c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1650,6 +1650,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    MachineState *ms = MACHINE(spapr);
+    NodeInfo *numa_info = ms->numa_state->numa_info;
     char *namebuf;
     int i;
     PCIBus *bus;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index cd7fe0f933..0e42a13ae2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -5,6 +5,7 @@
 
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
+#include "sysemu/sysemu.h"
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
@@ -232,12 +233,22 @@ typedef struct DeviceMemoryState {
     MemoryRegion mr;
 } DeviceMemoryState;
 
+struct NodeInfo {
+    uint64_t node_mem;
+    struct HostMemoryBackend *node_memdev;
+    bool present;
+    uint8_t distance[MAX_NODES];
+};
+
 typedef struct NumaState {
     /* Number of NUMA nodes */
     int nb_numa_nodes;
 
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
+
+    /* NUMA nodes information */
+    NodeInfo numa_info[MAX_NODES];
 } NumaState;
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 0d3920767a..5f0129b70f 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,19 +6,11 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-struct NodeInfo {
-    uint64_t node_mem;
-    struct HostMemoryBackend *node_memdev;
-    bool present;
-    uint8_t distance[MAX_NODES];
-};
-
 struct NumaNodeMem {
     uint64_t node_mem;
     uint64_t node_plugged_mem;
 };
 
-extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/numa.c b/numa.c
index a6d9951145..7fcebf0fcf 100644
--- a/numa.c
+++ b/numa.c
@@ -53,9 +53,6 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
 
-NodeInfo numa_info[MAX_NODES];
-
-
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
 {
@@ -63,6 +60,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     uint16_t nodenr;
     uint16List *cpus = NULL;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     if (node->has_nodeid) {
         nodenr = node->nodeid;
@@ -144,6 +142,7 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     uint16_t dst = dist->dst;
     uint8_t val = dist->val;
     MachineState *ms = MACHINE(qdev_get_machine());
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
@@ -198,7 +197,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             error_setg(&err, "Missing mandatory node-id property");
             goto end;
         }
-        if (!numa_info[object->u.cpu.node_id].present) {
+        if (!ms->numa_state->numa_info[object->u.cpu.node_id].present) {
             error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
                 "defined with -numa node,nodeid=ID before it's used with "
                 "-numa cpu,node-id=ID", object->u.cpu.node_id);
@@ -259,6 +258,7 @@ static void validate_numa_distance(void)
     bool is_asymmetrical = false;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     for (src = 0; src < nb_numa_nodes; src++) {
         for (dst = src; dst < nb_numa_nodes; dst++) {
@@ -301,6 +301,7 @@ static void complete_init_numa_distance(void)
     int src, dst;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -362,6 +363,7 @@ void numa_complete_configuration(MachineState *ms)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
     bool have_numa_distance = ms->numa_state->have_numa_distance;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -523,6 +525,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
     int i;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     if (nb_numa_nodes == 0 || !have_memdevs) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
@@ -593,6 +596,7 @@ void query_numa_node_mem(NumaNodeMem node_mem[])
     int i;
     MachineState *ms = MACHINE(qdev_get_machine());
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    NodeInfo *numa_info = ms->numa_state->numa_info;
 
     if (nb_numa_nodes <= 0) {
         return;
-- 
2.17.1
