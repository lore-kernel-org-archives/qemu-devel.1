Received: from eggs.gnu.org ([2001:4830:134:3::10]:46216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0002ug-5z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjw-0006Ss-Cy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:38 +1100
Message-Id: <20170112020327.24882-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/67] ppc: Rename cpu_version to compat_pvr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The 'cpu_version' field in PowerPCCPU is badly named.  It's named after the
'cpu-version' device tree property where it is advertised, but that meaning
may not be obvious in most places it appears.

Worse, it doesn't even really correspond to that device tree property.  The
property contains either the processor's PVR, or, if the CPU is running in
a compatibility mode, a special "logical PVR" representing which mode.

Rename the cpu_version field, and a number of related variables to
compat_pvr to make this clearer.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c              |  4 ++--
 hw/ppc/spapr_hcall.c        | 30 +++++++++++++++---------------
 target/ppc/cpu.h            |  6 +++---
 target/ppc/kvm.c            |  4 ++--
 target/ppc/kvm_ppc.h        |  4 ++--
 target/ppc/translate_init.c | 10 +++++-----
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b3bbad0..f921be3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -148,8 +148,8 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     uint32_t gservers_prop[smt_threads * 2];
     int index = ppc_get_vcpu_dt_id(cpu);
 
-    if (cpu->cpu_version) {
-        ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->cpu_version);
+    if (cpu->compat_pvr) {
+        ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
         if (ret < 0) {
             return ret;
         }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3f08b8a..35499ae 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -882,7 +882,7 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 }
 
 typedef struct {
-    uint32_t cpu_version;
+    uint32_t compat_pvr;
     Error *err;
 } SetCompatState;
 
@@ -892,7 +892,7 @@ static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
     SetCompatState *s = arg.host_ptr;
 
     cpu_synchronize_state(cs);
-    ppc_set_compat(cpu, s->cpu_version, &s->err);
+    ppc_set_compat(cpu, s->compat_pvr, &s->err);
 }
 
 #define get_compat_level(cpuver) ( \
@@ -903,7 +903,7 @@ static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
 
 static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
                                   unsigned max_lvl, unsigned *compat_lvl,
-                                  unsigned *cpu_version)
+                                  unsigned *compat_pvr)
 {
     unsigned lvl = get_compat_level(pvr);
     bool is205, is206, is207;
@@ -926,12 +926,12 @@ static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
             /* User did not set the level, choose the highest */
             if (*compat_lvl <= lvl) {
                 *compat_lvl = lvl;
-                *cpu_version = pvr;
+                *compat_pvr = pvr;
             }
         } else if (max_lvl >= lvl) {
             /* User chose the level, don't set higher than this */
             *compat_lvl = lvl;
-            *cpu_version = pvr;
+            *compat_pvr = pvr;
         }
     }
 }
@@ -946,8 +946,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu_);
     CPUState *cs;
     bool cpu_match = false;
-    unsigned old_cpu_version = cpu_->cpu_version;
-    unsigned compat_lvl = 0, cpu_version = 0;
+    unsigned old_compat_pvr = cpu_->compat_pvr;
+    unsigned compat_lvl = 0, compat_pvr = 0;
     unsigned max_lvl = get_compat_level(cpu_->max_compat);
     int counter;
     sPAPROptionVector *ov5_guest, *ov5_cas_old, *ov5_updates;
@@ -965,12 +965,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
         if (!max_lvl &&
             ((cpu_->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask))) {
             cpu_match = true;
-            cpu_version = 0;
-        } else if (pvr == cpu_->cpu_version) {
+            compat_pvr = 0;
+        } else if (pvr == cpu_->compat_pvr) {
             cpu_match = true;
-            cpu_version = cpu_->cpu_version;
+            compat_pvr = cpu_->compat_pvr;
         } else if (!cpu_match) {
-            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &cpu_version);
+            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compat_pvr);
         }
         /* Terminator record */
         if (~pvr_mask & pvr) {
@@ -979,14 +979,14 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
     }
 
     /* Parsing finished */
-    trace_spapr_cas_pvr(cpu_->cpu_version, cpu_match,
-                        cpu_version, pcc->pcr_mask);
+    trace_spapr_cas_pvr(cpu_->compat_pvr, cpu_match,
+                        compat_pvr, pcc->pcr_mask);
 
     /* Update CPUs */
-    if (old_cpu_version != cpu_version) {
+    if (old_compat_pvr != compat_pvr) {
         CPU_FOREACH(cs) {
             SetCompatState s = {
-                .cpu_version = cpu_version,
+                .compat_pvr = compat_pvr,
                 .err = NULL,
             };
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4fb4c20..b62f775 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1158,7 +1158,7 @@ typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
  * @env: #CPUPPCState
  * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
  * @max_compat: Maximal supported logical PVR from the command line
- * @cpu_version: Current logical PVR, zero if in "raw" mode
+ * @compat_pvr: Current logical PVR, zero if in "raw" mode
  *
  * A PowerPC CPU.
  */
@@ -1170,7 +1170,7 @@ struct PowerPCCPU {
     CPUPPCState env;
     int cpu_dt_id;
     uint32_t max_compat;
-    uint32_t cpu_version;
+    uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
 
     /* Fields related to migration compatibility hacks */
@@ -1252,7 +1252,7 @@ void ppc_store_msr (CPUPPCState *env, target_ulong value);
 void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
 int ppc_get_compat_smt_threads(PowerPCCPU *cpu);
 #if defined(TARGET_PPC64)
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version, Error **errp);
+void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 #endif
 
 /* Time-base and decrementer management */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9c4834c..15e12f3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2103,9 +2103,9 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
     cap_papr = 1;
 }
 
-int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version)
+int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr)
 {
-    return kvm_set_one_reg(CPU(cpu), KVM_REG_PPC_ARCH_COMPAT, &cpu_version);
+    return kvm_set_one_reg(CPU(cpu), KVM_REG_PPC_ARCH_COMPAT, &compat_pvr);
 }
 
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index bd1d78b..841a29b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -26,7 +26,7 @@ void kvmppc_enable_logical_ci_hcalls(void);
 void kvmppc_enable_set_mode_hcall(void);
 void kvmppc_enable_clear_ref_mod_hcalls(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
-int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version);
+int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
 int kvmppc_smt_threads(void);
 int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
@@ -123,7 +123,7 @@ static inline void kvmppc_set_papr(PowerPCCPU *cpu)
 {
 }
 
-static inline int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version)
+static inline int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr)
 {
     return 0;
 }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 82ed83b..60552c1 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9957,7 +9957,7 @@ int ppc_get_compat_smt_threads(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     int ret = MIN(cs->nr_threads, kvmppc_smt_threads());
 
-    switch (cpu->cpu_version) {
+    switch (cpu->compat_pvr) {
     case CPU_POWERPC_LOGICAL_2_05:
         ret = MIN(ret, 2);
         break;
@@ -9973,15 +9973,15 @@ int ppc_get_compat_smt_threads(PowerPCCPU *cpu)
 }
 
 #ifdef TARGET_PPC64
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version, Error **errp)
+void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 {
     int ret = 0;
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *host_pcc;
 
-    cpu->cpu_version = cpu_version;
+    cpu->compat_pvr = compat_pvr;
 
-    switch (cpu_version) {
+    switch (compat_pvr) {
     case CPU_POWERPC_LOGICAL_2_05:
         env->spr[SPR_PCR] = PCR_TM_DIS | PCR_VSX_DIS | PCR_COMPAT_2_07 |
                             PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -10004,7 +10004,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t cpu_version, Error **errp)
     }
 
     if (kvm_enabled()) {
-        ret = kvmppc_set_compat(cpu, cpu->cpu_version);
+        ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "Unable to set CPU compatibility mode in KVM");
-- 
2.9.3
