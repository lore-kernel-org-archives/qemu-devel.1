Received: from eggs.gnu.org ([2001:4830:134:3::10]:43578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eADk8-0006zj-OC
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eADk7-0007Ur-Jg
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:33:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Nov 2017 11:33:20 +0000
Message-Id: <1509622400-13351-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] translate.c: Fix usermode big-endian
 AArch32 LDREXD and STREXD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, christophe.lyon@linaro.org

For AArch32 LDREXD and STREXD, architecturally the 32-bit word at the
lowest address is always Rt and the one at addr+4 is Rt2, even if the
CPU is big-endian. Our implementation does these with a single
64-bit store, so if we're big-endian then we need to put the two
32-bit halves together in the opposite order to little-endian,
so that they end up in the right places. We were trying to do
this with the gen_aa32_frob64() function, but that is not correct
for the usermode emulator, because there there is a distinction
between "load a 64 bit value" (which does a BE 64-bit access
and doesn't need swapping) and "load two 32 bit values as one
64 bit access" (where we still need to do the swapping, like
system mode BE32).

Fixes: https://bugs.launchpad.net/qemu/+bug/1725267
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * use correct "s->be_data == MO_BE" check for bigendian
 * don't mangle the data from the atomic-cmpxchg before
   comparing against expected value
 * tcg_temp_free() the TCGv from gen_aa32_addr()
 * name that TCGv "taddr" rather than "a"...

 target/arm/translate.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6ba4ae9..0ed03d7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7903,9 +7903,27 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
         TCGv_i32 tmp2 = tcg_temp_new_i32();
         TCGv_i64 t64 = tcg_temp_new_i64();
 
-        gen_aa32_ld_i64(s, t64, addr, get_mem_index(s), opc);
+        /* For AArch32, architecturally the 32-bit word at the lowest
+         * address is always Rt and the one at addr+4 is Rt2, even if
+         * the CPU is big-endian. That means we don't want to do a
+         * gen_aa32_ld_i64(), which invokes gen_aa32_frob64() as if
+         * for an architecturally 64-bit access, but instead do a
+         * 64-bit access using MO_BE if appropriate and then split
+         * the two halves.
+         * This only makes a difference for BE32 user-mode, where
+         * frob64() must not flip the two halves of the 64-bit data
+         * but this code must treat BE32 user-mode like BE32 system.
+         */
+        TCGv taddr = gen_aa32_addr(s, addr, opc);
+
+        tcg_gen_qemu_ld_i64(t64, taddr, get_mem_index(s), opc);
+        tcg_temp_free(taddr);
         tcg_gen_mov_i64(cpu_exclusive_val, t64);
-        tcg_gen_extr_i64_i32(tmp, tmp2, t64);
+        if (s->be_data == MO_BE) {
+            tcg_gen_extr_i64_i32(tmp2, tmp, t64);
+        } else {
+            tcg_gen_extr_i64_i32(tmp, tmp2, t64);
+        }
         tcg_temp_free_i64(t64);
 
         store_reg(s, rt2, tmp2);
@@ -7954,15 +7972,26 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         TCGv_i64 n64 = tcg_temp_new_i64();
 
         t2 = load_reg(s, rt2);
-        tcg_gen_concat_i32_i64(n64, t1, t2);
+        /* For AArch32, architecturally the 32-bit word at the lowest
+         * address is always Rt and the one at addr+4 is Rt2, even if
+         * the CPU is big-endian. Since we're going to treat this as a
+         * single 64-bit BE store, we need to put the two halves in the
+         * opposite order for BE to LE, so that they end up in the right
+         * places.
+         * We don't want gen_aa32_frob64() because that does the wrong
+         * thing for BE32 usermode.
+         */
+        if (s->be_data == MO_BE) {
+            tcg_gen_concat_i32_i64(n64, t2, t1);
+        } else {
+            tcg_gen_concat_i32_i64(n64, t1, t2);
+        }
         tcg_temp_free_i32(t2);
-        gen_aa32_frob64(s, n64);
 
         tcg_gen_atomic_cmpxchg_i64(o64, taddr, cpu_exclusive_val, n64,
                                    get_mem_index(s), opc);
         tcg_temp_free_i64(n64);
 
-        gen_aa32_frob64(s, o64);
         tcg_gen_setcond_i64(TCG_COND_NE, o64, o64, cpu_exclusive_val);
         tcg_gen_extrl_i64_i32(t0, o64);
 
-- 
2.7.4
