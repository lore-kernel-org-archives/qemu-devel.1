Received: from eggs.gnu.org ([2001:4830:134:3::10]:57463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmV-0003G3-UI
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmQ-0005EY-Qh
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQhmP-0004eq-KX
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 24 Nov 2018 18:55:42 -0500
Message-Id: <20181124235553.17371-3-cota@braap.org>
In-Reply-To: <20181124235553.17371-1-cota@braap.org>
References: <20181124235553.17371-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/13] softfloat: add float{32, 64}_is_{de,
 }normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

This paves the way for upcoming work.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

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
