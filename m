Received: from eggs.gnu.org ([209.51.188.92]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZv-0006sC-Fx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZu-0002jp-8P
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:15 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 30 Apr 2019 14:10:35 +0930
Message-Id: <20190430044036.1144-3-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-1-joel@jms.id.au>
References: <20190430044036.1144-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/2] hw/arm/aspeed: Add RTC to SoC
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

All systems have an RTC.

The IRQ is hooked up but the model does not use it at this stage. There
is no guest code that uses it, so this limitation is acceptable.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add commit message
v2: Rebase on Cedric's patches (20190411161013.4514-4-clg@kaod.org)
---
 hw/arm/aspeed_soc.c         | 13 +++++++++++++
 include/hw/arm/aspeed_soc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 110956828c44..ea9700c35bc4 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -229,6 +229,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
                           TYPE_ASPEED_VIC);
 
+    sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
+                          TYPE_ASPEED_RTC);
+
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
                           sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
@@ -315,6 +318,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
+    /* RTC */
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->info->memmap[ASPEED_RTC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+                       aspeed_soc_get_irq(s, ASPEED_RTC));
+
     /* Timer */
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index eda9094660b5..d124674f25d8 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -17,6 +17,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/timer/aspeed_timer.h"
+#include "hw/timer/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
@@ -33,6 +34,7 @@ typedef struct AspeedSoCState {
     ARMCPU cpu;
     MemoryRegion sram;
     AspeedVICState vic;
+    AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
     AspeedSCUState scu;
-- 
2.20.1
