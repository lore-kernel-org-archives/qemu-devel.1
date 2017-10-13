Received: from eggs.gnu.org ([2001:4830:134:3::10]:41751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lX-0002V4-0a
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lW-0006ZS-1u
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:50 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:51101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lV-0006Yg-Mq
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:49 -0400
Received: by mail-wr0-x22f.google.com with SMTP id q42so1429685wrb.7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:13 +0100
Message-Id: <20171013162438.32458-6-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 05/30] softfloat: implement
 propagateFloat16NaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat-specialize.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index de2c5d5702..c8282b8bf7 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -685,6 +685,49 @@ static int pickNaNMulAdd(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 }
 #endif
 
+/*----------------------------------------------------------------------------
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
 /*----------------------------------------------------------------------------
 | Takes two single-precision floating-point values `a' and `b', one of which
 | is a NaN, and returns the appropriate NaN result.  If either `a' or `b' is a
-- 
2.14.1
