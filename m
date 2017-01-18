Received: from eggs.gnu.org ([2001:4830:134:3::10]:57101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoH-0002OY-K6
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoE-0007S1-61
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtoD-0007Rr-TJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:06 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:28 +0100
Message-Id: <1484759609-264075-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 12/13] pc: drop usage of legacy
 numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Replace usage of legacy cpu_index based node_cpu bitmaps
with PCMachineState.possible_cpus which have node-ids for
all possible CPUs.

As result:
 * -1 usage of global max_cpus
 * considering not set CPUArchId.props.node_id is 0
   drop not needed (numa_get_node_for_cpu(i) < nb_numa_nodes) checks,
   for the case where not all CPUs have been mapped to a numa,
   as it will have the same effect
 * -5 usage of global nb_numa_nodes

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/cpu.c        |  7 +++----
 hw/i386/acpi-build.c | 17 ++++++-----------
 hw/i386/pc.c         | 19 ++++++-------------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 6017ca0..ac63cb9 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -503,7 +503,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         /* build Processor object for each processor */
         for (i = 0; i < arch_ids->len; i++) {
-            int j;
             Aml *dev;
             Aml *uid = aml_int(i);
             GArray *madt_buf = g_array_new(0, 1, 1);
@@ -557,9 +556,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
              * as a result _PXM is required for all CPUs which might
              * be hot-plugged. For simplicity, add it for all CPUs.
              */
-            j = numa_get_node_for_cpu(i);
-            if (j < nb_numa_nodes) {
-                aml_append(dev, aml_name_decl("_PXM", aml_int(j)));
+            if (arch_ids->cpus[i].props.has_node_id) {
+                aml_append(dev, aml_name_decl("_PXM",
+                    aml_int(arch_ids->cpus[i].props.node_id)));
             }
 
             aml_append(cpus_dev, dev);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0c91043..d0dc8d9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2305,19 +2305,16 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     srat->reserved1 = cpu_to_le32(1);
 
     for (i = 0; i < apic_ids->len; i++) {
-        int j = numa_get_node_for_cpu(i);
-        uint32_t apic_id = apic_ids->cpus[i].arch_id;
+        const CPUArchId *cpu = &apic_ids->cpus[i];
 
-        if (apic_id < 255) {
+        if (cpu->arch_id < 255) {
             AcpiSratProcessorAffinity *core;
 
             core = acpi_data_push(table_data, sizeof *core);
             core->type = ACPI_SRAT_PROCESSOR_APIC;
             core->length = sizeof(*core);
-            core->local_apic_id = apic_id;
-            if (j < nb_numa_nodes) {
-                core->proximity_lo = j;
-            }
+            core->local_apic_id = cpu->arch_id;
+            core->proximity_lo = cpu->props.node_id;
             memset(core->proximity_hi, 0, 3);
             core->local_sapic_eid = 0;
             core->flags = cpu_to_le32(1);
@@ -2327,10 +2324,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
             core = acpi_data_push(table_data, sizeof *core);
             core->type = ACPI_SRAT_PROCESSOR_x2APIC;
             core->length = sizeof(*core);
-            core->x2apic_id = cpu_to_le32(apic_id);
-            if (j < nb_numa_nodes) {
-                core->proximity_domain = cpu_to_le32(j);
-            }
+            core->x2apic_id = cpu_to_le32(cpu->arch_id);
+            core->proximity_domain = cpu_to_le32(cpu->props.node_id);
             core->flags = cpu_to_le32(1);
         }
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5066339..e2833e0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -746,7 +746,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
-    int i, j;
+    int i;
 
     fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
@@ -781,13 +781,10 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
      */
     numa_fw_cfg = g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa_nodes);
     numa_fw_cfg[0] = cpu_to_le64(nb_numa_nodes);
-    for (i = 0; i < max_cpus; i++) {
-        unsigned int apic_id = x86_cpu_apic_id_from_index(i);
-        assert(apic_id < pcms->apic_id_limit);
-        j = numa_get_node_for_cpu(i);
-        if (j < nb_numa_nodes) {
-            numa_fw_cfg[apic_id + 1] = cpu_to_le64(j);
-        }
+    for (i = 0; i < pcms->possible_cpus->len; i++) {
+        const CPUArchId *cpu = &pcms->possible_cpus->cpus[i];
+        assert(cpu->arch_id < pcms->apic_id_limit);
+        numa_fw_cfg[cpu->arch_id + 1] = cpu_to_le64(cpu->props.node_id);
     }
     for (i = 0; i < nb_numa_nodes; i++) {
         numa_fw_cfg[pcms->apic_id_limit + 1 + i] =
@@ -1970,11 +1967,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cs = CPU(cpu);
     cs->cpu_index = idx;
-
-    idx = numa_get_node_for_cpu(cs->cpu_index);
-    if (idx < nb_numa_nodes) {
-        cpu->numa_nid = idx;
-    }
+    cpu->numa_nid = cpu_slot->props.node_id;
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
-- 
2.7.4
