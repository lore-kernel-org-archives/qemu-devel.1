Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVh-0002je-M3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVe-00024C-V7
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGVe-00023p-KI
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:16:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:19 +0100
Message-Id: <20170130181634.13934-2-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 01/16] softfloat: define 680x0 specific
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat-specialize.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index f05c865..01b594f 100644
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
 
@@ -502,6 +506,26 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
         return 1;
     }
 }
+#elif defined(TARGET_M68K)
+static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
+                   flag aIsLargerSignificand)
+{
+    /* If either operand, but not both operands, of an operation is a
+     * nonsignaling NAN, then that NAN is returned as the result. If both
+     * operands are nonsignaling NANs, then the destination operand
+     * nonsignaling NAN is returned as the result.
+     */
+
+    if (aIsSNaN) {
+        return 0;
+    } else if (bIsSNaN) {
+        return 1;
+    } else if (bIsQNaN) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
 #else
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
                     flag aIsLargerSignificand)
-- 
2.9.3
