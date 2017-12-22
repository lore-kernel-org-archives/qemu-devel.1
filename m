Received: from eggs.gnu.org ([2001:4830:134:3::10]:54332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@dinsnail.net>) id 1eSX8G-0005jT-64
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 18:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@dinsnail.net>) id 1eSX8D-0003vG-3s
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 18:53:40 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Fri, 22 Dec 2017 20:23:00 +0100
Message-Id: <20171222192300.46997-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [RFC PATCH] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

In big-endian mode, stlxp would not only store the individual doublewords
big-endian but also swap them in memory. This does not correspond to how ldxp
behaves nor how native code expects the result of stlxp to be stored in memory.

Also, when comparing if the values in memory still match what was previously
loaded by ldxp, stlxp would also swap the values loaded from memory, making the
comparison against the previously loaded value fail always.

With this change an aarch64_be Linux 4.14.4 kernel succeeds to boots up in
system emulation mode.

This change makes paired_cmpxchg64 helpers differ only in endianness handling.
It might be possible to fold them into a single routine using variables and
function pointers or get rid of them completely in favour of tcg_gen_-routines.
Both is currently beyond my skill level, though.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 target/arm/helper-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index b84ebcae6e..bab6446588 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -532,8 +532,8 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
 
         success = int128_eq(oldv, cmpv);
         if (success) {
-            stq_be_p(haddr + 0, int128_gethi(newv));
-            stq_be_p(haddr + 1, int128_getlo(newv));
+            stq_be_p(haddr + 0, int128_getlo(newv));
+            stq_be_p(haddr + 1, int128_gethi(newv));
         }
         helper_retaddr = 0;
 #else
@@ -541,14 +541,14 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
         TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
         TCGMemOpIdx oi1 = make_memop_idx(MO_BEQ, mem_idx);
 
-        o1 = helper_be_ldq_mmu(env, addr + 0, oi0, ra);
-        o0 = helper_be_ldq_mmu(env, addr + 8, oi1, ra);
+        o0 = helper_be_ldq_mmu(env, addr + 0, oi0, ra);
+        o1 = helper_be_ldq_mmu(env, addr + 8, oi1, ra);
         oldv = int128_make128(o0, o1);
 
         success = int128_eq(oldv, cmpv);
         if (success) {
-            helper_be_stq_mmu(env, addr + 0, int128_gethi(newv), oi1, ra);
-            helper_be_stq_mmu(env, addr + 8, int128_getlo(newv), oi1, ra);
+            helper_be_stq_mmu(env, addr + 0, int128_getlo(newv), oi1, ra);
+            helper_be_stq_mmu(env, addr + 8, int128_gethi(newv), oi1, ra);
         }
 #endif
     }
-- 
2.15.1
