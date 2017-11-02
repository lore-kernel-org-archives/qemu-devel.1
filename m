Received: from eggs.gnu.org ([2001:4830:134:3::10]:50892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eACph-0007PX-HH
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eACpe-0005Y0-DM
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:34:45 -0400
From: Luc MICHEL <luc.michel@git.antfield.fr>
Date: Thu,  2 Nov 2017 11:35:59 +0100
Message-Id: <20171102103559.7382-2-luc.michel@git.antfield.fr>
In-Reply-To: <20171102103559.7382-1-luc.michel@git.antfield.fr>
References: <20171102103559.7382-1-luc.michel@git.antfield.fr>
Subject: [Qemu-devel] [PATCH 1/1] target-ppc: Fix booke206 tlbwe TLB
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

When overwritting a valid TLB entry with a new one, the previous page
were not flushed in QEMU TLB, leading to incoherent mapping. This commit
fixes this.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
---
 target/ppc/mmu_helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2a1f9902c9..c2c89239b4 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2570,6 +2570,17 @@ void helper_booke_setpid(CPUPPCState *env, uint32_t pidn, target_ulong pid)
     tlb_flush(CPU(cpu));
 }
 
+static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+
+    if (booke206_tlb_to_page_size(env, tlb) == TARGET_PAGE_SIZE) {
+        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
+    } else {
+        tlb_flush(CPU(cpu));
+    }
+}
+
 void helper_booke206_tlbwe(CPUPPCState *env)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
@@ -2628,6 +2639,12 @@ void helper_booke206_tlbwe(CPUPPCState *env)
     if (msr_gs) {
         cpu_abort(CPU(cpu), "missing HV implementation\n");
     }
+
+    if (tlb->mas1 & MAS1_VALID) {
+        /* Invalidate the page in QEMU TLB if it was a valid entry */
+        flush_page(env, tlb);
+    }
+
     tlb->mas7_3 = ((uint64_t)env->spr[SPR_BOOKE_MAS7] << 32) |
         env->spr[SPR_BOOKE_MAS3];
     tlb->mas1 = env->spr[SPR_BOOKE_MAS1];
@@ -2663,11 +2680,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
         tlb->mas1 &= ~MAS1_IPROT;
     }
 
-    if (booke206_tlb_to_page_size(env, tlb) == TARGET_PAGE_SIZE) {
-        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
-    } else {
-        tlb_flush(CPU(cpu));
-    }
+    flush_page(env, tlb);
 }
 
 static inline void booke206_tlb_to_mas(CPUPPCState *env, ppcmas_tlb_t *tlb)
-- 
2.14.3
