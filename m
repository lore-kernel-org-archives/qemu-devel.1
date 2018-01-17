Received: from eggs.gnu.org ([2001:4830:134:3::10]:39226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqNE-00070u-Fg
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqNB-0003rS-8P
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:36 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqNA-0003qu-JW
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:32 -0500
Received: by mail-pf0-x244.google.com with SMTP id e11so11794441pff.6
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:15:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:14:28 -0800
Message-Id: <20180117161435.28981-14-richard.henderson@linaro.org>
In-Reply-To: <20180117161435.28981-1-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v10.5 13/20] target/arm: Use vector
 infrastructure for aa64 mov/not/neg
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b97bc9b83c..219cc1e19d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -85,6 +85,7 @@ typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 
 /* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
@@ -4579,14 +4580,19 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i64 tcg_op;
     TCGv_i64 tcg_res;
 
+    switch (opcode) {
+    case 0x0: /* FMOV */
+        tcg_gen_gvec_mov(0, vec_full_reg_offset(s, rd),
+                         vec_full_reg_offset(s, rn),
+                         8, vec_full_reg_size(s));
+        return;
+    }
+
     fpst = get_fpstatus_ptr();
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
     switch (opcode) {
-    case 0x0: /* FMOV */
-        tcg_gen_mov_i64(tcg_res, tcg_op);
-        break;
     case 0x1: /* FABS */
         gen_helper_vfp_absd(tcg_res, tcg_op);
         break;
@@ -9170,6 +9176,12 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         gvec_fn = tcg_gen_gvec_andc;
         goto do_fn;
     case 2: /* ORR */
+        if (rn == rm) { /* MOV */
+            tcg_gen_gvec_mov(0, vec_full_reg_offset(s, rd),
+                             vec_full_reg_offset(s, rn),
+                             is_q ? 16 : 8, vec_full_reg_size(s));
+            return;
+        }
         gvec_fn = tcg_gen_gvec_or;
         goto do_fn;
     case 3: /* ORN */
@@ -10049,6 +10061,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     int rmode = -1;
     TCGv_i32 tcg_rmode;
     TCGv_ptr tcg_fpstatus;
+    GVecGen2Fn *gvec_fn;
 
     switch (opcode) {
     case 0x0: /* REV64, REV32 */
@@ -10057,8 +10070,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         return;
     case 0x5: /* CNT, NOT, RBIT */
         if (u && size == 0) {
-            /* NOT: adjust size so we can use the 64-bits-at-a-time loop. */
-            size = 3;
+            /* NOT */
             break;
         } else if (u && size == 1) {
             /* RBIT */
@@ -10310,6 +10322,27 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         tcg_rmode = NULL;
     }
 
+    switch (opcode) {
+    case 0x5:
+        if (u && size == 0) { /* NOT */
+            gvec_fn = tcg_gen_gvec_not;
+            goto do_fn;
+        }
+        break;
+    case 0xb:
+        if (u) { /* NEG */
+            gvec_fn = tcg_gen_gvec_neg;
+            goto do_fn;
+        }
+        break;
+
+    do_fn:
+        gvec_fn(size, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+    }
+
     if (size == 3) {
         /* All 64-bit element operations can be shared with scalar 2misc */
         int pass;
-- 
2.14.3
