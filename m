Received: from eggs.gnu.org ([2001:4830:134:3::10]:35533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tu-0007Hm-Qa
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tt-00040a-TO
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tt-0003xu-Ie
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Ts-0006VL-Jq
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:13 +0100
Message-Id: <20180824093343.11346-23-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/52] hw/arm/iotkit: Wire up the dualtimer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now we have a model of the CMSDK dual timer, we can wire it
up in the IoTKit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180820141116.9118-5-peter.maydell@linaro.org
---
 include/hw/arm/iotkit.h | 3 ++-
 hw/arm/iotkit.c         | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index 2cddde55dd1..3e6d806e352 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -56,6 +56,7 @@
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/tz-mpc.h"
 #include "hw/timer/cmsdk-apb-timer.h"
+#include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
@@ -87,7 +88,7 @@ typedef struct IoTKit {
     SplitIRQ mpc_irq_splitter[IOTS_NUM_EXP_MPC + IOTS_NUM_MPC];
     qemu_or_irq mpc_irq_orgate;
 
-    UnimplementedDeviceState dualtimer;
+    CMSDKAPBDualTimer dualtimer;
     UnimplementedDeviceState s32ktimer;
 
     MemoryRegion container;
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 8cadc8b1608..130d013909e 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -139,7 +139,7 @@ static void iotkit_init(Object *obj)
     sysbus_init_child_obj(obj, "timer1", &s->timer1, sizeof(s->timer1),
                           TYPE_CMSDK_APB_TIMER);
     sysbus_init_child_obj(obj, "dualtimer", &s->dualtimer, sizeof(s->dualtimer),
-                          TYPE_UNIMPLEMENTED_DEVICE);
+                          TYPE_CMSDK_APB_DUALTIMER);
     object_initialize_child(obj, "ppc-irq-orgate", &s->ppc_irq_orgate,
                             sizeof(s->ppc_irq_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -390,13 +390,15 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qdev_prop_set_string(DEVICE(&s->dualtimer), "name", "Dual timer");
-    qdev_prop_set_uint64(DEVICE(&s->dualtimer), "size", 0x1000);
+
+    qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
     object_property_set_bool(OBJECT(&s->dualtimer), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
+                       qdev_get_gpio_in(DEVICE(&s->armv7m), 5));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dualtimer), 0);
     object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]", &err);
     if (err) {
-- 
2.18.0
