Received: from eggs.gnu.org ([2001:4830:134:3::10]:40789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00044D-9H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQh-0003LY-Rs
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQh-0003Ix-IS
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:49 -0400
Message-Id: <1528768140-17894-4-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/14] softfloat: add float{32, 64}_is_{de,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This paves the way for upcoming work.

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 69f4dbc..1fbece5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -412,6 +412,16 @@ static inline int float32_is_zero_or_denormal(float32 a)
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
@@ -541,6 +551,16 @@ static inline int float64_is_zero_or_denormal(float64 a)
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
2.7.4
