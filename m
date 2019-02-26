Received: from eggs.gnu.org ([209.51.188.92]:52768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSs-0008Av-RZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSo-0003KD-9m
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:32835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gydSo-0003Ir-1s
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id i12so14149851wrw.0
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 06:12:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 14:11:56 +0000
Message-Id: <20190226141201.16999-3-alex.bennee@linaro.org>
In-Reply-To: <20190226141201.16999-1-alex.bennee@linaro.org>
References: <20190226141201.16999-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, david@redhat.com, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: David Hildenbrand <david@redhat.com>

Needed on s390x, to test for the data class of a number. So it will
gain soon a user.

A number is considered normal if the exponent is neither 0 nor all 1's.
That can be checked by adding 1 to the exponent, and comparing against
>= 2 after dropping an eventual overflow into the sign bit.

While at it, convert the other floatXX_is_normal functions to use a
similar, less error prone calculation, as suggested by Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.20.1
