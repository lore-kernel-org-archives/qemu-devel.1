Received: from eggs.gnu.org ([2001:4830:134:3::10]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVG-0003Ex-NZ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVD-0008Fm-5V
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:40 +1100
Message-Id: <20170222063348.32176-36-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 35/43] pc: pass apic_id to pc_find_cpu_slot()
 directly so lookup could be done without CPU object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 50ba977..3475174 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1789,12 +1789,11 @@ static int pc_apic_cmp(const void *a, const void *b)
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
@@ -1810,6 +1809,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (pcms->acpi_dev) {
@@ -1829,7 +1829,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
@@ -1840,9 +1840,10 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
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
@@ -1867,6 +1868,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
@@ -1876,7 +1878,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = NULL;
     object_unparent(OBJECT(dev));
 
@@ -1934,7 +1936,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
     }
 
-    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), CPU(dev), &idx);
+    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-- 
2.9.3
