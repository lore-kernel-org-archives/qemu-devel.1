Received: from eggs.gnu.org ([2001:4830:134:3::10]:45930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUh-0008Qm-2C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFUf-0005eb-4O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:43 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFUe-0005d4-SR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:42:41 -0500
Received: by mail-wr0-x242.google.com with SMTP id p104so14512731wrc.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:42:40 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:29 +0000
Message-Id: <20180223153636.29809-25-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 24/31] arm/translate-a64: add FP16 FRCPX to
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

We go with the localised helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c    | 29 +++++++++++++++++++++++++++++
 target/arm/helper-a64.h    |  1 +
 target/arm/translate-a64.c |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 722fff2349..92a0d55a9c 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -356,6 +356,35 @@ uint64_t HELPER(neon_addlp_u16)(uint64_t a)
 }
 
 /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
+float16 HELPER(frecpx_f16)(float16 a, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    uint16_t val16, sbit;
+    int16_t exp;
+
+    if (float16_is_any_nan(a)) {
+        float16 nan = a;
+        if (float16_is_signaling_nan(a, fpst)) {
+            float_raise(float_flag_invalid, fpst);
+            nan = float16_maybe_silence_nan(a, fpst);
+        }
+        if (fpst->default_nan_mode) {
+            nan = float16_default_nan(fpst);
+        }
+        return nan;
+    }
+
+    val16 = float16_val(a);
+    sbit = 0x8000 & val16;
+    exp = extract32(val16, 10, 5);
+
+    if (exp == 0) {
+        return make_float16(deposit32(sbit, 10, 5, 0x1e));
+    } else {
+        return make_float16(deposit32(sbit, 10, 5, ~exp));
+    }
+}
+
 float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
 {
     float_status *fpst = fpstp;
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 32931b17c6..339323fc3d 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -41,6 +41,7 @@ DEF_HELPER_FLAGS_1(neon_addlp_s16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(neon_addlp_u16, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
+DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, env)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 56de5711fe..a7e99e2a2f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11312,6 +11312,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         handle_2misc_fcmp_zero(s, fpop, is_scalar, 0, is_q, MO_16, rn, rd);
         return;
     case 0x3d: /* FRECPE */
+    case 0x3f: /* FRECPX */
         break;
     case 0x18: /* FRINTN */
         need_rmode = true;
@@ -11436,6 +11437,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x3d: /* FRECPE */
             gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x3f: /* FRECPX */
+            gen_helper_frecpx_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
-- 
2.15.1
