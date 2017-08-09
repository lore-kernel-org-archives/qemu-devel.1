Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfJi4-0001ls-Se
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfJi1-0006he-LZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:39:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48462
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dfJi1-0006hP-FZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:39:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v795d5pv084152
	for <qemu-devel@nongnu.org>; Wed, 9 Aug 2017 01:39:08 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c7uqs29au-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 01:39:08 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 9 Aug 2017 15:39:01 +1000
Date: Wed, 9 Aug 2017 15:38:56 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1502257087.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1502257087.git.sam.bobroff@au1.ibm.com>
Message-Id: <17e168d7cfb75dee8d4d898bc2dcac6f57dacb54.1502257087.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] ppc: spapr: Make VCPU ID handling
 private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

The concept of a VCPU ID that differs from the CPU's index
(cpu->cpu_index) exists only within SPAPR machines so, move the
functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
and rename them appropriately.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
Changes in v3:

* Implemented spapr_find_cpu() using spapr_vcpu_id() rather than direct access
  to vcpu_id.

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
index d6c9b3e334..cd6eb2d4a9 100644
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
 
@@ -2982,7 +2982,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = ppc_get_vcpu_id(cpu);
+    int id = spapr_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3392,7 +3392,7 @@ static void spapr_ics_resend(XICSFabric *dev)
 
 static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
 {
-    PowerPCCPU *cpu = ppc_get_cpu_by_vcpu_id(vcpu_id);
+    PowerPCCPU *cpu = spapr_find_cpu(vcpu_id);
 
     return cpu ? ICP(cpu->intc) : NULL;
 }
@@ -3412,6 +3412,32 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
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
index 2a303a705c..86c982cf2c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -704,4 +704,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
 
+int spapr_vcpu_id(PowerPCCPU *cpu);
+PowerPCCPU *spapr_find_cpu(int vcpu_id);
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2a3594dea5..abc729f029 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2513,23 +2513,5 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 
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
index 7ccb350c5f..5b2abee4da 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
-    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
+    return POWERPC_CPU(cpu)->vcpu_id;
 }
 
 /* e500 supports 2 h/w breakpoint and 2 watchpoint.
-- 
2.12.1.382.gc0f9c7058
