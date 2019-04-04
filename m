Received: from eggs.gnu.org ([209.51.188.92]:56981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB5-0000xn-Ok
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB3-0000AN-HC
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:25555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hBtB3-0008QA-2M
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:33 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Thu,  4 Apr 2019 11:34:27 +0800
Message-Id: <20190404033429.17232-2-tao3.xu@intel.com>
In-Reply-To: <20190404033429.17232-1-tao3.xu@intel.com>
References: <20190404033429.17232-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 1/3] numa: move numa global variable
 nb_numa_nodes into MachineState
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

The aim of this patch is to add struct NumaState in MachineState
and move existing numa global nb_numa_nodes into NumaState.
And add variable numa_support into MachineClass to decide which
submachines support NUMA.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 exec.c                              |  2 ++
 hw/acpi/aml-build.c                 |  2 ++
 hw/arm/boot.c                       |  2 ++
 hw/arm/virt-acpi-build.c            |  6 +++++-
 hw/arm/virt.c                       |  5 ++++-
 hw/core/machine.c                   |  9 +++++++--
 hw/i386/pc.c                        |  7 ++++++-
 hw/mem/pc-dimm.c                    |  2 ++
 hw/pci-bridge/pci_expander_bridge.c |  2 ++
 hw/ppc/spapr.c                      | 19 +++++++++++++++----
 include/hw/boards.h                 |  7 +++++++
 include/sysemu/numa.h               |  1 -
 monitor.c                           |  2 ++
 numa.c                              | 15 ++++++++++++---
 14 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4eee..97314b3ba7 100644
--- a/exec.c
+++ b/exec.c
@@ -1708,6 +1708,8 @@ long qemu_getrampagesize(void)
     long hpsize = LONG_MAX;
     long mainrampagesize;
     Object *memdev_root;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     mainrampagesize = qemu_mempath_getpagesize(mem_path);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 555c24f21d..e4f062ca3f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1730,6 +1730,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker)
 {
     int slit_start, i, j;
     slit_start = table_data->len;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655e1a..d2326d76bb 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -532,6 +532,8 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     hwaddr mem_base, mem_len;
     char **node_path;
     Error *err = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     if (binfo->dtb_filename) {
         char *filename;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bf9c0bc2f4..f9b72333a9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -516,7 +516,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, srat_start;
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
-    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     srat_start = table_data->len;
     srat = acpi_data_push(table_data, sizeof(*srat));
@@ -780,6 +782,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
+    MachineState *ms = MACHINE(vms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce2664a30b..430189af1a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -195,6 +195,8 @@ static bool cpu_type_valid(const char *cpu)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    MachineState *ms = MACHINE(vms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
 
     if (!fdt) {
@@ -1780,7 +1782,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
 static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx % nb_numa_nodes;
+    return idx % ms->numa_state->nb_numa_nodes;
 }
 
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
@@ -1886,6 +1888,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    mc->numa_supported = true;
     hc->plug = virt_machine_device_plug_cb;
 }
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 743fef2898..d876b672ff 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -854,6 +854,10 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
 
+    if (mc->numa_supported) {
+        ms->numa_state = g_new0(NumaState, 1);
+    }
+
 
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify = machine_init_notify;
@@ -874,6 +878,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->firmware);
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
+    g_free(ms->numa_state);
 }
 
 bool machine_usb(MachineState *machine)
@@ -945,7 +950,7 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
 
-    assert(nb_numa_nodes);
+    assert(machine->numa_state->nb_numa_nodes);
     for (i = 0; i < possible_cpus->len; i++) {
         if (possible_cpus->cpus[i].props.has_node_id) {
             break;
@@ -992,7 +997,7 @@ void machine_run_board_init(MachineState *machine)
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     numa_complete_configuration(machine);
-    if (nb_numa_nodes) {
+    if (machine->numa_state->nb_numa_nodes) {
         machine_numa_finish_cpu_init(machine);
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6077d27361..02c799f5b9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -996,6 +996,8 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     int i;
     const CPUArchIdList *cpus;
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
@@ -1672,6 +1674,8 @@ void pc_machine_done(Notifier *notifier, void *data)
 void pc_guest_info_init(PCMachineState *pcms)
 {
     int i;
+    MachineState *ms = MACHINE(pcms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     pcms->apic_xrupt_override = kvm_allows_irq0_override();
     pcms->numa_nodes = nb_numa_nodes;
@@ -2650,7 +2654,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             smp_cores, smp_threads, &topo);
-   return topo.pkg_id % nb_numa_nodes;
+   return topo.pkg_id % ms->numa_state->nb_numa_nodes;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
@@ -2744,6 +2748,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
+    mc->numa_supported = true;
 
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..478803fc6d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -160,6 +160,8 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index e62de4218f..d136fc5ff7 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -217,6 +217,8 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     PCIBus *bus;
     const char *dev_name = NULL;
     Error *local_err = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= nb_numa_nodes) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b52b82d298..28a6f18fde 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -290,6 +290,8 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
     CPUState *cs;
     char cpu_model[32];
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -344,6 +346,8 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
 
 static hwaddr spapr_node0_size(MachineState *machine)
 {
+    int nb_numa_nodes = machine->numa_state->nb_numa_nodes;
+
     if (nb_numa_nodes) {
         int i;
         for (i = 0; i < nb_numa_nodes; ++i) {
@@ -390,6 +394,7 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
 static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state->nb_numa_nodes;
     hwaddr mem_start, node_size;
     int i, nb_nodes = nb_numa_nodes;
     NodeInfo *nodes = numa_info;
@@ -444,6 +449,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
     int index = spapr_get_vcpu_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
@@ -849,6 +856,7 @@ static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
 static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state->nb_numa_nodes;
     int ret, i, offset;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
@@ -1023,11 +1031,13 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     int rtas;
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
     uint32_t refpoints[] = { cpu_to_be32(0x4), cpu_to_be32(0x4) };
-    uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
-        memory_region_size(&MACHINE(spapr)->device_memory->mr);
+    uint64_t max_device_addr = ms->device_memory->base +
+        memory_region_size(&ms->device_memory->mr);
     uint32_t lrdr_capacity[] = {
         cpu_to_be32(max_device_addr >> 32),
         cpu_to_be32(max_device_addr & 0xffffffff),
@@ -2483,7 +2493,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
         return;
     }
 
-    for (i = 0; i < nb_numa_nodes; i++) {
+    for (i = 0; i < machine->numa_state->nb_numa_nodes; i++) {
         if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
@@ -4066,7 +4076,7 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
 
 static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx / smp_cores % nb_numa_nodes;
+    return idx / smp_cores % ms->numa_state->nb_numa_nodes;
 }
 
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
@@ -4266,6 +4276,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
+    mc->numa_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..2d4536b1a0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -211,6 +211,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
+    bool numa_supported;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
@@ -231,6 +232,11 @@ typedef struct DeviceMemoryState {
     MemoryRegion mr;
 } DeviceMemoryState;
 
+typedef struct NumaState {
+    /* Number of NUMA nodes */
+    int nb_numa_nodes;
+} NumaState;
+
 /**
  * MachineState:
  */
@@ -274,6 +280,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     struct NVDIMMState *nvdimms_state;
+    NumaState *numa_state;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b6ac7de43e..6c753f9ccf 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,7 +6,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;
 
 struct NodeInfo {
diff --git a/monitor.c b/monitor.c
index 4807bbe811..786a98bf2f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1908,6 +1908,8 @@ static void hmp_info_numa(Monitor *mon, const QDict *qdict)
     int i;
     NumaNodeMem *node_mem;
     CpuInfoList *cpu_list, *cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     cpu_list = qmp_query_cpus(&error_abort);
     node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
diff --git a/numa.c b/numa.c
index 3875e1efda..ff40f6f04f 100644
--- a/numa.c
+++ b/numa.c
@@ -52,7 +52,6 @@ static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-int nb_numa_nodes;
 bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
 
@@ -68,7 +67,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     if (node->has_nodeid) {
         nodenr = node->nodeid;
     } else {
-        nodenr = nb_numa_nodes;
+        nodenr = ms->numa_state->nb_numa_nodes;
     }
 
     if (nodenr >= MAX_NODES) {
@@ -136,7 +135,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
-    nb_numa_nodes++;
+    ms->numa_state->nb_numa_nodes++;
 }
 
 static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
@@ -256,6 +255,8 @@ static void validate_numa_distance(void)
 {
     int src, dst;
     bool is_asymmetrical = false;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     for (src = 0; src < nb_numa_nodes; src++) {
         for (dst = src; dst < nb_numa_nodes; dst++) {
@@ -296,6 +297,8 @@ static void validate_numa_distance(void)
 static void complete_init_numa_distance(void)
 {
     int src, dst;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -355,6 +358,7 @@ void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -440,6 +444,7 @@ void numa_complete_configuration(MachineState *ms)
             complete_init_numa_distance();
         }
     }
+    ms->numa_state->nb_numa_nodes = nb_numa_nodes;
 }
 
 void parse_numa_opts(MachineState *ms)
@@ -513,6 +518,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 {
     uint64_t addr = 0;
     int i;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     if (nb_numa_nodes == 0 || !have_memdevs) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
@@ -581,6 +588,8 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 void query_numa_node_mem(NumaNodeMem node_mem[])
 {
     int i;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     if (nb_numa_nodes <= 0) {
         return;
-- 
2.17.1
