Received: from eggs.gnu.org ([2001:4830:134:3::10]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe7-0002B0-IE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe1-0003Fy-L7
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:33 +1000
Message-Id: <20170908103558.31632-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/40] ppc: spapr: Rename cpu_dt_id to vcpu_id
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

This field actually records the VCPU ID used by KVM and, although the
value is also used in the device tree it is primarily the VCPU ID so
rename it as such.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
[dwg: Updated comment missed in cpu.h]
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c                |  8 ++++----
 hw/ppc/spapr.c              | 16 ++++++++--------
 hw/ppc/spapr_hcall.c        |  4 ++--
 hw/ppc/spapr_rtas.c         |  4 ++--
 target/ppc/cpu.h            | 16 ++++++++--------
 target/ppc/kvm.c            |  2 +-
 target/ppc/translate_init.c |  8 ++++----
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 224184d66d..4477d4ad89 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1359,19 +1359,19 @@ void PPC_debug_write (void *opaque, uint32_t addr, uint32_t val)
 }
 
 /* CPU device-tree ID helpers */
-int ppc_get_vcpu_dt_id(PowerPCCPU *cpu)
+int ppc_get_vcpu_id(PowerPCCPU *cpu)
 {
-    return cpu->cpu_dt_id;
+    return cpu->vcpu_id;
 }
 
-PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id)
+PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id)
 {
     CPUState *cs;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        if (cpu->cpu_dt_id == cpu_dt_id) {
+        if (cpu->vcpu_id == vcpu_id) {
             return cpu;
         }
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a0c5923776..f7a4c73e08 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -208,7 +208,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     int i, ret = 0;
     uint32_t servers_prop[smt_threads];
     uint32_t gservers_prop[smt_threads * 2];
-    int index = ppc_get_vcpu_dt_id(cpu);
+    int index = ppc_get_vcpu_id(cpu);
 
     if (cpu->compat_pvr) {
         ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
@@ -237,7 +237,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
 
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
-    int index = ppc_get_vcpu_dt_id(cpu);
+    int index = ppc_get_vcpu_id(cpu);
     uint32_t associativity[] = {cpu_to_be32(0x5),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
@@ -341,7 +341,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *env = &cpu->env;
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        int index = ppc_get_vcpu_dt_id(cpu);
+        int index = ppc_get_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
 
         if ((index % smt) != 0) {
@@ -493,7 +493,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
-    int index = ppc_get_vcpu_dt_id(cpu);
+    int index = ppc_get_vcpu_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
@@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
      */
     CPU_FOREACH_REVERSE(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        int index = ppc_get_vcpu_dt_id(cpu);
+        int index = ppc_get_vcpu_id(cpu);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
@@ -3025,7 +3025,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = ppc_get_vcpu_dt_id(cpu);
+    int id = ppc_get_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3433,9 +3433,9 @@ static void spapr_ics_resend(XICSFabric *dev)
     ics_resend(spapr->ics);
 }
 
-static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
+static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
 {
-    PowerPCCPU *cpu = ppc_get_vcpu_by_dt_id(cpu_dt_id);
+    PowerPCCPU *cpu = ppc_get_cpu_by_vcpu_id(vcpu_id);
 
     return cpu ? ICP(cpu->intc) : NULL;
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 07b3da8dc4..4ca233854a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -999,7 +999,7 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     CPUPPCState *tenv;
     PowerPCCPU *tcpu;
 
-    tcpu = ppc_get_vcpu_by_dt_id(procno);
+    tcpu = ppc_get_cpu_by_vcpu_id(procno);
     if (!tcpu) {
         return H_PARAMETER;
     }
@@ -1431,7 +1431,7 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
 
     } else {
         /* Unicast */
-        cs = CPU(ppc_get_vcpu_by_dt_id(target));
+        cs = CPU(ppc_get_cpu_by_vcpu_id(target));
         if (cs) {
             run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
             return H_SUCCESS;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 94a2799b99..626c06b375 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -104,7 +104,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
     }
 
     id = rtas_ld(args, 0);
-    cpu = ppc_get_vcpu_by_dt_id(id);
+    cpu = ppc_get_cpu_by_vcpu_id(id);
     if (cpu != NULL) {
         if (CPU(cpu)->halted) {
             rtas_st(rets, 1, 0);
@@ -158,7 +158,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
     start = rtas_ld(args, 1);
     r3 = rtas_ld(args, 2);
 
-    cpu = ppc_get_vcpu_by_dt_id(id);
+    cpu = ppc_get_cpu_by_vcpu_id(id);
     if (cpu != NULL) {
         CPUState *cs = CPU(cpu);
         CPUPPCState *env = &cpu->env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 12f09492fb..687e66acde 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1188,7 +1188,7 @@ typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
 /**
  * PowerPCCPU:
  * @env: #CPUPPCState
- * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
+ * @vcpu_id: vCPU identifier given to KVM
  * @compat_pvr: Current logical PVR, zero if in "raw" mode
  *
  * A PowerPC CPU.
@@ -1199,7 +1199,7 @@ struct PowerPCCPU {
     /*< public >*/
 
     CPUPPCState env;
-    int cpu_dt_id;
+    int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
@@ -2515,22 +2515,22 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
 
 /**
- * ppc_get_vcpu_dt_id:
+ * ppc_get_vcpu_id:
  * @cs: a PowerPCCPU struct.
  *
  * Returns a device-tree ID for a CPU.
  */
-int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
+int ppc_get_vcpu_id(PowerPCCPU *cpu);
 
 /**
- * ppc_get_vcpu_by_dt_id:
- * @cpu_dt_id: a device tree id
+ * ppc_get_cpu_by_vcpu_id:
+ * @vcpu_id: a VCPU ID
  *
- * Searches for a CPU by @cpu_dt_id.
+ * Searches for a CPU by @vcpu_id.
  *
  * Returns: a PowerPCCPU struct
  */
-PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
+PowerPCCPU *ppc_get_cpu_by_vcpu_id(int vcpu_id);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 #endif /* PPC_CPU_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f31c67e1b1..1142d5c970 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -520,7 +520,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
-    return ppc_get_vcpu_dt_id(POWERPC_CPU(cpu));
+    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
 }
 
 /* e500 supports 2 h/w breakpoint and 2 watchpoint.
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 43be9a8331..1586e28055 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9838,14 +9838,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    cpu->cpu_dt_id = (cs->cpu_index / smp_threads) * max_smt
+    cpu->vcpu_id = (cs->cpu_index / smp_threads) * max_smt
         + (cs->cpu_index % smp_threads);
 
-    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->cpu_dt_id)) {
-        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->cpu_dt_id);
+    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
+        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->vcpu_id);
         error_append_hint(errp, "Adjust the number of cpus to %d "
                           "or try to raise the number of threads per core\n",
-                          cpu->cpu_dt_id * smp_threads / max_smt);
+                          cpu->vcpu_id * smp_threads / max_smt);
         goto unrealize;
     }
 #endif
-- 
2.13.5
