Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiB-0008Ev-OK
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi9-0008LB-L2
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:55 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILi9-0008JX-BT
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:53 -0400
Received: by mail-pl0-x243.google.com with SMTP id bi12-v6so8144440plb.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:13 -0700
Message-Id: <20180514221219.7091-23-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 22/28] fpu/softfloat: Specialize on
 snan_bit_is_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Only MIPS requires snan_bit_is_one to be variable.  While we are
specializing softfloat behaviour, allow other targets to eliminate
this runtime check.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v5
  - do not remove the set_snan_bit_is_one function
  - tidy the language in the snan_bit_is_one block comment
---
 fpu/softfloat-specialize.h    | 68 ++++++++++++++++++++++-------------
 include/fpu/softfloat-types.h |  1 +
 target/hppa/cpu.c             |  1 -
 target/ppc/fpu_helper.c       |  1 -
 target/sh4/cpu.c              |  1 -
 target/unicore32/cpu.c        |  2 --
 6 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index d7033b7757..d1e06da75b 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -79,13 +79,31 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-#if defined(TARGET_XTENSA)
 /* Define for architectures which deviate from IEEE in not supporting
  * signaling NaNs (so all NaNs are treated as quiet).
  */
+#if defined(TARGET_XTENSA)
 #define NO_SIGNALING_NANS 1
 #endif
 
+/* Define how the architecture discriminates signaling NaNs.
+ * This done with the most significant bit of the fraction.
+ * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
+ * the msb must be zero.  MIPS is (so far) unique in supporting both the
+ * 2008 revision and backward compatibility with their original choice.
+ * Thus for MIPS we must make the choice at runtime.
+ */
+static inline flag snan_bit_is_one(float_status *status)
+{
+#if defined(TARGET_MIPS)
+    return status->snan_bit_is_one;
+#elif defined(TARGET_HPPA) || defined(TARGET_UNICORE32) || defined(TARGET_SH4)
+    return 1;
+#else
+    return 0;
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
@@ -97,7 +115,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
     return false;
 #else
     flag msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
-    return msb == status->snan_bit_is_one;
+    return msb == snan_bit_is_one(status);
 #endif
 }
 
@@ -118,7 +136,7 @@ static FloatParts parts_default_nan(float_status *status)
 #elif defined(TARGET_HPPA)
     frac = 1ULL << (DECOMPOSED_BINARY_POINT - 2);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         frac = (1ULL << (DECOMPOSED_BINARY_POINT - 1)) - 1;
     } else {
 #if defined(TARGET_MIPS)
@@ -151,7 +169,7 @@ static FloatParts parts_silence_nan(FloatParts a, float_status *status)
     a.frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
     a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return parts_default_nan(status);
     } else {
         a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
@@ -169,7 +187,7 @@ float16 float16_default_nan(float_status *status)
 #if defined(TARGET_ARM)
     return const_float16(0x7E00);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return const_float16(0x7DFF);
     } else {
 #if defined(TARGET_MIPS)
@@ -195,7 +213,7 @@ float32 float32_default_nan(float_status *status)
 #elif defined(TARGET_HPPA)
     return const_float32(0x7FA00000);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return const_float32(0x7FBFFFFF);
     } else {
 #if defined(TARGET_MIPS)
@@ -220,7 +238,7 @@ float64 float64_default_nan(float_status *status)
 #elif defined(TARGET_HPPA)
     return const_float64(LIT64(0x7FF4000000000000));
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return const_float64(LIT64(0x7FF7FFFFFFFFFFFF));
     } else {
 #if defined(TARGET_MIPS)
@@ -242,7 +260,7 @@ floatx80 floatx80_default_nan(float_status *status)
     r.low = LIT64(0xFFFFFFFFFFFFFFFF);
     r.high = 0x7FFF;
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         r.low = LIT64(0xBFFFFFFFFFFFFFFF);
         r.high = 0x7FFF;
     } else {
@@ -274,7 +292,7 @@ float128 float128_default_nan(float_status *status)
 {
     float128 r;
 
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         r.low = LIT64(0xFFFFFFFFFFFFFFFF);
         r.high = LIT64(0x7FFF7FFFFFFFFFFF);
     } else {
@@ -319,7 +337,7 @@ int float16_is_quiet_nan(float16 a_, float_status *status)
     return float16_is_any_nan(a_);
 #else
     uint16_t a = float16_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     } else {
         return ((a & ~0x8000) >= 0x7C80);
@@ -338,7 +356,7 @@ int float16_is_signaling_nan(float16 a_, float_status *status)
     return 0;
 #else
     uint16_t a = float16_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return ((a & ~0x8000) >= 0x7C80);
     } else {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
@@ -356,7 +374,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     g_assert_not_reached();
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return float16_default_nan(status);
     } else {
         return a | (1 << 9);
@@ -375,7 +393,7 @@ int float32_is_quiet_nan(float32 a_, float_status *status)
     return float32_is_any_nan(a_);
 #else
     uint32_t a = float32_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
     } else {
         return ((uint32_t)(a << 1) >= 0xFF800000);
@@ -394,7 +412,7 @@ int float32_is_signaling_nan(float32 a_, float_status *status)
     return 0;
 #else
     uint32_t a = float32_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return ((uint32_t)(a << 1) >= 0xFF800000);
     } else {
         return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
@@ -412,7 +430,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     g_assert_not_reached();
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
 # ifdef TARGET_HPPA
         a &= ~0x00400000;
         a |=  0x00200000;
@@ -651,7 +669,7 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
         return 3;
     }
 
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         /* Prefer sNaN over qNaN, in the a, b, c order. */
         if (aIsSNaN) {
             return 0;
@@ -786,7 +804,7 @@ int float64_is_quiet_nan(float64 a_, float_status *status)
     return float64_is_any_nan(a_);
 #else
     uint64_t a = float64_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return (((a >> 51) & 0xFFF) == 0xFFE)
             && (a & 0x0007FFFFFFFFFFFFULL);
     } else {
@@ -806,7 +824,7 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
     return 0;
 #else
     uint64_t a = float64_val(a_);
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return ((a << 1) >= 0xFFF0000000000000ULL);
     } else {
         return (((a >> 51) & 0xFFF) == 0xFFE)
@@ -825,7 +843,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     g_assert_not_reached();
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
 # ifdef TARGET_HPPA
         a &= ~0x0008000000000000ULL;
         a |=  0x0004000000000000ULL;
@@ -942,7 +960,7 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     return floatx80_is_any_nan(a);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         uint64_t aLow;
 
         aLow = a.low & ~0x4000000000000000ULL;
@@ -967,7 +985,7 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     return 0;
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return ((a.high & 0x7FFF) == 0x7FFF)
             && ((a.low << 1) >= 0x8000000000000000ULL);
     } else {
@@ -991,7 +1009,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     g_assert_not_reached();
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return floatx80_default_nan(status);
     } else {
         a.low |= LIT64(0xC000000000000000);
@@ -1105,7 +1123,7 @@ int float128_is_quiet_nan(float128 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     return float128_is_any_nan(a);
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
             && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
     } else {
@@ -1125,7 +1143,7 @@ int float128_is_signaling_nan(float128 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     return 0;
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return ((a.high << 1) >= 0xFFFF000000000000ULL)
             && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
     } else {
@@ -1145,7 +1163,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
 #ifdef NO_SIGNALING_NANS
     g_assert_not_reached();
 #else
-    if (status->snan_bit_is_one) {
+    if (snan_bit_is_one(status)) {
         return float128_default_nan(status);
     } else {
         a.high |= LIT64(0x0000800000000000);
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 4e378cb612..2aae6a89b1 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -173,6 +173,7 @@ typedef struct float_status {
     /* should denormalised inputs go to zero and set the input_denormal flag? */
     flag flush_inputs_to_zero;
     flag default_nan_mode;
+    /* not always used -- see snan_bit_is_one() in softfloat-specialize.h */
     flag snan_bit_is_one;
 } float_status;
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c261b6b090..00bf444620 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -141,7 +141,6 @@ static void hppa_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
-    set_snan_bit_is_one(true, &env->fp_status);
     cpu_hppa_put_psw(env, PSW_W);
 }
 
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9ae418a577..d31a933cbb 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3382,7 +3382,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
             xt.f128 = xb.f128;
         } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128)) {
             float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSQRT, 1);
-            set_snan_bit_is_one(0, &env->fp_status);
             xt.f128 = float128_default_nan(&env->fp_status);
         }
     }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 541ffc2d97..b9f393b7c7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -71,7 +71,6 @@ static void superh_cpu_reset(CPUState *s)
     set_flush_to_zero(1, &env->fp_status);
 #endif
     set_default_nan_mode(1, &env->fp_status);
-    set_snan_bit_is_one(1, &env->fp_status);
 }
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 29d160a88d..68f978d80b 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -70,7 +70,6 @@ static void unicore_ii_cpu_initfn(Object *obj)
 
     set_feature(env, UC32_HWCAP_CMOV);
     set_feature(env, UC32_HWCAP_UCF64);
-    set_snan_bit_is_one(1, &env->ucf64.fp_status);
 }
 
 static void uc32_any_cpu_initfn(Object *obj)
@@ -83,7 +82,6 @@ static void uc32_any_cpu_initfn(Object *obj)
 
     set_feature(env, UC32_HWCAP_CMOV);
     set_feature(env, UC32_HWCAP_UCF64);
-    set_snan_bit_is_one(1, &env->ucf64.fp_status);
 }
 
 static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.0
