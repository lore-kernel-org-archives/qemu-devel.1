Received: from eggs.gnu.org ([2001:4830:134:3::10]:51771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAu-0004vk-IS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAt-0000pI-Dd
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:44848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fpNAt-0000ou-4d
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id r1-v6so8272987pgp.11
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 17:27:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 13 Aug 2018 17:26:53 -0700
Message-Id: <20180814002653.12828-5-richard.henderson@linaro.org>
In-Reply-To: <20180814002653.12828-1-richard.henderson@linaro.org>
References: <20180814002653.12828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Use the float-to-int-scale
 softfloat routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 101 ++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 38439a2ee8..e4a7d97805 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11552,38 +11552,28 @@ float##fsz HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift, \
                                      void *fpstp) \
 { return itype##_to_##float##fsz##_scalbn(x, -shift, fpstp); }
 
-/* Notice that we want only input-denormal exception flags from the
- * scalbn operation: the other possible flags (overflow+inexact if
- * we overflow to infinity, output-denormal) aren't correct for the
- * complete scale-and-convert operation.
- */
-#define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, round) \
-uint##isz##_t HELPER(vfp_to##name##p##round)(float##fsz x, \
-                                             uint32_t shift, \
-                                             void *fpstp) \
-{ \
-    float_status *fpst = fpstp; \
-    int old_exc_flags = get_float_exception_flags(fpst); \
-    float##fsz tmp; \
-    if (float##fsz##_is_any_nan(x)) { \
-        float_raise(float_flag_invalid, fpst); \
-        return 0; \
-    } \
-    tmp = float##fsz##_scalbn(x, shift, fpst); \
-    old_exc_flags |= get_float_exception_flags(fpst) \
-        & float_flag_input_denormal; \
-    set_float_exception_flags(old_exc_flags, fpst); \
-    return float##fsz##_to_##itype##round(tmp, fpst); \
+#define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, ROUND, suff)   \
+uint##isz##_t HELPER(vfp_to##name##p##suff)(float##fsz x, uint32_t shift, \
+                                            void *fpst)                   \
+{                                                                         \
+    if (unlikely(float##fsz##_is_any_nan(x))) {                           \
+        float_raise(float_flag_invalid, fpst);                            \
+        return 0;                                                         \
+    }                                                                     \
+    return float##fsz##_to_##itype##_scalbn(x, ROUND, shift, fpst);       \
 }
 
 #define VFP_CONV_FIX(name, p, fsz, isz, itype)                   \
 VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype)                     \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, _round_to_zero) \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, )
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+                         float_round_to_zero, _round_to_zero)    \
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+                         get_float_rounding_mode(fpst), )
 
 #define VFP_CONV_FIX_A64(name, p, fsz, isz, itype)               \
 VFP_CONV_FIX_FLOAT(name, p, fsz, isz, itype)                     \
-VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype, )
+VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, isz, itype,               \
+                         get_float_rounding_mode(fpst), )
 
 VFP_CONV_FIX(sh, d, 64, 64, int16)
 VFP_CONV_FIX(sl, d, 64, 64, int32)
@@ -11623,53 +11613,64 @@ uint32_t HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
     return uint64_to_float16_scalbn(x, -shift, fpst);
 }
 
-static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
-{
-    if (unlikely(float16_is_any_nan(f))) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    } else {
-        int old_exc_flags = get_float_exception_flags(fpst);
-        float64 ret;
-
-        ret = float16_to_float64(f, true, fpst);
-        ret = float64_scalbn(ret, shift, fpst);
-        old_exc_flags |= get_float_exception_flags(fpst)
-            & float_flag_input_denormal;
-        set_float_exception_flags(old_exc_flags, fpst);
-
-        return ret;
-    }
-}
-
 uint32_t HELPER(vfp_toshh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_int16(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_int16_scalbn(x, get_float_rounding_mode(fpst),
+                                   shift, fpst);
 }
 
 uint32_t HELPER(vfp_touhh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_uint16(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_uint16_scalbn(x, get_float_rounding_mode(fpst),
+                                    shift, fpst);
 }
 
 uint32_t HELPER(vfp_toslh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_int32(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_int32_scalbn(x, get_float_rounding_mode(fpst),
+                                   shift, fpst);
 }
 
 uint32_t HELPER(vfp_toulh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_uint32(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_uint32_scalbn(x, get_float_rounding_mode(fpst),
+                                    shift, fpst);
 }
 
 uint64_t HELPER(vfp_tosqh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_int64(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_int64_scalbn(x, get_float_rounding_mode(fpst),
+                                   shift, fpst);
 }
 
 uint64_t HELPER(vfp_touqh)(uint32_t x, uint32_t shift, void *fpst)
 {
-    return float64_to_uint64(do_prescale_fp16(x, shift, fpst), fpst);
+    if (unlikely(float16_is_any_nan(x))) {
+        float_raise(float_flag_invalid, fpst);
+        return 0;
+    }
+    return float16_to_uint64_scalbn(x, get_float_rounding_mode(fpst),
+                                    shift, fpst);
 }
 
 /* Set the current fp rounding mode and return the old one.
-- 
2.17.1
