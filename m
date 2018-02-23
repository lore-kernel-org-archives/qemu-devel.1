Received: from eggs.gnu.org ([2001:4830:134:3::10]:44559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFP6-0002x5-4Y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFP4-0007UD-RW
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:56 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFP4-0007RD-Hq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:54 -0500
Received: by mail-wm0-x241.google.com with SMTP id 191so5339413wmm.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:22 +0000
Message-Id: <20180223153636.29809-18-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/31] arm/translate-a64: add FP16 FPRINTx
 to simd_two_reg_misc_fp16
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

This adds the full range of half-precision floating point to integral
instructions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fix re-base conflicts
  - move comment to previous commit
  - don't double test is_scalar in unallocated checks
---
 target/arm/helper-a64.c    |  22 ++++++++
 target/arm/helper-a64.h    |   2 +
 target/arm/translate-a64.c | 123 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 4d5ae96d8f..4fd28fdf48 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -745,3 +745,25 @@ uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
     int compare = float16_compare(f0, f1, fpst);
     return ADVSIMD_CMPRES(compare == float_relation_greater);
 }
+
+/* round to integral */
+float16 HELPER(advsimd_rinth_exact)(float16 x, void *fp_status)
+{
+    return float16_round_to_int(x, fp_status);
+}
+
+float16 HELPER(advsimd_rinth)(float16 x, void *fp_status)
+{
+    int old_flags = get_float_exception_flags(fp_status), new_flags;
+    float16 ret;
+
+    ret = float16_round_to_int(x, fp_status);
+
+    /* Suppress any inexact exceptions the conversion produced */
+    if (!(old_flags & float_flag_inexact)) {
+        new_flags = get_float_exception_flags(fp_status);
+        set_float_exception_flags(new_flags & ~float_flag_inexact, fp_status);
+    }
+
+    return ret;
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 003ffa582f..bc8d5b105b 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -75,3 +75,5 @@ DEF_HELPER_3(advsimd_maxnum2h, i32, i32, i32, ptr)
 DEF_HELPER_3(advsimd_minnum2h, i32, i32, i32, ptr)
 DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, ptr)
 DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, ptr)
+DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
+DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ea453fb6d9..6f33663c7b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11180,27 +11180,140 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
  */
 static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 {
-    int fpop, opcode, a;
+    int fpop, opcode, a, u;
+    int rn, rd;
+    bool is_q;
+    bool is_scalar;
+    bool only_in_vector = false;
+
+    int pass;
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr tcg_fpstatus = NULL;
+    bool need_rmode = false;
+    int rmode;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
         unallocated_encoding(s);
         return;
     }
 
-    if (!fp_access_check(s)) {
-        return;
-    }
+    rd = extract32(insn, 0, 5);
+    rn = extract32(insn, 5, 5);
 
-    opcode = extract32(insn, 12, 4);
     a = extract32(insn, 23, 1);
+    u = extract32(insn, 29, 1);
+    is_scalar = extract32(insn, 28, 1);
+    is_q = extract32(insn, 30, 1);
+
+    opcode = extract32(insn, 12, 5);
     fpop = deposit32(opcode, 5, 1, a);
+    fpop = deposit32(fpop, 6, 1, u);
 
     switch (fpop) {
+    case 0x18: /* FRINTN */
+        need_rmode = true;
+        only_in_vector = true;
+        rmode = FPROUNDING_TIEEVEN;
+        break;
+    case 0x19: /* FRINTM */
+        need_rmode = true;
+        only_in_vector = true;
+        rmode = FPROUNDING_NEGINF;
+        break;
+    case 0x38: /* FRINTP */
+        need_rmode = true;
+        only_in_vector = true;
+        rmode = FPROUNDING_POSINF;
+        break;
+    case 0x39: /* FRINTZ */
+        need_rmode = true;
+        only_in_vector = true;
+        rmode = FPROUNDING_ZERO;
+        break;
+    case 0x58: /* FRINTA */
+        need_rmode = true;
+        only_in_vector = true;
+        rmode = FPROUNDING_TIEAWAY;
+        break;
+    case 0x59: /* FRINTX */
+    case 0x79: /* FRINTI */
+        only_in_vector = true;
+        /* current rounding mode */
+        break;
     default:
         fprintf(stderr, "%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
         g_assert_not_reached();
     }
 
+
+    /* Check additional constraints for the scalar encoding */
+    if (is_scalar) {
+        if (!is_q) {
+            unallocated_encoding(s);
+            return;
+        }
+        /* FRINTxx is only in the vector form */
+        if (only_in_vector) {
+            unallocated_encoding(s);
+            return;
+        }
+    }
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    if (need_rmode) {
+        tcg_fpstatus = get_fpstatus_ptr(true);
+    }
+
+    if (need_rmode) {
+        tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
+    }
+
+    if (is_scalar) {
+        /* no operations yet */
+    } else {
+        for (pass = 0; pass < (is_q ? 8 : 4); pass++) {
+            TCGv_i32 tcg_op = tcg_temp_new_i32();
+            TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, tcg_op, rn, pass, MO_16);
+
+            switch (fpop) {
+            case 0x18: /* FRINTN */
+            case 0x19: /* FRINTM */
+            case 0x38: /* FRINTP */
+            case 0x39: /* FRINTZ */
+            case 0x58: /* FRINTA */
+            case 0x79: /* FRINTI */
+                gen_helper_advsimd_rinth(tcg_res, tcg_op, tcg_fpstatus);
+                break;
+            case 0x59: /* FRINTX */
+                gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
+
+            tcg_temp_free_i32(tcg_res);
+            tcg_temp_free_i32(tcg_op);
+        }
+
+        clear_vec_high(s, is_q, rd);
+    }
+
+    if (tcg_rmode) {
+        gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
+        tcg_temp_free_i32(tcg_rmode);
+    }
+
+    if (tcg_fpstatus) {
+        tcg_temp_free_ptr(tcg_fpstatus);
+    }
 }
 
 /* AdvSIMD scalar x indexed element
-- 
2.15.1
