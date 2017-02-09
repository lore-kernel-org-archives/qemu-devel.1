Received: from eggs.gnu.org ([2001:4830:134:3::10]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmaq-0001fd-8a
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmap-0004EU-2l
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:52 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  9 Feb 2017 12:08:35 +0100
Message-Id: <1486638518-171446-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] pc: pass apic_id to pc_find_cpu_slot()
 directly so lookup could be done without CPU object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f03a555..ec6dded 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1783,12 +1783,11 @@ static int pc_apic_cmp(const void *a, const void *b)
  * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
  * entry corresponding to CPU's apic_id returns NULL.
  */
-static CPUArchId *pc_find_cpu_slot(MachineState *ms, CPUState *cpu, int *idx)
+static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchId apic_id, *found_cpu;
 
-    apic_id.arch_id = cc->get_arch_id(CPU(cpu));
+    apic_id.arch_id = id;
     found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
         ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
         pc_apic_cmp);
@@ -1804,6 +1803,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (pcms->acpi_dev) {
@@ -1823,7 +1823,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
@@ -1834,9 +1834,10 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     int idx = -1;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
+    pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
         error_setg(&local_err, "Boot CPU is unpluggable");
@@ -1861,6 +1862,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
@@ -1870,7 +1872,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = NULL;
     object_unparent(OBJECT(dev));
 
@@ -1928,7 +1930,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
     }
 
-    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
+    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-- 
2.7.4
