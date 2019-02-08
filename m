Received: from eggs.gnu.org ([209.51.188.92]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gs9A1-00006V-FY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gs99s-0005MP-5R
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:37:48 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:44306
	helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gs99j-00051w-Rp
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:37:38 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 88F365FD99
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 17:37:27 +0100 (CET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Date: Fri,  8 Feb 2019 18:37:27 +0200
Message-Id: <20190208163727.13733-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tcg: assert last byte is in guest space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rather than assert that the first byte of a checked range is within the
guest address space, assert that the last byte is. The assertion is
moved past the overflow check to ensure that the last byte is actually
the one with the highest address.

Signed-off-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
---
 accel/tcg/translate-all.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8f593b926f..ea0c96af71 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2515,13 +2515,6 @@ int page_check_range(target_ulong start, target_ul=
ong len, int flags)
     target_ulong end;
     target_ulong addr;
=20
-    /* This function should never be called with addresses outside the
-       guest address space.  If this assert fires, it probably indicates
-       a missing call to h2g_valid.  */
-#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
-#endif
-
     if (len =3D=3D 0) {
         return 0;
     }
@@ -2530,6 +2523,13 @@ int page_check_range(target_ulong start, target_ul=
ong len, int flags)
         return -1;
     }
=20
+    /* This function should never be called with addresses outside the
+       guest address space.  If this assert fires, it probably indicates
+       a missing call to h2g_valid.  */
+#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
+    assert((start + len - 1) < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BIT=
S));
+#endif
+
     /* must do before we loose bits in the next step */
     end =3D TARGET_PAGE_ALIGN(start + len);
     start =3D start & TARGET_PAGE_MASK;
--=20
2.20.1
