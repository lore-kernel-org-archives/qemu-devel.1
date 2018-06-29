Received: from eggs.gnu.org ([2001:4830:134:3::10]:58484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw9H-0008NC-5L
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw9G-0002FS-6i
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYw9G-0002Aa-0C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:21:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 17:21:22 +0100
Message-Id: <20180629162122.19376-3-peter.maydell@linaro.org>
In-Reply-To: <20180629162122.19376-1-peter.maydell@linaro.org>
References: <20180629162122.19376-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] accel/tcg: Correct "is this a TLB miss"
 check in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

In commit 71b9a45330fe220d1 we changed the condition we use
to determine whether we need to refill the TLB in
get_page_addr_code() to
    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
                 (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {

This isn't the right check (it will falsely fail if the
input addr happens to have the low bit corresponding to
TLB_INVALID_MASK set, for instance). Replace it with a
use of the new tlb_hit() function, which is the correct test.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/cputlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index adb711963bf..3ae1198c245 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -957,8 +957,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
-                 (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
+    if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_read, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
         }
-- 
2.17.1
