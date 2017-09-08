Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeE-0002GX-L9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-0003LW-WD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:40 +1000
Message-Id: <20170908103558.31632-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/40] ppc4xx: Move MAL from ppc405_uc to
 ppc4xx_devs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

This device appears in other SoCs as well not just in 405 ones

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c      | 263 -----------------------------------------------
 hw/ppc/ppc4xx_devs.c    | 264 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/ppc4xx.h |   2 +
 3 files changed, 266 insertions(+), 263 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index f6fe3e6f5e..3c744021d6 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -42,7 +42,6 @@
 //#define DEBUG_OCM
 //#define DEBUG_I2C
 //#define DEBUG_GPT
-//#define DEBUG_MAL
 //#define DEBUG_CLOCKS
 //#define DEBUG_CLOCKS_LL
 
@@ -1513,268 +1512,6 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq irqs[5])
 }
 
 /*****************************************************************************/
-/* MAL */
-enum {
-    MAL0_CFG      = 0x180,
-    MAL0_ESR      = 0x181,
-    MAL0_IER      = 0x182,
-    MAL0_TXCASR   = 0x184,
-    MAL0_TXCARR   = 0x185,
-    MAL0_TXEOBISR = 0x186,
-    MAL0_TXDEIR   = 0x187,
-    MAL0_RXCASR   = 0x190,
-    MAL0_RXCARR   = 0x191,
-    MAL0_RXEOBISR = 0x192,
-    MAL0_RXDEIR   = 0x193,
-    MAL0_TXCTP0R  = 0x1A0,
-    MAL0_TXCTP1R  = 0x1A1,
-    MAL0_TXCTP2R  = 0x1A2,
-    MAL0_TXCTP3R  = 0x1A3,
-    MAL0_RXCTP0R  = 0x1C0,
-    MAL0_RXCTP1R  = 0x1C1,
-    MAL0_RCBS0    = 0x1E0,
-    MAL0_RCBS1    = 0x1E1,
-};
-
-typedef struct ppc40x_mal_t ppc40x_mal_t;
-struct ppc40x_mal_t {
-    qemu_irq irqs[4];
-    uint32_t cfg;
-    uint32_t esr;
-    uint32_t ier;
-    uint32_t txcasr;
-    uint32_t txcarr;
-    uint32_t txeobisr;
-    uint32_t txdeir;
-    uint32_t rxcasr;
-    uint32_t rxcarr;
-    uint32_t rxeobisr;
-    uint32_t rxdeir;
-    uint32_t txctpr[4];
-    uint32_t rxctpr[2];
-    uint32_t rcbs[2];
-};
-
-static void ppc40x_mal_reset (void *opaque);
-
-static uint32_t dcr_read_mal (void *opaque, int dcrn)
-{
-    ppc40x_mal_t *mal;
-    uint32_t ret;
-
-    mal = opaque;
-    switch (dcrn) {
-    case MAL0_CFG:
-        ret = mal->cfg;
-        break;
-    case MAL0_ESR:
-        ret = mal->esr;
-        break;
-    case MAL0_IER:
-        ret = mal->ier;
-        break;
-    case MAL0_TXCASR:
-        ret = mal->txcasr;
-        break;
-    case MAL0_TXCARR:
-        ret = mal->txcarr;
-        break;
-    case MAL0_TXEOBISR:
-        ret = mal->txeobisr;
-        break;
-    case MAL0_TXDEIR:
-        ret = mal->txdeir;
-        break;
-    case MAL0_RXCASR:
-        ret = mal->rxcasr;
-        break;
-    case MAL0_RXCARR:
-        ret = mal->rxcarr;
-        break;
-    case MAL0_RXEOBISR:
-        ret = mal->rxeobisr;
-        break;
-    case MAL0_RXDEIR:
-        ret = mal->rxdeir;
-        break;
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
-    default:
-        ret = 0;
-        break;
-    }
-
-    return ret;
-}
-
-static void dcr_write_mal (void *opaque, int dcrn, uint32_t val)
-{
-    ppc40x_mal_t *mal;
-    int idx;
-
-    mal = opaque;
-    switch (dcrn) {
-    case MAL0_CFG:
-        if (val & 0x80000000)
-            ppc40x_mal_reset(mal);
-        mal->cfg = val & 0x00FFC087;
-        break;
-    case MAL0_ESR:
-        /* Read/clear */
-        mal->esr &= ~val;
-        break;
-    case MAL0_IER:
-        mal->ier = val & 0x0000001F;
-        break;
-    case MAL0_TXCASR:
-        mal->txcasr = val & 0xF0000000;
-        break;
-    case MAL0_TXCARR:
-        mal->txcarr = val & 0xF0000000;
-        break;
-    case MAL0_TXEOBISR:
-        /* Read/clear */
-        mal->txeobisr &= ~val;
-        break;
-    case MAL0_TXDEIR:
-        /* Read/clear */
-        mal->txdeir &= ~val;
-        break;
-    case MAL0_RXCASR:
-        mal->rxcasr = val & 0xC0000000;
-        break;
-    case MAL0_RXCARR:
-        mal->rxcarr = val & 0xC0000000;
-        break;
-    case MAL0_RXEOBISR:
-        /* Read/clear */
-        mal->rxeobisr &= ~val;
-        break;
-    case MAL0_RXDEIR:
-        /* Read/clear */
-        mal->rxdeir &= ~val;
-        break;
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
-    }
-}
-
-static void ppc40x_mal_reset (void *opaque)
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
-static void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
-{
-    ppc40x_mal_t *mal;
-    int i;
-
-    mal = g_malloc0(sizeof(ppc40x_mal_t));
-    for (i = 0; i < 4; i++)
-        mal->irqs[i] = irqs[i];
-    qemu_register_reset(&ppc40x_mal_reset, mal);
-    ppc_dcr_register(env, MAL0_CFG,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_ESR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_IER,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCASR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXCARR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXEOBISR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_TXDEIR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXCASR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXCARR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXEOBISR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
-    ppc_dcr_register(env, MAL0_RXDEIR,
-                     mal, &dcr_read_mal, &dcr_write_mal);
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
-}
-
-/*****************************************************************************/
 /* SPR */
 void ppc40x_core_reset(PowerPCCPU *cpu)
 {
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 6b38ed7bc7..b296ea66c2 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -734,3 +734,267 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
 
     return ram_size;
 }
+
+/*****************************************************************************/
+/* MAL */
+enum {
+    MAL0_CFG      = 0x180,
+    MAL0_ESR      = 0x181,
+    MAL0_IER      = 0x182,
+    MAL0_TXCASR   = 0x184,
+    MAL0_TXCARR   = 0x185,
+    MAL0_TXEOBISR = 0x186,
+    MAL0_TXDEIR   = 0x187,
+    MAL0_RXCASR   = 0x190,
+    MAL0_RXCARR   = 0x191,
+    MAL0_RXEOBISR = 0x192,
+    MAL0_RXDEIR   = 0x193,
+    MAL0_TXCTP0R  = 0x1A0,
+    MAL0_TXCTP1R  = 0x1A1,
+    MAL0_TXCTP2R  = 0x1A2,
+    MAL0_TXCTP3R  = 0x1A3,
+    MAL0_RXCTP0R  = 0x1C0,
+    MAL0_RXCTP1R  = 0x1C1,
+    MAL0_RCBS0    = 0x1E0,
+    MAL0_RCBS1    = 0x1E1,
+};
+
+typedef struct ppc40x_mal_t ppc40x_mal_t;
+struct ppc40x_mal_t {
+    qemu_irq irqs[4];
+    uint32_t cfg;
+    uint32_t esr;
+    uint32_t ier;
+    uint32_t txcasr;
+    uint32_t txcarr;
+    uint32_t txeobisr;
+    uint32_t txdeir;
+    uint32_t rxcasr;
+    uint32_t rxcarr;
+    uint32_t rxeobisr;
+    uint32_t rxdeir;
+    uint32_t txctpr[4];
+    uint32_t rxctpr[2];
+    uint32_t rcbs[2];
+};
+
+static void ppc40x_mal_reset(void *opaque);
+
+static uint32_t dcr_read_mal(void *opaque, int dcrn)
+{
+    ppc40x_mal_t *mal;
+    uint32_t ret;
+
+    mal = opaque;
+    switch (dcrn) {
+    case MAL0_CFG:
+        ret = mal->cfg;
+        break;
+    case MAL0_ESR:
+        ret = mal->esr;
+        break;
+    case MAL0_IER:
+        ret = mal->ier;
+        break;
+    case MAL0_TXCASR:
+        ret = mal->txcasr;
+        break;
+    case MAL0_TXCARR:
+        ret = mal->txcarr;
+        break;
+    case MAL0_TXEOBISR:
+        ret = mal->txeobisr;
+        break;
+    case MAL0_TXDEIR:
+        ret = mal->txdeir;
+        break;
+    case MAL0_RXCASR:
+        ret = mal->rxcasr;
+        break;
+    case MAL0_RXCARR:
+        ret = mal->rxcarr;
+        break;
+    case MAL0_RXEOBISR:
+        ret = mal->rxeobisr;
+        break;
+    case MAL0_RXDEIR:
+        ret = mal->rxdeir;
+        break;
+    case MAL0_TXCTP0R:
+        ret = mal->txctpr[0];
+        break;
+    case MAL0_TXCTP1R:
+        ret = mal->txctpr[1];
+        break;
+    case MAL0_TXCTP2R:
+        ret = mal->txctpr[2];
+        break;
+    case MAL0_TXCTP3R:
+        ret = mal->txctpr[3];
+        break;
+    case MAL0_RXCTP0R:
+        ret = mal->rxctpr[0];
+        break;
+    case MAL0_RXCTP1R:
+        ret = mal->rxctpr[1];
+        break;
+    case MAL0_RCBS0:
+        ret = mal->rcbs[0];
+        break;
+    case MAL0_RCBS1:
+        ret = mal->rcbs[1];
+        break;
+    default:
+        ret = 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void dcr_write_mal(void *opaque, int dcrn, uint32_t val)
+{
+    ppc40x_mal_t *mal;
+    int idx;
+
+    mal = opaque;
+    switch (dcrn) {
+    case MAL0_CFG:
+        if (val & 0x80000000) {
+            ppc40x_mal_reset(mal);
+        }
+        mal->cfg = val & 0x00FFC087;
+        break;
+    case MAL0_ESR:
+        /* Read/clear */
+        mal->esr &= ~val;
+        break;
+    case MAL0_IER:
+        mal->ier = val & 0x0000001F;
+        break;
+    case MAL0_TXCASR:
+        mal->txcasr = val & 0xF0000000;
+        break;
+    case MAL0_TXCARR:
+        mal->txcarr = val & 0xF0000000;
+        break;
+    case MAL0_TXEOBISR:
+        /* Read/clear */
+        mal->txeobisr &= ~val;
+        break;
+    case MAL0_TXDEIR:
+        /* Read/clear */
+        mal->txdeir &= ~val;
+        break;
+    case MAL0_RXCASR:
+        mal->rxcasr = val & 0xC0000000;
+        break;
+    case MAL0_RXCARR:
+        mal->rxcarr = val & 0xC0000000;
+        break;
+    case MAL0_RXEOBISR:
+        /* Read/clear */
+        mal->rxeobisr &= ~val;
+        break;
+    case MAL0_RXDEIR:
+        /* Read/clear */
+        mal->rxdeir &= ~val;
+        break;
+    case MAL0_TXCTP0R:
+        idx = 0;
+        goto update_tx_ptr;
+    case MAL0_TXCTP1R:
+        idx = 1;
+        goto update_tx_ptr;
+    case MAL0_TXCTP2R:
+        idx = 2;
+        goto update_tx_ptr;
+    case MAL0_TXCTP3R:
+        idx = 3;
+    update_tx_ptr:
+        mal->txctpr[idx] = val;
+        break;
+    case MAL0_RXCTP0R:
+        idx = 0;
+        goto update_rx_ptr;
+    case MAL0_RXCTP1R:
+        idx = 1;
+    update_rx_ptr:
+        mal->rxctpr[idx] = val;
+        break;
+    case MAL0_RCBS0:
+        idx = 0;
+        goto update_rx_size;
+    case MAL0_RCBS1:
+        idx = 1;
+    update_rx_size:
+        mal->rcbs[idx] = val & 0x000000FF;
+        break;
+    }
+}
+
+static void ppc40x_mal_reset(void *opaque)
+{
+    ppc40x_mal_t *mal;
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
+
+void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4])
+{
+    ppc40x_mal_t *mal;
+    int i;
+
+    mal = g_malloc0(sizeof(ppc40x_mal_t));
+    for (i = 0; i < 4; i++) {
+        mal->irqs[i] = irqs[i];
+    }
+    qemu_register_reset(&ppc40x_mal_reset, mal);
+    ppc_dcr_register(env, MAL0_CFG,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_ESR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_IER,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCASR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCARR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXEOBISR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXDEIR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXCASR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXCARR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXEOBISR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXDEIR,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCTP0R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCTP1R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCTP2R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_TXCTP3R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXCTP0R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RXCTP1R,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RCBS0,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+    ppc_dcr_register(env, MAL0_RCBS1,
+                     mal, &dcr_read_mal, &dcr_write_mal);
+}
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 66e57a5194..db50cfac02 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -53,6 +53,8 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         hwaddr *ram_sizes,
                         int do_init);
 
+void ppc405_mal_init(CPUPPCState *env, qemu_irq irqs[4]);
+
 #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
 
 #endif /* PPC4XX_H */
-- 
2.13.5
