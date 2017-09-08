Received: from eggs.gnu.org ([2001:4830:134:3::10]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-00028i-AG
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe0-0003EJ-F5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:36 +1000
Message-Id: <20170908103558.31632-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/40] booke206: fix tlbnps for fixed size TLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>, David Gibson <david@gibson.dropbear.id.au>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Some OS don't populate the TSIZE field when using a fixed size TLB which result
in a 1KB TLB. When the TLB is a fixed size TLB the TSIZE field should be
ignored.

Fix this wrong behavior with MAV 2.0.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        | 22 ++++++++++++++++++++++
 target/ppc/mmu_helper.c | 16 ++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 21f0ddd056..042372c5ad 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2491,6 +2491,28 @@ static inline uint32_t booke206_tlbnps(CPUPPCState *env, const int tlbn)
     return ret;
 }
 
+static inline void booke206_fixed_size_tlbn(CPUPPCState *env, const int tlbn,
+                                            ppcmas_tlb_t *tlb)
+{
+    uint8_t i;
+    int32_t tsize = -1;
+
+    for (i = 0; i < 32; i++) {
+        if ((env->spr[SPR_BOOKE_TLB0PS + tlbn]) & (1ULL << i)) {
+            if (tsize == -1) {
+                tsize = i;
+            } else {
+                return;
+            }
+        }
+    }
+
+    /* TLBnPS unimplemented? Odd.. */
+    assert(tsize != -1);
+    tlb->mas1 &= ~MAS1_TSIZE_MASK;
+    tlb->mas1 |= ((uint32_t)tsize) << MAS1_TSIZE_SHIFT;
+}
+
 #endif
 
 static inline bool msr_is_64bit(CPUPPCState *env, target_ulong msr)
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index f06b9382b4..2a1f9902c9 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2632,12 +2632,16 @@ void helper_booke206_tlbwe(CPUPPCState *env)
         env->spr[SPR_BOOKE_MAS3];
     tlb->mas1 = env->spr[SPR_BOOKE_MAS1];
 
-    /* MAV 1.0 only */
-    if (!(tlbncfg & TLBnCFG_AVAIL)) {
-        /* force !AVAIL TLB entries to correct page size */
-        tlb->mas1 &= ~MAS1_TSIZE_MASK;
-        /* XXX can be configured in MMUCSR0 */
-        tlb->mas1 |= (tlbncfg & TLBnCFG_MINSIZE) >> 12;
+    if ((env->spr[SPR_MMUCFG] & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
+        /* For TLB which has a fixed size TSIZE is ignored with MAV2 */
+        booke206_fixed_size_tlbn(env, tlbn, tlb);
+    } else {
+        if (!(tlbncfg & TLBnCFG_AVAIL)) {
+            /* force !AVAIL TLB entries to correct page size */
+            tlb->mas1 &= ~MAS1_TSIZE_MASK;
+            /* XXX can be configured in MMUCSR0 */
+            tlb->mas1 |= (tlbncfg & TLBnCFG_MINSIZE) >> 12;
+        }
     }
 
     /* Make a mask from TLB size to discard invalid bits in EPN field */
-- 
2.13.5
