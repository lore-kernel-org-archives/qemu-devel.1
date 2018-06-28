Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2p-0005R2-2V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2n-0005h2-GR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:43 -0400
Message-Id: <beba73ec147c790500c6a57e405d5c5f83899af1.1530225513.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530225513.git.balaton@eik.bme.hu>
References: <cover.1530225513.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 29 Jun 2018 00:38:33 +0200
Subject: [Qemu-devel] [PATCH v6 4/5] ppc440_uc: Basic emulation of PPC440
 DMA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>

PPC440 SoCs such as the AMCC 460EX have a DMA controller which is used
by AmigaOS on the sam460ex. Implement the parts used by AmigaOS so it
can get further booting on the sam460ex machine.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v6:
- CamelCase type names
- Check return value of cpu_physical_memory_map

 hw/ppc/ppc440.h    |   1 +
 hw/ppc/ppc440_uc.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/sam460ex.c  |   3 +
 3 files changed, 225 insertions(+)

diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index ad27db1..7cef936 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -21,6 +21,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks,
                        hwaddr *ram_bases, hwaddr *ram_sizes,
                        int do_init);
 void ppc4xx_ahb_init(CPUPPCState *env);
+void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
 void ppc460ex_pcie_init(CPUPPCState *env);
 
 #endif /* PPC440_H */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 123f4ac..97808ce 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -13,6 +13,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "exec/address-spaces.h"
@@ -803,6 +804,226 @@ void ppc4xx_ahb_init(CPUPPCState *env)
 }
 
 /*****************************************************************************/
+/* DMA controller */
+
+#define DMA0_CR_CE  (1 << 31)
+#define DMA0_CR_PW  (1 << 26 | 1 << 25)
+#define DMA0_CR_DAI (1 << 24)
+#define DMA0_CR_SAI (1 << 23)
+#define DMA0_CR_DEC (1 << 2)
+
+enum {
+    DMA0_CR  = 0x00,
+    DMA0_CT,
+    DMA0_SAH,
+    DMA0_SAL,
+    DMA0_DAH,
+    DMA0_DAL,
+    DMA0_SGH,
+    DMA0_SGL,
+
+    DMA0_SR  = 0x20,
+    DMA0_SGC = 0x23,
+    DMA0_SLP = 0x25,
+    DMA0_POL = 0x26,
+};
+
+typedef struct {
+    uint32_t cr;
+    uint32_t ct;
+    uint64_t sa;
+    uint64_t da;
+    uint64_t sg;
+} PPC4xxDmaChnl;
+
+typedef struct {
+    int base;
+    PPC4xxDmaChnl ch[4];
+    uint32_t sr;
+} PPC4xxDmaState;
+
+static uint32_t dcr_read_dma(void *opaque, int dcrn)
+{
+    PPC4xxDmaState *dma = opaque;
+    uint32_t val = 0;
+    int addr = dcrn - dma->base;
+    int chnl = addr / 8;
+
+    switch (addr) {
+    case 0x00 ... 0x1f:
+        switch (addr % 8) {
+        case DMA0_CR:
+            val = dma->ch[chnl].cr;
+            break;
+        case DMA0_CT:
+            val = dma->ch[chnl].ct;
+            break;
+        case DMA0_SAH:
+            val = dma->ch[chnl].sa >> 32;
+            break;
+        case DMA0_SAL:
+            val = dma->ch[chnl].sa;
+            break;
+        case DMA0_DAH:
+            val = dma->ch[chnl].da >> 32;
+            break;
+        case DMA0_DAL:
+            val = dma->ch[chnl].da;
+            break;
+        case DMA0_SGH:
+            val = dma->ch[chnl].sg >> 32;
+            break;
+        case DMA0_SGL:
+            val = dma->ch[chnl].sg;
+            break;
+        }
+        break;
+    case DMA0_SR:
+        val = dma->sr;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d, %x)\n",
+                      __func__, dcrn, chnl, addr);
+    }
+
+    return val;
+}
+
+static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
+{
+    PPC4xxDmaState *dma = opaque;
+    int addr = dcrn - dma->base;
+    int chnl = addr / 8;
+
+    switch (addr) {
+    case 0x00 ... 0x1f:
+        switch (addr % 8) {
+        case DMA0_CR:
+            dma->ch[chnl].cr = val;
+            if (val & DMA0_CR_CE) {
+                int count = dma->ch[chnl].ct & 0xffff;
+
+                if (count) {
+                    int width, i, sidx, didx;
+                    uint8_t *rptr, *wptr;
+                    hwaddr rlen, wlen;
+
+                    width = 1 << ((val & DMA0_CR_PW) >> 25);
+                    rptr = cpu_physical_memory_map(dma->ch[chnl].sa, &rlen, 0);
+                    wptr = cpu_physical_memory_map(dma->ch[chnl].da, &wlen, 1);
+                    if (rptr && wptr) {
+                        if (!(val & DMA0_CR_DEC) &&
+                            val & DMA0_CR_SAI && val & DMA0_CR_DAI) {
+                            /* optimise common case */
+                            memmove(wptr, rptr, count * width);
+                            sidx = didx = count * width;
+                        } else {
+                            /* do it the slow way */
+                            for (sidx = didx = i = 0; i < count; i++) {
+                                uint64_t v = ldn_le_p(rptr + sidx, width);
+                                stn_le_p(wptr + didx, width, v);
+                                if (val & DMA0_CR_SAI) {
+                                    sidx += width;
+                                }
+                                if (val & DMA0_CR_DAI) {
+                                    didx += width;
+                                }
+                            }
+                        }
+                    }
+                    if (wptr) {
+                        cpu_physical_memory_unmap(wptr, wlen, 1, didx);
+                    }
+                    if (wptr) {
+                        cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
+                    }
+                }
+            }
+            break;
+        case DMA0_CT:
+            dma->ch[chnl].ct = val;
+            break;
+        case DMA0_SAH:
+            dma->ch[chnl].sa &= 0xffffffffULL;
+            dma->ch[chnl].sa |= (uint64_t)val << 32;
+            break;
+        case DMA0_SAL:
+            dma->ch[chnl].sa &= 0xffffffff00000000ULL;
+            dma->ch[chnl].sa |= val;
+            break;
+        case DMA0_DAH:
+            dma->ch[chnl].da &= 0xffffffffULL;
+            dma->ch[chnl].da |= (uint64_t)val << 32;
+            break;
+        case DMA0_DAL:
+            dma->ch[chnl].da &= 0xffffffff00000000ULL;
+            dma->ch[chnl].da |= val;
+            break;
+        case DMA0_SGH:
+            dma->ch[chnl].sg &= 0xffffffffULL;
+            dma->ch[chnl].sg |= (uint64_t)val << 32;
+            break;
+        case DMA0_SGL:
+            dma->ch[chnl].sg &= 0xffffffff00000000ULL;
+            dma->ch[chnl].sg |= val;
+            break;
+        }
+        break;
+    case DMA0_SR:
+        dma->sr &= ~val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d, %x)\n",
+                      __func__, dcrn, chnl, addr);
+    }
+}
+
+static void ppc4xx_dma_reset(void *opaque)
+{
+    PPC4xxDmaState *dma = opaque;
+    int dma_base = dma->base;
+
+    memset(dma, 0, sizeof(*dma));
+    dma->base = dma_base;
+}
+
+void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
+{
+    PPC4xxDmaState *dma;
+    int i;
+
+    dma = g_malloc0(sizeof(*dma));
+    dma->base = dcr_base;
+    qemu_register_reset(&ppc4xx_dma_reset, dma);
+    for (i = 0; i < 4; i++) {
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CR,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CT,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAH,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAL,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAH,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAL,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGH,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGL,
+                         dma, &dcr_read_dma, &dcr_write_dma);
+    }
+    ppc_dcr_register(env, dcr_base + DMA0_SR,
+                     dma, &dcr_read_dma, &dcr_write_dma);
+    ppc_dcr_register(env, dcr_base + DMA0_SGC,
+                     dma, &dcr_read_dma, &dcr_write_dma);
+    ppc_dcr_register(env, dcr_base + DMA0_SLP,
+                     dma, &dcr_read_dma, &dcr_write_dma);
+    ppc_dcr_register(env, dcr_base + DMA0_POL,
+                     dma, &dcr_read_dma, &dcr_write_dma);
+}
+
+/*****************************************************************************/
 /* PCI Express controller */
 /* FIXME: This is not complete and does not work, only implemented partially
  * to allow firmware and guests to find an empty bus. Cards should use PCI.
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index dc730cc..4f9248e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -477,6 +477,9 @@ static void sam460ex_init(MachineState *machine)
     /* MAL */
     ppc4xx_mal_init(env, 4, 16, &uic[2][3]);
 
+    /* DMA */
+    ppc4xx_dma_init(env, 0x200);
+
     /* 256K of L2 cache as memory */
     ppc4xx_l2sram_init(env);
     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
-- 
2.7.6
