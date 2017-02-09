Received: from eggs.gnu.org ([2001:4830:134:3::10]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmam-0001cf-87
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cbmal-00045f-5G
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 06:08:48 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  9 Feb 2017 12:08:33 +0100
Message-Id: <1486638518-171446-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] pc: move pcms->possible_cpus init out of
 pc_cpus_init()
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

possible_cpus could be initialized earlier then cpu objects,
i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()
interface func and do initialization on the first call.

it should help later with making -numa cpu/-smp parsing a machine state
properties.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cf2bec4..a6cfc97 100644
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
 
@@ -2248,10 +2245,26 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
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
2.7.4
