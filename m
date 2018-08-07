Received: from eggs.gnu.org ([2001:4830:134:3::10]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwtU-00037W-6R
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwtT-0005iM-97
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:59:04 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:57 +0930
Message-Id: <20180807075757.7242-8-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 7/7] aspeed: Link SCU to the watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

The ast2500 uses the watchdog to reset the SDRAM controller. This
operation is usually performed by u-boot's memory training procedure,
and it is enabled by setting a bit in the SCU and then causing the
watchdog to expire. Therefore, we need the watchdog to be able to
acess the SCU's register space.

This does not cause a system reset, but only resets the SDRAM
controller.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed_soc.c              |  2 ++
 hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++++++++++
 include/hw/watchdog/wdt_aspeed.h |  1 +
 3 files changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a27233d4876b..2cbacb4430bb 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -164,6 +164,8 @@ static void aspeed_soc_init(Object *obj)
         qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
         qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
                                     sc->info->silicon_rev);
+        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
+                                       OBJECT(&s->scu), &error_abort);
     }
 
     object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC100);
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 95f6ad186d72..f5cb30c0b584 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -43,6 +43,9 @@
 
 #define WDT_RESTART_MAGIC               0x4755
 
+#define SCU_RESET_CONTROL1              (0x04 / 4)
+#define    SCU_RESET_SDRAM              BIT(0)
+
 static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
 {
     return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
@@ -221,6 +224,13 @@ static void aspeed_wdt_timer_expired(void *dev)
 {
     AspeedWDTState *s = ASPEED_WDT(dev);
 
+    /* Do not reset on SDRAM controller reset */
+    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
+        timer_del(s->timer);
+        s->regs[WDT_CTRL] = 0;
+        return;
+    }
+
     qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
     watchdog_perform_action();
     timer_del(s->timer);
@@ -232,6 +242,16 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedWDTState *s = ASPEED_WDT(dev);
+    Error *err = NULL;
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "scu", &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link 'scu' not found: ");
+        return;
+    }
+    s->scu = ASPEED_SCU(obj);
 
     if (!is_supported_silicon_rev(s->silicon_rev)) {
         error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 7de3e5c224fb..cc734bd7ae7b 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -26,6 +26,7 @@ typedef struct AspeedWDTState {
     MemoryRegion iomem;
     uint32_t regs[ASPEED_WDT_REGS_MAX];
 
+    AspeedSCUState *scu;
     uint32_t pclk_freq;
     uint32_t silicon_rev;
     uint32_t ext_pulse_width_mask;
-- 
2.17.1
