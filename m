Received: from eggs.gnu.org ([2001:4830:134:3::10]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-0002A0-VP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000z9-7h
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000y5-2Q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:40 -0400
Message-Id: <1521663109-32262-6-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 05/14] softfloat: add float32_is_normal and
 float64_is_normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This paves the way for upcoming work.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 36626a5..7b9d31c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -402,6 +402,11 @@ static inline int float32_is_zero(float32 a)
     return (float32_val(a) & 0x7fffffff) == 0;
 }
 
+static inline bool float32_is_normal(float32 a)
+{
+    return ((float32_val(a) + 0x00800000) & 0x7fffffff) >= 0x01000000;
+}
+
 static inline int float32_is_any_nan(float32 a)
 {
     return ((float32_val(a) & ~(1 << 31)) > 0x7f800000UL);
@@ -531,6 +536,11 @@ static inline int float64_is_zero(float64 a)
     return (float64_val(a) & 0x7fffffffffffffffLL) == 0;
 }
 
+static inline bool float64_is_normal(float64 a)
+{
+    return ((float64_val(a) + (1ULL << 52)) & -1ULL >> 1) >= 1ULL << 53;
+}
+
 static inline int float64_is_any_nan(float64 a)
 {
     return ((float64_val(a) & ~(1ULL << 63)) > 0x7ff0000000000000ULL);
-- 
2.7.4
