Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TF-LI
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007wU-DA
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007vf-5J
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:22 -0400
Message-Id: <20181013231933.28789-3-cota@braap.org>
In-Reply-To: <20181013231933.28789-1-cota@braap.org>
References: <20181013231933.28789-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/13] softfloat: add float{32, 64}_is_{de,
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
