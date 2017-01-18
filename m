Received: from eggs.gnu.org ([2001:4830:134:3::10]:56880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnx-00024b-7U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnw-0007J3-8H
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtnv-0007Ia-W3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:48 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:21 +0100
Message-Id: <1484759609-264075-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 05/13] pc: move pcms->possible_cpus init out of
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
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

possible_cpus could be initialized earlier then cpu objects,
i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()
interface func and do initialization on the first call.

it should help later with making -numa cpu/-smp parsing a machine state
properties.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a2ab7fb..7ec5304 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1143,7 +1143,9 @@ void pc_cpus_init(PCMachineState *pcms)
     ObjectClass *oc;
     const char *typename;
     gchar **model_pieces;
+    const CPUArchIdList *possible_cpus;
     MachineState *machine = MACHINE(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
     /* init CPUs */
     if (machine->cpu_model == NULL) {
@@ -1178,14 +1180,9 @@ void pc_cpus_init(PCMachineState *pcms)
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
-    pcms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                                    sizeof(CPUArchId) * max_cpus);
-    for (i = 0; i < max_cpus; i++) {
-        pcms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
-        pcms->possible_cpus->len++;
-        if (i < smp_cpus) {
-            pc_new_cpu(typename, x86_cpu_apic_id_from_index(i), &error_fatal);
-        }
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < smp_cpus; i++) {
+        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -2248,7 +2245,21 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    assert(pcms->possible_cpus);
+    if (!pcms->possible_cpus) {
+        int i;
+        CPUArchIdList *possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                                 sizeof(CPUArchId) * max_cpus);
+        possible_cpus->len = max_cpus;
+        for (i = 0; i < max_cpus; i++) {
+            possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        }
+        pcms->possible_cpus = possible_cpus;
+    }
+    /*
+     * make sure that max_cpus hasn't changed since the first use, i.e.
+     * -smp hasn't been parsed after it
+     */
+    assert(pcms->possible_cpus->len == max_cpus);
     return pcms->possible_cpus;
 }
 
-- 
2.7.4
