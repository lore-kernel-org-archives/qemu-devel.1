Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD83-00039T-0o
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD82-0004Jx-3W
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:39 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD81-0004JN-T7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:38 -0400
Received: by mail-wm0-x229.google.com with SMTP id w126so27195883wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:21 +0100
Message-Id: <20170720150426.12393-19-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 18/23] fpu/softfloat2a: implement
 float16_squash_input_denormal
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
 fpu/softfloat2a/softfloat.c         | 15 +++++++++++++++
 include/fpu/softfloat2a/softfloat.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fpu/softfloat2a/softfloat.c b/fpu/softfloat2a/softfloat.c
index 59b9bc9e24..4f1abbe08f 100644
--- a/fpu/softfloat2a/softfloat.c
+++ b/fpu/softfloat2a/softfloat.c
@@ -3488,6 +3488,21 @@ static float16 roundAndPackFloat16(flag zSign, int zExp,
     return packFloat16(zSign, zExp, zSig >> 13);
 }
 
+/*----------------------------------------------------------------------------
+| If `a' is denormal and we are in flush-to-zero mode then set the
+| input-denormal exception and return zero. Otherwise just return the value.
+*----------------------------------------------------------------------------*/
+float16 float16_squash_input_denormal(float16 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        if (extractFloat16Exp(a) == 0 && extractFloat16Frac(a) != 0) {
+            float_raise(float_flag_input_denormal, status);
+            return make_float16(float16_val(a) & 0x8000);
+        }
+    }
+    return a;
+}
+
 static void normalizeFloat16Subnormal(uint32_t aSig, int *zExpPtr,
                                       uint32_t *zSigPtr)
 {
diff --git a/include/fpu/softfloat2a/softfloat.h b/include/fpu/softfloat2a/softfloat.h
index d9689eca2a..a274dc7419 100644
--- a/include/fpu/softfloat2a/softfloat.h
+++ b/include/fpu/softfloat2a/softfloat.h
@@ -282,6 +282,7 @@ void float_raise(uint8_t flags, float_status *status);
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
 *----------------------------------------------------------------------------*/
+float16 float16_squash_input_denormal(float16 a, float_status *status);
 float32 float32_squash_input_denormal(float32 a, float_status *status);
 float64 float64_squash_input_denormal(float64 a, float_status *status);
 
-- 
2.13.0
