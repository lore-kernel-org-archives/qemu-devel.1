Received: from eggs.gnu.org ([2001:4830:134:3::10]:33284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4g-0008Aa-PV
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4a-0005uv-Vx
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQv4a-0005sP-CP
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 30 Jun 2017 14:30:47 +0200
Message-Id: <20170630123050.19834-5-laurent@vivier.eu>
In-Reply-To: <20170630123050.19834-1-laurent@vivier.eu>
References: <20170630123050.19834-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/7] softfloat: define floatx80_round()
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

Add a function to round a floatx80 to the defined precision
(floatx80_rounding_precision)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170628204241.32106-5-laurent@vivier.eu>
---
 fpu/softfloat.c         | 16 ++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7af14e2..433c5da 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5086,6 +5086,22 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
+| Rounds the extended double-precision floating-point value `a'
+| to the precision provided by floatx80_rounding_precision and returns the
+| result as an extended double-precision floating-point value.
+| The operation is performed according to the IEC/IEEE Standard for Binary
+| Floating-Point Arithmetic.
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
