Received: from eggs.gnu.org ([2001:4830:134:3::10]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN8-00038y-IB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dafN5-0001DC-Jh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dafN5-0001Cq-Dw
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51201C00F7D9
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:46:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 27 Jul 2017 11:46:16 +0200
Message-Id: <1501148776-16890-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1501148776-16890-1-git-send-email-armbru@redhat.com>
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] host-utils: Simplify pow2ceil()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/host-utils.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 6c6005f..5ac621c 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -381,18 +381,23 @@ static inline uint64_t pow2floor(uint64_t value)
     return 0x8000000000000000ull >> clz64(value);
 }
=20
-/* round up to the nearest power of 2 (0 if overflow) */
+/*
+ * Return @value rounded up to the nearest power of two modulo 2^64.
+ * This is *zero* for @value > 2^63, so be careful.
+ */
 static inline uint64_t pow2ceil(uint64_t value)
 {
-    uint8_t nlz =3D clz64(value);
+    int n =3D clz64(value - 1);
=20
-    if (is_power_of_2(value)) {
-        return value;
+    if (!n) {
+        /*
+         * @value - 1 has no leading zeroes, thus @value - 1 >=3D 2^63
+         * Therefore, either @value =3D=3D 0 or @value > 2^63.
+         * If it's 0, return 1, else return 0.
+         */
+        return !value;
     }
-    if (!nlz) {
-        return 0;
-    }
-    return 1ULL << (64 - nlz);
+    return 0x8000000000000000ull >> (n - 1);
 }
=20
 /**
--=20
2.7.5
