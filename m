Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2X-00086Y-Bz
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2W-0002sf-7q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:20:30 +0100
Message-Id: <20180620132032.28865-7-peter.maydell@linaro.org>
In-Reply-To: <20180620132032.28865-1-peter.maydell@linaro.org>
References: <20180620132032.28865-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/8] hw/arm/iotkit: Instantiate MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eric Auger <eric.auger@redhat.com>

Wire up the one MPC that is part of the IoTKit itself. For the
moment we don't wire up its interrupt line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/iotkit.h |  2 ++
 hw/arm/iotkit.c         | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index c6129d926b6..b21cf1ab9d1 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -51,6 +51,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/misc/iotkit-secctl.h"
 #include "hw/misc/tz-ppc.h"
+#include "hw/misc/tz-mpc.h"
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
@@ -74,6 +75,7 @@ typedef struct IoTKit {
     IoTKitSecCtl secctl;
     TZPPC apb_ppc0;
     TZPPC apb_ppc1;
+    TZMPC mpc;
     CMSDKAPBTIMER timer0;
     CMSDKAPBTIMER timer1;
     qemu_or_irq ppc_irq_orgate;
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index 234185e8f78..160e40c7449 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -130,6 +130,7 @@ static void iotkit_init(Object *obj)
                       TYPE_TZ_PPC);
     init_sysbus_child(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
                       TYPE_TZ_PPC);
+    init_sysbus_child(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
     init_sysbus_child(obj, "timer0", &s->timer0, sizeof(s->timer0),
                       TYPE_CMSDK_APB_TIMER);
     init_sysbus_child(obj, "timer1", &s->timer1, sizeof(s->timer1),
@@ -266,15 +267,6 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
      */
     make_alias(s, &s->alias3, "alias 3", 0x50000000, 0x10000000, 0x40000000);
 
-    /* This RAM should be behind a Memory Protection Controller, but we
-     * don't implement that yet.
-     */
-    memory_region_init_ram(&s->sram0, NULL, "iotkit.sram0", 0x00008000, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    memory_region_add_subregion(&s->container, 0x20000000, &s->sram0);
 
     /* Security controller */
     object_property_set_bool(OBJECT(&s->secctl), true, "realized", &err);
@@ -310,6 +302,32 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(dev_secctl, "sec_resp_cfg", 0,
                                 qdev_get_gpio_in(dev_splitter, 0));
 
+    /* This RAM lives behind the Memory Protection Controller */
+    memory_region_init_ram(&s->sram0, NULL, "iotkit.sram0", 0x00008000, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_link(OBJECT(&s->mpc), OBJECT(&s->sram0),
+                             "downstream", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->mpc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    /* Map the upstream end of the MPC into the right place... */
+    memory_region_add_subregion(&s->container, 0x20000000,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mpc),
+                                                       1));
+    /* ...and its register interface */
+    memory_region_add_subregion(&s->container, 0x50083000,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mpc),
+                                                       0));
+
     /* Devices behind APB PPC0:
      *   0x40000000: timer0
      *   0x40001000: timer1
@@ -473,8 +491,6 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("NS watchdog", 0x40081000, 0x1000);
     create_unimplemented_device("S watchdog", 0x50081000, 0x1000);
 
-    create_unimplemented_device("SRAM0 MPC", 0x50083000, 0x1000);
-
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         Object *splitter = OBJECT(&s->ppc_irq_splitter[i]);
 
-- 
2.17.1
