Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E5C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2230B217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2230B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH12X-0000Cn-AG
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 03:00:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH10Q-0007Gj-SL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH0qT-00060y-2J
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:17089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hH0qS-0005vo-Lm
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Apr 2019 23:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; d="scan'208";a="136790435"
Received: from vmmtaopc.sh.intel.com ([10.239.13.92])
	by orsmga006.jf.intel.com with ESMTP; 17 Apr 2019 23:48:20 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	ehabkost@redhat.com,
	pbonzini@redhat.com
Date: Thu, 18 Apr 2019 14:46:00 +0800
Message-Id: <20190418064602.24558-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418064602.24558-1-tao3.xu@intel.com>
References: <20190418064602.24558-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v2 1/3] numa: move numa global variable
 nb_numa_nodes into MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418064600.R9N0TDpHpT_s3dIei2NJP7qpAfN2jOazfN2uoszLCkw@z>

The aim of this patch is to add struct NumaState in MachineState
and move existing numa global nb_numa_nodes into NumaState.
And add variable numa_support into MachineClass to decide which
submachines support NUMA.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 exec.c                              |  5 ++-
 hw/acpi/aml-build.c                 |  3 +-
 hw/arm/boot.c                       |  2 ++
 hw/arm/virt-acpi-build.c            |  8 +++--
 hw/arm/virt.c                       |  5 ++-
 hw/core/machine.c                   | 16 +++++++---
 hw/i386/acpi-build.c                |  2 +-
 hw/i386/pc.c                        |  7 ++++-
 hw/mem/pc-dimm.c                    |  2 ++
 hw/pci-bridge/pci_expander_bridge.c |  2 ++
 hw/ppc/spapr.c                      | 26 +++++++++++++--
 include/hw/acpi/aml-build.h         |  2 +-
 include/hw/boards.h                 |  9 ++++++
 include/sysemu/numa.h               |  3 +-
 monitor.c                           |  4 ++-
 numa.c                              | 49 ++++++++++++++++-------------
 16 files changed, 106 insertions(+), 39 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4eee..d0b59a4ae0 100644
--- a/exec.c
+++ b/exec.c
@@ -1708,6 +1708,7 @@ long qemu_getrampagesize(void)
     long hpsize = LONG_MAX;
     long mainrampagesize;
     Object *memdev_root;
+    MachineState *ms = MACHINE(qdev_get_machine());
 
     mainrampagesize = qemu_mempath_getpagesize(mem_path);
 
@@ -1735,7 +1736,9 @@ long qemu_getrampagesize(void)
      * so if its page size is smaller we have got to report that size instead.
      */
     if (hpsize > mainrampagesize &&
-        (nb_numa_nodes == 0 || numa_info[0].node_memdev == NULL)) {
+        (ms->numa_state == NULL ||
+         ms->numa_state->nb_numa_nodes == 0 ||
+         numa_info[0].node_memdev == NULL)) {
         static bool warned;
         if (!warned) {
             error_report("Huge page support disabled (n/a for main memory).");
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 555c24f21d..f1e50742cd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1726,10 +1726,11 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
  */
-void build_slit(GArray *table_data, BIOSLinker *linker)
+void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
 {
     int slit_start, i, j;
     slit_start = table_data->len;
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655e1a..2745880bd1 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -532,6 +532,8 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     hwaddr mem_base, mem_len;
     char **node_path;
     Error *err = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     if (binfo->dtb_filename) {
         char *filename;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bf9c0bc2f4..88722e0746 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -516,7 +516,9 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     int i, srat_start;
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
-    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(MACHINE(vms));
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     srat_start = table_data->len;
     srat = acpi_data_push(table_data, sizeof(*srat));
@@ -780,6 +782,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
+    MachineState *ms = MACHINE(vms);
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -813,7 +817,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         build_srat(tables_blob, tables->linker, vms);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            build_slit(tables_blob, tables->linker, ms);
         }
     }
 
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
index 743fef2898..99ad8dca83 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -854,6 +854,11 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
 
+    if (mc->numa_supported) {
+        ms->numa_state = g_new0(NumaState, 1);
+    } else {
+        ms->numa_state = NULL;
+    }
 
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify = machine_init_notify;
@@ -874,6 +879,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->firmware);
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
+    g_free(ms->numa_state);
 }
 
 bool machine_usb(MachineState *machine)
@@ -945,7 +951,7 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
 
-    assert(nb_numa_nodes);
+    assert(machine->numa_state->nb_numa_nodes);
     for (i = 0; i < possible_cpus->len; i++) {
         if (possible_cpus->cpus[i].props.has_node_id) {
             break;
@@ -991,9 +997,11 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
-    numa_complete_configuration(machine);
-    if (nb_numa_nodes) {
-        machine_numa_finish_cpu_init(machine);
+    if (machine_class->numa_supported) {
+        numa_complete_configuration(machine);
+        if (machine->numa_state->nb_numa_nodes) {
+            machine_numa_finish_cpu_init(machine);
+        }
     }
 
     /* If the machine supports the valid_cpu_types check and the user
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 416da318ae..7d9bc88ac9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2687,7 +2687,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
         build_srat(tables_blob, tables->linker, machine);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            build_slit(tables_blob, tables->linker, machine);
         }
     }
     if (acpi_get_mcfg(&mcfg)) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2..b3b7e96090 100644
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
@@ -2655,7 +2659,7 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             smp_cores, smp_threads, &topo);
-   return topo.pkg_id % nb_numa_nodes;
+   return topo.pkg_id % ms->numa_state->nb_numa_nodes;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
@@ -2749,6 +2753,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
+    mc->numa_supported = true;
 
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..af25f4b568 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -160,6 +160,8 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index e62de4218f..b4a60de234 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -217,6 +217,8 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     PCIBus *bus;
     const char *dev_name = NULL;
     Error *local_err = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= nb_numa_nodes) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b52b82d298..e2825523fd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -290,6 +290,8 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
     CPUState *cs;
     char cpu_model[32];
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -344,6 +346,9 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
 
 static hwaddr spapr_node0_size(MachineState *machine)
 {
+    int nb_numa_nodes = machine->numa_state ?
+                        machine->numa_state->nb_numa_nodes :
+                        0;
     if (nb_numa_nodes) {
         int i;
         for (i = 0; i < nb_numa_nodes; ++i) {
@@ -390,6 +395,9 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
 static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state ?
+                        machine->numa_state->nb_numa_nodes :
+                        0;
     hwaddr mem_start, node_size;
     int i, nb_nodes = nb_numa_nodes;
     NodeInfo *nodes = numa_info;
@@ -444,6 +452,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
     int index = spapr_get_vcpu_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
@@ -849,6 +859,9 @@ static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
 static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state ?
+                        machine->numa_state->nb_numa_nodes :
+                        0;
     int ret, i, offset;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
@@ -1023,11 +1036,13 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     int rtas;
+    MachineState *ms = MACHINE(spapr);
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
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
@@ -2466,6 +2481,9 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
 static void spapr_validate_node_memory(MachineState *machine, Error **errp)
 {
     int i;
+    int nb_numa_nodes = machine->numa_state ?
+                        machine->numa_state->nb_numa_nodes :
+                        0;
 
     if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
@@ -4066,7 +4084,8 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
 
 static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx / smp_cores % nb_numa_nodes;
+    return idx / smp_cores %
+           (ms->numa_state ? ms->numa_state->nb_numa_nodes : 0);
 }
 
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
@@ -4266,6 +4285,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
+    mc->numa_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 1a563ad756..991cf05134 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -414,7 +414,7 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-void build_slit(GArray *table_data, BIOSLinker *linker);
+void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..c4e8bb2437 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -5,6 +5,7 @@
 
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
+#include "sysemu/sysemu.h"
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
@@ -211,6 +212,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
+    bool numa_supported;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
@@ -231,6 +233,12 @@ typedef struct DeviceMemoryState {
     MemoryRegion mr;
 } DeviceMemoryState;
 
+typedef struct NumaState {
+    /* Number of NUMA nodes */
+    int nb_numa_nodes;
+
+} NumaState;
+
 /**
  * MachineState:
  */
@@ -274,6 +282,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     struct NVDIMMState *nvdimms_state;
+    NumaState *numa_state;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b6ac7de43e..a55e2be563 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,7 +6,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;
 
 struct NodeInfo {
@@ -24,7 +23,7 @@ struct NumaNodeMem {
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
-void query_numa_node_mem(NumaNodeMem node_mem[]);
+void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
 void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
diff --git a/monitor.c b/monitor.c
index 4807bbe811..fa5dbb589b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1908,11 +1908,13 @@ static void hmp_info_numa(Monitor *mon, const QDict *qdict)
     int i;
     NumaNodeMem *node_mem;
     CpuInfoList *cpu_list, *cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     cpu_list = qmp_query_cpus(&error_abort);
     node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
 
-    query_numa_node_mem(node_mem);
+    query_numa_node_mem(node_mem, ms);
     monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
     for (i = 0; i < nb_numa_nodes; i++) {
         monitor_printf(mon, "node %d cpus:", i);
diff --git a/numa.c b/numa.c
index 3875e1efda..4cc4d5ff5c 100644
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
@@ -136,10 +135,11 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
-    nb_numa_nodes++;
+    ms->numa_state->nb_numa_nodes++;
 }
 
-static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
+static
+void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
 {
     uint16_t src = dist->src;
     uint16_t dst = dist->dst;
@@ -187,7 +187,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
         }
         break;
     case NUMA_OPTIONS_TYPE_DIST:
-        parse_numa_distance(&object->u.dist, &err);
+        parse_numa_distance(ms, &object->u.dist, &err);
         if (err) {
             goto end;
         }
@@ -252,10 +252,11 @@ end:
  * distance from a node to itself is always NUMA_DISTANCE_MIN,
  * so providing it is never necessary.
  */
-static void validate_numa_distance(void)
+static void validate_numa_distance(MachineState *ms)
 {
     int src, dst;
     bool is_asymmetrical = false;
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     for (src = 0; src < nb_numa_nodes; src++) {
         for (dst = src; dst < nb_numa_nodes; dst++) {
@@ -293,9 +294,10 @@ static void validate_numa_distance(void)
     }
 }
 
-static void complete_init_numa_distance(void)
+static void complete_init_numa_distance(MachineState *ms)
 {
     int src, dst;
+    int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
 
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -369,7 +371,7 @@ void numa_complete_configuration(MachineState *ms)
      *
      * Enable NUMA implicitly by adding a new NUMA node automatically.
      */
-    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
+    if (ms->ram_slots > 0 && ms->numa_state->nb_numa_nodes == 0 &&
         mc->auto_enable_numa_with_memhp) {
             NumaNodeOptions node = { };
             parse_numa_node(ms, &node, &error_abort);
@@ -387,30 +389,33 @@ void numa_complete_configuration(MachineState *ms)
     }
 
     /* This must be always true if all nodes are present: */
-    assert(nb_numa_nodes == max_numa_nodeid);
+    assert(ms->numa_state->nb_numa_nodes == max_numa_nodeid);
 
-    if (nb_numa_nodes > 0) {
+    if (ms->numa_state->nb_numa_nodes > 0) {
         uint64_t numa_total;
 
-        if (nb_numa_nodes > MAX_NODES) {
-            nb_numa_nodes = MAX_NODES;
+        if (ms->numa_state->nb_numa_nodes > MAX_NODES) {
+            ms->numa_state->nb_numa_nodes = MAX_NODES;
         }
 
         /* If no memory size is given for any node, assume the default case
          * and distribute the available memory equally across all nodes
          */
-        for (i = 0; i < nb_numa_nodes; i++) {
+        for (i = 0; i < ms->numa_state->nb_numa_nodes; i++) {
             if (numa_info[i].node_mem != 0) {
                 break;
             }
         }
-        if (i == nb_numa_nodes) {
+        if (i == ms->numa_state->nb_numa_nodes) {
             assert(mc->numa_auto_assign_ram);
-            mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
+            mc->numa_auto_assign_ram(mc,
+                                     numa_info,
+                                     ms->numa_state->nb_numa_nodes,
+                                     ram_size);
         }
 
         numa_total = 0;
-        for (i = 0; i < nb_numa_nodes; i++) {
+        for (i = 0; i < ms->numa_state->nb_numa_nodes; i++) {
             numa_total += numa_info[i].node_mem;
         }
         if (numa_total != ram_size) {
@@ -434,10 +439,10 @@ void numa_complete_configuration(MachineState *ms)
          */
         if (have_numa_distance) {
             /* Validate enough NUMA distance information was provided. */
-            validate_numa_distance();
+            validate_numa_distance(ms);
 
             /* Validation succeeded, now fill in any missing distances. */
-            complete_init_numa_distance();
+            complete_init_numa_distance(ms);
         }
     }
 }
@@ -513,6 +518,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 {
     uint64_t addr = 0;
     int i;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
 
     if (nb_numa_nodes == 0 || !have_memdevs) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
@@ -578,16 +585,16 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
     qapi_free_MemoryDeviceInfoList(info_list);
 }
 
-void query_numa_node_mem(NumaNodeMem node_mem[])
+void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
 {
     int i;
 
-    if (nb_numa_nodes <= 0) {
+    if (ms->numa_state == NULL || ms->numa_state->nb_numa_nodes <= 0) {
         return;
     }
 
     numa_stat_memory_devices(node_mem);
-    for (i = 0; i < nb_numa_nodes; i++) {
+    for (i = 0; i < ms->numa_state->nb_numa_nodes; i++) {
         node_mem[i].node_mem += numa_info[i].node_mem;
     }
 }
-- 
2.17.1


