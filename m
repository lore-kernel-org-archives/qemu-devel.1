Received: from eggs.gnu.org ([209.51.188.92]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeC0-00011N-V2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBy-0006Ut-25
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqeBx-0006Pt-Mt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so14305426wrt.11
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:21:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:21:23 +0000
Message-Id: <20190204132126.3255-2-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-1-richard.henderson@linaro.org>
References: <20190204132126.3255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/4] target/arm: Add TBFLAG_A64_TBID,
 split out gen_top_byte_ignore
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

Split out gen_top_byte_ignore in preparation of handling these
data accesses; the new tbflags field is not yet honored.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Re-add some commentary wrt TBI bits.
---
 target/arm/cpu.h           |  1 +
 target/arm/translate.h     |  3 +-
 target/arm/helper.c        |  1 +
 target/arm/translate-a64.c | 72 +++++++++++++++++++-------------------
 4 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 366ab97db3..029f6cd60c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3058,6 +3058,7 @@ FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)
+FIELD(TBFLAG_A64, TBID, 12, 2)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index f73939d7b4..17748ddfb9 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -26,7 +26,8 @@ typedef struct DisasContext {
     int user;
 #endif
     ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
-    uint8_t tbii;      /* TBI1|TBI0 for EL0/1 or TBI for EL2/3 */
+    uint8_t tbii;      /* TBI1|TBI0 for insns */
+    uint8_t tbid;      /* TBI1|TBI0 for data */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be0ec7de2a..25d8ec38f8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13767,6 +13767,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
 
             flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
+            flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
         }
 #endif
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 37077138e3..0b4a09ca1c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -284,10 +284,10 @@ void gen_a64_set_pc_im(uint64_t val)
     tcg_gen_movi_i64(cpu_pc, val);
 }
 
-/* Load the PC from a generic TCG variable.
+/*
+ * Handle Top Byte Ignore (TBI) bits.
  *
- * If address tagging is enabled via the TCR TBI bits, then loading
- * an address into the PC will clear out any tag in it:
+ * If address tagging is enabled via the TCR TBI bits:
  *  + for EL2 and EL3 there is only one TBI bit, and if it is set
  *    then the address is zero-extended, clearing bits [63:56]
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
@@ -295,45 +295,44 @@ void gen_a64_set_pc_im(uint64_t val)
  *    If the appropriate TBI bit is set for the address then
  *    the address is sign-extended from bit 55 into bits [63:56]
  *
- * We can avoid doing this for relative-branches, because the
- * PC + offset can never overflow into the tag bits (assuming
- * that virtual addresses are less than 56 bits wide, as they
- * are currently), but we must handle it for branch-to-register.
+ * Here We have concatenated TBI{1,0} into tbi.
  */
-static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
+static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
+                                TCGv_i64 src, int tbi)
 {
-    /* Note that TBII is TBI1:TBI0.  */
-    int tbi = s->tbii;
-
-    if (s->current_el <= 1) {
-        if (tbi != 0) {
-            /* Sign-extend from bit 55.  */
-            tcg_gen_sextract_i64(cpu_pc, src, 0, 56);
-
-            if (tbi != 3) {
-                TCGv_i64 tcg_zero = tcg_const_i64(0);
-
-                /*
-                 * The two TBI bits differ.
-                 * If tbi0, then !tbi1: only use the extension if positive.
-                 * if !tbi0, then tbi1: only use the extension if negative.
-                 */
-                tcg_gen_movcond_i64(tbi == 1 ? TCG_COND_GE : TCG_COND_LT,
-                                    cpu_pc, cpu_pc, tcg_zero, cpu_pc, src);
-                tcg_temp_free_i64(tcg_zero);
-            }
-            return;
-        }
+    if (tbi == 0) {
+        /* Load unmodified address */
+        tcg_gen_mov_i64(dst, src);
+    } else if (s->current_el >= 2) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        /* Force tag byte to all zero */
+        tcg_gen_extract_i64(dst, src, 0, 56);
     } else {
-        if (tbi != 0) {
-            /* Force tag byte to all zero */
-            tcg_gen_extract_i64(cpu_pc, src, 0, 56);
-            return;
+        /* Sign-extend from bit 55.  */
+        tcg_gen_sextract_i64(dst, src, 0, 56);
+
+        if (tbi != 3) {
+            TCGv_i64 tcg_zero = tcg_const_i64(0);
+
+            /*
+             * The two TBI bits differ.
+             * If tbi0, then !tbi1: only use the extension if positive.
+             * if !tbi0, then tbi1: only use the extension if negative.
+             */
+            tcg_gen_movcond_i64(tbi == 1 ? TCG_COND_GE : TCG_COND_LT,
+                                dst, dst, tcg_zero, dst, src);
+            tcg_temp_free_i64(tcg_zero);
         }
     }
+}
 
-    /* Load unmodified address */
-    tcg_gen_mov_i64(cpu_pc, src);
+static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
+{
+    /*
+     * If address tagging is enabled for instructions via the TCR TBI bits,
+     * then loading an address into the PC will clear out any tag.
+     */
+    gen_top_byte_ignore(s, cpu_pc, src, s->tbii);
 }
 
 typedef struct DisasCompare64 {
@@ -14018,6 +14017,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
+    dc->tbid = FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
-- 
2.17.2
