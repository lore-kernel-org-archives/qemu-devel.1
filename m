Received: from eggs.gnu.org ([2001:4830:134:3::10]:46948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuU3-0007se-Da
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eHuU1-0003XQ-Bv
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:15 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eHuU1-0003W5-0O
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:36:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 23 Nov 2017 17:35:34 +0100
Message-Id: <20171123163538.31411-2-laurent@vivier.eu>
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
References: <20171123163538.31411-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 1/5] softfloat: add floatx80_mod()
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
 fpu/softfloat.c         | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 89 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 433c5dad2d..36e67e50a3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5701,6 +5701,94 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *status)
                                 0, zExp, zSig0, zSig1, status);
 }
 
+#if defined(TARGET_M68K)
+/* This part is copied from previous:
+ *  Written by Andreas Grabher for Previous, NeXT Computer Emulator.
+ */
+
+/*----------------------------------------------------------------------------
+ | Returns the modulo remainder of the extended double-precision floating-point
+ | value `a' with respect to the corresponding value `b'.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
+{
+    flag aSign, zSign;
+    int32_t aExp, bExp, expDiff;
+    uint64_t aSig0, aSig1, bSig;
+    uint64_t qTemp, term0, term1;
+
+    aSig0 = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+    bSig = extractFloatx80Frac(b);
+    bExp = extractFloatx80Exp(b);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig0 << 1)
+            || ((bExp == 0x7FFF) && (uint64_t) (bSig << 1))) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        goto invalid;
+    }
+    if (bExp == 0x7FFF) {
+        if ((uint64_t) (bSig << 1)) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        return a;
+    }
+    if (bExp == 0) {
+        if (bSig == 0) {
+        invalid:
+            float_raise(float_flag_invalid, status);
+            return floatx80_default_nan(status);
+        }
+        normalizeFloatx80Subnormal(bSig, &bExp, &bSig);
+    }
+    if (aExp == 0) {
+        if ((uint64_t) (aSig0 << 1) == 0) {
+            return a;
+        }
+        normalizeFloatx80Subnormal(aSig0, &aExp, &aSig0);
+    }
+    bSig |= LIT64(0x8000000000000000);
+    zSign = aSign;
+    expDiff = aExp - bExp;
+    aSig1 = 0;
+    if (expDiff < 0) {
+        return a;
+    }
+    qTemp = (bSig <= aSig0);
+    if (qTemp) {
+        aSig0 -= bSig;
+    }
+    expDiff -= 64;
+    while (0 < expDiff) {
+        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
+        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
+        mul64To128(bSig, qTemp, &term0, &term1);
+        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
+    }
+    expDiff += 64;
+    if (0 < expDiff) {
+        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
+        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
+        qTemp >>= 64 - expDiff;
+        mul64To128(bSig, qTemp << (64 - expDiff), &term0, &term1);
+        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        shortShift128Left(0, bSig, 64 - expDiff, &term0, &term1);
+        while (le128(term0, term1, aSig0, aSig1)) {
+            ++qTemp;
+            sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
+        }
+    }
+    return
+        normalizeRoundAndPackFloatx80(
+            80, zSign, bExp + expDiff, aSig0, aSig1, status);
+}
+#endif /* TARGET_M68K */
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the extended double-precision floating-point value `a' is equal
 | to the corresponding value `b', and 0 otherwise.  The invalid exception is
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 0f96a0edd1..ad6249b3df 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -623,6 +623,7 @@ floatx80 floatx80_sub(floatx80, floatx80, float_status *status);
 floatx80 floatx80_mul(floatx80, floatx80, float_status *status);
 floatx80 floatx80_div(floatx80, floatx80, float_status *status);
 floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
+floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
 int floatx80_eq(floatx80, floatx80, float_status *status);
 int floatx80_le(floatx80, floatx80, float_status *status);
-- 
2.13.6
