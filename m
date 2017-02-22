Received: from eggs.gnu.org ([2001:4830:134:3::10]:38049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-00038p-S5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-0008C7-Po
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:38 +1100
Message-Id: <20170222063348.32176-34-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 33/43] pc: move pcms->possible_cpus init out of
 pc_cpus_init()
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

possible_cpus could be initialized earlier then cpu objects,
i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()
interface func and do initialization on the first call.

it should help later with making -numa cpu/-smp parsing a machine state
properties.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i386/pc.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 04c6e59..a187748 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1144,7 +1144,9 @@ void pc_cpus_init(PCMachineState *pcms)
     ObjectClass *oc;
     const char *typename;
     gchar **model_pieces;
+    const CPUArchIdList *possible_cpus;
     MachineState *machine = MACHINE(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
     /* init CPUs */
     if (machine->cpu_model == NULL) {
@@ -1179,14 +1181,9 @@ void pc_cpus_init(PCMachineState *pcms)
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
-    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                                       sizeof(CPUArchId) * max_cpus);
-    for (i = 0; i < max_cpus; i++) {
-        machine->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
-        machine->possible_cpus->len++;
-        if (i < smp_cpus) {
-            pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_fatal);
-        }
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < smp_cpus; i++) {
+        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -2254,10 +2251,26 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
     return topo.pkg_id;
 }
 
-static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
+static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
-    assert(machine->possible_cpus);
-    return machine->possible_cpus;
+    int i;
+
+    if (ms->possible_cpus) {
+        /*
+         * make sure that max_cpus hasn't changed since the first use, i.e.
+         * -smp hasn't been parsed after it
+        */
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (i = 0; i < ms->possible_cpus->len; i++) {
+        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+    }
+    return ms->possible_cpus;
 }
 
 static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
-- 
2.9.3
