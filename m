Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdv-0002JW-VX
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdt-0007Y5-At
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:12 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONdt-0007XB-4U
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:09 -0500
Received: by mail-wr0-x244.google.com with SMTP id z34so17439199wrz.10
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:08 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:47 +0000
Message-Id: <20171211125705.16120-2-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/19] fpu/softfloat: implement
 float16_squash_input_denormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 15 +++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 433c5dad2d..3a4ab1355f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
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
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 0f96a0edd1..d5e99667b6 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -277,6 +277,7 @@ void float_raise(uint8_t flags, float_status *status);
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
 *----------------------------------------------------------------------------*/
+float16 float16_squash_input_denormal(float16 a, float_status *status);
 float32 float32_squash_input_denormal(float32 a, float_status *status);
 float64 float64_squash_input_denormal(float64 a, float_status *status);
 
-- 
2.15.1
