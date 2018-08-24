Received: from eggs.gnu.org ([2001:4830:134:3::10]:35570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tw-0007KL-VN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tv-00044p-RJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tv-00042k-GQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tu-0006W2-J7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:15 +0100
Message-Id: <20180824093343.11346-25-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/52] hw/arm/iotkit: Wire up the watchdogs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The IoTKit includes three different instances of the
CMSDK APB watchdog; create and wire them up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180820141116.9118-7-peter.maydell@linaro.org
---
 include/hw/arm/iotkit.h |  6 +++++
 hw/arm/iotkit.c         | 58 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index 3e6d806e352..776d0497087 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -57,6 +57,7 @@
 #include "hw/misc/tz-mpc.h"
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
@@ -87,10 +88,15 @@ typedef struct IoTKit {
     SplitIRQ ppc_irq_splitter[NUM_PPCS];
     SplitIRQ mpc_irq_splitter[IOTS_NUM_EXP_MPC + IOTS_NUM_MPC];
     qemu_or_irq mpc_irq_orgate;
+    qemu_or_irq nmi_orgate;
 
     CMSDKAPBDualTimer dualtimer;
     UnimplementedDeviceState s32ktimer;
 
+    CMSDKAPBWatchdog s32kwatchdog;
+    CMSDKAPBWatchdog nswatchdog;
+    CMSDKAPBWatchdog swatchdog;
+
     MemoryRegion container;
     MemoryRegion alias1;
     MemoryRegion alias2;
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 130d013909e..5cedfa03570 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -19,6 +19,9 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/arm.h"
 
+/* Clock frequency in HZ of the 32KHz "slow clock" */
+#define S32KCLK (32 * 1000)
+
 /* Create an alias region of @size bytes starting at @base
  * which mirrors the memory starting at @orig.
  */
@@ -140,6 +143,15 @@ static void iotkit_init(Object *obj)
                           TYPE_CMSDK_APB_TIMER);
     sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
                           TYPE_CMSDK_APB_DUALTIMER);
+    sysbus_init_child_obj(obj, "s32kwatchdog", &s->s32kwatchdog,
+                          sizeof(s->s32kwatchdog), TYPE_CMSDK_APB_WATCHDOG);
+    sysbus_init_child_obj(obj, "nswatchdog", &s->nswatchdog,
+                          sizeof(s->nswatchdog), TYPE_CMSDK_APB_WATCHDOG);
+    sysbus_init_child_obj(obj, "swatchdog", &s->swatchdog,
+                          sizeof(s->swatchdog), TYPE_CMSDK_APB_WATCHDOG);
+    object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
+                            sizeof(s->nmi_orgate), TYPE_OR_IRQ,
+                            &error_abort, NULL);
     object_initialize_child(obj, "ppc-irq-orgate", &s->ppc_irq_orgate,
                             sizeof(s->ppc_irq_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -510,12 +522,52 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("SYSINFO", 0x40020000, 0x1000);
 
     create_unimplemented_device("SYSCONTROL", 0x50021000, 0x1000);
-    create_unimplemented_device("S32KWATCHDOG", 0x5002e000, 0x1000);
+
+    /* This OR gate wires together outputs from the secure watchdogs to NMI */
+    object_property_set_int(OBJECT(&s->nmi_orgate), 2, "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->nmi_orgate), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->nmi_orgate), 0,
+                          qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
+
+    qdev_prop_set_uint32(DEVICE(&s->s32kwatchdog), "wdogclk-frq", S32KCLK);
+    object_property_set_bool(OBJECT(&s->s32kwatchdog), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32kwatchdog), 0,
+                       qdev_get_gpio_in(DEVICE(&s->nmi_orgate), 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->s32kwatchdog), 0, 0x5002e000);
 
     /* 0x40080000 .. 0x4008ffff : IoTKit second Base peripheral region */
 
-    create_unimplemented_device("NS watchdog", 0x40081000, 0x1000);
-    create_unimplemented_device("S watchdog", 0x50081000, 0x1000);
+    qdev_prop_set_uint32(DEVICE(&s->nswatchdog), "wdogclk-frq", s->mainclk_frq);
+    object_property_set_bool(OBJECT(&s->nswatchdog), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->nswatchdog), 0,
+                       qdev_get_gpio_in(DEVICE(&s->armv7m), 1));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
+
+    qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
+    object_property_set_bool(OBJECT(&s->swatchdog), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->swatchdog), 0,
+                       qdev_get_gpio_in(DEVICE(&s->nmi_orgate), 1));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->swatchdog), 0, 0x50081000);
 
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         Object *splitter = OBJECT(&s->ppc_irq_splitter[i]);
-- 
2.18.0
