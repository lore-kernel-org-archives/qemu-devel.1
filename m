Received: from eggs.gnu.org ([2001:4830:134:3::10]:51828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh272-0007Po-47
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh270-0005w3-IR
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:04 -0400
Message-Id: <675e091387248b49c97ff99ef07eb23ed316aefb.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 11/12] ppc4xx: Export ECB and PLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

These devices are found in some other ppc4xx cores too.
Also add some more PLB registers for 460EX.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc405.h    |  3 +++
 hw/ppc/ppc405_uc.c | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index a9ffc87..7ed25cf 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -59,6 +59,9 @@ struct ppc4xx_bd_info_t {
 ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
                                 uint32_t flags);
 
+void ppc4xx_plb_init(CPUPPCState *env);
+void ppc405_ebc_init(CPUPPCState *env);
+
 CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
                         MemoryRegion ram_memories[4],
                         hwaddr ram_bases[4],
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8f44cb4..8e58065 100644
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
@@ -174,14 +177,17 @@ static void ppc4xx_plb_reset (void *opaque)
     plb->besr = 0x00000000;
 }
 
-static void ppc4xx_plb_init(CPUPPCState *env)
+void ppc4xx_plb_init(CPUPPCState *env)
 {
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
 
@@ -585,7 +591,7 @@ static void ebc_reset (void *opaque)
     ebc->cfg = 0x80400000;
 }
 
-static void ppc405_ebc_init(CPUPPCState *env)
+void ppc405_ebc_init(CPUPPCState *env)
 {
     ppc4xx_ebc_t *ebc;
 
-- 
2.7.4
