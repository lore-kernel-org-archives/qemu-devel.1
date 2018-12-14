Received: from eggs.gnu.org ([2001:4830:134:3::10]:49115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvg-0008Kt-D5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvd-0001un-6o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnvd-0001t1-0A
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:54:57 -0500
Received: by mail-wr1-x432.google.com with SMTP id c14so5549783wrr.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:54:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:41 +0000
Message-Id: <20181214135452.25936-5-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/15] softfloat: add float{32, 64}_is_{de,
 }normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

This paves the way for upcoming work.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8fd9f9bbae..9eeccd88a5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -464,6 +464,16 @@ static inline int float32_is_zero_or_denormal(float32 a)
     return (float32_val(a) & 0x7f800000) == 0;
 }
 
+static inline bool float32_is_normal(float32 a)
+{
+    return ((float32_val(a) + 0x00800000) & 0x7fffffff) >= 0x01000000;
+}
+
+static inline bool float32_is_denormal(float32 a)
+{
+    return float32_is_zero_or_denormal(a) && !float32_is_zero(a);
+}
+
 static inline float32 float32_set_sign(float32 a, int sign)
 {
     return make_float32((float32_val(a) & 0x7fffffff) | (sign << 31));
@@ -605,6 +615,16 @@ static inline int float64_is_zero_or_denormal(float64 a)
     return (float64_val(a) & 0x7ff0000000000000LL) == 0;
 }
 
+static inline bool float64_is_normal(float64 a)
+{
+    return ((float64_val(a) + (1ULL << 52)) & -1ULL >> 1) >= 1ULL << 53;
+}
+
+static inline bool float64_is_denormal(float64 a)
+{
+    return float64_is_zero_or_denormal(a) && !float64_is_zero(a);
+}
+
 static inline float64 float64_set_sign(float64 a, int sign)
 {
     return make_float64((float64_val(a) & 0x7fffffffffffffffULL)
-- 
2.17.1
