Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFP-0005Jz-22
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFN-0003zm-1V
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:43 +1100
Message-Id: <20181108121646.26173-20-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/22] hw/ppc/ppc440_uc: Remove dead code in
 sdram_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out in CID 1390588 that the test for sh =3D=3D 0
in sdram_size() can never fire, because we calculate sh with
    sh =3D 1024 - ((bcr >> 6) & 0x3ff);
which must result in a value between 1 and 1024 inclusive.

Without the relevant manual for the SoC, we're not completely
sure of the correct behaviour here, but we can remove the
dead code without changing how QEMU currently behaves.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 09ccda548f..9360f781ce 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -559,11 +559,7 @@ static target_ulong sdram_size(uint32_t bcr)
     int sh;
=20
     sh =3D 1024 - ((bcr >> 6) & 0x3ff);
-    if (sh =3D=3D 0) {
-        size =3D -1;
-    } else {
-        size =3D 8 * MiB * sh;
-    }
+    size =3D 8 * MiB * sh;
=20
     return size;
 }
--=20
2.19.1
