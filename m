Received: from eggs.gnu.org ([209.51.188.92]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbd-0002v1-Ja
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbc-0007Y3-Kp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbc-0007XO-Eh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:48 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so4785309wmj.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:51 +0000
Message-Id: <20190118145805.6852-36-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/49] target/arm: Tidy TBI handling in
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

From: Richard Henderson <richard.henderson@linaro.org>

We can perform this with fewer operations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 62 +++++++++++++-------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f49fe1de3a8..4d28a27c3bd 100644
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
@@ -280,54 +280,34 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
     int tbi = s->tbii;
 
     if (s->current_el <= 1) {
-        /* Test if NEITHER or BOTH TBI values are set.  If so, no need to
-         * examine bit 55 of address, can just generate code.
-         * If mixed, then test via generated code
-         */
-        if (tbi == 3) {
-            TCGv_i64 tmp_reg = tcg_temp_new_i64();
-            /* Both bits set, sign extension from bit 55 into [63:56] will
-             * cover both cases
-             */
-            tcg_gen_shli_i64(tmp_reg, src, 8);
-            tcg_gen_sari_i64(cpu_pc, tmp_reg, 8);
-            tcg_temp_free_i64(tmp_reg);
-        } else if (tbi == 0) {
-            /* Neither bit set, just load it as-is */
-            tcg_gen_mov_i64(cpu_pc, src);
-        } else {
-            TCGv_i64 tcg_tmpval = tcg_temp_new_i64();
-            TCGv_i64 tcg_bit55  = tcg_temp_new_i64();
-            TCGv_i64 tcg_zero   = tcg_const_i64(0);
+        if (tbi != 0) {
+            /* Sign-extend from bit 55.  */
+            tcg_gen_sextract_i64(cpu_pc, src, 0, 56);
 
-            tcg_gen_andi_i64(tcg_bit55, src, (1ull << 55));
+            if (tbi != 3) {
+                TCGv_i64 tcg_zero = tcg_const_i64(0);
 
-            if (tbi == 1) {
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
+                tcg_gen_movcond_i64(tbi == 1 ? TCG_COND_GE : TCG_COND_LT,
+                                    cpu_pc, cpu_pc, tcg_zero, cpu_pc, src);
+                tcg_temp_free_i64(tcg_zero);
             }
-            tcg_temp_free_i64(tcg_zero);
-            tcg_temp_free_i64(tcg_bit55);
-            tcg_temp_free_i64(tcg_tmpval);
+            return;
         }
-    } else {  /* EL > 1 */
+    } else {
         if (tbi != 0) {
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
2.20.1
