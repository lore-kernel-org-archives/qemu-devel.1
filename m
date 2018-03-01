Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK5-0003uG-EJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK4-0008Dl-BG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMK4-0008DQ-4t
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK3-0000fQ-87
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:53 +0000
Message-Id: <20180301112403.12487-33-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/42] arm/translate-a64: add FP16 FRCPX to
 simd_two_reg_misc_fp16
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

We go with the localised helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-25-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |  1 +
 target/arm/helper-a64.c    | 29 +++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  4 ++++
 3 files changed, 34 insertions(+)

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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 50b4fa4ce4..715dc4333d 100644
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
2.16.2
