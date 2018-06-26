Received: from eggs.gnu.org ([2001:4830:134:3::10]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHS-0002JV-1R
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHR-0007Ls-0t
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHQ-0007L2-PE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHP-0000F8-Dl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:58 +0100
Message-Id: <20180626165658.31394-33-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/32] aspeed/timer: use the APB frequency from
 the SCU
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

The timer controller can be driven by either an external 1MHz clock or
by the APB clock. Today, the model makes the assumption that the APB
frequency is always set to 24MHz but this is incorrect.

The AST2400 SoC on the palmetto machines uses a 48MHz input clock
source and the APB can be set to 48MHz. The consequence is a general
system slowdown. The QEMU machines using the AST2500 SoC do not seem
impacted today because the APB frequency is still set to 24MHz.

We fix the timer frequency for all SoCs by linking the Timer model to
the SCU model. The APB frequency driving the timers is now the one
configured for the SoC.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180622075700.5923-4-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/aspeed_timer.h |  4 ++++
 hw/arm/aspeed_soc.c             |  2 ++
 hw/timer/aspeed_timer.c         | 19 +++++++++++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index bd6c1a7f960..040a0887343 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -24,6 +24,8 @@
 
 #include "qemu/timer.h"
 
+typedef struct AspeedSCUState AspeedSCUState;
+
 #define ASPEED_TIMER(obj) \
     OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
 #define TYPE_ASPEED_TIMER "aspeed.timer"
@@ -55,6 +57,8 @@ typedef struct AspeedTimerCtrlState {
     uint32_t ctrl;
     uint32_t ctrl2;
     AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
+
+    AspeedSCUState *scu;
 } AspeedTimerCtrlState;
 
 #endif /* ASPEED_TIMER_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 7cc05ee27ea..e68911af0f9 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -127,6 +127,8 @@ static void aspeed_soc_init(Object *obj)
 
     object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), NULL);
+    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
+                                   OBJECT(&s->scu), &error_abort);
     qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
 
     object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 1e31e22b6f1..5e3f51b66b4 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -10,8 +10,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
+#include "hw/misc/aspeed_scu.h"
 #include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
@@ -26,7 +28,6 @@
 #define TIMER_CLOCK_USE_EXT true
 #define TIMER_CLOCK_EXT_HZ 1000000
 #define TIMER_CLOCK_USE_APB false
-#define TIMER_CLOCK_APB_HZ 24000000
 
 #define TIMER_REG_STATUS 0
 #define TIMER_REG_RELOAD 1
@@ -80,11 +81,11 @@ static inline bool timer_external_clock(AspeedTimer *t)
     return timer_ctrl_status(t, op_external_clock);
 }
 
-static uint32_t clock_rates[] = { TIMER_CLOCK_APB_HZ, TIMER_CLOCK_EXT_HZ };
-
 static inline uint32_t calculate_rate(struct AspeedTimer *t)
 {
-    return clock_rates[timer_external_clock(t)];
+    AspeedTimerCtrlState *s = timer_to_ctrl(t);
+
+    return timer_external_clock(t) ? TIMER_CLOCK_EXT_HZ : s->scu->apb_freq;
 }
 
 static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t now_ns)
@@ -449,6 +450,16 @@ static void aspeed_timer_realize(DeviceState *dev, Error **errp)
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedTimerCtrlState *s = ASPEED_TIMER(dev);
+    Object *obj;
+    Error *err = NULL;
+
+    obj = object_property_get_link(OBJECT(dev), "scu", &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link 'scu' not found: ");
+        return;
+    }
+    s->scu = ASPEED_SCU(obj);
 
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         aspeed_init_one_timer(s, i);
-- 
2.17.1
