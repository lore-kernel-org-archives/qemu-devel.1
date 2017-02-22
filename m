Received: from eggs.gnu.org ([2001:4830:134:3::10]:38043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-00038k-Om
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-0008Bt-Ie
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:33 +1100
Message-Id: <20170222063348.32176-29-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 28/43] target/ppc/POWER9: Add ISAv3.00 MMU
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

POWER9 processors implement the mmu as defined in version 3.00 of the ISA.

Add a definition for this mmu model and set the POWER9 cpu model to use
this mmu model.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-qom.h        | 5 ++++-
 target/ppc/mmu_helper.c     | 2 ++
 target/ppc/translate_init.c | 3 +--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index b7977ba..4e3132b 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -86,10 +86,13 @@ enum powerpc_mmu_t {
     POWERPC_MMU_2_07       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
                              | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | 0x00000004,
-    /* FIXME Add POWERPC_MMU_3_OO defines */
     /* Architecture 2.07 "degraded" (no 1T segments)           */
     POWERPC_MMU_2_07a      = POWERPC_MMU_64 | POWERPC_MMU_AMR
                              | 0x00000004,
+    /* Architecture 3.00 variant                               */
+    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
+                             | POWERPC_MMU_64K
+                             | POWERPC_MMU_AMR | 0x00000005,
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index f746f53..172a305 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1935,6 +1935,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
 #endif /* defined(TARGET_PPC64) */
         env->tlb_need_flush = 0;
         tlb_flush(CPU(cpu));
@@ -1974,6 +1975,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
         /* tlbie invalidate TLBs for all segments */
         /* XXX: given the fact that there are too many segments to invalidate,
          *      and we still don't have a tlb_flush_mask(env, n, mask) in QEMU,
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 76f79fa..84bf125 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8816,8 +8816,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                     (1ull << MSR_PMM) |
                     (1ull << MSR_RI) |
                     (1ull << MSR_LE);
-    /* Using 2.07 defines until new radix model is added. */
-    pcc->mmu_model = POWERPC_MMU_2_07;
+    pcc->mmu_model = POWERPC_MMU_3_00;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
     /* segment page size remain the same */
-- 
2.9.3
