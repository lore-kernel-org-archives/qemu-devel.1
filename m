Received: from eggs.gnu.org ([2001:4830:134:3::10]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw5a-0005wg-2S
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYw5Z-0002gE-7T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:17:38 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 17:17:31 +0100
Message-Id: <20180629161731.16239-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] accel/tcg: Don't treat invalid TLB
 entries as needing recheck
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

In get_page_addr_code() when we check whether the TLB entry
is marked as TLB_RECHECK, we should not go down that code
path if the TLB entry is not valid at all (ie the TLB_INVALID
bit is set).

Reported-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This fixes the abort that Laurent was seeing with his m68k test case.

 accel/tcg/cputlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eebe97dabb7..a55296583b9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -967,7 +967,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         }
     }
 
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
+    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
+                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
          * covers a smaller range than a target page, and we must
-- 
2.17.1
