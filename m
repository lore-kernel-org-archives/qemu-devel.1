Received: from eggs.gnu.org ([2001:4830:134:3::10]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau8U-0004jd-LA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 19:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cau8P-0005uv-V3
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 19:59:58 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:63507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cau8P-0005uV-KV
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 19:59:53 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 01:59:16 +0100
Message-Id: <20170207005930.28327-3-laurent@vivier.eu>
In-Reply-To: <20170207005930.28327-1-laurent@vivier.eu>
References: <20170207005930.28327-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/16] softloat: disable
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@linux-m68k.org>

According to the comment, this definition of invalid encoding is given
by intel developer's manual, and doesn't work with the behavior
of 680x0 FPU.

CC: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat.c         | 31 +++++++++++++++++++++++++++++++
 include/fpu/softfloat.h | 15 ---------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..f95b19f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4799,6 +4799,37 @@ int float64_unordered_quiet(float64 a, float64 b, float_status *status)
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
+    /*-------------------------------------------------------------------------
+    |  M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
+    |  1.6.2 Denormalized Numbers
+    |  Since the extended-precision data format has an explicit integer bit,
+    |  a number can be formatted with a nonzero exponent, less than the maximum
+    |  value, and a zero integer bit.  The IEEE 754 standard does not define a
+    |  zero integer bit. Such a number is an unnormalized number. Hardware does
+    |  not directly support denormalized and unnormalized numbers, but
+    |  implicitly supports them by trapping them as unimplemented data types,
+    |  allowing efficient conversion in software.
+    *------------------------------------------------------------------------*/
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
index 842ec6b..3920c0a 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -678,21 +678,6 @@ static inline int floatx80_is_any_nan(floatx80 a)
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
