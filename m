Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGm-0002zu-82
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGl-0001n7-CB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGl-0001lJ-6J
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39DB88553D
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:29 +0100
Message-Id: <20170906184133.25524-5-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/8] host-utils: Simplify pow2ceil()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1501148776-16890-4-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/host-utils.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 6c6005f5cf..5ac621cf1f 100644
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
-
-    if (is_power_of_2(value)) {
-        return value;
-    }
-    if (!nlz) {
-        return 0;
+    int n =3D clz64(value - 1);
+
+    if (!n) {
+        /*
+         * @value - 1 has no leading zeroes, thus @value - 1 >=3D 2^63
+         * Therefore, either @value =3D=3D 0 or @value > 2^63.
+         * If it's 0, return 1, else return 0.
+         */
+        return !value;
     }
-    return 1ULL << (64 - nlz);
+    return 0x8000000000000000ull >> (n - 1);
 }
=20
 /**
--=20
2.13.5
