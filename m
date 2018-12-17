Received: from eggs.gnu.org ([2001:4830:134:3::10]:58485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Tm-0007Uq-LI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Ti-0007Py-0T
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:13 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:45581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1Th-0007NM-Kx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:09 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.132])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9D69F430E2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:35:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:40 +0100
Message-Id: <20181217223445.28594-3-clg@kaod.org>
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 2/7] target/ppc: replace __builtin_ffssl()
 by the equivalent ctz routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

And remove the intermediate MASK_TO_LSH macro which does not add any valu=
e.

This fixes a compile breakage on windows.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 527181c0f09f..f4ef4f214564 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -78,18 +78,21 @@
                                  PPC_BIT32(bs))
 #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
=20
+/*
+ * OPAL PPC bitmask field manipulation, used in XIVE, PHB3 and PHB4
+ */
 #if HOST_LONG_BITS =3D=3D 32
-# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#  define GETFIELD(m, v)        (((v) & (m)) >> ctz32(m))
+#  define SETFIELD(m, v, val)                                   \
+    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz32(m)) & (m)))
 #elif HOST_LONG_BITS =3D=3D 64
-# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
+#  define GETFIELD(m, v)        (((v) & (m)) >> ctz64(m))
+#  define SETFIELD(m, v, val)                                   \
+    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz64(m)) & (m)))
 #else
 # error Unknown sizeof long
 #endif
=20
-#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
-#define SETFIELD(m, v, val)                             \
-        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
-
 /***********************************************************************=
******/
 /* Exception vectors definitions                                        =
     */
 enum {
--=20
2.17.2
