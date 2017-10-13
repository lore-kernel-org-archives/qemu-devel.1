Received: from eggs.gnu.org ([2001:4830:134:3::10]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sg-0000gk-T3
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sf-0002P3-CK
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:14 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:56195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sf-0002OX-4P
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:13 -0400
Received: by mail-wm0-x236.google.com with SMTP id u138so22988456wmu.4
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:22 +0100
Message-Id: <20171013162438.32458-15-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 14/30] softfloat: 16 bit helpers for shr,
 clz and rounding and packing
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

Half-precision helpers for float16 maths. I didn't bother hand-coding
the count leading zeros as we could always fall-back to host-utils if
we needed to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat-macros.h | 39 +++++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c        | 21 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fpu/softfloat-macros.h b/fpu/softfloat-macros.h
index 9cc6158cb4..73091a88a8 100644
--- a/fpu/softfloat-macros.h
+++ b/fpu/softfloat-macros.h
@@ -89,6 +89,31 @@ this code that are retained.
 # define SOFTFLOAT_GNUC_PREREQ(maj, min) 0
 #endif
 
+/*----------------------------------------------------------------------------
+| Shifts `a' right by the number of bits given in `count'.  If any nonzero
+| bits are shifted off, they are ``jammed'' into the least significant bit of
+| the result by setting the least significant bit to 1.  The value of `count'
+| can be arbitrarily large; in particular, if `count' is greater than 16, the
+| result will be either 0 or 1, depending on whether `a' is zero or nonzero.
+| The result is stored in the location pointed to by `zPtr'.
+*----------------------------------------------------------------------------*/
+
+static inline void shift16RightJamming(uint16_t a, int count, uint16_t *zPtr)
+{
+    uint16_t z;
+
+    if ( count == 0 ) {
+        z = a;
+    }
+    else if ( count < 16 ) {
+        z = ( a>>count ) | ( ( a<<( ( - count ) & 16 ) ) != 0 );
+    }
+    else {
+        z = ( a != 0 );
+    }
+    *zPtr = z;
+
+}
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -664,6 +689,20 @@ static uint32_t estimateSqrt32(int aExp, uint32_t a)
 
 }
 
+/*----------------------------------------------------------------------------
+| Returns the number of leading 0 bits before the most-significant 1 bit of
+| `a'.  If `a' is zero, 16 is returned.
+*----------------------------------------------------------------------------*/
+
+static int8_t countLeadingZeros16( uint16_t a )
+{
+    if (a) {
+        return __builtin_clz(a);
+    } else {
+        return 16;
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Returns the number of leading 0 bits before the most-significant 1 bit of
 | `a'.  If `a' is zero, 32 is returned.
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6ab4b39c09..cf7bf6d4f4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3488,6 +3488,27 @@ static float16 roundAndPackFloat16(flag zSign, int zExp,
     return packFloat16(zSign, zExp, zSig >> 13);
 }
 
+/*----------------------------------------------------------------------------
+| Takes an abstract floating-point value having sign `zSign', exponent `zExp',
+| and significand `zSig', and returns the proper single-precision floating-
+| point value corresponding to the abstract input.  This routine is just like
+| `roundAndPackFloat32' except that `zSig' does not have to be normalized.
+| Bit 15 of `zSig' must be zero, and `zExp' must be 1 less than the ``true''
+| floating-point exponent.
+*----------------------------------------------------------------------------*/
+
+static float16
+ normalizeRoundAndPackFloat16(flag zSign, int zExp, uint16_t zSig,
+                              float_status *status)
+{
+    int8_t shiftCount;
+
+    shiftCount = countLeadingZeros16( zSig ) - 1;
+    return roundAndPackFloat16(zSign, zExp - shiftCount, zSig<<shiftCount,
+                               true, status);
+
+}
+
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
 | input-denormal exception and return zero. Otherwise just return the value.
-- 
2.14.1
