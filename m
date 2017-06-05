Received: from eggs.gnu.org ([2001:4830:134:3::10]:32854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEF-0001ty-7w
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxEE-00083U-66
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxED-000838-TU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:23 -0300
Message-Id: <20170605185927.12111-7-ehabkost@redhat.com>
In-Reply-To: <20170605185927.12111-1-ehabkost@redhat.com>
References: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] numa: move numa_node from CPUState into
 target specific classes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Move vcpu's associated numa_node field out of generic CPUState
into inherited classes that actually care about cpu<->numa mapping,
i.e: ARMCPU, PowerPCCPU, X86CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1496161442-96665-6-git-send-email-imammedo@redhat.com>
[ehabkost: s/CPU is belonging to/CPU belongs to/ on comments]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h       | 2 --
 target/arm/cpu.h        | 2 ++
 target/i386/cpu.h       | 1 +
 target/ppc/cpu.h        | 1 +
 hw/ppc/spapr.c          | 2 +-
 hw/ppc/spapr_cpu_core.c | 4 +++-
 target/arm/cpu.c        | 2 +-
 target/i386/cpu.c       | 2 +-
 8 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 55214ce131..89ddb686fb 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -265,7 +265,6 @@ struct qemu_work_item;
  * @cpu_index: CPU index (informative).
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
- * @numa_node: NUMA node this CPU is belonging to.
  * @host_tid: Host thread ID.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
@@ -314,7 +313,6 @@ struct CPUState {
 
     int nr_cores;
     int nr_threads;
-    int numa_node;
 
     struct QemuThread *thread;
 #ifdef _WIN32
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 13da5036bc..16a1e59615 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -704,6 +704,8 @@ struct ARMCPU {
 
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
+
+    int32_t node_id; /* NUMA node this CPU belongs to */
 };
 
 static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4602ca80d..cfe825f0a4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1275,6 +1275,7 @@ struct X86CPU {
 
     struct kvm_msrs *kvm_msr_buf;
 
+    int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t core_id;
     int32_t thread_id;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 401e10e7da..d10808d9f4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1205,6 +1205,7 @@ struct PowerPCCPU {
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
+    int32_t node_id; /* NUMA node this CPU belongs to */
 
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 94563cd8f5..96471a5d89 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -191,7 +191,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
-                                cpu_to_be32(cs->numa_node),
+                                cpu_to_be32(cpu->node_id),
                                 cpu_to_be32(index)};
 
     /* Advertise NUMA via ibm,associativity */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ff7058ecc0..029a14120e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -184,15 +184,17 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < cc->nr_threads; i++) {
         char id[32];
         CPUState *cs;
+        PowerPCCPU *cpu;
 
         obj = sc->threads + i * size;
 
         object_initialize(obj, size, typename);
         cs = CPU(obj);
+        cpu = POWERPC_CPU(cs);
         cs->cpu_index = cc->core_id + i;
 
         /* Set NUMA node for the threads belonged to core  */
-        cs->numa_node = sc->node_id;
+        cpu->node_id = sc->node_id;
 
         snprintf(id, sizeof(id), "thread[%d]", i);
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e748097860..82d739f832 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1587,7 +1587,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
-    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a41d595c23..ffb5267162 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3986,7 +3986,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
-    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
     DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
-- 
2.11.0.259.g40922b1
