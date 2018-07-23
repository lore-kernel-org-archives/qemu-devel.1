Received: from eggs.gnu.org ([2001:4830:134:3::10]:43149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKm-0003wj-8G
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKi-0005NQ-8q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:31 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:28 -0500
Message-Id: <20180723201748.25573-80-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 79/99] target/arm: Introduce and use
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3d99d931266eaeaf7e83703a53f32232cd6faad7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c5be901b5f..bcb3b5c5e7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -614,6 +614,14 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
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
@@ -4638,11 +4646,9 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
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
@@ -7538,13 +7544,10 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
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
 
@@ -8085,13 +8088,10 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
 
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
@@ -12010,11 +12010,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
2.17.1
