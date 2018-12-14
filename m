Received: from eggs.gnu.org ([2001:4830:134:3::10]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mZ-5u
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxs-0005W4-Iz
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxs-0005Vj-DP
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:44 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so3631802oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:10 -0600
Message-Id: <20181214052410.11863-28-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 27/27] target/arm: Tidy TBI handling in
 gen_a64_set_pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We can perform this with fewer operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 65 ++++++++++++++------------------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c57c89d98a..5c06e429d4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -261,7 +261,7 @@ void gen_a64_set_pc_im(uint64_t val)
 /* Load the PC from a generic TCG variable.
  *
  * If address tagging is enabled via the TCR TBI bits, then loading
- * an address into the PC will clear out any tag in the it:
+ * an address into the PC will clear out any tag in it:
  *  + for EL2 and EL3 there is only one TBI bit, and if it is set
  *    then the address is zero-extended, clearing bits [63:56]
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
@@ -276,56 +276,37 @@ void gen_a64_set_pc_im(uint64_t val)
  */
 static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 {
+    bool tbi0 = s->tbi0, tbi1 = s->tbi1;
 
     if (s->current_el <= 1) {
-        /* Test if NEITHER or BOTH TBI values are set.  If so, no need to
-         * examine bit 55 of address, can just generate code.
-         * If mixed, then test via generated code
-         */
-        if (s->tbi0 && s->tbi1) {
-            TCGv_i64 tmp_reg = tcg_temp_new_i64();
-            /* Both bits set, sign extension from bit 55 into [63:56] will
-             * cover both cases
-             */
-            tcg_gen_shli_i64(tmp_reg, src, 8);
-            tcg_gen_sari_i64(cpu_pc, tmp_reg, 8);
-            tcg_temp_free_i64(tmp_reg);
-        } else if (!s->tbi0 && !s->tbi1) {
-            /* Neither bit set, just load it as-is */
-            tcg_gen_mov_i64(cpu_pc, src);
-        } else {
-            TCGv_i64 tcg_tmpval = tcg_temp_new_i64();
-            TCGv_i64 tcg_bit55  = tcg_temp_new_i64();
-            TCGv_i64 tcg_zero   = tcg_const_i64(0);
+        if (tbi0 || tbi1) {
+            /* Sign-extend from bit 55.  */
+            tcg_gen_sextract_i64(cpu_pc, src, 0, 56);
 
-            tcg_gen_andi_i64(tcg_bit55, src, (1ull << 55));
+            if (tbi0 != tbi1) {
+                TCGv_i64 tcg_zero = tcg_const_i64(0);
 
-            if (s->tbi0) {
-                /* tbi0==1, tbi1==0, so 0-fill upper byte if bit 55 = 0 */
-                tcg_gen_andi_i64(tcg_tmpval, src,
-                                 0x00FFFFFFFFFFFFFFull);
-                tcg_gen_movcond_i64(TCG_COND_EQ, cpu_pc, tcg_bit55, tcg_zero,
-                                    tcg_tmpval, src);
-            } else {
-                /* tbi0==0, tbi1==1, so 1-fill upper byte if bit 55 = 1 */
-                tcg_gen_ori_i64(tcg_tmpval, src,
-                                0xFF00000000000000ull);
-                tcg_gen_movcond_i64(TCG_COND_NE, cpu_pc, tcg_bit55, tcg_zero,
-                                    tcg_tmpval, src);
+                /*
+                 * The two TBI bits differ.
+                 * If tbi0, then !tbi1: only use the extension if positive.
+                 * if !tbi0, then tbi1: only use the extension if negative.
+                 */
+                tcg_gen_movcond_i64(tbi0 ? TCG_COND_GE : TCG_COND_LT,
+                                    cpu_pc, cpu_pc, tcg_zero, cpu_pc, src);
+                tcg_temp_free_i64(tcg_zero);
             }
-            tcg_temp_free_i64(tcg_zero);
-            tcg_temp_free_i64(tcg_bit55);
-            tcg_temp_free_i64(tcg_tmpval);
+            return;
         }
-    } else {  /* EL > 1 */
-        if (s->tbi0) {
+    } else {
+        if (tbi0) {
             /* Force tag byte to all zero */
-            tcg_gen_andi_i64(cpu_pc, src, 0x00FFFFFFFFFFFFFFull);
-        } else {
-            /* Load unmodified address */
-            tcg_gen_mov_i64(cpu_pc, src);
+            tcg_gen_extract_i64(cpu_pc, src, 0, 56);
+            return;
         }
     }
+
+    /* Load unmodified address */
+    tcg_gen_mov_i64(cpu_pc, src);
 }
 
 typedef struct DisasCompare64 {
-- 
2.17.2
