Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVF-0003Ck-Dg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVC-0008F6-Mv
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:17 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:48 +1100
Message-Id: <20170222063348.32176-44-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/43] hw/ppc/ppc405_uc.c: Avoid integer
 overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

When performing clock calculations, the ppc405_uc code
has several places where it multiplies together two
32-bit variables and assigns the result to a 64-bit
variable. This doesn't quite do what is intended because
C will compute a 32-bit multiply result. Add casts to
ensure we don't truncate the result.

(Spotted by Coverity, CID 1005504, 1005505.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index d6d3fc2..d5df94a 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1881,7 +1881,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc=
)
         D1 =3D (((cpc->pllmr >> 20) - 1) & 0xF) + 1; /* FBDV */
         D2 =3D 8 - ((cpc->pllmr >> 16) & 0x7); /* FWDVA */
         M =3D D0 * D1 * D2;
-        VCO_out =3D cpc->sysclk * M;
+        VCO_out =3D (uint64_t)cpc->sysclk * M;
         if (VCO_out < 400000000 || VCO_out > 800000000) {
             /* PLL cannot lock */
             cpc->pllmr &=3D ~0x80000000;
@@ -1892,7 +1892,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc=
)
         /* Bypass PLL */
     bypass_pll:
         M =3D D0;
-        PLL_out =3D cpc->sysclk * M;
+        PLL_out =3D (uint64_t)cpc->sysclk * M;
     }
     CPU_clk =3D PLL_out;
     if (cpc->cr1 & 0x00800000)
@@ -2242,7 +2242,7 @@ static void ppc405ep_compute_clocks (ppc405ep_cpc_t=
 *cpc)
 #ifdef DEBUG_CLOCKS_LL
         printf("FWDA %01" PRIx32 " %d\n", (cpc->pllmr[1] >> 16) & 0x7, D=
);
 #endif
-        VCO_out =3D cpc->sysclk * M * D;
+        VCO_out =3D (uint64_t)cpc->sysclk * M * D;
         if (VCO_out < 500000000UL || VCO_out > 1000000000UL) {
             /* Error - unlock the PLL */
             printf("VCO out of range %" PRIu64 "\n", VCO_out);
--=20
2.9.3
