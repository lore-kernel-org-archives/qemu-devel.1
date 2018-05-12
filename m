Received: from eggs.gnu.org ([2001:4830:134:3::10]:59156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISb-0006Ef-Vz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISa-0008AM-Um
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:30 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHISa-00089F-QZ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:28 -0400
Received: by mail-pl0-x241.google.com with SMTP id ay10-v6so4134338plb.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:32:11 -0700
Message-Id: <20180512003217.9105-6-richard.henderson@linaro.org>
In-Reply-To: <20180512003217.9105-1-richard.henderson@linaro.org>
References: <20180512003217.9105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 05/11] target/arm: Introduce and use
 read_fp_hreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d0ed125442..78f12daaf6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -615,6 +615,14 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
     return v;
 }
 
+static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
+{
+    TCGv_i32 v = tcg_temp_new_i32();
+
+    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_16));
+    return v;
+}
+
 /* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
  * If SVE is not enabled, then there are only 128 bits in the vector.
  */
@@ -4881,11 +4889,9 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
     TCGv_ptr fpst = NULL;
-    TCGv_i32 tcg_op = tcg_temp_new_i32();
+    TCGv_i32 tcg_op = read_fp_hreg(s, rn);
     TCGv_i32 tcg_res = tcg_temp_new_i32();
 
-    read_vec_element_i32(s, tcg_op, rn, 0, MO_16);
-
     switch (opcode) {
     case 0x0: /* FMOV */
         tcg_gen_mov_i32(tcg_res, tcg_op);
@@ -7784,13 +7790,10 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
         tcg_temp_free_i64(tcg_op2);
         tcg_temp_free_i64(tcg_res);
     } else {
-        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-        TCGv_i32 tcg_op2 = tcg_temp_new_i32();
+        TCGv_i32 tcg_op1 = read_fp_hreg(s, rn);
+        TCGv_i32 tcg_op2 = read_fp_hreg(s, rm);
         TCGv_i64 tcg_res = tcg_temp_new_i64();
 
-        read_vec_element_i32(s, tcg_op1, rn, 0, MO_16);
-        read_vec_element_i32(s, tcg_op2, rm, 0, MO_16);
-
         gen_helper_neon_mull_s16(tcg_res, tcg_op1, tcg_op2);
         gen_helper_neon_addl_saturate_s32(tcg_res, cpu_env, tcg_res, tcg_res);
 
@@ -8331,13 +8334,10 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
 
     fpst = get_fpstatus_ptr(true);
 
-    tcg_op1 = tcg_temp_new_i32();
-    tcg_op2 = tcg_temp_new_i32();
+    tcg_op1 = read_fp_hreg(s, rn);
+    tcg_op2 = read_fp_hreg(s, rm);
     tcg_res = tcg_temp_new_i32();
 
-    read_vec_element_i32(s, tcg_op1, rn, 0, MO_16);
-    read_vec_element_i32(s, tcg_op2, rm, 0, MO_16);
-
     switch (fpopcode) {
     case 0x03: /* FMULX */
         gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
@@ -12235,11 +12235,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     }
 
     if (is_scalar) {
-        TCGv_i32 tcg_op = tcg_temp_new_i32();
+        TCGv_i32 tcg_op = read_fp_hreg(s, rn);
         TCGv_i32 tcg_res = tcg_temp_new_i32();
 
-        read_vec_element_i32(s, tcg_op, rn, 0, MO_16);
-
         switch (fpop) {
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
-- 
2.17.0
