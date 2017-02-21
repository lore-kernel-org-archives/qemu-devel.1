Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cgAZh-000451-OT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cgAZg-0001QC-UC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:33:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cgAZg-0001Pw-JU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:33:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 13:33:41 +0000
Message-Id: <1487684021-22713-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/ppc/ppc405_uc.c: Avoid integer overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

When performing clock calculations, the ppc405_uc code
has several places where it multiplies together two
32-bit variables and assigns the result to a 64-bit
variable. This doesn't quite do what is intended because
C will compute a 32-bit multiply result. Add casts to
ensure we don't truncate the result.

(Spotted by Coverity, CID 1005504, 1005505.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/ppc405_uc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index d6d3fc2..d5df94a 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1881,7 +1881,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
         D1 = (((cpc->pllmr >> 20) - 1) & 0xF) + 1; /* FBDV */
         D2 = 8 - ((cpc->pllmr >> 16) & 0x7); /* FWDVA */
         M = D0 * D1 * D2;
-        VCO_out = cpc->sysclk * M;
+        VCO_out = (uint64_t)cpc->sysclk * M;
         if (VCO_out < 400000000 || VCO_out > 800000000) {
             /* PLL cannot lock */
             cpc->pllmr &= ~0x80000000;
@@ -1892,7 +1892,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
         /* Bypass PLL */
     bypass_pll:
         M = D0;
-        PLL_out = cpc->sysclk * M;
+        PLL_out = (uint64_t)cpc->sysclk * M;
     }
     CPU_clk = PLL_out;
     if (cpc->cr1 & 0x00800000)
@@ -2242,7 +2242,7 @@ static void ppc405ep_compute_clocks (ppc405ep_cpc_t *cpc)
 #ifdef DEBUG_CLOCKS_LL
         printf("FWDA %01" PRIx32 " %d\n", (cpc->pllmr[1] >> 16) & 0x7, D);
 #endif
-        VCO_out = cpc->sysclk * M * D;
+        VCO_out = (uint64_t)cpc->sysclk * M * D;
         if (VCO_out < 500000000UL || VCO_out > 1000000000UL) {
             /* Error - unlock the PLL */
             printf("VCO out of range %" PRIu64 "\n", VCO_out);
-- 
2.7.4
