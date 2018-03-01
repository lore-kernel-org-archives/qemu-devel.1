Received: from eggs.gnu.org ([2001:4830:134:3::10]:33948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK2-0003r5-8o
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK1-0008CT-3n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMK0-0008BS-S6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:25 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJz-0000eB-Nw
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:48 +0000
Message-Id: <20180301112403.12487-28-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/42] arm/translate-a64: add FP16 FCMxx (zero)
 to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

I re-use the existing handle_2misc_fcmp_zero handler and tweak it
slightly to deal with the half-precision case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-20-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 80 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 046079b1b3..9c02f1e23c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7821,14 +7821,14 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
                                    bool is_scalar, bool is_u, bool is_q,
                                    int size, int rn, int rd)
 {
-    bool is_double = (size == 3);
+    bool is_double = (size == MO_64);
     TCGv_ptr fpst;
 
     if (!fp_access_check(s)) {
         return;
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = get_fpstatus_ptr(size == MO_16);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
@@ -7880,34 +7880,57 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         bool swap = false;
         int pass, maxpasses;
 
-        switch (opcode) {
-        case 0x2e: /* FCMLT (zero) */
-            swap = true;
-            /* fall through */
-        case 0x2c: /* FCMGT (zero) */
-            genfn = gen_helper_neon_cgt_f32;
-            break;
-        case 0x2d: /* FCMEQ (zero) */
-            genfn = gen_helper_neon_ceq_f32;
-            break;
-        case 0x6d: /* FCMLE (zero) */
-            swap = true;
-            /* fall through */
-        case 0x6c: /* FCMGE (zero) */
-            genfn = gen_helper_neon_cge_f32;
-            break;
-        default:
-            g_assert_not_reached();
+        if (size == MO_16) {
+            switch (opcode) {
+            case 0x2e: /* FCMLT (zero) */
+                swap = true;
+                /* fall through */
+            case 0x2c: /* FCMGT (zero) */
+                genfn = gen_helper_advsimd_cgt_f16;
+                break;
+            case 0x2d: /* FCMEQ (zero) */
+                genfn = gen_helper_advsimd_ceq_f16;
+                break;
+            case 0x6d: /* FCMLE (zero) */
+                swap = true;
+                /* fall through */
+            case 0x6c: /* FCMGE (zero) */
+                genfn = gen_helper_advsimd_cge_f16;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            switch (opcode) {
+            case 0x2e: /* FCMLT (zero) */
+                swap = true;
+                /* fall through */
+            case 0x2c: /* FCMGT (zero) */
+                genfn = gen_helper_neon_cgt_f32;
+                break;
+            case 0x2d: /* FCMEQ (zero) */
+                genfn = gen_helper_neon_ceq_f32;
+                break;
+            case 0x6d: /* FCMLE (zero) */
+                swap = true;
+                /* fall through */
+            case 0x6c: /* FCMGE (zero) */
+                genfn = gen_helper_neon_cge_f32;
+                break;
+            default:
+                g_assert_not_reached();
+            }
         }
 
         if (is_scalar) {
             maxpasses = 1;
         } else {
-            maxpasses = is_q ? 4 : 2;
+            int vector_size = 8 << is_q;
+            maxpasses = vector_size >> size;
         }
 
         for (pass = 0; pass < maxpasses; pass++) {
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
+            read_vec_element_i32(s, tcg_op, rn, pass, size);
             if (swap) {
                 genfn(tcg_res, tcg_zero, tcg_op, fpst);
             } else {
@@ -7916,7 +7939,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
             if (is_scalar) {
                 write_fp_sreg(s, rd, tcg_res);
             } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
+                write_vec_element_i32(s, tcg_res, rd, pass, size);
             }
         }
         tcg_temp_free_i32(tcg_res);
@@ -11209,7 +11232,18 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     fpop = deposit32(opcode, 5, 1, a);
     fpop = deposit32(fpop, 6, 1, u);
 
+    rd = extract32(insn, 0, 5);
+    rn = extract32(insn, 5, 5);
+
     switch (fpop) {
+    break;
+    case 0x2c: /* FCMGT (zero) */
+    case 0x2d: /* FCMEQ (zero) */
+    case 0x2e: /* FCMLT (zero) */
+    case 0x6c: /* FCMGE (zero) */
+    case 0x6d: /* FCMLE (zero) */
+        handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd);
+        return;
     case 0x18: /* FRINTN */
         need_rmode = true;
         only_in_vector = true;
-- 
2.16.2
