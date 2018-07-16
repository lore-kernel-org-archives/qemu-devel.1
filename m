Received: from eggs.gnu.org ([2001:4830:134:3::10]:50728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6ab-00005l-Qj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aa-0005bd-Sr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aa-0005ae-L5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aZ-00012E-EY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:43:00 +0100
Message-Id: <20180716164300.6731-9-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 8/8] accel/tcg: Assert that tlb fill gave us a
 valid TLB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit 4b1a3e1e34ad97 we added a check for whether the TLB entry
we had following a tlb_fill had the INVALID bit set.  This could
happen in some circumstances because a stale or wrong TLB entry was
pulled out of the victim cache.  However, after commit
68fea038553039e (which prevents stale entries being in the victim
cache) and the previous commit (which ensures we don't incorrectly
hit in the victim cache)) this should never be possible.

Drop the check on TLB_INVALID_MASK from the "is this a TLB_RECHECK?"
condition, and instead assert that the tlb fill procedure has given
us a valid TLB entry (or longjumped out with a guest exception).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180713141636.18665-3-peter.maydell@linaro.org
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2d5fb15d9a3..563fa30117e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -970,10 +970,10 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
         }
+        assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
     }
 
-    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
-                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
+    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
          * covers a smaller range than a target page, and we must
-- 
2.17.1
