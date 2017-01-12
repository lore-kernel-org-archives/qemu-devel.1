Received: from eggs.gnu.org ([2001:4830:134:3::10]:47027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkF-0003F6-N7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0006nN-TY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:22 +1100
Message-Id: <20170112020327.24882-63-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 62/67] ppc: Add ppc_set_compat_all()
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

Once a compatiblity mode is negotiated with the guest,
h_client_architecture_support() uses run_on_cpu() to update each CPU to
the new mode.  We're going to want this logic somewhere else shortly,
so make a helper function to do this global update.

We put it in target-ppc/compat.c - it makes as much sense at the CPU level
as it does at the machine level.  We also move the cpu_synchronize_state()
into ppc_set_compat(), since it doesn't really make any sense to call that
without synchronizing state.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 31 +++++--------------------------
 target/ppc/compat.c  | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h     |  3 +++
 3 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 43a1fef..21b6334 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -921,20 +921,6 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
     }
 }
 
-typedef struct {
-    uint32_t compat_pvr;
-    Error *err;
-} SetCompatState;
-
-static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    SetCompatState *s = arg.host_ptr;
-
-    cpu_synchronize_state(cs);
-    ppc_set_compat(cpu, s->compat_pvr, &s->err);
-}
-
 static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                                                   sPAPRMachineState *spapr,
                                                   target_ulong opcode,
@@ -942,7 +928,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 {
     target_ulong list = ppc64_phys_to_real(args[0]);
     target_ulong ov_table;
-    CPUState *cs;
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t max_compat = cpu->max_compat;
     uint32_t best_compat = 0;
@@ -986,18 +971,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     /* Update CPUs */
     if (cpu->compat_pvr != best_compat) {
-        CPU_FOREACH(cs) {
-            SetCompatState s = {
-                .compat_pvr = best_compat,
-                .err = NULL,
-            };
+        Error *local_err = NULL;
 
-            run_on_cpu(cs, do_set_compat, RUN_ON_CPU_HOST_PTR(&s));
-
-            if (s.err) {
-                error_report_err(s.err);
-                return H_HARDWARE;
-            }
+        ppc_set_compat_all(best_compat, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return H_HARDWARE;
         }
     }
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 1059555..8de9dfb 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -124,6 +124,8 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
         pcr = compat->pcr;
     }
 
+    cpu_synchronize_state(CPU(cpu));
+
     cpu->compat_pvr = compat_pvr;
     env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
 
@@ -136,6 +138,38 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
     }
 }
 
+typedef struct {
+    uint32_t compat_pvr;
+    Error *err;
+} SetCompatState;
+
+static void do_set_compat(CPUState *cs, run_on_cpu_data arg)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    SetCompatState *s = arg.host_ptr;
+
+    ppc_set_compat(cpu, s->compat_pvr, &s->err);
+}
+
+void ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        SetCompatState s = {
+            .compat_pvr = compat_pvr,
+            .err = NULL,
+        };
+
+        run_on_cpu(cs, do_set_compat, RUN_ON_CPU_HOST_PTR(&s));
+
+        if (s.err) {
+            error_propagate(errp, s.err);
+            return;
+        }
+    }
+}
+
 int ppc_compat_max_threads(PowerPCCPU *cpu)
 {
     const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 22842dd..4d72d75 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1326,6 +1326,9 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
 bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
                       uint32_t min_compat_pvr, uint32_t max_compat_pvr);
 void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
+#if !defined(CONFIG_USER_ONLY)
+void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+#endif
 int ppc_compat_max_threads(PowerPCCPU *cpu);
 #endif /* defined(TARGET_PPC64) */
 
-- 
2.9.3
