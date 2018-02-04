Received: from eggs.gnu.org ([2001:4830:134:3::10]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf8-00050X-Ul
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf5-00057J-5C
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:18 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBf4-00056p-OG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:15 -0500
Received: by mail-pl0-x22e.google.com with SMTP id f4so9361275plr.10
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:35 -0800
Message-Id: <20180204041136.17525-24-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/24] fpu: Implement muladd with soft-fp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Add routines for float16 and float128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/soft-fp-specialize.h   | 123 ++++++++++++
 fpu/softfloat-specialize.h | 228 ----------------------
 include/fpu/softfloat.h    |   3 +
 fpu/floatxx.inc.c          |  68 +++++++
 fpu/softfloat.c            | 473 ---------------------------------------------
 5 files changed, 194 insertions(+), 701 deletions(-)

diff --git a/fpu/soft-fp-specialize.h b/fpu/soft-fp-specialize.h
index 869f5a0195..10061595a3 100644
--- a/fpu/soft-fp-specialize.h
+++ b/fpu/soft-fp-specialize.h
@@ -129,3 +129,126 @@ static inline int pick_nan(int a_nan, int b_nan, bool a_larger,
     return a_larger ^ 1;
 #endif
 }
+
+
+/*
+ * Select which NaN to propagate for a three-input FMA operation.
+ *
+ * A_SNAN etc are set iff the operand is an SNaN; QNaN can be
+ * determined from (A_CLS == FP_CLS_NAN && !A_SNAN).
+ *
+ * The return value is 0 to select NaN A, 1 for NaN B, 2 for NaN C,
+ * or 3 to build a new default QNaN.
+ *
+ * Note that signalling NaNs are always squashed to quiet NaNs
+ * by the caller before returning them.
+ */
+static inline int pick_nan_muladd(int a_cls, bool a_snan,
+                                  int b_cls, bool b_snan,
+                                  int c_cls, bool c_snan,
+                                  float_status *status)
+{
+    /* True if the inner product would itself generate a default NaN.  */
+    bool infzero = (a_cls == FP_CLS_INF && b_cls == FP_CLS_ZERO)
+                || (b_cls == FP_CLS_INF && a_cls == FP_CLS_ZERO);
+
+#if defined(TARGET_ARM)
+    /* For ARM, the (inf,zero,qnan) case sets InvalidOp
+     * and returns the default NaN.
+     */
+    if (infzero && c_cls == FP_CLS_NAN && !c_snan) {
+        float_raise(float_flag_invalid, status);
+        return 3;
+    }
+
+    /* This looks different from the ARM ARM pseudocode, because the ARM ARM
+     * puts the operands to a fused mac operation (a*b)+c in the order c,a,b.
+     */
+    if (c_snan) {
+        return 2;
+    } else if (a_snan) {
+        return 0;
+    } else if (b_snan) {
+        return 1;
+    } else if (c_cls == FP_CLS_NAN) {
+        return 2;
+    } else if (a_cls == FP_CLS_NAN) {
+        return 0;
+    } else {
+        return 1;
+    }
+#elif defined(TARGET_MIPS)
+    /* For MIPS, the (inf,zero,*) case sets InvalidOp
+     * and returns the default NaN.
+     */
+    if (infzero) {
+        float_raise(float_flag_invalid, status);
+        return 3;
+    }
+    if (status->snan_bit_is_one) {
+        /* Prefer sNaN over qNaN, in the a, b, c order. */
+        if (a_snan) {
+            return 0;
+        } else if (b_snan) {
+            return 1;
+        } else if (c_snan) {
+            return 2;
+        } else if (a_cls == FP_CLS_NAN) {
+            return 0;
+        } else if (b_cls == FP_CLS_NAN) {
+            return 1;
+        } else {
+            return 2;
+        }
+    } else {
+        /* Prefer sNaN over qNaN, in the c, a, b order. */
+        if (c_snan) {
+            return 2;
+        } else if (a_snan) {
+            return 0;
+        } else if (b_snan) {
+            return 1;
+        } else if (c_cls == FP_CLS_NAN) {
+            return 2;
+        } else if (a_cls == FP_CLS_NAN) {
+            return 0;
+        } else {
+            return 1;
+        }
+    }
+#elif defined(TARGET_PPC)
+    /* For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
+     * to return an input NaN if we have one (ie c) rather than generating
+     * a default NaN
+     */
+    if (infzero) {
+        float_raise(float_flag_invalid, status);
+        return 2;
+    }
+
+    /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
+     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+     */
+    if (a_cls == FP_CLS_NAN) {
+        return 0;
+    } else if (c_cls == FP_CLS_NAN) {
+        return 2;
+    } else {
+        return 1;
+    }
+#else
+    /* A default implementation, which is unlikely to match any
+     * real implementation.
+     */
+    if (infzero) {
+        float_raise(float_flag_invalid, status);
+    }
+    if (a_cls == FP_CLS_NAN) {
+        return 0;
+    } else if (b_cls == FP_CLS_NAN) {
+        return 1;
+    } else {
+        return 2;
+    }
+#endif
+}
diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index ffc0264018..ce5755f93d 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -522,130 +522,6 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 }
 #endif
 
-/*----------------------------------------------------------------------------
-| Select which NaN to propagate for a three-input operation.
-| For the moment we assume that no CPU needs the 'larger significand'
-| information.
-| Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
-*----------------------------------------------------------------------------*/
-#if defined(TARGET_ARM)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
-    /* For ARM, the (inf,zero,qnan) case sets InvalidOp and returns
-     * the default NaN
-     */
-    if (infzero && cIsQNaN) {
-        float_raise(float_flag_invalid, status);
-        return 3;
-    }
-
-    /* This looks different from the ARM ARM pseudocode, because the ARM ARM
-     * puts the operands to a fused mac operation (a*b)+c in the order c,a,b.
-     */
-    if (cIsSNaN) {
-        return 2;
-    } else if (aIsSNaN) {
-        return 0;
-    } else if (bIsSNaN) {
-        return 1;
-    } else if (cIsQNaN) {
-        return 2;
-    } else if (aIsQNaN) {
-        return 0;
-    } else {
-        return 1;
-    }
-}
-#elif defined(TARGET_MIPS)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
-    /* For MIPS, the (inf,zero,qnan) case sets InvalidOp and returns
-     * the default NaN
-     */
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return 3;
-    }
-
-    if (status->snan_bit_is_one) {
-        /* Prefer sNaN over qNaN, in the a, b, c order. */
-        if (aIsSNaN) {
-            return 0;
-        } else if (bIsSNaN) {
-            return 1;
-        } else if (cIsSNaN) {
-            return 2;
-        } else if (aIsQNaN) {
-            return 0;
-        } else if (bIsQNaN) {
-            return 1;
-        } else {
-            return 2;
-        }
-    } else {
-        /* Prefer sNaN over qNaN, in the c, a, b order. */
-        if (cIsSNaN) {
-            return 2;
-        } else if (aIsSNaN) {
-            return 0;
-        } else if (bIsSNaN) {
-            return 1;
-        } else if (cIsQNaN) {
-            return 2;
-        } else if (aIsQNaN) {
-            return 0;
-        } else {
-            return 1;
-        }
-    }
-}
-#elif defined(TARGET_PPC)
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
-    /* For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
-     * to return an input NaN if we have one (ie c) rather than generating
-     * a default NaN
-     */
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return 2;
-    }
-
-    /* If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
-     */
-    if (aIsSNaN || aIsQNaN) {
-        return 0;
-    } else if (cIsSNaN || cIsQNaN) {
-        return 2;
-    } else {
-        return 1;
-    }
-}
-#else
-/* A default implementation: prefer a to b to c.
- * This is unlikely to actually match any real implementation.
- */
-static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                         flag cIsQNaN, flag cIsSNaN, flag infzero,
-                         float_status *status)
-{
-    if (aIsSNaN || aIsQNaN) {
-        return 0;
-    } else if (bIsSNaN || bIsQNaN) {
-        return 1;
-    } else {
-        return 2;
-    }
-}
-#endif
-
 /*----------------------------------------------------------------------------
 | Takes two single-precision floating-point values `a' and `b', one of which
 | is a NaN, and returns the appropriate NaN result.  If either `a' or `b' is a
@@ -689,58 +565,6 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
-| Takes three single-precision floating-point values `a', `b' and `c', one of
-| which is a NaN, and returns the appropriate NaN result.  If any of  `a',
-| `b' or `c' is a signaling NaN, the invalid exception is raised.
-| The input infzero indicates whether a*b was 0*inf or inf*0 (in which case
-| obviously c is a NaN, and whether to propagate c or some other NaN is
-| implementation defined).
-*----------------------------------------------------------------------------*/
-
-static float32 propagateFloat32MulAddNaN(float32 a, float32 b,
-                                         float32 c, flag infzero,
-                                         float_status *status)
-{
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-        cIsQuietNaN, cIsSignalingNaN;
-    int which;
-
-    aIsQuietNaN = float32_is_quiet_nan(a, status);
-    aIsSignalingNaN = float32_is_signaling_nan(a, status);
-    bIsQuietNaN = float32_is_quiet_nan(b, status);
-    bIsSignalingNaN = float32_is_signaling_nan(b, status);
-    cIsQuietNaN = float32_is_quiet_nan(c, status);
-    cIsSignalingNaN = float32_is_signaling_nan(c, status);
-
-    if (aIsSignalingNaN | bIsSignalingNaN | cIsSignalingNaN) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    which = pickNaNMulAdd(aIsQuietNaN, aIsSignalingNaN,
-                          bIsQuietNaN, bIsSignalingNaN,
-                          cIsQuietNaN, cIsSignalingNaN, infzero, status);
-
-    if (status->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        return float32_default_nan(status);
-    }
-
-    switch (which) {
-    case 0:
-        return float32_maybe_silence_nan(a, status);
-    case 1:
-        return float32_maybe_silence_nan(b, status);
-    case 2:
-        return float32_maybe_silence_nan(c, status);
-    case 3:
-    default:
-        return float32_default_nan(status);
-    }
-}
-
 #ifdef NO_SIGNALING_NANS
 int float64_is_quiet_nan(float64 a_, float_status *status)
 {
@@ -896,58 +720,6 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
-| Takes three double-precision floating-point values `a', `b' and `c', one of
-| which is a NaN, and returns the appropriate NaN result.  If any of  `a',
-| `b' or `c' is a signaling NaN, the invalid exception is raised.
-| The input infzero indicates whether a*b was 0*inf or inf*0 (in which case
-| obviously c is a NaN, and whether to propagate c or some other NaN is
-| implementation defined).
-*----------------------------------------------------------------------------*/
-
-static float64 propagateFloat64MulAddNaN(float64 a, float64 b,
-                                         float64 c, flag infzero,
-                                         float_status *status)
-{
-    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
-        cIsQuietNaN, cIsSignalingNaN;
-    int which;
-
-    aIsQuietNaN = float64_is_quiet_nan(a, status);
-    aIsSignalingNaN = float64_is_signaling_nan(a, status);
-    bIsQuietNaN = float64_is_quiet_nan(b, status);
-    bIsSignalingNaN = float64_is_signaling_nan(b, status);
-    cIsQuietNaN = float64_is_quiet_nan(c, status);
-    cIsSignalingNaN = float64_is_signaling_nan(c, status);
-
-    if (aIsSignalingNaN | bIsSignalingNaN | cIsSignalingNaN) {
-        float_raise(float_flag_invalid, status);
-    }
-
-    which = pickNaNMulAdd(aIsQuietNaN, aIsSignalingNaN,
-                          bIsQuietNaN, bIsSignalingNaN,
-                          cIsQuietNaN, cIsSignalingNaN, infzero, status);
-
-    if (status->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        return float64_default_nan(status);
-    }
-
-    switch (which) {
-    case 0:
-        return float64_maybe_silence_nan(a, status);
-    case 1:
-        return float64_maybe_silence_nan(b, status);
-    case 2:
-        return float64_maybe_silence_nan(c, status);
-    case 3:
-    default:
-        return float64_default_nan(status);
-    }
-}
-
 #ifdef NO_SIGNALING_NANS
 int floatx80_is_quiet_nan(floatx80 a_, float_status *status)
 {
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 53468eec1b..3a2d148651 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -250,6 +250,7 @@ float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+float16 float16_muladd(float16, float16, float16, int, float_status *status);
 float16 float16_sqrt(float16, float_status *status);
 int float16_eq(float16, float16, float_status *status);
 int float16_le(float16, float16, float_status *status);
@@ -679,6 +680,8 @@ float128 float128_sub(float128, float128, float_status *status);
 float128 float128_mul(float128, float128, float_status *status);
 float128 float128_div(float128, float128, float_status *status);
 float128 float128_rem(float128, float128, float_status *status);
+float128 float128_muladd(float128, float128, float128, int,
+                         float_status *status);
 float128 float128_sqrt(float128, float_status *status);
 int float128_eq(float128, float128, float_status *status);
 int float128_le(float128, float128, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index 8c009dd966..a4b305e1ff 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -30,6 +30,8 @@
     _FP_CHOOSENAN(fs, wc, R, A, B, OP)
 #define FP_SETQNAN(fs, wc, X) \
     _FP_SETQNAN(fs, wc, X)
+#define FP_FRAC_SNANP(fs, X) \
+    _FP_FRAC_SNANP(fs, X)
 #define FP_ADD_INTERNAL(fs, wc, R, A, B, OP) \
     _FP_ADD_INTERNAL(fs, wc, R, A, B, '-')
 
@@ -145,6 +147,72 @@ FLOATXX glue(FLOATXX,_scalbn)(FLOATXX a, int n, float_status *status)
     return a;
 }
 
+FLOATXX glue(FLOATXX,_muladd)(FLOATXX a, FLOATXX b, FLOATXX c, int flags,
+                              float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    glue(FP_DECL_, FS)(C);
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+    glue(FP_UNPACK_, FS)(B, b);
+    glue(FP_UNPACK_, FS)(C, c);
+
+    /* R_e is not set in cases where it is not used in packing, but the
+     * compiler does not see that it is set in all cases where it is used,
+     * resulting in warnings that it may be used uninitialized.
+     * For QEMU, we will usually read it before packing, for halve_result.
+     */
+    R_e = 0;
+
+    /* _FP_FMA does pair-wise calls to _FP_CHOOSENAN.  For proper
+       emulation of the target cpu we need to do better than that.  */
+    if (A_c == FP_CLS_NAN || B_c == FP_CLS_NAN || C_c == FP_CLS_NAN) {
+        bool a_snan = A_c == FP_CLS_NAN && FP_FRAC_SNANP(FS, A);
+        bool b_snan = B_c == FP_CLS_NAN && FP_FRAC_SNANP(FS, B);
+        bool c_snan = C_c == FP_CLS_NAN && FP_FRAC_SNANP(FS, C);
+        int p = pick_nan_muladd(A_c, a_snan, B_c, b_snan, C_c, c_snan, status);
+
+        R_c = FP_CLS_NAN;
+        switch (p) {
+        case 0:
+            R_s = A_s;
+            glue(_FP_FRAC_COPY_, WC)(R, A);
+            break;
+        case 1:
+            R_s = B_s;
+            glue(_FP_FRAC_COPY_, WC)(R, B);
+            break;
+        case 2:
+            R_s = C_s;
+            glue(_FP_FRAC_COPY_, WC)(R, C);
+            break;
+        default:
+            R_s = glue(_FP_NANSIGN_, FS);
+            glue(_FP_FRAC_SET_, WC)(R, glue(_FP_NANFRAC_, FS));
+            break;
+        }
+        /* Any SNaN result will be silenced during _FP_PACK_CANONICAL.  */
+    } else {
+        C_s ^= (flags & float_muladd_negate_c) != 0;
+        B_s ^= (flags & float_muladd_negate_product) != 0;
+
+        glue(FP_FMA_, FS)(R, A, B, C);
+
+        R_s ^= ((flags & float_muladd_negate_result) && R_c != FP_CLS_NAN);
+        R_e -= ((flags & float_muladd_halve_result) && R_c == FP_CLS_NORMAL);
+    }
+
+    glue(FP_PACK_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
+
 #define DO_FLOAT_TO_INT(NAME, SZ, FP_TO_INT_WHICH)   \
 int##SZ##_t NAME(FLOATXX a, float_status *status) \
 {                                                 \
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dab9e39480..47b9dd9bd3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1493,232 +1493,6 @@ float32 float32_rem(float32 a, float32 b, float_status *status)
     return normalizeRoundAndPackFloat32(aSign ^ zSign, bExp, aSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the single-precision floating-point values
-| `a' and `b' then adding 'c', with no intermediate rounding step after the
-| multiplication.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic 754-2008.
-| The flags argument allows the caller to select negation of the
-| addend, the intermediate product, or the final result. (The difference
-| between this and having the caller do a separate negation is that negating
-| externally will flip the sign bit on NaNs.)
-*----------------------------------------------------------------------------*/
-
-float32 float32_muladd(float32 a, float32 b, float32 c, int flags,
-                       float_status *status)
-{
-    flag aSign, bSign, cSign, zSign;
-    int aExp, bExp, cExp, pExp, zExp, expDiff;
-    uint32_t aSig, bSig, cSig;
-    flag pInf, pZero, pSign;
-    uint64_t pSig64, cSig64, zSig64;
-    uint32_t pSig;
-    int shiftcount;
-    flag signflip, infzero;
-
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-    c = float32_squash_input_denormal(c, status);
-    aSig = extractFloat32Frac(a);
-    aExp = extractFloat32Exp(a);
-    aSign = extractFloat32Sign(a);
-    bSig = extractFloat32Frac(b);
-    bExp = extractFloat32Exp(b);
-    bSign = extractFloat32Sign(b);
-    cSig = extractFloat32Frac(c);
-    cExp = extractFloat32Exp(c);
-    cSign = extractFloat32Sign(c);
-
-    infzero = ((aExp == 0 && aSig == 0 && bExp == 0xff && bSig == 0) ||
-               (aExp == 0xff && aSig == 0 && bExp == 0 && bSig == 0));
-
-    /* It is implementation-defined whether the cases of (0,inf,qnan)
-     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
-     * they return if they do), so we have to hand this information
-     * off to the target-specific pick-a-NaN routine.
-     */
-    if (((aExp == 0xff) && aSig) ||
-        ((bExp == 0xff) && bSig) ||
-        ((cExp == 0xff) && cSig)) {
-        return propagateFloat32MulAddNaN(a, b, c, infzero, status);
-    }
-
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-
-    if (flags & float_muladd_negate_c) {
-        cSign ^= 1;
-    }
-
-    signflip = (flags & float_muladd_negate_result) ? 1 : 0;
-
-    /* Work out the sign and type of the product */
-    pSign = aSign ^ bSign;
-    if (flags & float_muladd_negate_product) {
-        pSign ^= 1;
-    }
-    pInf = (aExp == 0xff) || (bExp == 0xff);
-    pZero = ((aExp | aSig) == 0) || ((bExp | bSig) == 0);
-
-    if (cExp == 0xff) {
-        if (pInf && (pSign ^ cSign)) {
-            /* addition of opposite-signed infinities => InvalidOperation */
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        /* Otherwise generate an infinity of the same sign */
-        return packFloat32(cSign ^ signflip, 0xff, 0);
-    }
-
-    if (pInf) {
-        return packFloat32(pSign ^ signflip, 0xff, 0);
-    }
-
-    if (pZero) {
-        if (cExp == 0) {
-            if (cSig == 0) {
-                /* Adding two exact zeroes */
-                if (pSign == cSign) {
-                    zSign = pSign;
-                } else if (status->float_rounding_mode == float_round_down) {
-                    zSign = 1;
-                } else {
-                    zSign = 0;
-                }
-                return packFloat32(zSign ^ signflip, 0, 0);
-            }
-            /* Exact zero plus a denorm */
-            if (status->flush_to_zero) {
-                float_raise(float_flag_output_denormal, status);
-                return packFloat32(cSign ^ signflip, 0, 0);
-            }
-        }
-        /* Zero plus something non-zero : just return the something */
-        if (flags & float_muladd_halve_result) {
-            if (cExp == 0) {
-                normalizeFloat32Subnormal(cSig, &cExp, &cSig);
-            }
-            /* Subtract one to halve, and one again because roundAndPackFloat32
-             * wants one less than the true exponent.
-             */
-            cExp -= 2;
-            cSig = (cSig | 0x00800000) << 7;
-            return roundAndPackFloat32(cSign ^ signflip, cExp, cSig, status);
-        }
-        return packFloat32(cSign ^ signflip, cExp, cSig);
-    }
-
-    if (aExp == 0) {
-        normalizeFloat32Subnormal(aSig, &aExp, &aSig);
-    }
-    if (bExp == 0) {
-        normalizeFloat32Subnormal(bSig, &bExp, &bSig);
-    }
-
-    /* Calculate the actual result a * b + c */
-
-    /* Multiply first; this is easy. */
-    /* NB: we subtract 0x7e where float32_mul() subtracts 0x7f
-     * because we want the true exponent, not the "one-less-than"
-     * flavour that roundAndPackFloat32() takes.
-     */
-    pExp = aExp + bExp - 0x7e;
-    aSig = (aSig | 0x00800000) << 7;
-    bSig = (bSig | 0x00800000) << 8;
-    pSig64 = (uint64_t)aSig * bSig;
-    if ((int64_t)(pSig64 << 1) >= 0) {
-        pSig64 <<= 1;
-        pExp--;
-    }
-
-    zSign = pSign ^ signflip;
-
-    /* Now pSig64 is the significand of the multiply, with the explicit bit in
-     * position 62.
-     */
-    if (cExp == 0) {
-        if (!cSig) {
-            /* Throw out the special case of c being an exact zero now */
-            shift64RightJamming(pSig64, 32, &pSig64);
-            pSig = pSig64;
-            if (flags & float_muladd_halve_result) {
-                pExp--;
-            }
-            return roundAndPackFloat32(zSign, pExp - 1,
-                                       pSig, status);
-        }
-        normalizeFloat32Subnormal(cSig, &cExp, &cSig);
-    }
-
-    cSig64 = (uint64_t)cSig << (62 - 23);
-    cSig64 |= LIT64(0x4000000000000000);
-    expDiff = pExp - cExp;
-
-    if (pSign == cSign) {
-        /* Addition */
-        if (expDiff > 0) {
-            /* scale c to match p */
-            shift64RightJamming(cSig64, expDiff, &cSig64);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            /* scale p to match c */
-            shift64RightJamming(pSig64, -expDiff, &pSig64);
-            zExp = cExp;
-        } else {
-            /* no scaling needed */
-            zExp = cExp;
-        }
-        /* Add significands and make sure explicit bit ends up in posn 62 */
-        zSig64 = pSig64 + cSig64;
-        if ((int64_t)zSig64 < 0) {
-            shift64RightJamming(zSig64, 1, &zSig64);
-        } else {
-            zExp--;
-        }
-    } else {
-        /* Subtraction */
-        if (expDiff > 0) {
-            shift64RightJamming(cSig64, expDiff, &cSig64);
-            zSig64 = pSig64 - cSig64;
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            shift64RightJamming(pSig64, -expDiff, &pSig64);
-            zSig64 = cSig64 - pSig64;
-            zExp = cExp;
-            zSign ^= 1;
-        } else {
-            zExp = pExp;
-            if (cSig64 < pSig64) {
-                zSig64 = pSig64 - cSig64;
-            } else if (pSig64 < cSig64) {
-                zSig64 = cSig64 - pSig64;
-                zSign ^= 1;
-            } else {
-                /* Exact zero */
-                zSign = signflip;
-                if (status->float_rounding_mode == float_round_down) {
-                    zSign ^= 1;
-                }
-                return packFloat32(zSign, 0, 0);
-            }
-        }
-        --zExp;
-        /* Normalize to put the explicit bit back into bit 62. */
-        shiftcount = countLeadingZeros64(zSig64) - 1;
-        zSig64 <<= shiftcount;
-        zExp -= shiftcount;
-    }
-    if (flags & float_muladd_halve_result) {
-        zExp--;
-    }
-
-    shift64RightJamming(zSig64, 32, &zSig64);
-    return roundAndPackFloat32(zSign, zExp, zSig64, status);
-}
-
-
 /*----------------------------------------------------------------------------
 | Returns the binary exponential of the single-precision floating-point value
 | `a'. The operation is performed according to the IEC/IEEE Standard for
@@ -2079,253 +1853,6 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the double-precision floating-point values
-| `a' and `b' then adding 'c', with no intermediate rounding step after the
-| multiplication.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic 754-2008.
-| The flags argument allows the caller to select negation of the
-| addend, the intermediate product, or the final result. (The difference
-| between this and having the caller do a separate negation is that negating
-| externally will flip the sign bit on NaNs.)
-*----------------------------------------------------------------------------*/
-
-float64 float64_muladd(float64 a, float64 b, float64 c, int flags,
-                       float_status *status)
-{
-    flag aSign, bSign, cSign, zSign;
-    int aExp, bExp, cExp, pExp, zExp, expDiff;
-    uint64_t aSig, bSig, cSig;
-    flag pInf, pZero, pSign;
-    uint64_t pSig0, pSig1, cSig0, cSig1, zSig0, zSig1;
-    int shiftcount;
-    flag signflip, infzero;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-    c = float64_squash_input_denormal(c, status);
-    aSig = extractFloat64Frac(a);
-    aExp = extractFloat64Exp(a);
-    aSign = extractFloat64Sign(a);
-    bSig = extractFloat64Frac(b);
-    bExp = extractFloat64Exp(b);
-    bSign = extractFloat64Sign(b);
-    cSig = extractFloat64Frac(c);
-    cExp = extractFloat64Exp(c);
-    cSign = extractFloat64Sign(c);
-
-    infzero = ((aExp == 0 && aSig == 0 && bExp == 0x7ff && bSig == 0) ||
-               (aExp == 0x7ff && aSig == 0 && bExp == 0 && bSig == 0));
-
-    /* It is implementation-defined whether the cases of (0,inf,qnan)
-     * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
-     * they return if they do), so we have to hand this information
-     * off to the target-specific pick-a-NaN routine.
-     */
-    if (((aExp == 0x7ff) && aSig) ||
-        ((bExp == 0x7ff) && bSig) ||
-        ((cExp == 0x7ff) && cSig)) {
-        return propagateFloat64MulAddNaN(a, b, c, infzero, status);
-    }
-
-    if (infzero) {
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-
-    if (flags & float_muladd_negate_c) {
-        cSign ^= 1;
-    }
-
-    signflip = (flags & float_muladd_negate_result) ? 1 : 0;
-
-    /* Work out the sign and type of the product */
-    pSign = aSign ^ bSign;
-    if (flags & float_muladd_negate_product) {
-        pSign ^= 1;
-    }
-    pInf = (aExp == 0x7ff) || (bExp == 0x7ff);
-    pZero = ((aExp | aSig) == 0) || ((bExp | bSig) == 0);
-
-    if (cExp == 0x7ff) {
-        if (pInf && (pSign ^ cSign)) {
-            /* addition of opposite-signed infinities => InvalidOperation */
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        /* Otherwise generate an infinity of the same sign */
-        return packFloat64(cSign ^ signflip, 0x7ff, 0);
-    }
-
-    if (pInf) {
-        return packFloat64(pSign ^ signflip, 0x7ff, 0);
-    }
-
-    if (pZero) {
-        if (cExp == 0) {
-            if (cSig == 0) {
-                /* Adding two exact zeroes */
-                if (pSign == cSign) {
-                    zSign = pSign;
-                } else if (status->float_rounding_mode == float_round_down) {
-                    zSign = 1;
-                } else {
-                    zSign = 0;
-                }
-                return packFloat64(zSign ^ signflip, 0, 0);
-            }
-            /* Exact zero plus a denorm */
-            if (status->flush_to_zero) {
-                float_raise(float_flag_output_denormal, status);
-                return packFloat64(cSign ^ signflip, 0, 0);
-            }
-        }
-        /* Zero plus something non-zero : just return the something */
-        if (flags & float_muladd_halve_result) {
-            if (cExp == 0) {
-                normalizeFloat64Subnormal(cSig, &cExp, &cSig);
-            }
-            /* Subtract one to halve, and one again because roundAndPackFloat64
-             * wants one less than the true exponent.
-             */
-            cExp -= 2;
-            cSig = (cSig | 0x0010000000000000ULL) << 10;
-            return roundAndPackFloat64(cSign ^ signflip, cExp, cSig, status);
-        }
-        return packFloat64(cSign ^ signflip, cExp, cSig);
-    }
-
-    if (aExp == 0) {
-        normalizeFloat64Subnormal(aSig, &aExp, &aSig);
-    }
-    if (bExp == 0) {
-        normalizeFloat64Subnormal(bSig, &bExp, &bSig);
-    }
-
-    /* Calculate the actual result a * b + c */
-
-    /* Multiply first; this is easy. */
-    /* NB: we subtract 0x3fe where float64_mul() subtracts 0x3ff
-     * because we want the true exponent, not the "one-less-than"
-     * flavour that roundAndPackFloat64() takes.
-     */
-    pExp = aExp + bExp - 0x3fe;
-    aSig = (aSig | LIT64(0x0010000000000000))<<10;
-    bSig = (bSig | LIT64(0x0010000000000000))<<11;
-    mul64To128(aSig, bSig, &pSig0, &pSig1);
-    if ((int64_t)(pSig0 << 1) >= 0) {
-        shortShift128Left(pSig0, pSig1, 1, &pSig0, &pSig1);
-        pExp--;
-    }
-
-    zSign = pSign ^ signflip;
-
-    /* Now [pSig0:pSig1] is the significand of the multiply, with the explicit
-     * bit in position 126.
-     */
-    if (cExp == 0) {
-        if (!cSig) {
-            /* Throw out the special case of c being an exact zero now */
-            shift128RightJamming(pSig0, pSig1, 64, &pSig0, &pSig1);
-            if (flags & float_muladd_halve_result) {
-                pExp--;
-            }
-            return roundAndPackFloat64(zSign, pExp - 1,
-                                       pSig1, status);
-        }
-        normalizeFloat64Subnormal(cSig, &cExp, &cSig);
-    }
-
-    /* Shift cSig and add the explicit bit so [cSig0:cSig1] is the
-     * significand of the addend, with the explicit bit in position 126.
-     */
-    cSig0 = cSig << (126 - 64 - 52);
-    cSig1 = 0;
-    cSig0 |= LIT64(0x4000000000000000);
-    expDiff = pExp - cExp;
-
-    if (pSign == cSign) {
-        /* Addition */
-        if (expDiff > 0) {
-            /* scale c to match p */
-            shift128RightJamming(cSig0, cSig1, expDiff, &cSig0, &cSig1);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            /* scale p to match c */
-            shift128RightJamming(pSig0, pSig1, -expDiff, &pSig0, &pSig1);
-            zExp = cExp;
-        } else {
-            /* no scaling needed */
-            zExp = cExp;
-        }
-        /* Add significands and make sure explicit bit ends up in posn 126 */
-        add128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-        if ((int64_t)zSig0 < 0) {
-            shift128RightJamming(zSig0, zSig1, 1, &zSig0, &zSig1);
-        } else {
-            zExp--;
-        }
-        shift128RightJamming(zSig0, zSig1, 64, &zSig0, &zSig1);
-        if (flags & float_muladd_halve_result) {
-            zExp--;
-        }
-        return roundAndPackFloat64(zSign, zExp, zSig1, status);
-    } else {
-        /* Subtraction */
-        if (expDiff > 0) {
-            shift128RightJamming(cSig0, cSig1, expDiff, &cSig0, &cSig1);
-            sub128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-            zExp = pExp;
-        } else if (expDiff < 0) {
-            shift128RightJamming(pSig0, pSig1, -expDiff, &pSig0, &pSig1);
-            sub128(cSig0, cSig1, pSig0, pSig1, &zSig0, &zSig1);
-            zExp = cExp;
-            zSign ^= 1;
-        } else {
-            zExp = pExp;
-            if (lt128(cSig0, cSig1, pSig0, pSig1)) {
-                sub128(pSig0, pSig1, cSig0, cSig1, &zSig0, &zSig1);
-            } else if (lt128(pSig0, pSig1, cSig0, cSig1)) {
-                sub128(cSig0, cSig1, pSig0, pSig1, &zSig0, &zSig1);
-                zSign ^= 1;
-            } else {
-                /* Exact zero */
-                zSign = signflip;
-                if (status->float_rounding_mode == float_round_down) {
-                    zSign ^= 1;
-                }
-                return packFloat64(zSign, 0, 0);
-            }
-        }
-        --zExp;
-        /* Do the equivalent of normalizeRoundAndPackFloat64() but
-         * starting with the significand in a pair of uint64_t.
-         */
-        if (zSig0) {
-            shiftcount = countLeadingZeros64(zSig0) - 1;
-            shortShift128Left(zSig0, zSig1, shiftcount, &zSig0, &zSig1);
-            if (zSig1) {
-                zSig0 |= 1;
-            }
-            zExp -= shiftcount;
-        } else {
-            shiftcount = countLeadingZeros64(zSig1);
-            if (shiftcount == 0) {
-                zSig0 = (zSig1 >> 1) | (zSig1 & 1);
-                zExp -= 63;
-            } else {
-                shiftcount--;
-                zSig0 = zSig1 << shiftcount;
-                zExp -= (shiftcount + 64);
-            }
-        }
-        if (flags & float_muladd_halve_result) {
-            zExp--;
-        }
-        return roundAndPackFloat64(zSign, zExp, zSig0, status);
-    }
-}
-
 /*----------------------------------------------------------------------------
 | Returns the binary log of the double-precision floating-point value `a'.
 | The operation is performed according to the IEC/IEEE Standard for Binary
-- 
2.14.3
