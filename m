Received: from eggs.gnu.org ([2001:4830:134:3::10]:56985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto6-0002Ct-6K
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto1-0007LU-4Y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTto0-0007Kw-Sl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:53 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:23 +0100
Message-Id: <1484759609-264075-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 07/13] pc: pass apic_id to pc_find_cpu_slot()
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
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ed41046..f8ea635 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1776,13 +1776,12 @@ static int pc_apic_cmp(const void *a, const void *b)
  * in pcms->possible_cpus->cpus, if pcms->possible_cpus->cpus has no
  * entry correponding to CPU's apic_id returns NULL.
  */
-static CPUArchId *pc_find_cpu_slot(PCMachineState *pcms, CPUState *cpu,
+static CPUArchId *pc_find_cpu_slot(PCMachineState *pcms, uint32_t id,
                                    int *idx)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchId apic_id, *found_cpu;
 
-    apic_id.arch_id = cc->get_arch_id(CPU(cpu));
+    apic_id.arch_id = id;
     found_cpu = bsearch(&apic_id, pcms->possible_cpus->cpus,
         pcms->possible_cpus->len, sizeof(*pcms->possible_cpus->cpus),
         pc_apic_cmp);
@@ -1798,6 +1797,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (pcms->acpi_dev) {
@@ -1817,7 +1817,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    found_cpu = pc_find_cpu_slot(pcms, CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(pcms, cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
@@ -1828,9 +1828,10 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     int idx = -1;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    pc_find_cpu_slot(pcms, CPU(dev), &idx);
+    pc_find_cpu_slot(pcms, cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
         error_setg(&local_err, "Boot CPU is unpluggable");
@@ -1855,6 +1856,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     CPUArchId *found_cpu;
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
@@ -1864,7 +1866,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    found_cpu = pc_find_cpu_slot(pcms, CPU(dev), NULL);
+    found_cpu = pc_find_cpu_slot(pcms, cpu->apic_id, NULL);
     found_cpu->cpu = NULL;
     object_unparent(OBJECT(dev));
 
@@ -1922,7 +1924,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         cpu->apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
     }
 
-    cpu_slot = pc_find_cpu_slot(pcms, CPU(dev), &idx);
+    cpu_slot = pc_find_cpu_slot(pcms, cpu->apic_id, &idx);
     if (!cpu_slot) {
         x86_topo_ids_from_apicid(cpu->apic_id, smp_cores, smp_threads, &topo);
         error_setg(errp, "Invalid CPU [socket: %u, core: %u, thread: %u] with"
-- 
2.7.4
