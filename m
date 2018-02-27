Received: from eggs.gnu.org ([2001:4830:134:3::10]:55968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPR-0003lQ-W1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPQ-00083j-CF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:13 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPP-00082l-VG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:12 -0500
Received: by mail-wm0-x243.google.com with SMTP id 188so23613694wme.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:39:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:39 +0000
Message-Id: <20180227143852.11175-19-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 18/31] arm/translate-a64: add FCVTxx to
 simd_two_reg_misc_fp16
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

This covers all the floating point convert operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c    | 32 +++++++++++++++++
 target/arm/helper-a64.h    |  2 ++
 target/arm/translate-a64.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 4fd28fdf48..722fff2349 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -767,3 +767,35 @@ float16 HELPER(advsimd_rinth)(float16 x, void *fp_status)
 
     return ret;
 }
+
+/*
+ * Half-precision floating point conversion functions
+ *
+ * There are a multitude of conversion functions with various
+ * different rounding modes. This is dealt with by the calling code
+ * setting the mode appropriately before calling the helper.
+ */
+
+uint32_t HELPER(advsimd_f16tosinth)(float16 a, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    /* Invalid if we are passed a NaN */
+    if (float16_is_any_nan(a)) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_int16(a, fpst);
+}
+
+uint32_t HELPER(advsimd_f16touinth)(float16 a, void *fpstp)
+{
+    float_status *fpst = fpstp;
+
+    /* Invalid if we are passed a NaN */
+    if (float16_is_any_nan(a)) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_uint16(a, fpst);
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index bc8d5b105b..32931b17c6 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -77,3 +77,5 @@ DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, ptr)
 DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, ptr)
 DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
+DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
+DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3c37eb99ff..046079b1b3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11240,6 +11240,46 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         only_in_vector = true;
         /* current rounding mode */
         break;
+    case 0x1a: /* FCVTNS */
+        need_rmode = true;
+        rmode = FPROUNDING_TIEEVEN;
+        break;
+    case 0x1b: /* FCVTMS */
+        need_rmode = true;
+        rmode = FPROUNDING_NEGINF;
+        break;
+    case 0x1c: /* FCVTAS */
+        need_rmode = true;
+        rmode = FPROUNDING_TIEAWAY;
+        break;
+    case 0x3a: /* FCVTPS */
+        need_rmode = true;
+        rmode = FPROUNDING_POSINF;
+        break;
+    case 0x3b: /* FCVTZS */
+        need_rmode = true;
+        rmode = FPROUNDING_ZERO;
+        break;
+    case 0x5a: /* FCVTNU */
+        need_rmode = true;
+        rmode = FPROUNDING_TIEEVEN;
+        break;
+    case 0x5b: /* FCVTMU */
+        need_rmode = true;
+        rmode = FPROUNDING_NEGINF;
+        break;
+    case 0x5c: /* FCVTAU */
+        need_rmode = true;
+        rmode = FPROUNDING_TIEAWAY;
+        break;
+    case 0x7a: /* FCVTPU */
+        need_rmode = true;
+        rmode = FPROUNDING_POSINF;
+        break;
+    case 0x7b: /* FCVTZU */
+        need_rmode = true;
+        rmode = FPROUNDING_ZERO;
+        break;
     default:
         fprintf(stderr, "%s: insn %#04x fpop %#2x\n", __func__, insn, fpop);
         g_assert_not_reached();
@@ -11273,7 +11313,36 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     }
 
     if (is_scalar) {
-        /* no operations yet */
+        TCGv_i32 tcg_op = tcg_temp_new_i32();
+        TCGv_i32 tcg_res = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, tcg_op, rn, 0, MO_16);
+
+        switch (fpop) {
+        case 0x1a: /* FCVTNS */
+        case 0x1b: /* FCVTMS */
+        case 0x1c: /* FCVTAS */
+        case 0x3a: /* FCVTPS */
+        case 0x3b: /* FCVTZS */
+            gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
+            break;
+        case 0x5a: /* FCVTNU */
+        case 0x5b: /* FCVTMU */
+        case 0x5c: /* FCVTAU */
+        case 0x7a: /* FCVTPU */
+        case 0x7b: /* FCVTZU */
+            gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* limit any sign extension going on */
+        tcg_gen_andi_i32(tcg_res, tcg_res, 0xffff);
+        write_fp_sreg(s, rd, tcg_res);
+
+        tcg_temp_free_i32(tcg_res);
+        tcg_temp_free_i32(tcg_op);
     } else {
         for (pass = 0; pass < (is_q ? 8 : 4); pass++) {
             TCGv_i32 tcg_op = tcg_temp_new_i32();
@@ -11282,6 +11351,20 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op, rn, pass, MO_16);
 
             switch (fpop) {
+            case 0x1a: /* FCVTNS */
+            case 0x1b: /* FCVTMS */
+            case 0x1c: /* FCVTAS */
+            case 0x3a: /* FCVTPS */
+            case 0x3b: /* FCVTZS */
+                gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
+                break;
+            case 0x5a: /* FCVTNU */
+            case 0x5b: /* FCVTMU */
+            case 0x5c: /* FCVTAU */
+            case 0x7a: /* FCVTPU */
+            case 0x7b: /* FCVTZU */
+                gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
+                break;
             case 0x18: /* FRINTN */
             case 0x19: /* FRINTM */
             case 0x38: /* FRINTP */
-- 
2.15.1
