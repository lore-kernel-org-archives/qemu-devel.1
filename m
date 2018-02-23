Received: from eggs.gnu.org ([2001:4830:134:3::10]:46147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUp-00009i-9m
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUn-0005yi-JQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:51 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFUn-0005x9-9i
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id z9so5345612wmb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:42:49 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:24 +0000
Message-Id: <20180223153636.29809-20-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 19/31] arm/translate-a64: add FP16 FCMxx
 (zero) to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

I re-use the existing handle_2misc_fcmp_zero handler and tweak it
slightly to deal with the half-precision case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use size directly wuth read/write_vec_element
  - drop unneeded break
  - WIP: mess with calculating maxpasses
---
 target/arm/translate-a64.c | 80 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e3318837c9..c251121c2b 100644
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
2.15.1
