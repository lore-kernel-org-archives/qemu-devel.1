Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPw-00014c-Su
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005Cy-Qh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-00051T-FT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPe-00038A-3U
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:32 +0000
Message-Id: <1484834995-26826-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/36] aspeed/smc: handle SPI flash Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The Aspeed SMC controllers have a mode (Command mode) in which
accesses to the flash content are no different than doing MMIOs. The
controller generates all the necessary commands to load (or store)
data in memory.

However, accesses are restricted to the segment window assigned the
the flash module by the controller. This window is defined by the
Segment Address Register.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-8-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |   2 +-
 hw/ssi/aspeed_smc.c         | 152 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 132 insertions(+), 22 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index e811742..1f55731 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -49,7 +49,7 @@ typedef struct AspeedSMCController {
 } AspeedSMCController;
 
 typedef struct AspeedSMCFlash {
-    const struct AspeedSMCState *controller;
+    struct AspeedSMCState *controller;
 
     uint8_t id;
     uint32_t size;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 8d8a62e..a0a8164 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -69,6 +69,7 @@
 #define R_CTRL0           (0x10 / 4)
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
+#define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
 #define     CTRL_READMODE          0x0
@@ -138,6 +139,9 @@
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
 #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
 
+/* Flash opcodes. */
+#define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
+
 /*
  * Default segments mapping addresses and size for each slave per
  * controller. These can be changed when board is initialized with the
@@ -414,21 +418,123 @@ static inline bool aspeed_smc_is_writable(const AspeedSMCFlash *fl)
     return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl->id));
 }
 
+static inline int aspeed_smc_flash_cmd(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s = fl->controller;
+    int cmd = (s->regs[s->r_ctrl0 + fl->id] >> CTRL_CMD_SHIFT) & CTRL_CMD_MASK;
+
+    /* In read mode, the default SPI command is READ (0x3). In other
+     * modes, the command should necessarily be defined */
+    if (aspeed_smc_flash_mode(fl) == CTRL_READMODE) {
+        cmd = SPI_OP_READ;
+    }
+
+    if (!cmd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no command defined for mode %d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
+    }
+
+    return cmd;
+}
+
+static inline int aspeed_smc_flash_is_4byte(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s = fl->controller;
+
+    if (s->ctrl->segments == aspeed_segments_spi) {
+        return s->regs[s->r_ctrl0] & CTRL_AST2400_SPI_4BYTE;
+    } else {
+        return s->regs[s->r_ce_ctrl] & (1 << (CTRL_EXTENDED0 + fl->id));
+    }
+}
+
+static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s = fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
+}
+
+static void aspeed_smc_flash_select(AspeedSMCFlash *fl)
+{
+    AspeedSMCState *s = fl->controller;
+
+    s->regs[s->r_ctrl0 + fl->id] &= ~CTRL_CE_STOP_ACTIVE;
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+}
+
+static void aspeed_smc_flash_unselect(AspeedSMCFlash *fl)
+{
+    AspeedSMCState *s = fl->controller;
+
+    s->regs[s->r_ctrl0 + fl->id] |= CTRL_CE_STOP_ACTIVE;
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+}
+
+static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
+                                              uint32_t addr)
+{
+    const AspeedSMCState *s = fl->controller;
+    AspeedSegments seg;
+
+    aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
+    if ((addr & (seg.size - 1)) != addr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid address 0x%08x for CS%d segment : "
+                      "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
+                      s->ctrl->name, addr, fl->id, seg.addr,
+                      seg.addr + seg.size);
+    }
+
+    addr &= seg.size - 1;
+    return addr;
+}
+
+static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr)
+{
+    const AspeedSMCState *s = fl->controller;
+    uint8_t cmd = aspeed_smc_flash_cmd(fl);
+
+    /* Flash access can not exceed CS segment */
+    addr = aspeed_smc_check_segment_addr(fl, addr);
+
+    ssi_transfer(s->spi, cmd);
+
+    if (aspeed_smc_flash_is_4byte(fl)) {
+        ssi_transfer(s->spi, (addr >> 24) & 0xff);
+    }
+    ssi_transfer(s->spi, (addr >> 16) & 0xff);
+    ssi_transfer(s->spi, (addr >> 8) & 0xff);
+    ssi_transfer(s->spi, (addr & 0xff));
+}
+
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
 {
     AspeedSMCFlash *fl = opaque;
-    const AspeedSMCState *s = fl->controller;
+    AspeedSMCState *s = fl->controller;
     uint64_t ret = 0;
     int i;
 
-    if (aspeed_smc_is_usermode(fl)) {
+    switch (aspeed_smc_flash_mode(fl)) {
+    case CTRL_USERMODE:
         for (i = 0; i < size; i++) {
             ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
         }
-    } else {
-        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
-                      __func__);
-        ret = -1;
+        break;
+    case CTRL_READMODE:
+    case CTRL_FREADMODE:
+        aspeed_smc_flash_select(fl);
+        aspeed_smc_flash_send_addr(fl, addr);
+
+        for (i = 0; i < size; i++) {
+            ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
+        }
+
+        aspeed_smc_flash_unselect(fl);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
     }
 
     return ret;
@@ -438,7 +544,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
     AspeedSMCFlash *fl = opaque;
-    const AspeedSMCState *s = fl->controller;
+    AspeedSMCState *s = fl->controller;
     int i;
 
     if (!aspeed_smc_is_writable(fl)) {
@@ -447,14 +553,25 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
         return;
     }
 
-    if (!aspeed_smc_is_usermode(fl)) {
-        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
-                      __func__);
-        return;
-    }
+    switch (aspeed_smc_flash_mode(fl)) {
+    case CTRL_USERMODE:
+        for (i = 0; i < size; i++) {
+            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        }
+        break;
+    case CTRL_WRITEMODE:
+        aspeed_smc_flash_select(fl);
+        aspeed_smc_flash_send_addr(fl, addr);
+
+        for (i = 0; i < size; i++) {
+            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        }
 
-    for (i = 0; i < size; i++) {
-        ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        aspeed_smc_flash_unselect(fl);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
     }
 }
 
@@ -468,13 +585,6 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     },
 };
 
-static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl)
-{
-    const AspeedSMCState *s = fl->controller;
-
-    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
-}
-
 static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s = fl->controller;
-- 
2.7.4
