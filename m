Received: from eggs.gnu.org ([2001:4830:134:3::10]:37584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdP-0007V6-DI
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdN-00057g-Hz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:11 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdN-000575-AE
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:09 -0500
Received: by mail-pf0-x241.google.com with SMTP id 68so976495pfj.8
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:37 -0800
Message-Id: <20180207225540.31698-18-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/20] target/arm: Use vector infrastructure for
 aa64 multiplies
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 154 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 129 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2ac297fc14..91f0ab7f12 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9749,6 +9749,66 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_add_u8(d, d, a);
+}
+
+static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_add_u16(d, d, a);
+}
+
+static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_sub_u8(d, d, a);
+}
+
+static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_sub_u16(d, d, a);
+}
+
+static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_sub_i32(d, d, a);
+}
+
+static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_sub_i64(d, d, a);
+}
+
+static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_sub_vec(vece, d, d, a);
+}
+
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -9767,6 +9827,52 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
+    static const GVecGen3 mla_op[4] = {
+        { .fni4 = gen_mla8_i32,
+          .fniv = gen_mla_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni4 = gen_mla16_i32,
+          .fniv = gen_mla_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_mla32_i32,
+          .fniv = gen_mla_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_mla64_i64,
+          .fniv = gen_mla_vec,
+          .opc = INDEX_op_mul_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    static const GVecGen3 mls_op[4] = {
+        { .fni4 = gen_mls8_i32,
+          .fniv = gen_mls_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni4 = gen_mls16_i32,
+          .fniv = gen_mls_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_mls32_i32,
+          .fniv = gen_mls_vec,
+          .opc = INDEX_op_mul_vec,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_mls64_i64,
+          .fniv = gen_mls_vec,
+          .opc = INDEX_op_mul_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
 
     int is_q = extract32(insn, 30, 1);
     int u = extract32(insn, 29, 1);
@@ -9824,6 +9930,19 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
         }
         return;
+    case 0x13: /* MUL, PMUL */
+        if (!u) { /* MUL */
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
+            return;
+        }
+        break;
+    case 0x12: /* MLA, MLS */
+        if (u) {
+            gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
+        } else {
+            gen_gvec_op3(s, is_q, rd, rn, rm, &mla_op[size]);
+        }
+        return;
     case 0x11:
         if (!u) { /* CMTST */
             gen_gvec_op3(s, is_q, rd, rn, rm, &cmtst_op[size]);
@@ -9998,23 +10117,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 break;
             }
             case 0x13: /* MUL, PMUL */
-                if (u) {
-                    /* PMUL */
-                    assert(size == 0);
-                    genfn = gen_helper_neon_mul_p8;
-                    break;
-                }
-                /* fall through : MUL */
-            case 0x12: /* MLA, MLS */
-            {
-                static NeonGenTwoOpFn * const fns[3] = {
-                    gen_helper_neon_mul_u8,
-                    gen_helper_neon_mul_u16,
-                    tcg_gen_mul_i32,
-                };
-                genfn = fns[size];
+                assert(u); /* PMUL */
+                assert(size == 0);
+                genfn = gen_helper_neon_mul_p8;
                 break;
-            }
             case 0x16: /* SQDMULH, SQRDMULH */
             {
                 static NeonGenTwoOpEnvFn * const fns[2][2] = {
@@ -10035,18 +10141,16 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op1, tcg_op2);
             }
 
-            if (opcode == 0xf || opcode == 0x12) {
-                /* SABA, UABA, MLA, MLS: accumulating ops */
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_add_u8, gen_helper_neon_sub_u8 },
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
+            if (opcode == 0xf) {
+                /* SABA, UABA: accumulating ops */
+                static NeonGenTwoOpFn * const fns[3] = {
+                    gen_helper_neon_add_u8,
+                    gen_helper_neon_add_u16,
+                    tcg_gen_add_i32,
                 };
-                bool is_sub = (opcode == 0x12 && u); /* MLS */
 
-                genfn = fns[size][is_sub];
                 read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
-                genfn(tcg_res, tcg_op1, tcg_res);
+                fns[size](tcg_res, tcg_op1, tcg_res);
             }
 
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-- 
2.14.3
