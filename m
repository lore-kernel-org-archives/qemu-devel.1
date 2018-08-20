Received: from eggs.gnu.org ([2001:4830:134:3::10]:41825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku2-0003R8-Nc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku1-0007EM-Mt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:30 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:01 +0100
Message-Id: <20180820141116.9118-8-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/22] hw/arm/iotkit: Wire up the S32KTIMER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The IoTKit has a CMSDK timer device that runs on the S32KCLK.
Create this and wire it up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/iotkit.h | 2 +-
 hw/arm/iotkit.c         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index 776d0497087..0f5c5101708 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -83,6 +83,7 @@ typedef struct IoTKit {
     TZMPC mpc;
     CMSDKAPBTIMER timer0;
     CMSDKAPBTIMER timer1;
+    CMSDKAPBTIMER s32ktimer;
     qemu_or_irq ppc_irq_orgate;
     SplitIRQ sec_resp_splitter;
     SplitIRQ ppc_irq_splitter[NUM_PPCS];
@@ -91,7 +92,6 @@ typedef struct IoTKit {
     qemu_or_irq nmi_orgate;
 
     CMSDKAPBDualTimer dualtimer;
-    UnimplementedDeviceState s32ktimer;
 
     CMSDKAPBWatchdog s32kwatchdog;
     CMSDKAPBWatchdog nswatchdog;
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 5cedfa03570..cb0ec456f39 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -141,6 +141,8 @@ static void iotkit_init(Object *obj)
                           TYPE_CMSDK_APB_TIMER);
     sysbus_init_child_obj(obj, "timer1", &s->timer1, sizeof(s->timer1),
                           TYPE_CMSDK_APB_TIMER);
+    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
+                          TYPE_CMSDK_APB_TIMER);
     sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
                           TYPE_CMSDK_APB_DUALTIMER);
     sysbus_init_child_obj(obj, "s32kwatchdog", &s->s32kwatchdog,
@@ -166,8 +168,6 @@ static void iotkit_init(Object *obj)
                                 TYPE_SPLIT_IRQ, &error_abort, NULL);
         g_free(name);
     }
-    sysbus_init_child_obj(obj, "s32ktimer", &s->s32ktimer, sizeof(s->s32ktimer),
-                          TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void iotkit_exp_irq(void *opaque, int n, int level)
@@ -476,13 +476,14 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     /* Devices behind APB PPC1:
      *   0x4002f000: S32K timer
      */
-    qdev_prop_set_string(DEVICE(&s->s32ktimer), "name", "S32KTIMER");
-    qdev_prop_set_uint64(DEVICE(&s->s32ktimer), "size", 0x1000);
+    qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
     object_property_set_bool(OBJECT(&s->s32ktimer), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
+                       qdev_get_gpio_in(DEVICE(&s->armv7m), 2));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
     object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]", &err);
     if (err) {
-- 
2.18.0
