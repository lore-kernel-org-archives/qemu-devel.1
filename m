Received: from eggs.gnu.org ([2001:4830:134:3::10]:52699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiG-0008HZ-Iz
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILiF-00008a-3Z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:13:00 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILiE-00006M-Rg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:59 -0400
Received: by mail-pf0-x244.google.com with SMTP id e9-v6so6669644pfi.4
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:17 -0700
Message-Id: <20180514221219.7091-27-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 26/28] fpu/softfloat: Define
 floatN_default_nan in terms of parts_default_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Isolate the target-specific choice to 2 functions instead of 6.

The code in float16_default_nan was only correct for ARM, MIPS, and X86.
Though float16 support is rare among our targets.

The code in float128_default_nan was arguably wrong for Sparc.  While
QEMU supports the Sparc 128-bit insns, no real cpu enables it.

The code in floatx80_default_nan tried to be over-general.  There are
only two targets that support this format: x86 and m68k.  Thus there
is no point in inventing a value for snan_bit_is_one.

Move routines that no longer have ifdefs out of softfloat-specialize.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 105 +++----------------------------------
 fpu/softfloat.c            |  35 +++++++++++++
 2 files changed, 41 insertions(+), 99 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 0399dfe011..9d562ed504 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -179,94 +179,22 @@ static FloatParts parts_silence_nan(FloatParts a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
-| The pattern for a default generated half-precision NaN.
-*----------------------------------------------------------------------------*/
-float16 float16_default_nan(float_status *status)
-{
-#if defined(TARGET_ARM)
-    return const_float16(0x7E00);
-#else
-    if (snan_bit_is_one(status)) {
-        return const_float16(0x7DFF);
-    } else {
-#if defined(TARGET_MIPS)
-        return const_float16(0x7E00);
-#else
-        return const_float16(0xFE00);
-#endif
-    }
-#endif
-}
-
-/*----------------------------------------------------------------------------
-| The pattern for a default generated single-precision NaN.
-*----------------------------------------------------------------------------*/
-float32 float32_default_nan(float_status *status)
-{
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
-    return const_float32(0x7FFFFFFF);
-#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
-      defined(TARGET_XTENSA) || defined(TARGET_S390X) || \
-      defined(TARGET_TRICORE) || defined(TARGET_RISCV)
-    return const_float32(0x7FC00000);
-#elif defined(TARGET_HPPA)
-    return const_float32(0x7FA00000);
-#else
-    if (snan_bit_is_one(status)) {
-        return const_float32(0x7FBFFFFF);
-    } else {
-#if defined(TARGET_MIPS)
-        return const_float32(0x7FC00000);
-#else
-        return const_float32(0xFFC00000);
-#endif
-    }
-#endif
-}
-
-/*----------------------------------------------------------------------------
-| The pattern for a default generated double-precision NaN.
-*----------------------------------------------------------------------------*/
-float64 float64_default_nan(float_status *status)
-{
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
-    return const_float64(LIT64(0x7FFFFFFFFFFFFFFF));
-#elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
-      defined(TARGET_S390X) || defined(TARGET_RISCV)
-    return const_float64(LIT64(0x7FF8000000000000));
-#elif defined(TARGET_HPPA)
-    return const_float64(LIT64(0x7FF4000000000000));
-#else
-    if (snan_bit_is_one(status)) {
-        return const_float64(LIT64(0x7FF7FFFFFFFFFFFF));
-    } else {
-#if defined(TARGET_MIPS)
-        return const_float64(LIT64(0x7FF8000000000000));
-#else
-        return const_float64(LIT64(0xFFF8000000000000));
-#endif
-    }
-#endif
-}
-
 /*----------------------------------------------------------------------------
 | The pattern for a default generated extended double-precision NaN.
 *----------------------------------------------------------------------------*/
 floatx80 floatx80_default_nan(float_status *status)
 {
     floatx80 r;
+
+    /* None of the targets that have snan_bit_is_one use floatx80.  */
+    assert(!snan_bit_is_one(status));
 #if defined(TARGET_M68K)
     r.low = LIT64(0xFFFFFFFFFFFFFFFF);
     r.high = 0x7FFF;
 #else
-    if (snan_bit_is_one(status)) {
-        r.low = LIT64(0xBFFFFFFFFFFFFFFF);
-        r.high = 0x7FFF;
-    } else {
-        r.low = LIT64(0xC000000000000000);
-        r.high = 0xFFFF;
-    }
+    /* X86 */
+    r.low = LIT64(0xC000000000000000);
+    r.high = 0xFFFF;
 #endif
     return r;
 }
@@ -285,27 +213,6 @@ floatx80 floatx80_default_nan(float_status *status)
 const floatx80 floatx80_infinity
     = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
 
-/*----------------------------------------------------------------------------
-| The pattern for a default generated quadruple-precision NaN.
-*----------------------------------------------------------------------------*/
-float128 float128_default_nan(float_status *status)
-{
-    float128 r;
-
-    if (snan_bit_is_one(status)) {
-        r.low = LIT64(0xFFFFFFFFFFFFFFFF);
-        r.high = LIT64(0x7FFF7FFFFFFFFFFF);
-    } else {
-        r.low = LIT64(0x0000000000000000);
-#if defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_RISCV)
-        r.high = LIT64(0x7FFF800000000000);
-#else
-        r.high = LIT64(0xFFFF800000000000);
-#endif
-    }
-    return r;
-}
-
 /*----------------------------------------------------------------------------
 | Raises the exceptions specified by `flags'.  Floating-point traps can be
 | defined here if desired.  It is currently not possible for such a trap
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 65e970eeb2..b5842f7b1c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2092,6 +2092,41 @@ float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+/*----------------------------------------------------------------------------
+| The pattern for a default generated NaN.
+*----------------------------------------------------------------------------*/
+
+float16 float16_default_nan(float_status *status)
+{
+    return float16_pack_raw(parts_default_nan(status));
+}
+
+float32 float32_default_nan(float_status *status)
+{
+    return float32_pack_raw(parts_default_nan(status));
+}
+
+float64 float64_default_nan(float_status *status)
+{
+    return float64_pack_raw(parts_default_nan(status));
+}
+
+float128 float128_default_nan(float_status *status)
+{
+    FloatParts p = parts_default_nan(status);
+    float128 r;
+
+    /* Extrapolate from the choices made by parts_default_nan to fill
+     * in the quad-floating format.  If the low bit is set, assume we
+     * want to set all non-snan bits.
+     */
+    r.low = -(p.frac & 1);
+    r.high = p.frac >> (DECOMPOSED_BINARY_POINT - 48);
+    r.high |= LIT64(0x7FFF000000000000);
+    r.high |= (uint64_t)p.sign << 63;
+
+    return r;
+}
 
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
-- 
2.17.0
