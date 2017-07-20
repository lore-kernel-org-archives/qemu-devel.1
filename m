Received: from eggs.gnu.org ([2001:4830:134:3::10]:53645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0c-0004Yu-5L
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0Y-0007z3-Le
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:58 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0Y-0007yK-ES
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:54 -0400
Received: by mail-wm0-x236.google.com with SMTP id k69so26976574wmc.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:20 +0100
Message-Id: <20170720150426.12393-18-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 17/23] fpu/softfloat2a: implement
 propagateFloat16NaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat2a/softfloat-specialize.h | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fpu/softfloat2a/softfloat-specialize.h b/fpu/softfloat2a/softfloat-specialize.h
index de2c5d5702..c8282b8bf7 100644
--- a/fpu/softfloat2a/softfloat-specialize.h
+++ b/fpu/softfloat2a/softfloat-specialize.h
@@ -686,6 +686,49 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 #endif
 
 /*----------------------------------------------------------------------------
+| Takes two half-precision floating-point values `a' and `b', one of which
+| is a NaN, and returns the appropriate NaN result.  If either `a' or `b' is a
+| signaling NaN, the invalid exception is raised.
+*----------------------------------------------------------------------------*/
+
+static float16 propagateFloat16NaN(float16 a, float16 b, float_status *status)
+{
+    flag aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN;
+    flag aIsLargerSignificand;
+    uint16_t av, bv;
+
+    aIsQuietNaN = float16_is_quiet_nan(a, status);
+    aIsSignalingNaN = float16_is_signaling_nan(a, status);
+    bIsQuietNaN = float16_is_quiet_nan(b, status);
+    bIsSignalingNaN = float16_is_signaling_nan(b, status);
+    av = float16_val(a);
+    bv = float16_val(b);
+
+    if (aIsSignalingNaN | bIsSignalingNaN) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    if (status->default_nan_mode) {
+        return float16_default_nan(status);
+    }
+
+    if ((uint16_t)(av << 1) < (uint16_t)(bv << 1)) {
+        aIsLargerSignificand = 0;
+    } else if ((uint16_t)(bv << 1) < (uint16_t)(av << 1)) {
+        aIsLargerSignificand = 1;
+    } else {
+        aIsLargerSignificand = (av < bv) ? 1 : 0;
+    }
+
+    if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
+                aIsLargerSignificand)) {
+        return float16_maybe_silence_nan(b, status);
+    } else {
+        return float16_maybe_silence_nan(a, status);
+    }
+}
+
+/*----------------------------------------------------------------------------
 | Takes two single-precision floating-point values `a' and `b', one of which
 | is a NaN, and returns the appropriate NaN result.  If either `a' or `b' is a
 | signaling NaN, the invalid exception is raised.
-- 
2.13.0
