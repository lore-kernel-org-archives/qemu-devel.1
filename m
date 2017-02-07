Received: from eggs.gnu.org ([2001:4830:134:3::10]:32883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau8W-0004jp-Sr
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau8S-0005vS-Pb
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 20:00:00 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:61946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cau8S-0005vH-Ey
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 19:59:56 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 01:59:15 +0100
Message-Id: <20170207005930.28327-2-laurent@vivier.eu>
In-Reply-To: <20170207005930.28327-1-laurent@vivier.eu>
References: <20170207005930.28327-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/16] softfloat: define 680x0 specific
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

CC: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat-specialize.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 100c8a9..fb70d32 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -111,7 +111,7 @@ float16 float16_default_nan(float_status *status)
 *----------------------------------------------------------------------------*/
 float32 float32_default_nan(float_status *status)
 {
-#if defined(TARGET_SPARC)
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
     return const_float32(0x7FFFFFFF);
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
       defined(TARGET_XTENSA) || defined(TARGET_S390X) || defined(TARGET_TRICORE)
@@ -136,7 +136,7 @@ float32 float32_default_nan(float_status *status)
 *----------------------------------------------------------------------------*/
 float64 float64_default_nan(float_status *status)
 {
-#if defined(TARGET_SPARC)
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
     return const_float64(LIT64(0x7FFFFFFFFFFFFFFF));
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
       defined(TARGET_S390X)
@@ -162,7 +162,10 @@ float64 float64_default_nan(float_status *status)
 floatx80 floatx80_default_nan(float_status *status)
 {
     floatx80 r;
-
+#if defined(TARGET_M68K)
+    r.low = LIT64(0xFFFFFFFFFFFFFFFF);
+    r.high = 0x7FFF;
+#else
     if (status->snan_bit_is_one) {
         r.low = LIT64(0xBFFFFFFFFFFFFFFF);
         r.high = 0x7FFF;
@@ -170,6 +173,7 @@ floatx80 floatx80_default_nan(float_status *status)
         r.low = LIT64(0xC000000000000000);
         r.high = 0xFFFF;
     }
+#endif
     return r;
 }
 
@@ -502,6 +506,30 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
         return 1;
     }
 }
+#elif defined(TARGET_M68K)
+static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
+                   flag aIsLargerSignificand)
+{
+    /* M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
+     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+     * If either operand, but not both operands, of an operation is a
+     * nonsignaling NaN, then that NaN is returned as the result. If both
+     * operands are nonsignaling NaNs, then the destination operand
+     * nonsignaling NaN is returned as the result.
+     * If either operand to an operation is a signaling NaN (SNaN), then the
+     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+     * is set in the FPCR ENABLE byte, then the exception is taken and the
+     * destination is not modified. If the SNaN exception enable bit is not
+     * set, setting the SNaN bit in the operand to a one converts the SNaN to
+     * a nonsignaling NaN. The operation then continues as described in the
+     * preceding paragraph for nonsignaling NaNs.
+     */
+    if (aIsQNaN || aIsSNaN) { /* a is the destination operand */
+        return 0; /* return the destination operand */
+    } else {
+        return 1; /* return b */
+    }
+}
 #else
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
                     flag aIsLargerSignificand)
-- 
2.9.3
