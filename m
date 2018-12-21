Received: from eggs.gnu.org ([2001:4830:134:3::10]:59893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdd-0000UO-Q7
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdc-0006tK-FV
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:21 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:28 +1100
Message-Id: <20181221054606.22007-3-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/40] target/ppc: Remove silly
 GETFIELD/SETFIELD/MASK_TO_LSH macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The (only) obvious use for these macros is constructing and parsing guest
visible register fields.  But the way they're constructed, they're only
valid when used on a *host* long, whose size shouldn't be visible to the
guest at all.

They also have no current users, so just get rid of them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 527181c0f0..d5f99f1fc7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -78,18 +78,6 @@
                                  PPC_BIT32(bs))
 #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
=20
-#if HOST_LONG_BITS =3D=3D 32
-# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
-#elif HOST_LONG_BITS =3D=3D 64
-# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
-#else
-# error Unknown sizeof long
-#endif
-
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
2.19.2
