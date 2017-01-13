Received: from eggs.gnu.org ([2001:4830:134:3::10]:53071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvM3-00061j-9h
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvM2-0001wS-As
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:51 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:10 +1100
Message-Id: <1484288903-18807-5-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 04/17] target/ppc/POWER9: Add ISAv3.00 MMU
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

POWER9 processors implement the mmu as defined in version 3.00 of the ISA.

Add a definition for this mmu model and set the POWER9 cpu model to use
this mmu model.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu-qom.h        | 5 ++++-
 target/ppc/mmu_helper.c     | 2 ++
 target/ppc/translate_init.c | 3 +--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index d46c31a..1577cc8 100644
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
index d09fc0a..2ab4562 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1935,6 +1935,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
 #endif /* defined(TARGET_PPC64) */
         env->tlb_need_flush = 0;
         tlb_flush(CPU(cpu), 1);
@@ -1974,6 +1975,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
         /* tlbie invalidate TLBs for all segments */
         /* XXX: given the fact that there are too many segments to invalidate,
          *      and we still don't have a tlb_flush_mask(env, n, mask) in QEMU,
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index bfc1f24..2402eef 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8838,8 +8838,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
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
2.5.5
