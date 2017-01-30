Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVr-0002ox-AO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cYGVn-00026J-AE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:11 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cYGVm-00025u-Vh
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:17:07 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:16:20 +0100
Message-Id: <20170130181634.13934-3-laurent@vivier.eu>
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
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

According to the comment, this definition of invalid encoding is given
by intel developer's manual, and doesn't work with the behavior
of 680x0 FPU.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat.c         | 20 ++++++++++++++++++++
 include/fpu/softfloat.h | 15 ---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..3aa05c1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4799,6 +4799,26 @@ int float64_unordered_quiet(float64 a, float64 b, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
+| Return whether the given value is an invalid floatx80 encoding.
+| Invalid floatx80 encodings arise when the integer bit is not set, but
+| the exponent is not zero. The only times the integer bit is permitted to
+| be zero is in subnormal numbers and the value zero.
+| This includes what the Intel software developer's manual calls pseudo-NaNs,
+| pseudo-infinities and un-normal numbers. It does not include
+| pseudo-denormals, which must still be correctly handled as inputs even
+| if they are never generated as outputs.
+*----------------------------------------------------------------------------*/
+static inline bool floatx80_invalid_encoding(floatx80 a)
+{
+#if defined(TARGET_M68K)
+    return 0;
+#else
+    return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
+#endif
+}
+
+
+/*----------------------------------------------------------------------------
 | Returns the result of converting the extended double-precision floating-
 | point value `a' to the 32-bit two's complement integer format.  The
 | conversion is performed according to the IEC/IEEE Standard for Binary
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 14f8383..1bde349 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -658,21 +658,6 @@ static inline int floatx80_is_any_nan(floatx80 a)
     return ((a.high & 0x7fff) == 0x7fff) && (a.low<<1);
 }
 
-/*----------------------------------------------------------------------------
-| Return whether the given value is an invalid floatx80 encoding.
-| Invalid floatx80 encodings arise when the integer bit is not set, but
-| the exponent is not zero. The only times the integer bit is permitted to
-| be zero is in subnormal numbers and the value zero.
-| This includes what the Intel software developer's manual calls pseudo-NaNs,
-| pseudo-infinities and un-normal numbers. It does not include
-| pseudo-denormals, which must still be correctly handled as inputs even
-| if they are never generated as outputs.
-*----------------------------------------------------------------------------*/
-static inline bool floatx80_invalid_encoding(floatx80 a)
-{
-    return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
-}
-
 #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
 #define floatx80_one make_floatx80(0x3fff, 0x8000000000000000LL)
 #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
-- 
2.9.3
