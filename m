Received: from eggs.gnu.org ([2001:4830:134:3::10]:56904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnz-00026y-Nm
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtny-0007Jp-Kh
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtny-0007JW-CT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:50 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:22 +0100
Message-Id: <1484759609-264075-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 06/13] pc: calculate topology only once when
 possible_cpus is initialised
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
 include/hw/boards.h |  1 +
 hw/i386/pc.c        | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ac891a8..6364617 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -49,6 +49,7 @@ void machine_register_compat_props(MachineState *machine);
  */
 typedef struct {
     uint64_t arch_id;
+    CpuInstanceProperties props;
     struct CPUState *cpu;
 } CPUArchId;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7ec5304..ed41046 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2251,7 +2251,18 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
                                                  sizeof(CPUArchId) * max_cpus);
         possible_cpus->len = max_cpus;
         for (i = 0; i < max_cpus; i++) {
+            X86CPUTopoInfo topo;
+            CpuInstanceProperties *cpu_props = &possible_cpus->cpus[i].props;
+
             possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+            x86_topo_ids_from_apicid(possible_cpus->cpus[i].arch_id,
+                                     smp_cores, smp_threads, &topo);
+            cpu_props->has_socket_id = true;
+            cpu_props->socket_id = topo.pkg_id;
+            cpu_props->has_core_id = true;
+            cpu_props->core_id = topo.core_id;
+            cpu_props->has_thread_id = true;
+            cpu_props->thread_id = topo.smt_id;
         }
         pcms->possible_cpus = possible_cpus;
     }
@@ -2276,23 +2287,13 @@ static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
     cpu_type = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(cpu)));
 
     for (i = 0; i < pcms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
         HotpluggableCPUList *list_item = g_new0(typeof(*list_item), 1);
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
-        CpuInstanceProperties *cpu_props = g_new0(typeof(*cpu_props), 1);
-        const uint32_t apic_id = pcms->possible_cpus->cpus[i].arch_id;
-
-        x86_topo_ids_from_apicid(apic_id, smp_cores, smp_threads, &topo);
 
         cpu_item->type = g_strdup(cpu_type);
         cpu_item->vcpus_count = 1;
-        cpu_props->has_socket_id = true;
-        cpu_props->socket_id = topo.pkg_id;
-        cpu_props->has_core_id = true;
-        cpu_props->core_id = topo.core_id;
-        cpu_props->has_thread_id = true;
-        cpu_props->thread_id = topo.smt_id;
-        cpu_item->props = cpu_props;
+        cpu_item->props = g_memdup(&pcms->possible_cpus->cpus[i].props,
+                                   sizeof(*cpu_item->props));
 
         cpu = pcms->possible_cpus->cpus[i].cpu;
         if (cpu) {
-- 
2.7.4
