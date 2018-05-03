Received: from eggs.gnu.org ([2001:4830:134:3::10]:40955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cr-00074q-RF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cn-0002NQ-4C
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:38 +1000
Message-Id: <20180503062145.17899-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 1/8] target/ppc: Add ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
 target/ppc/mmu-hash64.c     | 15 +++++++++++----
 target/ppc/mmu-hash64.h     |  3 +--
 target/ppc/translate_init.c |  6 +-----
 3 files changed, 13 insertions(+), 11 deletions(-)

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
index f6349ccdb3..53dcec5b93 100644
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
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c83c910a29..3fd380dad6 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8940,15 +8940,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     /* We should be followed by a CPU reset but update the active value
      * just in case...
      */
-    env->spr[SPR_LPCR] = lpcr->default_value;
+    ppc_store_lpcr(cpu, lpcr->default_value);
 
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] = amor->default_value = 0xffffffffffffffffull;
 
-    /* Update some env bits based on new LPCR value */
-    ppc_hash64_update_rmls(cpu);
-    ppc_hash64_update_vrma(cpu);
-
     /* Tell KVM that we're in PAPR mode */
     if (kvm_enabled()) {
         kvmppc_set_papr(cpu);
-- 
2.17.0
