Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF621C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF33920645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF33920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIqAP-00032a-1I
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 03:48:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8W-0001jK-Fg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8U-0002rq-GW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:31627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hIq8U-0002p2-8R
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 00:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,385,1549958400"; d="scan'208";a="163990254"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2019 00:46:36 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com,
	imammedo@redhat.com,
	pbonzini@redhat.com
Date: Tue, 23 Apr 2019 15:44:28 +0800
Message-Id: <20190423074428.23031-4-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423074428.23031-1-tao3.xu@intel.com>
References: <20190423074428.23031-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 3/3] numa: move numa global variable
 numa_info into MachineState
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
Message-ID: <20190423074428.4bx0wbQLTTTimkWXSGNOmAe6wwgUr8G6ML5PC7W4hdI@z>

The aim of this patch is to move existing numa global numa_info
(renamed as "nodes") into NumaState.

Changes in v3 -> v2:
    - rename the "NumaState::numa_info" as "NumaState::nodes" (Eduardo)

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 exec.c                   |  2 +-
 hw/acpi/aml-build.c      |  6 ++++--
 hw/arm/boot.c            |  2 +-
 hw/arm/virt-acpi-build.c |  7 ++++---
 hw/arm/virt.c            |  1 +
 hw/i386/pc.c             |  4 ++--
 hw/ppc/spapr.c           |  8 +++++++-
 hw/ppc/spapr_pci.c       |  2 ++
 include/hw/boards.h      | 10 ++++++++++
 include/sysemu/numa.h    |  8 --------
 numa.c                   | 15 +++++++++------
 11 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/exec.c b/exec.c
index 87f4da207d..6b3bda2766 100644
--- a/exec.c
+++ b/exec.c
@@ -1738,7 +1738,7 @@ long qemu_getrampagesize(void)
     if (hpsize > mainrampagesize &&
         (ms->numa_state == NULL ||
          ms->numa_state->num_nodes == 0 ||
-         numa_info[0].node_memdev == NULL)) {
+         ms->numa_state->nodes[0].node_memdev == NULL)) {
         static bool warned;
         if (!warned) {
             error_report("Huge page support disabled (n/a for main memory).");
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index c67f4561a4..b53a55cb56 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1737,8 +1737,10 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
     build_append_int_noprefix(table_data, nb_numa_nodes, 8);
     for (i = 0; i < nb_numa_nodes; i++) {
         for (j = 0; j < nb_numa_nodes; j++) {
-            assert(numa_info[i].distance[j]);
-            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
+            assert(ms->numa_state->nodes[i].distance[j]);
+            build_append_int_noprefix(table_data,
+                                      ms->numa_state->nodes[i].distance[j],
+                                      1);
         }
     }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 8ff08814fd..845b737ab9 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -602,7 +602,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     if (nb_numa_nodes > 0) {
         mem_base = binfo->loader_start;
         for (i = 0; i < nb_numa_nodes; i++) {
-            mem_len = numa_info[i].node_mem;
+            mem_len = ms->numa_state->nodes[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
             if (rc < 0) {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 65f070843c..b22c3d27ad 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -535,11 +535,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     mem_base = vms->memmap[VIRT_MEM].base;
     for (i = 0; i < nb_numa_nodes; ++i) {
-        if (numa_info[i].node_mem > 0) {
+        if (ms->numa_state->nodes[i].node_mem > 0) {
             numamem = acpi_data_push(table_data, sizeof(*numamem));
-            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
+            build_srat_memory(numamem, mem_base,
+                              ms->numa_state->nodes[i].node_mem, i,
                               MEM_AFFINITY_ENABLED);
-            mem_base += numa_info[i].node_mem;
+            mem_base += ms->numa_state->nodes[i].node_mem;
         }
     }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6cd5e13eb9..8a8fc0d9b4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -232,6 +232,7 @@ static void create_fdt(VirtMachineState *vms)
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
         uint32_t *matrix = g_malloc0(size);
         int idx, i, j;
+        NodeInfo *numa_info = ms->numa_state->nodes;
 
         for (i = 0; i < nb_numa_nodes; i++) {
             for (j = 0; j < nb_numa_nodes; j++) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a752594df2..4ace0ad893 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1040,7 +1040,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     }
     for (i = 0; i < nb_numa_nodes; i++) {
         numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
-            cpu_to_le64(numa_info[i].node_mem);
+            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
                      (1 + pcms->apic_id_limit + nb_numa_nodes) *
@@ -1682,7 +1682,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     pcms->node_mem = g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
     for (i = 0; i < nb_numa_nodes; i++) {
-        pcms->node_mem[i] = numa_info[i].node_mem;
+        pcms->node_mem[i] = ms->numa_state->nodes[i].node_mem;
     }
 
     pcms->machine_done.notify = pc_machine_done;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 23789256f7..7701cb1dac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -349,6 +349,7 @@ static hwaddr spapr_node0_size(MachineState *machine)
     int nb_numa_nodes = machine_num_numa_nodes(machine);
     if (nb_numa_nodes) {
         int i;
+        NodeInfo *numa_info = machine->numa_state->nodes;
         for (i = 0; i < nb_numa_nodes; ++i) {
             if (numa_info[i].node_mem) {
                 return MIN(pow2floor(numa_info[i].node_mem),
@@ -396,7 +397,9 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
     int nb_numa_nodes = machine_num_numa_nodes(machine);
     hwaddr mem_start, node_size;
     int i, nb_nodes = nb_numa_nodes;
-    NodeInfo *nodes = numa_info;
+    NodeInfo *nodes = machine->numa_state ?
+                      machine->numa_state->nodes :
+                      NULL;
     NodeInfo ramnode;
 
     /* No NUMA nodes, assume there is just one node with whole RAM */
@@ -2476,6 +2479,9 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
 {
     int i;
     int nb_numa_nodes = machine_num_numa_nodes(machine);
+    NodeInfo *numa_info = machine->numa_state ?
+                          machine->numa_state->nodes :
+                          NULL;
 
     if (machine->ram_size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f62e6833b8..d4378558d3 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1672,6 +1672,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    MachineState *ms = MACHINE(spapr);
+    NodeInfo *numa_info = ms->numa_state ? ms->numa_state->nodes : NULL;
     char *namebuf;
     int i;
     PCIBus *bus;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index c3ff2dbd4a..e2676009fe 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -234,12 +234,22 @@ typedef struct DeviceMemoryState {
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
     int num_nodes;
 
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
+
+    /* NUMA nodes information */
+    NodeInfo nodes[MAX_NODES];
 } NumaState;
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 1a29408db9..7b8011f9ea 100644
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
 void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
diff --git a/numa.c b/numa.c
index d4f5ff5193..ddea376d72 100644
--- a/numa.c
+++ b/numa.c
@@ -52,8 +52,6 @@ static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-NodeInfo numa_info[MAX_NODES];
-
 
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
@@ -62,6 +60,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     uint16_t nodenr;
     uint16List *cpus = NULL;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     if (node->has_nodeid) {
         nodenr = node->nodeid;
@@ -143,6 +142,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     uint16_t src = dist->src;
     uint16_t dst = dist->dst;
     uint8_t val = dist->val;
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
@@ -201,7 +201,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             error_setg(&err, "Missing mandatory node-id property");
             goto end;
         }
-        if (!numa_info[object->u.cpu.node_id].present) {
+        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
             error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
                 "defined with -numa node,nodeid=ID before it's used with "
                 "-numa cpu,node-id=ID", object->u.cpu.node_id);
@@ -261,6 +261,7 @@ static void validate_numa_distance(MachineState *ms)
     int src, dst;
     bool is_asymmetrical = false;
     int nb_numa_nodes = machine_num_numa_nodes(ms);
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     for (src = 0; src < nb_numa_nodes; src++) {
         for (dst = src; dst < nb_numa_nodes; dst++) {
@@ -302,6 +303,7 @@ static void complete_init_numa_distance(MachineState *ms)
 {
     int src, dst;
     int nb_numa_nodes = machine_num_numa_nodes(ms);
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -361,6 +363,7 @@ void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    NodeInfo *numa_info = ms->numa_state->nodes;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -532,8 +535,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 
     memory_region_init(mr, owner, name, ram_size);
     for (i = 0; i < nb_numa_nodes; i++) {
-        uint64_t size = numa_info[i].node_mem;
-        HostMemoryBackend *backend = numa_info[i].node_memdev;
+        uint64_t size = ms->numa_state->nodes[i].node_mem;
+        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
         if (!backend) {
             continue;
         }
@@ -599,7 +602,7 @@ void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
 
     numa_stat_memory_devices(node_mem);
     for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        node_mem[i].node_mem += numa_info[i].node_mem;
+        node_mem[i].node_mem += ms->numa_state->nodes[i].node_mem;
     }
 }
 
-- 
2.17.1


