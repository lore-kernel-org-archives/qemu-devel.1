Received: from eggs.gnu.org ([209.51.188.92]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNe-0003AV-O7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-0000Yd-Mo
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNc-0000NX-De
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id m1so15043046wml.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:42 +0000
Message-Id: <20190128181047.20781-22-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/26] aspeed/smc: snoop SPI transfers to fake
 dummy cycles
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

The m25p80 models dummy cycles using byte transfers. This works well
when the transfers are initiated by the QEMU model of a SPI controller
but when these are initiated by the OS, it breaks emulation.

Snoop the SPI transfer to catch commands requiring dummy cycles and
replace them with byte transfers compatible with the m25p80 model.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20190124140519.13838-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |   3 +
 hw/ssi/aspeed_smc.c         | 115 +++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 1f557313fa9..3b1e7fce6c8 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -98,6 +98,9 @@ typedef struct AspeedSMCState {
     uint8_t conf_enable_w0;
 
     AspeedSMCFlash *flashes;
+
+    uint8_t snoop_index;
+    uint8_t snoop_dummies;
 } AspeedSMCState;
 
 #endif /* ASPEED_SMC_H */
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9f3b6f4b450..f1e66870d71 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -145,6 +145,9 @@
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
 
+#define SNOOP_OFF         0xFF
+#define SNOOP_START       0x0
+
 /*
  * Default segments mapping addresses and size for each slave per
  * controller. These can be changed when board is initialized with the
@@ -566,6 +569,101 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
     return ret;
 }
 
+/*
+ * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
+ * common include header.
+ */
+typedef enum {
+    READ = 0x3,         READ_4 = 0x13,
+    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
+    DOR = 0x3b,         DOR_4 = 0x3c,
+    QOR = 0x6b,         QOR_4 = 0x6c,
+    DIOR = 0xbb,        DIOR_4 = 0xbc,
+    QIOR = 0xeb,        QIOR_4 = 0xec,
+
+    PP = 0x2,           PP_4 = 0x12,
+    DPP = 0xa2,
+    QPP = 0x32,         QPP_4 = 0x34,
+} FlashCMD;
+
+static int aspeed_smc_num_dummies(uint8_t command)
+{
+    switch (command) { /* check for dummies */
+    case READ: /* no dummy bytes/cycles */
+    case PP:
+    case DPP:
+    case QPP:
+    case READ_4:
+    case PP_4:
+    case QPP_4:
+        return 0;
+    case FAST_READ:
+    case DOR:
+    case QOR:
+    case DOR_4:
+    case QOR_4:
+        return 1;
+    case DIOR:
+    case FAST_READ_4:
+    case DIOR_4:
+        return 2;
+    case QIOR:
+    case QIOR_4:
+        return 4;
+    default:
+        return -1;
+    }
+}
+
+static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
+                                unsigned size)
+{
+    AspeedSMCState *s = fl->controller;
+    uint8_t addr_width = aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
+
+    if (s->snoop_index == SNOOP_OFF) {
+        return false; /* Do nothing */
+
+    } else if (s->snoop_index == SNOOP_START) {
+        uint8_t cmd = data & 0xff;
+        int ndummies = aspeed_smc_num_dummies(cmd);
+
+        /*
+         * No dummy cycles are expected with the current command. Turn
+         * off snooping and let the transfer proceed normally.
+         */
+        if (ndummies <= 0) {
+            s->snoop_index = SNOOP_OFF;
+            return false;
+        }
+
+        s->snoop_dummies = ndummies * 8;
+
+    } else if (s->snoop_index >= addr_width + 1) {
+
+        /* The SPI transfer has reached the dummy cycles sequence */
+        for (; s->snoop_dummies; s->snoop_dummies--) {
+            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
+        }
+
+        /* If no more dummy cycles are expected, turn off snooping */
+        if (!s->snoop_dummies) {
+            s->snoop_index = SNOOP_OFF;
+        } else {
+            s->snoop_index += size;
+        }
+
+        /*
+         * Dummy cycles have been faked already. Ignore the current
+         * SPI transfer
+         */
+        return true;
+    }
+
+    s->snoop_index += size;
+    return false;
+}
+
 static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
                                    unsigned size)
 {
@@ -581,6 +679,10 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
 
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
+        if (aspeed_smc_do_snoop(fl, data, size)) {
+            break;
+        }
+
         for (i = 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
         }
@@ -613,7 +715,9 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
 
 static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
 {
-    const AspeedSMCState *s = fl->controller;
+    AspeedSMCState *s = fl->controller;
+
+    s->snoop_index = aspeed_smc_is_ce_stop_active(fl) ? SNOOP_OFF : SNOOP_START;
 
     qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
 }
@@ -652,6 +756,9 @@ static void aspeed_smc_reset(DeviceState *d)
     if (s->ctrl->segments == aspeed_segments_fmc) {
         s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
     }
+
+    s->snoop_index = SNOOP_OFF;
+    s->snoop_dummies = 0;
 }
 
 static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
@@ -793,10 +900,12 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
+        VMSTATE_UINT8(snoop_index, AspeedSMCState),
+        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.20.1
