Received: from eggs.gnu.org ([2001:4830:134:3::10]:56479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70M-0001Pt-4t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-000431-31
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:56 +1000
Message-Id: <20170927074316.4454-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/26] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

These registers are present in 440 SoCs (and maybe in others too) and
U-Boot accesses them when printing register info. We don't emulate
these but add them to avoid crashing when they are read or written.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index e621d0aec5..8e58065f5f 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
 /*****************************************************************************/
 /* Peripheral local bus arbitrer */
 enum {
-    PLB0_BESR = 0x084,
-    PLB0_BEAR = 0x086,
-    PLB0_ACR  = 0x087,
+    PLB3A0_ACR = 0x077,
+    PLB4A0_ACR = 0x081,
+    PLB0_BESR  = 0x084,
+    PLB0_BEAR  = 0x086,
+    PLB0_ACR   = 0x087,
+    PLB4A1_ACR = 0x089,
 };
 
 typedef struct ppc4xx_plb_t ppc4xx_plb_t;
@@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
     ppc4xx_plb_t *plb;
 
     plb = g_malloc0(sizeof(ppc4xx_plb_t));
+    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
+    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_plb);
+    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     qemu_register_reset(ppc4xx_plb_reset, plb);
 }
 
-- 
2.13.5
