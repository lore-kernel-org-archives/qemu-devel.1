Received: from eggs.gnu.org ([2001:4830:134:3::10]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gN3-0001qi-BG
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gN0-0002m8-29
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 27 Mar 2018 15:37:33 +1100
Message-Id: <20180327043741.7705-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180327043741.7705-1-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 04/12] target/ppc: Avoid taking "env"
 parameter to mmu-hash64 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

In most cases we prefer to pass a PowerPCCPU rather than the (embedded)
CPUPPCState.

For ppc_hash64_update_{rmls,vrma}() change to take "cpu" instead of "env".
For ppc_hash64_set_{dsi,isi}() remove the redundant "env" parameter.

In theory this makes more work for the functions, but since "cs", "cpu"
and "env" are related by at most constant offsets, the compiler should be
able to optimize out the difference at effectively zero cost.

helper_*() functions are left alone - since they're more closely tied to
the TCG generated code, passing "env" is still the standard there.

While we're there, fix an incorrect indentation.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c     | 35 +++++++++++++++++++----------------
 target/ppc/mmu-hash64.h     |  4 ++--
 target/ppc/translate_init.c |  4 ++--
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c9b72b7429..a87fa7c83f 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -633,9 +633,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
     return 0;
 }
 
-static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
-                               uint64_t error_code)
+static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
 {
+    CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
 
     if (msr_ir) {
@@ -659,9 +659,9 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
     env->error_code = error_code;
 }
 
-static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCState *env, uint64_t dar,
-                               uint64_t dsisr)
+static void ppc_hash64_set_dsi(CPUState *cs, uint64_t dar, uint64_t dsisr)
 {
+    CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
 
     if (msr_dr) {
@@ -741,13 +741,13 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
             } else {
                 /* The access failed, generate the approriate interrupt */
                 if (rwx == 2) {
-                    ppc_hash64_set_isi(cs, env, SRR1_PROTFAULT);
+                    ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
                 } else {
                     int dsisr = DSISR_PROTFAULT;
                     if (rwx == 1) {
                         dsisr |= DSISR_ISSTORE;
                     }
-                    ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+                    ppc_hash64_set_dsi(cs, eaddr, dsisr);
                 }
                 return 1;
             }
@@ -783,7 +783,7 @@ skip_slb_search:
 
     /* 3. Check for segment level no-execute violation */
     if ((rwx == 2) && (slb->vsid & SLB_VSID_N)) {
-        ppc_hash64_set_isi(cs, env, SRR1_NOEXEC_GUARD);
+        ppc_hash64_set_isi(cs, SRR1_NOEXEC_GUARD);
         return 1;
     }
 
@@ -791,13 +791,13 @@ skip_slb_search:
     ptex = ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
     if (ptex == -1) {
         if (rwx == 2) {
-            ppc_hash64_set_isi(cs, env, SRR1_NOPTE);
+            ppc_hash64_set_isi(cs, SRR1_NOPTE);
         } else {
             int dsisr = DSISR_NOPTE;
             if (rwx == 1) {
                 dsisr |= DSISR_ISSTORE;
             }
-            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, eaddr, dsisr);
         }
         return 1;
     }
@@ -824,7 +824,7 @@ skip_slb_search:
             if (PAGE_EXEC & ~amr_prot) {
                 srr1 |= SRR1_IAMR; /* Access violates virt pg class key prot */
             }
-            ppc_hash64_set_isi(cs, env, srr1);
+            ppc_hash64_set_isi(cs, srr1);
         } else {
             int dsisr = 0;
             if (need_prot[rwx] & ~pp_prot) {
@@ -836,7 +836,7 @@ skip_slb_search:
             if (need_prot[rwx] & ~amr_prot) {
                 dsisr |= DSISR_AMR;
             }
-            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, eaddr, dsisr);
         }
         return 1;
     }
@@ -942,8 +942,9 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
     cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
 }
 
-void ppc_hash64_update_rmls(CPUPPCState *env)
+void ppc_hash64_update_rmls(PowerPCCPU *cpu)
 {
+    CPUPPCState *env = &cpu->env;
     uint64_t lpcr = env->spr[SPR_LPCR];
 
     /*
@@ -976,8 +977,9 @@ void ppc_hash64_update_rmls(CPUPPCState *env)
     }
 }
 
-void ppc_hash64_update_vrma(CPUPPCState *env)
+void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
+    CPUPPCState *env = &cpu->env;
     const struct ppc_one_seg_page_size *sps = NULL;
     target_ulong esid, vsid, lpcr;
     ppc_slb_t *slb = &env->vrma_slb;
@@ -1002,7 +1004,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
     vsid |= (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
     esid = SLB_ESID_V;
 
-   for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
+    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
         const struct ppc_one_seg_page_size *sps1 = &env->sps.sps[i];
 
         if (!sps1->page_shift) {
@@ -1028,6 +1030,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
 
 void helper_store_lpcr(CPUPPCState *env, target_ulong val)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
     uint64_t lpcr = 0;
 
     /* Filter out bits */
@@ -1089,6 +1092,6 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
         ;
     }
     env->spr[SPR_LPCR] = lpcr;
-    ppc_hash64_update_rmls(env);
-    ppc_hash64_update_vrma(env);
+    ppc_hash64_update_rmls(cpu);
+    ppc_hash64_update_vrma(cpu);
 }
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d297b97d37..95a8c330d6 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -17,8 +17,8 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte0, target_ulong pte1);
 unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
                                           uint64_t pte0, uint64_t pte1);
-void ppc_hash64_update_vrma(CPUPPCState *env);
-void ppc_hash64_update_rmls(CPUPPCState *env);
+void ppc_hash64_update_vrma(PowerPCCPU *cpu);
+void ppc_hash64_update_rmls(PowerPCCPU *cpu);
 #endif
 
 /*
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 2ae718242a..29bd6f3654 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8975,8 +8975,8 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     env->spr[SPR_AMOR] = amor->default_value = 0xffffffffffffffffull;
 
     /* Update some env bits based on new LPCR value */
-    ppc_hash64_update_rmls(env);
-    ppc_hash64_update_vrma(env);
+    ppc_hash64_update_rmls(cpu);
+    ppc_hash64_update_vrma(cpu);
 
     /* Tell KVM that we're in PAPR mode */
     if (kvm_enabled()) {
-- 
2.14.3
