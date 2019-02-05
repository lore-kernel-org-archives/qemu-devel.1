Received: from eggs.gnu.org ([209.51.188.92]:49367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gr3Uy-0002Ix-Mo
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gr3Uy-0000k0-4f
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gr3Ux-0000jh-VS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:23:00 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue,  5 Feb 2019 17:22:53 +0100
Message-Id: <20190205162253.9155-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] softfloat: add float128_is_{normal,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Hildenbrand <david@redhat.com>

Needed on s390x, to test for the data class of a number. So it will
gain soon a user.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/fpu/softfloat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 38a5e99cf3..10c31557b4 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -940,6 +940,16 @@ static inline int float128_is_zero_or_denormal(float128 a)
     return (a.high & 0x7fff000000000000LL) == 0;
 }
 
+static inline bool float128_is_normal(float128 a)
+{
+    return ((a.high + (1ULL << 47)) & -1ULL >> 1) >= 1ULL << 48;
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
