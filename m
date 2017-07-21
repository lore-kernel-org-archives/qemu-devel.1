Received: from eggs.gnu.org ([2001:4830:134:3::10]:39992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNok-0003sZ-4f
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0007U5-6Z
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:52324)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0007TP-0w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:25 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:03 +0100
Message-ID: <1500604635-15027-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 02/14] target/mips: Fix TLBWI shadow flush for
 EHINV, XI, RI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

Writing specific TLB entries with TLBWI flushes shadow TLB entries
unless an existing entry is having its access permissions upgraded. This
is necessary as software would from then on expect the previous mapping
in that entry to no longer be in effect (even if QEMU has quietly
evicted it to the shadow TLB on a TLBWR).

However it won't do this if only EHINV, XI, or RI bits have been set,
even if that results in a reduction of permissions, so add the necessary
checks to invoke the flush when these bits are set.

Fixes: 2fb58b73746e ("target-mips: add RI and XI fields to TLB entry")
Fixes: 9456c2fbcd82 ("target-mips: add TLBINV support")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>
[yongbok.kim@imgtec.com:
  cosmetic changes]
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/op_helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index e5f3ea4..6393eff 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2029,7 +2029,7 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
     int idx;
     target_ulong VPN;
     uint16_t ASID;
-    bool G, V0, D0, V1, D1;
+    bool EHINV, G, V0, D0, V1, D1, XI0, XI1, RI0, RI1;
 
     idx = (env->CP0_Index & ~0x80000000) % env->tlb->nb_tlb;
     tlb = &env->tlb->mmu.r4k.tlb[idx];
@@ -2038,17 +2038,25 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
     VPN &= env->SEGMask;
 #endif
     ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
+    EHINV = (env->CP0_EntryHi & (1 << CP0EnHi_EHINV)) != 0;
     G = env->CP0_EntryLo0 & env->CP0_EntryLo1 & 1;
     V0 = (env->CP0_EntryLo0 & 2) != 0;
     D0 = (env->CP0_EntryLo0 & 4) != 0;
+    XI0 = (env->CP0_EntryLo0 >> CP0EnLo_XI) &1;
+    RI0 = (env->CP0_EntryLo0 >> CP0EnLo_RI) &1;
     V1 = (env->CP0_EntryLo1 & 2) != 0;
     D1 = (env->CP0_EntryLo1 & 4) != 0;
+    XI1 = (env->CP0_EntryLo1 >> CP0EnLo_XI) &1;
+    RI1 = (env->CP0_EntryLo1 >> CP0EnLo_RI) &1;
 
     /* Discard cached TLB entries, unless tlbwi is just upgrading access
        permissions on the current entry. */
     if (tlb->VPN != VPN || tlb->ASID != ASID || tlb->G != G ||
+        (!tlb->EHINV && EHINV) ||
         (tlb->V0 && !V0) || (tlb->D0 && !D0) ||
-        (tlb->V1 && !V1) || (tlb->D1 && !D1)) {
+        (!tlb->XI0 && XI0) || (!tlb->RI0 && RI0) ||
+        (tlb->V1 && !V1) || (tlb->D1 && !D1) ||
+        (!tlb->XI1 && XI1) || (!tlb->RI1 && RI1)) {
         r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
     }
 
-- 
2.7.4
