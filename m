Received: from eggs.gnu.org ([209.51.188.92]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grJEW-0006ZC-Na
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grJEV-0001fO-Qq
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:11:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1grJEP-0001be-1a
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:10:59 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed,  6 Feb 2019 10:10:43 +0100
Message-Id: <20190206091043.10985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Hildenbrand <david@redhat.com>

Needed on s390x, to test for the data class of a number. So it will
gain soon a user.

A number is considered normal if the exponent is neither 0 nor all 1's.
That can be checked by adding 1 to the exponent, and comparing against
>= 2 after dropping an eventual overflow into the sign bit.

While at it, convert the other floatXX_is_normal functions to use a
similar, less error prone calculation, as suggested by Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/fpu/softfloat.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 38a5e99cf3..3ff5215b81 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -466,7 +466,7 @@ static inline int float32_is_zero_or_denormal(float32 a)
 
 static inline bool float32_is_normal(float32 a)
 {
-    return ((float32_val(a) + 0x00800000) & 0x7fffffff) >= 0x01000000;
+    return (((float32_val(a) >> 23) + 1) & 0xff) >= 2;
 }
 
 static inline bool float32_is_denormal(float32 a)
@@ -622,7 +622,7 @@ static inline int float64_is_zero_or_denormal(float64 a)
 
 static inline bool float64_is_normal(float64 a)
 {
-    return ((float64_val(a) + (1ULL << 52)) & -1ULL >> 1) >= 1ULL << 53;
+    return (((float64_val(a) >> 52) + 1) & 0x7ff) >= 2;
 }
 
 static inline bool float64_is_denormal(float64 a)
@@ -940,6 +940,16 @@ static inline int float128_is_zero_or_denormal(float128 a)
     return (a.high & 0x7fff000000000000LL) == 0;
 }
 
+static inline bool float128_is_normal(float128 a)
+{
+    return (((a.high >> 48) + 1) & 0x7fff) >= 2;
+}
+
+static inline bool float128_is_denormal(float128 a)
+{
+    return float128_is_zero_or_denormal(a) && !float128_is_zero(a);
+}
+
 static inline int float128_is_any_nan(float128 a)
 {
     return ((a.high >> 48) & 0x7fff) == 0x7fff &&
-- 
2.17.2
