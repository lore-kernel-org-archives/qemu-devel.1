Received: from eggs.gnu.org ([2001:4830:134:3::10]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuU3-0007sd-DL
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuU0-0003WU-Jz
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:64143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eHuU0-0003VI-9E
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 23 Nov 2017 17:35:37 +0100
Message-Id: <20171123163538.31411-5-laurent@vivier.eu>
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
References: <20171123163538.31411-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 4/5] softfloat: add floatx80_getman(),
 floatx80_getexp(), floatx80_scale()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat-specialize.h |  15 ++++++
 fpu/softfloat.c            | 132 +++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h    |   3 ++
 3 files changed, 150 insertions(+)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 1cb3502e5a..4706a0ec3a 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -1163,6 +1163,21 @@ static floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b,
     }
 }
 
+#if defined(TARGET_M68K)
+static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
+{
+    if (floatx80_is_signaling_nan(a, status)) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    if (status->default_nan_mode) {
+        return floatx80_default_nan(status);
+    }
+
+    return floatx80_maybe_silence_nan(a, status);
+}
+#endif
+
 #ifdef NO_SIGNALING_NANS
 int float128_is_quiet_nan(float128 a_, float_status *status)
 {
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c6289bba75..a17e849fe7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5800,6 +5800,138 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
         normalizeRoundAndPackFloatx80(
             80, zSign, bExp + expDiff, aSig0, aSig1, status);
 }
+
+/*----------------------------------------------------------------------------
+ | Returns the mantissa of the extended double-precision floating-point
+ | value `a'.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_getman(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a , status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+                                0x3FFF, aSig, 0, status);
+}
+
+/*----------------------------------------------------------------------------
+ | Returns the exponent of the extended double-precision floating-point
+ | value `a' as an extended double-precision value.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_getexp(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a , status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    return int32_to_floatx80(aExp - 0x3FFF, status);
+}
+
+/*----------------------------------------------------------------------------
+ | Scales extended double-precision floating-point value in operand `a' by
+ | value `b'. The function truncates the value in the second operand 'b' to
+ | an integral value and adds that value to the exponent of the operand 'a'.
+ | The operation performed according to the IEC/IEEE Standard for Binary
+ | Floating-Point Arithmetic.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
+{
+    flag aSign, bSign;
+    int32_t aExp, bExp, shiftCount;
+    uint64_t aSig, bSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+    bSig = extractFloatx80Frac(b);
+    bExp = extractFloatx80Exp(b);
+    bSign = extractFloatx80Sign(b);
+
+    if (bExp == 0x7FFF) {
+        if ((uint64_t) (bSig << 1) ||
+            ((aExp == 0x7FFF) && (uint64_t) (aSig << 1))) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        return packFloatx80(aSign, floatx80_infinity_high,
+                            floatx80_infinity_low);
+    }
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        if (bExp < 0x3FFF) {
+            return a;
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    if (bExp < 0x3FFF) {
+        return a;
+    }
+
+    if (0x400F < bExp) {
+        aExp = bSign ? -0x6001 : 0xE000;
+        return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                    aSign, aExp, aSig, 0, status);
+    }
+
+    shiftCount = 0x403E - bExp;
+    bSig >>= shiftCount;
+    aExp = bSign ? (aExp - bSig) : (aExp + bSig);
+
+    return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                aSign, aExp, aSig, 0, status);
+
+}
 #endif /* TARGET_M68K */
 
 /*----------------------------------------------------------------------------
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 413cdb20cb..84ddcb12a1 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -630,6 +630,9 @@ floatx80 floatx80_div(floatx80, floatx80, float_status *status);
 floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
+floatx80 floatx80_getman(floatx80 a, float_status *status);
+floatx80 floatx80_getexp(floatx80 a, float_status *status);
+floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
 int floatx80_eq(floatx80, floatx80, float_status *status);
 int floatx80_le(floatx80, floatx80, float_status *status);
 int floatx80_lt(floatx80, floatx80, float_status *status);
-- 
2.13.6
