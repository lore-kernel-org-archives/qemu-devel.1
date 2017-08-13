Received: from eggs.gnu.org ([2001:4830:134:3::10]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh273-0007RW-VR
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh270-0005wM-NB
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:05 -0400
Message-Id: <4282985e208e7c623dcb32e737cd43ab4c2a2716.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 02/12] ppc4xx: Make MAL emulation more
 generic
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

Allow MAL with more RX and TX channels as found in newer versions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc405_uc.c      |   2 +-
 hw/ppc/ppc4xx_devs.c    | 171 +++++++++++++++++++-----------------------------
 include/hw/ppc/ppc4xx.h |   3 +-
 3 files changed, 70 insertions(+), 106 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 3c74402..03856d5 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -2281,7 +2281,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     mal_irqs[1] = pic[12];
     mal_irqs[2] = pic[13];
     mal_irqs[3] = pic[14];
-    ppc405_mal_init(env, mal_irqs);
+    ppc4xx_mal_init(env, 4, 2, mal_irqs);
     /* Ethernet */
     /* Uses pic[9], pic[15], pic[17] */
     /* CPU control */
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 8e4f78e..6e1cc09 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -737,6 +737,7 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
 
 /*****************************************************************************/
 /* MAL */
+
 enum {
     MAL0_CFG      = 0x180,
     MAL0_ESR      = 0x181,
@@ -750,17 +751,13 @@ enum {
     MAL0_RXEOBISR = 0x192,
     MAL0_RXDEIR   = 0x193,
     MAL0_TXCTP0R  = 0x1A0,
-    MAL0_TXCTP1R  = 0x1A1,
-    MAL0_TXCTP2R  = 0x1A2,
-    MAL0_TXCTP3R  = 0x1A3,
     MAL0_RXCTP0R  = 0x1C0,
-    MAL0_RXCTP1R  = 0x1C1,
     MAL0_RCBS0    = 0x1E0,
     MAL0_RCBS1    = 0x1E1,
 };
 
-typedef struct ppc40x_mal_t ppc40x_mal_t;
-struct ppc40x_mal_t {
+typedef struct ppc4xx_mal_t ppc4xx_mal_t;
+struct ppc4xx_mal_t {
     qemu_irq irqs[4];
     uint32_t cfg;
     uint32_t esr;
@@ -773,16 +770,32 @@ struct ppc40x_mal_t {
     uint32_t rxcarr;
     uint32_t rxeobisr;
     uint32_t rxdeir;
-    uint32_t txctpr[4];
-    uint32_t rxctpr[2];
-    uint32_t rcbs[2];
+    uint32_t *txctpr;
+    uint32_t *rxctpr;
+    uint32_t *rcbs;
+    uint8_t  txcnum;
+    uint8_t  rxcnum;
 };
 
-static void ppc40x_mal_reset(void *opaque);
+static void ppc4xx_mal_reset(void *opaque)
+{
+    ppc4xx_mal_t *mal;
+
+    mal = opaque;
+    mal->cfg = 0x0007C000;
+    mal->esr = 0x00000000;
+    mal->ier = 0x00000000;
+    mal->rxcasr = 0x00000000;
+    mal->rxdeir = 0x00000000;
+    mal->rxeobisr = 0x00000000;
+    mal->txcasr = 0x00000000;
+    mal->txdeir = 0x00000000;
+    mal->txeobisr = 0x00000000;
+}
 
 static uint32_t dcr_read_mal(void *opaque, int dcrn)
 {
-    ppc40x_mal_t *mal;
+    ppc4xx_mal_t *mal;
     uint32_t ret;
 
     mal = opaque;
@@ -820,48 +833,32 @@ static uint32_t dcr_read_mal(void *opaque, int dcrn)
     case MAL0_RXDEIR:
         ret = mal->rxdeir;
         break;
-    case MAL0_TXCTP0R:
-        ret = mal->txctpr[0];
-        break;
-    case MAL0_TXCTP1R:
-        ret = mal->txctpr[1];
-        break;
-    case MAL0_TXCTP2R:
-        ret = mal->txctpr[2];
-        break;
-    case MAL0_TXCTP3R:
-        ret = mal->txctpr[3];
-        break;
-    case MAL0_RXCTP0R:
-        ret = mal->rxctpr[0];
-        break;
-    case MAL0_RXCTP1R:
-        ret = mal->rxctpr[1];
-        break;
-    case MAL0_RCBS0:
-        ret = mal->rcbs[0];
-        break;
-    case MAL0_RCBS1:
-        ret = mal->rcbs[1];
-        break;
     default:
         ret = 0;
         break;
     }
+    if (dcrn >= MAL0_TXCTP0R && dcrn < MAL0_TXCTP0R + mal->txcnum) {
+        ret = mal->txctpr[dcrn - MAL0_TXCTP0R];
+    }
+    if (dcrn >= MAL0_RXCTP0R && dcrn < MAL0_RXCTP0R + mal->rxcnum) {
+        ret = mal->rxctpr[dcrn - MAL0_RXCTP0R];
+    }
+    if (dcrn >= MAL0_RCBS0 && dcrn < MAL0_RCBS0 + mal->rxcnum) {
+        ret = mal->rcbs[dcrn - MAL0_RCBS0];
+    }
 
     return ret;
 }
 
 static void dcr_write_mal(void *opaque, int dcrn, uint32_t val)
 {
-    ppc40x_mal_t *mal;
-    int idx;
+    ppc4xx_mal_t *mal;
 
     mal = opaque;
     switch (dcrn) {
     case MAL0_CFG:
         if (val & 0x80000000) {
-            ppc40x_mal_reset(mal);
+            ppc4xx_mal_reset(mal);
         }
         mal->cfg = val & 0x00FFC087;
         break;
@@ -900,65 +897,35 @@ static void dcr_write_mal(void *opaque, int dcrn, uint32_t val)
         /* Read/clear */
         mal->rxdeir &= ~val;
         break;
-    case MAL0_TXCTP0R:
-        idx = 0;
-        goto update_tx_ptr;
-    case MAL0_TXCTP1R:
-        idx = 1;
-        goto update_tx_ptr;
-    case MAL0_TXCTP2R:
-        idx = 2;
-        goto update_tx_ptr;
-    case MAL0_TXCTP3R:
-        idx = 3;
-    update_tx_ptr:
-        mal->txctpr[idx] = val;
-        break;
-    case MAL0_RXCTP0R:
-        idx = 0;
-        goto update_rx_ptr;
-    case MAL0_RXCTP1R:
-        idx = 1;
-    update_rx_ptr:
-        mal->rxctpr[idx] = val;
-        break;
-    case MAL0_RCBS0:
-        idx = 0;
-        goto update_rx_size;
-    case MAL0_RCBS1:
-        idx = 1;
-    update_rx_size:
-        mal->rcbs[idx] = val & 0x000000FF;
-        break;
+    }
+    if (dcrn >= MAL0_TXCTP0R && dcrn < MAL0_TXCTP0R + mal->txcnum) {
+        mal->txctpr[dcrn - MAL0_TXCTP0R] = val;
+    }
+    if (dcrn >= MAL0_RXCTP0R && dcrn < MAL0_RXCTP0R + mal->rxcnum) {
+        mal->rxctpr[dcrn - MAL0_RXCTP0R] = val;
+    }
+    if (dcrn >= MAL0_RCBS0 && dcrn < MAL0_RCBS0 + mal->rxcnum) {
+        mal->rcbs[dcrn - MAL0_RCBS0] = val & 0x000000FF;
     }
 }
 
-static void ppc40x_mal_reset(void *opaque)
-{
-    ppc40x_mal_t *mal;
-
-    mal = opaque;
-    mal->cfg = 0x0007C000;
-    mal->esr = 0x00000000;
-    mal->ier = 0x00000000;
-    mal->rxcasr = 0x00000000;
-    mal->rxdeir = 0x00000000;
-    mal->rxeobisr = 0x00000000;
-    mal->txcasr = 0x00000000;
-    mal->txdeir = 0x00000000;
-    mal->txeobisr = 0x00000000;
-}
-
-void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
+void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
+                     qemu_irq irqs[4])
 {
-    ppc40x_mal_t *mal;
+    ppc4xx_mal_t *mal;
     int i;
 
-    mal = g_malloc0(sizeof(ppc40x_mal_t));
+    assert(txcnum <= 32 && rxcnum <= 32);
+    mal = g_malloc0(sizeof(*mal));
+    mal->txcnum = txcnum;
+    mal->rxcnum = rxcnum;
+    mal->txctpr = g_new0(uint32_t, txcnum);
+    mal->rxctpr = g_new0(uint32_t, rxcnum);
+    mal->rcbs = g_new0(uint32_t, rxcnum);
     for (i = 0; i < 4; i++) {
         mal->irqs[i] = irqs[i];
     }
-    qemu_register_reset(&ppc40x_mal_reset, mal);
+    qemu_register_reset(&ppc4xx_mal_reset, mal);
     ppc_dcr_register(env, MAL0_CFG,
                      mal, &dcr_read_mal, &dcr_write_mal);
     ppc_dcr_register(env, MAL0_ESR,
@@ -981,20 +948,16 @@ void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
                      mal, &dcr_read_mal, &dcr_write_mal);
     ppc_dcr_register(env, MAL0_RXDEIR,
                      mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCTP0R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCTP1R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCTP2R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCTP3R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXCTP0R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXCTP1R,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RCBS0,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RCBS1,
-                     mal, &dcr_read_mal, &dcr_write_mal);
+    for (i = 0; i < txcnum; i++) {
+        ppc_dcr_register(env, MAL0_TXCTP0R + i,
+                         mal, &dcr_read_mal, &dcr_write_mal);
+    }
+    for (i = 0; i < rxcnum; i++) {
+        ppc_dcr_register(env, MAL0_RXCTP0R + i,
+                         mal, &dcr_read_mal, &dcr_write_mal);
+    }
+    for (i = 0; i < rxcnum; i++) {
+        ppc_dcr_register(env, MAL0_RCBS0 + i,
+                         mal, &dcr_read_mal, &dcr_write_mal);
+    }
 }
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index db50cfa..cb0bb55 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -53,7 +53,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         hwaddr *ram_sizes,
                         int do_init);
 
-void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4]);
+void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
+                     qemu_irq irqs[4]);
 
 #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
 
-- 
2.7.4
