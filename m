Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9ct-0005G0-U5
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9cq-0007K9-Oc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dd9cq-0007J4-ES
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:28:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v736Scln069713
	for <qemu-devel@nongnu.org>; Thu, 3 Aug 2017 02:28:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3x4v1jv0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 02:28:50 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 3 Aug 2017 16:28:48 +1000
Date: Thu, 3 Aug 2017 16:28:44 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
Message-Id: <5777ef503c5c7f43f21981ed11c90fb7579ccfae.1501740002.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] ppc: spapr: Rename cpu_dt_id to vcpu_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de

This field actually records the VCPU ID used by KVM and, although the
value is also used in the device tree it is primarily the VCPU ID so
rename it as such.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/ppc.c                |  8 ++++----
 hw/ppc/spapr.c              | 16 ++++++++--------
 hw/ppc/spapr_hcall.c        |  4 ++--
 hw/ppc/spapr_rtas.c         |  4 ++--
 target/ppc/cpu.h            | 14 +++++++-------
 target/ppc/kvm.c            |  2 +-
 target/ppc/translate_init.c |  8 ++++----
 7 files changed, 28 insertions(+), 28 deletions(-)

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
index f7a19720dc..83c77096a6 100644
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
 
@@ -2982,7 +2982,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = ppc_get_vcpu_dt_id(cpu);
+    int id = ppc_get_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3390,9 +3390,9 @@ static void spapr_ics_resend(XICSFabric *dev)
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
index 6ee2a26a96..89f05542c6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1199,7 +1199,7 @@ struct PowerPCCPU {
     /*< public >*/
 
     CPUPPCState env;
-    int cpu_dt_id;
+    int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
@@ -2514,22 +2514,22 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
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
index 85713795de..7ccb350c5f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
-    return ppc_get_vcpu_dt_id(POWERPC_CPU(cpu));
+    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
 }
 
 /* e500 supports 2 h/w breakpoint and 2 watchpoint.
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 01723bdfec..a80e9ffdf8 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9828,14 +9828,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
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
2.12.1.382.gc0f9c7058
