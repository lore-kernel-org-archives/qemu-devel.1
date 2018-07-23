Received: from eggs.gnu.org ([2001:4830:134:3::10]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKW-0003kj-Ba
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKV-0005Hd-1k
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:16 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:22 -0500
Message-Id: <20180723201748.25573-74-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 73/99] target/arm: Fix float16 to/from int16
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

The instruction "ucvtf v0.4h, v04h, #2", with input 0x8000u,
overflows the intermediate float16 to infinity before we have a
chance to scale the output.  Use float64 as the intermediate type
so that no input argument (uint32_t in this case) can overflow
or round before scaling.  Given the declared argument, the signed
int32_t function has the same problem.

When converting from float16 to integer, using u/int32_t instead
of u/int16_t means that the bounding is incorrect.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180502221552.3873-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 88808a022c06f98d81cd3f2d105a5734c5614839)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper.c        | 53 ++++++++++++++++++++++++++++++++++++--
 target/arm/helper.h        |  4 +--
 target/arm/translate-a64.c |  4 +--
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b14fdab140..c07c1d7f48 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11409,11 +11409,60 @@ VFP_CONV_FIX_A64(sq, s, 32, 64, int64)
 VFP_CONV_FIX(uh, s, 32, 32, uint16)
 VFP_CONV_FIX(ul, s, 32, 32, uint32)
 VFP_CONV_FIX_A64(uq, s, 32, 64, uint64)
-VFP_CONV_FIX_A64(sl, h, 16, 32, int32)
-VFP_CONV_FIX_A64(ul, h, 16, 32, uint32)
+
 #undef VFP_CONV_FIX
 #undef VFP_CONV_FIX_FLOAT
 #undef VFP_CONV_FLOAT_FIX_ROUND
+#undef VFP_CONV_FIX_A64
+
+/* Conversion to/from f16 can overflow to infinity before/after scaling.
+ * Therefore we convert to f64 (which does not round), scale,
+ * and then convert f64 to f16 (which may round).
+ */
+
+static float16 do_postscale_fp16(float64 f, int shift, float_status *fpst)
+{
+    return float64_to_float16(float64_scalbn(f, -shift, fpst), true, fpst);
+}
+
+float16 HELPER(vfp_sltoh)(uint32_t x, uint32_t shift, void *fpst)
+{
+    return do_postscale_fp16(int32_to_float64(x, fpst), shift, fpst);
+}
+
+float16 HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
+{
+    return do_postscale_fp16(uint32_to_float64(x, fpst), shift, fpst);
+}
+
+static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
+{
+    if (unlikely(float16_is_any_nan(f))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    } else {
+        int old_exc_flags = get_float_exception_flags(fpst);
+        float64 ret;
+
+        ret = float16_to_float64(f, true, fpst);
+        ret = float64_scalbn(ret, shift, fpst);
+        old_exc_flags |= get_float_exception_flags(fpst)
+            & float_flag_input_denormal;
+        set_float_exception_flags(old_exc_flags, fpst);
+
+        return ret;
+    }
+}
+
+uint32_t HELPER(vfp_toshh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_int16(do_prescale_fp16(x, shift, fpst), fpst);
+}
+
+uint32_t HELPER(vfp_touhh)(float16 x, uint32_t shift, void *fpst)
+{
+    return float64_to_uint16(do_prescale_fp16(x, shift, fpst), fpst);
+}
 
 /* Set the current fp rounding mode and return the old one.
  * The argument is a softfloat float_round_ value.
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 34e8cc8904..1969b37f2d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -149,8 +149,8 @@ DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
 DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
 DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
 DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 61735dc185..3c4c9b9fdc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7263,9 +7263,9 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
         switch (size) {
         case MO_16:
             if (is_u) {
-                fn = gen_helper_vfp_toulh;
+                fn = gen_helper_vfp_touhh;
             } else {
-                fn = gen_helper_vfp_toslh;
+                fn = gen_helper_vfp_toshh;
             }
             break;
         case MO_32:
-- 
2.17.1
