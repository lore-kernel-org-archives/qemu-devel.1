Received: from eggs.gnu.org ([2001:4830:134:3::10]:57988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Kru-0003Sz-PX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krt-0008VF-FI
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Apr 2018 17:17:18 +1000
Message-Id: <20180417071722.9399-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180417071722.9399-1-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.13 06/10] target/ppc: Add
 ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

There are some fields in the cpu state which need to be updated when the
LPCR register is changed, which is done by ppc_hash64_update_rmls() and
ppc_hash64_update_vrma().  Code which alters env->spr[SPR_LPCR] needs to
call them afterwards to make sure the state is up to date.

That's easy to get wrong.  The normal way of dealing with sitautions like
that is to use a helper which both updates the basic register value and the
derived state.

So, do that.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c |  6 +-----
 target/ppc/mmu-hash64.c | 15 +++++++++++----
 target/ppc/mmu-hash64.h |  3 +--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9080664ec1..b1c3cf11f0 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -74,14 +74,10 @@ static void spapr_cpu_reset(void *opaque)
         lpcr &= ~pcc->lpcr_pm;
     }
 
-    env->spr[SPR_LPCR] = lpcr;
+    ppc_store_lpcr(cpu, lpcr);
 
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] = 0xffffffffffffffffull;
-
-    /* Update some env bits based on new LPCR value */
-    ppc_hash64_update_rmls(cpu);
-    ppc_hash64_update_vrma(cpu);
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7e0adecfd9..a1db20e3a8 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -942,7 +942,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
     cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
 }
 
-void ppc_hash64_update_rmls(PowerPCCPU *cpu)
+static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
     uint64_t lpcr = env->spr[SPR_LPCR];
@@ -977,7 +977,7 @@ void ppc_hash64_update_rmls(PowerPCCPU *cpu)
     }
 }
 
-void ppc_hash64_update_vrma(PowerPCCPU *cpu)
+static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
     const PPCHash64SegmentPageSizes *sps = NULL;
@@ -1028,9 +1028,9 @@ void ppc_hash64_update_vrma(PowerPCCPU *cpu)
     slb->sps = sps;
 }
 
-void helper_store_lpcr(CPUPPCState *env, target_ulong val)
+void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
 {
-    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    CPUPPCState *env = &cpu->env;
     uint64_t lpcr = 0;
 
     /* Filter out bits */
@@ -1096,6 +1096,13 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
     ppc_hash64_update_vrma(cpu);
 }
 
+void helper_store_lpcr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+
+    ppc_store_lpcr(cpu, val);
+}
+
 void ppc_hash64_init(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index d5fc03441d..f23b78d787 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -17,8 +17,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
                                target_ulong pte0, target_ulong pte1);
 unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
                                           uint64_t pte0, uint64_t pte1);
-void ppc_hash64_update_vrma(PowerPCCPU *cpu);
-void ppc_hash64_update_rmls(PowerPCCPU *cpu);
+void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_hash64_init(PowerPCCPU *cpu);
 void ppc_hash64_finalize(PowerPCCPU *cpu);
 #endif
-- 
2.14.3
