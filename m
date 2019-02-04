Received: from eggs.gnu.org ([209.51.188.92]:38199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8Z-0000Vb-R3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8O-0007Eq-Hr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:57 +1100
Message-Id: <20190204090124.26191-11-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/37] ppc440: Avoid reporting error when
 reading non-existent RAM slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

When reading base register of RAM slot with no RAM we should not try
to calculate register value because that will result printing an error
due to invalid RAM size. Just return 0 without the error in this case.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index c489368905..9130eb314c 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -613,8 +613,10 @@ static uint32_t dcr_read_sdram(void *opaque, int dcr=
n)
     case SDRAM_R1BAS:
     case SDRAM_R2BAS:
     case SDRAM_R3BAS:
-        ret =3D sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
-                        sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
+        if (sdram->ram_sizes[dcrn - SDRAM_R0BAS]) {
+            ret =3D sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
+                            sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
+        }
         break;
     case SDRAM_CONF1HB:
     case SDRAM_CONF1LL:
--=20
2.20.1
