Received: from eggs.gnu.org ([209.51.188.92]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHrc-0003Fi-Th
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHgv-0006tC-Jo
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:06 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxHgv-0006sF-Bj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:05 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so3111595wmh.4
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 12:45:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 20:44:57 +0000
Message-Id: <20190222204500.24434-4-alex.bennee@linaro.org>
In-Reply-To: <20190222204500.24434-1-alex.bennee@linaro.org>
References: <20190222204500.24434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/6] softfloat: Implement float128_to_uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: David Hildenbrand <david@redhat.com>

Handling it just like float128_to_uint32_round_to_zero, that hopefully
is free of bugs :)

Documentation basically copied from float128_to_uint64

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         | 29 +++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9132d7a0b0..c69cd6b5d1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6792,6 +6792,35 @@ uint32_t float128_to_uint32_round_to_zero(float128 a, float_status *status)
     return res;
 }
 
+/*----------------------------------------------------------------------------
+| Returns the result of converting the quadruple-precision floating-point value
+| `a' to the 32-bit unsigned integer format.  The conversion is
+| performed according to the IEC/IEEE Standard for Binary Floating-Point
+| Arithmetic---which means in particular that the conversion is rounded
+| according to the current rounding mode.  If `a' is a NaN, the largest
+| positive integer is returned.  If the conversion overflows, the
+| largest unsigned integer is returned.  If 'a' is negative, the value is
+| rounded and zero is returned; negative values that do not round to zero
+| will raise the inexact exception.
+*----------------------------------------------------------------------------*/
+
+uint32_t float128_to_uint32(float128 a, float_status *status)
+{
+    uint64_t v;
+    uint32_t res;
+    int old_exc_flags = get_float_exception_flags(status);
+
+    v = float128_to_uint64(a, status);
+    if (v > 0xffffffff) {
+        res = 0xffffffff;
+    } else {
+        return v;
+    }
+    set_float_exception_flags(old_exc_flags, status);
+    float_raise(float_flag_invalid, status);
+    return res;
+}
+
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff5215b81..3ff3fa5224 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -878,6 +878,7 @@ int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32(float128, float_status *status);
 uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
-- 
2.20.1
