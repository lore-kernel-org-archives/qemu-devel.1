Received: from eggs.gnu.org ([2001:4830:134:3::10]:38120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSh-0003Is-QB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSe-0002wa-D2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:35 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euJSe-0002vf-42
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:32 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:57:10 +0100
Message-Id: <20180309145717.9603-2-laurent@vivier.eu>
In-Reply-To: <20180309145717.9603-1-laurent@vivier.eu>
References: <20180309145717.9603-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 1/8] target/m68k: define floatx80_move()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

This functions is needed by upcoming m68k softfloat functions.

Source code copied for WinUAE (tag 3500)
(The WinUAE file has been copied from QEMU and has
the QEMU licensing notice)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-2-laurent@vivier.eu>
---
 target/m68k/softfloat.c | 27 +++++++++++++++++++++++++++
 target/m68k/softfloat.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 9cb141900c..55eb7a260a 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -247,3 +247,30 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
     return roundAndPackFloatx80(status->floatx80_rounding_precision,
                                 aSign, aExp, aSig, 0, status);
 }
+
+floatx80 floatx80_move(floatx80 a, float_status *status)
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
+        if ((uint64_t)(aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        return a;
+    }
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return a;
+        }
+        normalizeRoundAndPackFloatx80(status->floatx80_rounding_precision,
+                                      aSign, aExp, aSig, 0, status);
+    }
+    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+                                aExp, aSig, 0, status);
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 78fbc0cd0c..18561b870d 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -26,4 +26,5 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_getman(floatx80 a, float_status *status);
 floatx80 floatx80_getexp(floatx80 a, float_status *status);
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
+floatx80 floatx80_move(floatx80 a, float_status *status);
 #endif
-- 
2.14.3
