Received: from eggs.gnu.org ([2001:4830:134:3::10]:46760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6k-0005vu-31
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPD6f-0003n2-E0
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:64682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPD6f-0003mq-3k
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 15:22:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Jun 2017 21:21:23 +0200
Message-Id: <20170625192125.9992-6-laurent@vivier.eu>
In-Reply-To: <20170625192125.9992-1-laurent@vivier.eu>
References: <20170625192125.9992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 5/7] softfloat: define floatx80_round()
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

Add a function to round a floatx80 to the defined precision
(floatx80_rounding_precision)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat.c         | 15 +++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7af14e2..e9bf359 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5086,6 +5086,21 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
+| Rounds the extended double-precision floating-point value `a'
+| and returns the result as an extended double-precision floating-point
+| value.  The operation is performed according to the IEC/IEEE Standard for
+| Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+floatx80 floatx80_round(floatx80 a, float_status *status)
+{
+    return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                extractFloatx80Sign(a),
+                                extractFloatx80Exp(a),
+                                extractFloatx80Frac(a), 0, status);
+}
+
+/*----------------------------------------------------------------------------
 | Rounds the extended double-precision floating-point value `a' to an integer,
 | and returns the result as an extended quadruple-precision floating-point
 | value.  The operation is performed according to the IEC/IEEE Standard for
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index f1288ef..d9689ec 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -621,6 +621,7 @@ float128 floatx80_to_float128(floatx80, float_status *status);
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE extended double-precision operations.
 *----------------------------------------------------------------------------*/
+floatx80 floatx80_round(floatx80 a, float_status *status);
 floatx80 floatx80_round_to_int(floatx80, float_status *status);
 floatx80 floatx80_add(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sub(floatx80, floatx80, float_status *status);
-- 
2.9.4
