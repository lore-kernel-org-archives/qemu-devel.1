Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-00029E-UM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe0-0003EO-GE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:34 +1000
Message-Id: <20170908103558.31632-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/40] ppc: spapr: Make VCPU ID handling private
 to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

The concept of a VCPU ID that differs from the CPU's index
(cpu->cpu_index) exists only within SPAPR machines so, move the
functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
and rename them appropriately.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c           | 21 ---------------------
 hw/ppc/spapr.c         | 40 +++++++++++++++++++++++++++++++++-------
 hw/ppc/spapr_hcall.c   |  4 ++--
 hw/ppc/spapr_rtas.c    |  4 ++--
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/cpu.h       | 18 ------------------
 target/ppc/kvm.c       |  2 +-
 7 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4477d4ad89..f76886f4d3 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1358,27 +1358,6 @@ void PPC_debug_write (void *opaque, uint32_t addr, uint32_t val)
     }
 }
 
-/* CPU device-tree ID helpers */
-int ppc_get_vcpu_id(PowerPCCPU *cpu)
-{
-    return cpu->vcpu_id;
-}
-
-PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        if (cpu->vcpu_id == vcpu_id) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
 void ppc_cpu_parse_features(const char *cpu_model)
 {
     CPUClass *cc;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a4c73e08..067f571416 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -208,7 +208,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     int i, ret = 0;
     uint32_t servers_prop[smt_threads];
     uint32_t gservers_prop[smt_threads * 2];
-    int index = ppc_get_vcpu_id(cpu);
+    int index = spapr_vcpu_id(cpu);
 
     if (cpu->compat_pvr) {
         ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
@@ -237,7 +237,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
 
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
-    int index = ppc_get_vcpu_id(cpu);
+    int index = spapr_vcpu_id(cpu);
     uint32_t associativity[] = {cpu_to_be32(0x5),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
@@ -341,7 +341,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        int index = ppc_get_vcpu_id(cpu);
+        int index = spapr_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
 
         if ((index % smt) != 0) {
@@ -493,7 +493,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
-    int index = ppc_get_vcpu_id(cpu);
+    int index = spapr_vcpu_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
@@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
      */
     CPU_FOREACH_REVERSE(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        int index = ppc_get_vcpu_id(cpu);
+        int index = spapr_vcpu_id(cpu);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
@@ -3025,7 +3025,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = ppc_get_vcpu_id(cpu);
+    int id = spapr_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3435,7 +3435,7 @@ static void spapr_ics_resend(XICSFabric *dev)
 
 static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
 {
-    PowerPCCPU *cpu = ppc_get_cpu_by_vcpu_id(vcpu_id);
+    PowerPCCPU *cpu = spapr_find_cpu(vcpu_id);
 
     return cpu ? ICP(cpu->intc) : NULL;
 }
@@ -3455,6 +3455,32 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
     ics_pic_print_info(spapr->ics, mon);
 }
 
+int spapr_vcpu_id(PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (kvm_enabled()) {
+        return kvm_arch_vcpu_id(cs);
+    } else {
+        return cs->cpu_index;
+    }
+}
+
+PowerPCCPU *spapr_find_cpu(int vcpu_id)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+        if (spapr_vcpu_id(cpu) == vcpu_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4ca233854a..7cf0993800 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -999,7 +999,7 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     CPUPPCState *tenv;
     PowerPCCPU *tcpu;
 
-    tcpu = ppc_get_cpu_by_vcpu_id(procno);
+    tcpu = spapr_find_cpu(procno);
     if (!tcpu) {
         return H_PARAMETER;
     }
@@ -1431,7 +1431,7 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
 
     } else {
         /* Unicast */
-        cs = CPU(ppc_get_cpu_by_vcpu_id(target));
+        cs = CPU(spapr_find_cpu(target));
         if (cs) {
             run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
             return H_SUCCESS;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 626c06b375..cdf0b607a0 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -104,7 +104,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     }
 
     id = rtas_ld(args, 0);
-    cpu = ppc_get_cpu_by_vcpu_id(id);
+    cpu = spapr_find_cpu(id);
     if (cpu != NULL) {
         if (CPU(cpu)->halted) {
             rtas_st(rets, 1, 0);
@@ -158,7 +158,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
     start = rtas_ld(args, 1);
     r3 = rtas_ld(args, 2);
 
-    cpu = ppc_get_cpu_by_vcpu_id(id);
+    cpu = spapr_find_cpu(id);
     if (cpu != NULL) {
         CPUState *cs = CPU(cpu);
         CPUPPCState *env = &cpu->env;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5d161ec580..91617e3277 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -705,4 +705,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
 
+int spapr_vcpu_id(PowerPCCPU *cpu);
+PowerPCCPU *spapr_find_cpu(int vcpu_id);
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 687e66acde..cf4ded7b8e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2514,23 +2514,5 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
 
-/**
- * ppc_get_vcpu_id:
- * @cs: a PowerPCCPU struct.
- *
- * Returns a device-tree ID for a CPU.
- */
-int ppc_get_vcpu_id(PowerPCCPU *cpu);
-
-/**
- * ppc_get_cpu_by_vcpu_id:
- * @vcpu_id: a VCPU ID
- *
- * Searches for a CPU by @vcpu_id.
- *
- * Returns: a PowerPCCPU struct
- */
-PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id);
-
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 #endif /* PPC_CPU_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1142d5c970..f1d54106ac 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -520,7 +520,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
-    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
+    return POWERPC_CPU(cpu)->vcpu_id;
 }
 
 /* e500 supports 2 h/w breakpoint and 2 watchpoint.
-- 
2.13.5
