Received: from eggs.gnu.org ([2001:4830:134:3::10]:59475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYEth-0000wf-8V
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYEte-0002Q8-46
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:42:45 -0500
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gYEtd-0002O6-TP
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:42:42 -0500
Received: from player772.ha.ovh.net (unknown [10.109.160.251])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9FEC219E1BB
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 19:42:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat, 15 Dec 2018 19:42:22 +0100
Message-Id: <20181215184222.15127-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/ppc: fix compilation breakage on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Fix the PPC_BIT definitions to use ULL instead in UL and replace
__builtin_ffssl() by the equivalent ctz routines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Compile tested with --cross-prefix=3Dx86_64-w64-mingw32-. When I have
 some more time, I might try runtime on windows also.

 The PPC compile failures have been there for a while (pre 2.12) and
 the MASK_TO_LSH macro was not used until the XIVE definitions were
 introduced.

 I let you guys decide on how you want to proceed, but I think it is
 safe to merge this patch as a prereq of the pull request.

 Thanks,

 C.

 target/ppc/cpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ab68abe8a23c..a3d3e91eb4ce 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -70,18 +70,18 @@
 #define PPC_ELF_MACHINE     EM_PPC
 #endif
=20
-#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
-#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
-#define PPC_BIT8(bit)           (0x80UL >> (bit))
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000ULL >> (bit))
+#define PPC_BIT8(bit)           (0x80ULL >> (bit))
 #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
 #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
=20
 #if HOST_LONG_BITS =3D=3D 32
-# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+# define MASK_TO_LSH(m)          ctz32(m)
 #elif HOST_LONG_BITS =3D=3D 64
-# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
+# define MASK_TO_LSH(m)          ctz64(m)
 #else
 # error Unknown sizeof long
 #endif
--=20
2.17.2
