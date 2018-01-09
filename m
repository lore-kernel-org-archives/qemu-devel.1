Received: from eggs.gnu.org ([2001:4830:134:3::10]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt15-0002ae-TR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt11-00029s-0T
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:31 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt10-00029D-OR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:26 -0500
Received: by mail-wm0-x241.google.com with SMTP id 123so742650wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:26 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:50 +0000
Message-Id: <20180109122252.17670-19-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/20] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This is one of the simpler manipulations you could make to a floating
point number.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 104 +++++++++++++++---------------------------------
 include/fpu/softfloat.h |   1 +
 2 files changed, 32 insertions(+), 73 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bb68d77f72..3647f6ca03 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1663,6 +1663,37 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
     return uint64_to_float64(a, status);
 }
 
+/* Multiply A by 2 raised to the power N.  */
+static decomposed_parts scalbn_decomposed(decomposed_parts a, int n,
+                                          float_status *s)
+{
+    if (a.cls == float_class_normal) {
+        a.exp += n;
+    }
+    return a;
+}
+
+float16 float16_scalbn(float16 a, int n, float_status *status)
+{
+    decomposed_parts pa = float16_unpack_canonical(a, status);
+    decomposed_parts pr = scalbn_decomposed(pa, n, status);
+    return float16_round_pack_canonical(pr, status);
+}
+
+float32 float32_scalbn(float32 a, int n, float_status *status)
+{
+    decomposed_parts pa = float32_unpack_canonical(a, status);
+    decomposed_parts pr = scalbn_decomposed(pa, n, status);
+    return float32_round_pack_canonical(pr, status);
+}
+
+float64 float64_scalbn(float64 a, int n, float_status *status)
+{
+    decomposed_parts pa = float64_unpack_canonical(a, status);
+    decomposed_parts pr = scalbn_decomposed(pa, n, status);
+    return float64_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -6992,79 +7023,6 @@ MINMAX(32)
 MINMAX(64)
 
 
-/* Multiply A by 2 raised to the power N.  */
-float32 float32_scalbn(float32 a, int n, float_status *status)
-{
-    flag aSign;
-    int16_t aExp;
-    uint32_t aSig;
-
-    a = float32_squash_input_denormal(a, status);
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-
-    if ( aExp == 0xFF ) {
-        if ( aSig ) {
-            return propagateFloat32NaN(a, a, status);
-        }
-        return a;
-    }
-    if (aExp != 0) {
-        aSig |= 0x00800000;
-    } else if (aSig == 0) {
-        return a;
-    } else {
-        aExp++;
-    }
-
-    if (n > 0x200) {
-        n = 0x200;
-    } else if (n < -0x200) {
-        n = -0x200;
-    }
-
-    aExp += n - 1;
-    aSig <<= 7;
-    return normalizeRoundAndPackFloat32(aSign, aExp, aSig, status);
-}
-
-float64 float64_scalbn(float64 a, int n, float_status *status)
-{
-    flag aSign;
-    int16_t aExp;
-    uint64_t aSig;
-
-    a = float64_squash_input_denormal(a, status);
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-
-    if ( aExp == 0x7FF ) {
-        if ( aSig ) {
-            return propagateFloat64NaN(a, a, status);
-        }
-        return a;
-    }
-    if (aExp != 0) {
-        aSig |= LIT64( 0x0010000000000000 );
-    } else if (aSig == 0) {
-        return a;
-    } else {
-        aExp++;
-    }
-
-    if (n > 0x1000) {
-        n = 0x1000;
-    } else if (n < -0x1000) {
-        n = -0x1000;
-    }
-
-    aExp += n - 1;
-    aSig <<= 10;
-    return normalizeRoundAndPackFloat64(aSign, aExp, aSig, status);
-}
-
 floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 {
     flag aSign;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index aa9e30d254..41338184d5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -326,6 +326,7 @@ float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_muladd(float16, float16, float16, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
+float16 float16_scalbn(float16, int, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
