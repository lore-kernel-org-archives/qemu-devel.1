Received: from eggs.gnu.org ([2001:4830:134:3::10]:49156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dcuAn-0001qW-Ij
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dcuAk-0005Iy-HA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:53 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:42971)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dcuAk-0005Ek-BE
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:58:50 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
	by Forcepoint Email with ESMTPS id 9E66C66A06861
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 14:58:40 +0100 (IST)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 2 Aug 2017 14:58:31 +0100
Message-ID: <1501682311-16370-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target-mips: apply CP0.PageMask before writing
 into TLB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Leon Alrae <leon.alrae@imgtec.com>

PFN0 and PFN1 have to be masked out with PageMask_Mask.

Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
[Yongbok Kim:
  Added commit message]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 526f8e4..320f2b0 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2008,6 +2008,7 @@ static inline uint64_t get_tlb_pfn_from_entrylo(uint64_t entrylo)
 static void r4k_fill_tlb(CPUMIPSState *env, int idx)
 {
     r4k_tlb_t *tlb;
+    uint64_t mask = env->CP0_PageMask >> (TARGET_PAGE_BITS + 1);
 
     /* XXX: detect conflicting TLBs and raise a MCHECK exception when needed */
     tlb = &env->tlb->mmu.r4k.tlb[idx];
@@ -2028,13 +2029,13 @@ static void r4k_fill_tlb(CPUMIPSState *env, int idx)
     tlb->C0 = (env->CP0_EntryLo0 >> 3) & 0x7;
     tlb->XI0 = (env->CP0_EntryLo0 >> CP0EnLo_XI) & 1;
     tlb->RI0 = (env->CP0_EntryLo0 >> CP0EnLo_RI) & 1;
-    tlb->PFN[0] = get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) << 12;
+    tlb->PFN[0] = (get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) & ~mask) << 12;
     tlb->V1 = (env->CP0_EntryLo1 & 2) != 0;
     tlb->D1 = (env->CP0_EntryLo1 & 4) != 0;
     tlb->C1 = (env->CP0_EntryLo1 >> 3) & 0x7;
     tlb->XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) & 1;
     tlb->RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) & 1;
-    tlb->PFN[1] = get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) << 12;
+    tlb->PFN[1] = (get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) & ~mask) << 12;
 }
 
 void r4k_helper_tlbinv(CPUMIPSState *env)
-- 
2.7.4
