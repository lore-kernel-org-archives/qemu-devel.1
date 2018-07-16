Received: from eggs.gnu.org ([2001:4830:134:3::10]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aa-0008W4-Ou
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aZ-0005b0-Tw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aZ-0005ae-M8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aY-00011z-M7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:06 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:59 +0100
Message-Id: <20180716164300.6731-8-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 7/8] accel/tcg: Use correct test when looking in
 victim TLB for code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In get_page_addr_code(), we were incorrectly looking in the victim
TLB for an entry which matched the target address for reads, not
for code accesses. This meant that we could hit on a victim TLB
entry that indicated that the address was readable but not
executable, and incorrectly bypass the call to tlb_fill() which
should generate the guest MMU exception. Fix this bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180713141636.18665-2-peter.maydell@linaro.org
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 20c147d6554..2d5fb15d9a3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -967,7 +967,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
     if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
-        if (!VICTIM_TLB_HIT(addr_read, addr)) {
+        if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
         }
     }
-- 
2.17.1
