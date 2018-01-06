Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew3-0007cp-RD
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew1-0005NO-KK
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:15 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXew1-0005M0-Bq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:13 -0500
Received: by mail-pf0-x241.google.com with SMTP id a90so2970442pfk.1
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:13 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:37 -0800
Message-Id: <20180106031346.6650-15-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 14/23] target/arm: Use vector infrastructure
 for aa64 add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 207 +++++++++++++++++++++++++++++----------------
 1 file changed, 134 insertions(+), 73 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ba94f7d045..572af456d1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "translate.h"
@@ -83,6 +84,10 @@ typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 
+/* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
@@ -535,6 +540,21 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
     return offs;
 }
 
+/* Return the offset info CPUARMState of the "whole" vector register Qn.  */
+static inline int vec_full_reg_offset(DisasContext *s, int regno)
+{
+    assert_fp_access_checked(s);
+    return offsetof(CPUARMState, vfp.regs[regno * 2]);
+}
+
+/* Return the byte size of the "whole" vector register, VL / 8.  */
+static inline int vec_full_reg_size(DisasContext *s)
+{
+    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->flags.
+       In the meantime this is just the AdvSIMD length of 128.  */
+    return 128 / 8;
+}
+
 /* Return the offset into CPUARMState of a slice (from
  * the least significant end) of FP register Qn (ie
  * Dn, Sn, Hn or Bn).
@@ -9048,85 +9068,125 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rm);
+    tcg_gen_and_i64(rn, rn, rd);
+    tcg_gen_xor_i64(rd, rm, rn);
+}
+
+static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_and_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_andc_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rm);
+    tcg_gen_and_vec(vece, rn, rn, rd);
+    tcg_gen_xor_vec(vece, rd, rm, rn);
+}
+
+static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_and_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
+static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_andc_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
 /* Logic op (opcode == 3) subgroup of C3.6.16. */
 static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 {
+    static const GVecGen3 bsl_op = {
+        .fni8 = gen_bsl_i64,
+        .fniv = gen_bsl_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+    static const GVecGen3 bit_op = {
+        .fni8 = gen_bit_i64,
+        .fniv = gen_bit_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+    static const GVecGen3 bif_op = {
+        .fni8 = gen_bif_i64,
+        .fniv = gen_bif_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .load_dest = true
+    };
+
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int rm = extract32(insn, 16, 5);
     int size = extract32(insn, 22, 2);
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
-    TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
-    int pass;
+    GVecGen3Fn *gvec_fn;
+    const GVecGen3 *gvec_op;
 
     if (!fp_access_check(s)) {
         return;
     }
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_res[0] = tcg_temp_new_i64();
-    tcg_res[1] = tcg_temp_new_i64();
-
-    for (pass = 0; pass < (is_q ? 2 : 1); pass++) {
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-        if (!is_u) {
-            switch (size) {
-            case 0: /* AND */
-                tcg_gen_and_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 1: /* BIC */
-                tcg_gen_andc_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 2: /* ORR */
-                tcg_gen_or_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 3: /* ORN */
-                tcg_gen_orc_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            }
-        } else {
-            if (size != 0) {
-                /* B* ops need res loaded to operate on */
-                read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-            }
-
-            switch (size) {
-            case 0: /* EOR */
-                tcg_gen_xor_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            case 1: /* BSL bitwise select */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_op2, tcg_op1);
-                break;
-            case 2: /* BIT, bitwise insert if true */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_and_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-                break;
-            case 3: /* BIF, bitwise insert if false */
-                tcg_gen_xor_i64(tcg_op1, tcg_op1, tcg_res[pass]);
-                tcg_gen_andc_i64(tcg_op1, tcg_op1, tcg_op2);
-                tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-                break;
-            }
-        }
-    }
+    switch (size + 4 * is_u) {
+    case 0: /* AND */
+        gvec_fn = tcg_gen_gvec_and;
+        goto do_fn;
+    case 1: /* BIC */
+        gvec_fn = tcg_gen_gvec_andc;
+        goto do_fn;
+    case 2: /* ORR */
+        gvec_fn = tcg_gen_gvec_or;
+        goto do_fn;
+    case 3: /* ORN */
+        gvec_fn = tcg_gen_gvec_orc;
+        goto do_fn;
+    case 4: /* EOR */
+        gvec_fn = tcg_gen_gvec_xor;
+        goto do_fn;
+    do_fn:
+        gvec_fn(0, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                vec_full_reg_offset(s, rm),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+
+    case 5: /* BSL bitwise select */
+        gvec_op = &bsl_op;
+        goto do_op;
+    case 6: /* BIT, bitwise insert if true */
+        gvec_op = &bit_op;
+        goto do_op;
+    case 7: /* BIF, bitwise insert if false */
+        gvec_op = &bif_op;
+        goto do_op;
+    do_op:
+        tcg_gen_gvec_3(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
+        return;
 
-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    if (!is_q) {
-        tcg_gen_movi_i64(tcg_res[1], 0);
+    default:
+        g_assert_not_reached();
     }
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-
-    tcg_temp_free_i64(tcg_op1);
-    tcg_temp_free_i64(tcg_op2);
-    tcg_temp_free_i64(tcg_res[0]);
-    tcg_temp_free_i64(tcg_res[1]);
 }
 
 /* Helper functions for 32 bit comparisons */
@@ -9387,6 +9447,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
+    GVecGen3Fn *gvec_op;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -9426,6 +9487,16 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     }
 
+    switch (opcode) {
+    case 0x10: /* ADD, SUB */
+        gvec_op = u ? tcg_gen_gvec_sub : tcg_gen_gvec_add;
+        gvec_op(size, vec_full_reg_offset(s, rd),
+                vec_full_reg_offset(s, rn),
+                vec_full_reg_offset(s, rm),
+                is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
+    }
+
     if (size == 3) {
         assert(is_q);
         for (pass = 0; pass < 2; pass++) {
@@ -9598,16 +9669,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x10: /* ADD, SUB */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_add_u8, gen_helper_neon_sub_u8 },
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x11: /* CMTST, CMEQ */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
-- 
2.14.3
