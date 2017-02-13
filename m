Received: from eggs.gnu.org ([2001:4830:134:3::10]:38667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHt1-0007PU-9o
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHsx-00025l-65
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:51 -0500
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:38129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdHsw-00025D-OH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:45:47 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1242A47EDE
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 15:45:45 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 15:44:22 +0100
Message-Id: <1486997062-23227-3-git-send-email-clg@kaod.org>
In-Reply-To: <1486997062-23227-1-git-send-email-clg@kaod.org>
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Some of SMC controllers on the Aspeed SoCs support DMA to access the
flash modules. It can operate in a normal mode, to copy to or from the
flash module mapping window, or in a checksum calculation mode, to
evaluate the best clock settings for reads.

When DMA is enabled, a DMA request is built and passed on to a bottom
half to handle the memory transaction. The CPU is notified of the
completion with an IRQ if it was enabled.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 225 insertions(+), 7 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f6ecdc014436..d73ab1537559 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -26,8 +26,10 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/coroutine.h"
 #include "include/qemu/error-report.h"
 #include "exec/address-spaces.h"
+#include "sysemu/dma.h"
=20
 #include "hw/ssi/aspeed_smc.h"
=20
@@ -106,10 +108,10 @@
 #define   DMA_CTRL_DELAY_SHIFT  8
 #define   DMA_CTRL_FREQ_MASK    0xf
 #define   DMA_CTRL_FREQ_SHIFT   4
-#define   DMA_CTRL_MODE         (1 << 3)
+#define   DMA_CTRL_CALIB        (1 << 3)
 #define   DMA_CTRL_CKSUM        (1 << 2)
-#define   DMA_CTRL_DIR          (1 << 1)
-#define   DMA_CTRL_EN           (1 << 0)
+#define   DMA_CTRL_WRITE        (1 << 1)
+#define   DMA_CTRL_ENABLE       (1 << 0)
=20
 /* DMA Flash Side Address */
 #define R_DMA_FLASH_ADDR  (0x84 / 4)
@@ -141,6 +143,14 @@
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
 #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
=20
+/*
+ * DMA address and size encoding
+ */
+#define DMA_LENGTH(x)           (((x) & ~0xFE000003))
+#define DMA_DRAM_ADDR(base, x)  (((x) & ~0xE0000003) | base)
+#define DMA_FLASH_ADDR(x)       (((x) & ~0xE0000003) | \
+                                 ASPEED_SOC_FMC_FLASH_BASE)
+
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
=20
@@ -618,9 +628,6 @@ static void aspeed_smc_reset(DeviceState *d)
=20
     memset(s->regs, 0, sizeof s->regs);
=20
-    /* Pretend DMA is done (u-boot initialization) */
-    s->regs[R_INTR_CTRL] =3D INTR_CTRL_DMA_STATUS;
-
     /* Unselect all slaves */
     for (i =3D 0; i < s->num_cs; ++i) {
         s->regs[s->r_ctrl0 + i] |=3D CTRL_CE_STOP_ACTIVE;
@@ -663,6 +670,11 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr=
 addr, unsigned int size)
         addr =3D=3D s->r_timings ||
         addr =3D=3D s->r_ce_ctrl ||
         addr =3D=3D R_INTR_CTRL ||
+        (s->ctrl->has_dma && addr =3D=3D R_DMA_CTRL) ||
+        (s->ctrl->has_dma && addr =3D=3D R_DMA_FLASH_ADDR) ||
+        (s->ctrl->has_dma && addr =3D=3D R_DMA_DRAM_ADDR) ||
+        (s->ctrl->has_dma && addr =3D=3D R_DMA_LEN) ||
+        (s->ctrl->has_dma && addr =3D=3D R_DMA_CHECKSUM) ||
         (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slav=
es) ||
         (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs)) {
         return s->regs[addr];
@@ -673,6 +685,200 @@ static uint64_t aspeed_smc_read(void *opaque, hwadd=
r addr, unsigned int size)
     }
 }
=20
+typedef struct AspeedDmaCo {
+    AspeedSMCState *s;
+    int len;
+    uint32_t flash_addr;
+    uint32_t dram_addr;
+    uint32_t checksum;
+    bool direction;
+} AspeedDmaCo;
+
+static void coroutine_fn aspeed_smc_dma_done(AspeedDmaCo *dmaco)
+{
+    AspeedSMCState *s =3D dmaco->s;
+
+    s->regs[R_INTR_CTRL] |=3D INTR_CTRL_DMA_STATUS;
+    if (s->regs[R_INTR_CTRL] & INTR_CTRL_DMA_EN) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static bool coroutine_fn aspeed_smc_dma_update(AspeedDmaCo *dmaco)
+{
+    AspeedSMCState *s =3D dmaco->s;
+    bool ret;
+
+    if (s->regs[R_DMA_CTRL] & DMA_CTRL_ENABLE) {
+        s->regs[R_DMA_FLASH_ADDR] =3D dmaco->flash_addr;
+        s->regs[R_DMA_DRAM_ADDR] =3D dmaco->dram_addr;
+        s->regs[R_DMA_LEN] =3D dmaco->len - 4;
+        s->regs[R_DMA_CHECKSUM] =3D dmaco->checksum;
+        ret =3D true;
+    } else {
+        ret =3D false;
+    }
+
+    return ret;
+}
+
+/*
+ * Accumulate the result of the reads in a register. It will be used
+ * later to do timing calibration.
+ */
+static void coroutine_fn aspeed_smc_dma_checksum(void* opaque)
+{
+    AspeedDmaCo *dmaco =3D opaque;
+    uint32_t data;
+
+    while (dmaco->len) {
+        /* check for disablement and update register values */
+        if (!aspeed_smc_dma_update(dmaco)) {
+            goto out;
+        }
+
+        cpu_physical_memory_read(dmaco->flash_addr, &data, 4);
+        dmaco->checksum +=3D data;
+        dmaco->flash_addr +=3D 4;
+        dmaco->len -=3D 4;
+    }
+
+    aspeed_smc_dma_done(dmaco);
+out:
+    g_free(dmaco);
+}
+
+static void coroutine_fn aspeed_smc_dma_rw(void* opaque)
+{
+    AspeedDmaCo *dmaco =3D opaque;
+    uint32_t data;
+
+    while (dmaco->len) {
+        /* check for disablement and update register values */
+        if (!aspeed_smc_dma_update(dmaco)) {
+            goto out;
+        }
+
+        if (dmaco->direction) {
+            dma_memory_read(&address_space_memory, dmaco->dram_addr, &da=
ta, 4);
+            cpu_physical_memory_write(dmaco->flash_addr, &data, 4);
+        } else {
+            cpu_physical_memory_read(dmaco->flash_addr, &data, 4);
+            dma_memory_write(&address_space_memory, dmaco->dram_addr,
+                             &data, 4);
+        }
+
+        dmaco->flash_addr +=3D 4;
+        dmaco->dram_addr +=3D 4;
+        dmaco->len -=3D 4;
+    }
+
+    aspeed_smc_dma_done(dmaco);
+out:
+    g_free(dmaco);
+}
+
+
+static void aspeed_smc_dma_stop(AspeedSMCState *s)
+{
+    /*
+     * When the DMA is disabled, INTR_CTRL_DMA_STATUS=3D0 means the
+     * engine is idle
+     */
+    s->regs[R_INTR_CTRL] &=3D ~INTR_CTRL_DMA_STATUS;
+    s->regs[R_DMA_CHECKSUM] =3D 0x0;
+    s->regs[R_DMA_FLASH_ADDR] =3D 0;
+    s->regs[R_DMA_DRAM_ADDR] =3D 0;
+    s->regs[R_DMA_LEN] =3D 0;
+
+    /*
+     * Lower DMA irq even in any case. The IRQ control register could
+     * have been cleared before disabling the DMA.
+     */
+    qemu_irq_lower(s->irq);
+}
+
+typedef struct AspeedDmaRequest {
+    Coroutine *co;
+    QEMUBH *bh;
+} AspeedDmaRequest;
+
+static void aspeed_smc_dma_run(void *opaque)
+{
+    AspeedDmaRequest *dmareq =3D opaque;
+
+    qemu_coroutine_enter(dmareq->co);
+    qemu_bh_delete(dmareq->bh);
+    g_free(dmareq);
+}
+
+static void aspeed_smc_dma_schedule(Coroutine *co)
+{
+    AspeedDmaRequest *dmareq;
+
+    dmareq =3D g_new0(AspeedDmaRequest, 1);
+
+    dmareq->co =3D co;
+    dmareq->bh =3D qemu_bh_new(aspeed_smc_dma_run, dmareq);
+    qemu_bh_schedule(dmareq->bh);
+}
+
+static void aspeed_smc_dma_start(void *opaque)
+{
+    AspeedSMCState *s =3D opaque;
+    AspeedDmaCo *dmaco;
+    Coroutine *co;
+
+    /* freed in the coroutine */
+    dmaco =3D g_new0(AspeedDmaCo, 1);
+
+    /* A DMA transaction has a minimum of 4 bytes */
+    dmaco->len        =3D s->regs[R_DMA_LEN] + 4;
+    dmaco->flash_addr =3D s->regs[R_DMA_FLASH_ADDR];
+    dmaco->dram_addr  =3D s->regs[R_DMA_DRAM_ADDR];
+    dmaco->direction  =3D (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE);
+    dmaco->s          =3D s;
+
+    if (s->regs[R_DMA_CTRL] & DMA_CTRL_CKSUM) {
+        co =3D qemu_coroutine_create(aspeed_smc_dma_checksum, dmaco);
+    } else {
+        co =3D qemu_coroutine_create(aspeed_smc_dma_rw, dmaco);
+    }
+
+    aspeed_smc_dma_schedule(co);
+}
+
+/*
+ * This is to run one DMA at a time. When INTR_CTRL_DMA_STATUS becomes
+ * 1, the DMA has completed and a new DMA can start even if the result
+ * of the previous was not collected.
+ */
+static bool aspeed_smc_dma_in_progress(AspeedSMCState *s)
+{
+    bool ret =3D (s->regs[R_DMA_CTRL] & DMA_CTRL_ENABLE) &&
+        !(s->regs[R_INTR_CTRL] & INTR_CTRL_DMA_STATUS);
+    return ret;
+}
+
+static void aspeed_smc_dma_ctrl(AspeedSMCState *s, uint64_t dma_ctrl)
+{
+    if (dma_ctrl & DMA_CTRL_ENABLE) {
+        if (aspeed_smc_dma_in_progress(s)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA in progress\n",
+                          __func__);
+            return;
+        }
+
+        s->regs[R_DMA_CTRL] =3D dma_ctrl;
+
+        aspeed_smc_dma_start(s);
+    } else {
+        s->regs[R_DMA_CTRL] =3D dma_ctrl;
+
+        aspeed_smc_dma_stop(s);
+    }
+}
+
 static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
                              unsigned int size)
 {
@@ -696,6 +902,16 @@ static void aspeed_smc_write(void *opaque, hwaddr ad=
dr, uint64_t data,
         if (value !=3D s->regs[R_SEG_ADDR0 + cs]) {
             aspeed_smc_flash_set_segment(s, cs, value);
         }
+    } else if (addr =3D=3D R_INTR_CTRL) {
+        s->regs[addr] =3D value;
+    } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_CTRL) {
+        aspeed_smc_dma_ctrl(s, value);
+    } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_DRAM_ADDR) {
+        s->regs[addr] =3D DMA_DRAM_ADDR(s->sdram_base, value);
+    } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_FLASH_ADDR) {
+        s->regs[addr] =3D DMA_FLASH_ADDR(value);
+    } else if (s->ctrl->has_dma && addr =3D=3D R_DMA_LEN) {
+        s->regs[addr] =3D DMA_LENGTH(value);
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx =
"\n",
                       __func__, addr);
@@ -728,6 +944,9 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)
     s->r_timings =3D s->ctrl->r_timings;
     s->conf_enable_w0 =3D s->ctrl->conf_enable_w0;
=20
+    /* DMA irq */
+    sysbus_init_irq(sbd, &s->irq);
+
     /* Enforce some real HW limits */
     if (s->num_cs > s->ctrl->max_slaves) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: num_cs cannot exceed: %d\n",
@@ -738,7 +957,6 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)
     s->spi =3D ssi_create_bus(dev, "spi");
=20
     /* Setup cs_lines for slaves */
-    sysbus_init_irq(sbd, &s->irq);
     s->cs_lines =3D g_new0(qemu_irq, s->num_cs);
     ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
=20
--=20
2.7.4
