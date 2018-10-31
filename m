Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeLZ-0005T5-FN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHeLY-0000dX-LW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:26:57 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 30 Oct 2018 20:25:26 -0400
Message-Id: <20181031002526.14262-13-contrib@steffen-goertz.de>
In-Reply-To: <20181031002526.14262-1-contrib@steffen-goertz.de>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/13] arm: Instantiate NRF51 Timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, "open list:NRF51" <qemu-arm@nongnu.org>

Instantiates TIMER0 - TIMER2

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c         | 27 +++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 695b335dc5..c29b80c0ca 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -40,6 +40,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Err=
or **errp)
     NRF51State *s =3D NRF51_SOC(dev_soc);
     MemoryRegion *mr;
     Error *err =3D NULL;
+    uint8_t i =3D 0;
+    hwaddr base_addr =3D 0;
=20
     if (!s->board_memory) {
         error_setg(errp, "memory property was not set");
@@ -141,6 +143,22 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
     /* Pass all GPIOs to the SOC layer so they are available to the boar=
d */
     qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
=20
+    /* TIMER */
+    for (i =3D 0; i < NRF51_NUM_TIMERS; i++) {
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",=
 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        base_addr =3D NRF51_TIMER_BASE + i * 0x1000;
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->cpu),
+                                            BASE_TO_IRQ(base_addr)));
+    }
+
=20
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
@@ -150,6 +168,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
=20
 static void nrf51_soc_init(Object *obj)
 {
+    uint8_t i =3D 0;
+
     NRF51State *s =3D NRF51_SOC(obj);
=20
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX=
);
@@ -173,6 +193,13 @@ static void nrf51_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_NRF51_GPIO);
=20
+    for (i =3D 0; i < NRF51_NUM_TIMERS; i++) {
+        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
+                              sizeof(s->timer[i]), TYPE_NRF51_TIMER);
+
+    }
+
+
 }
=20
 static Property nrf51_soc_properties[] =3D {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index d4a48ccf91..89525dcb39 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -16,11 +16,14 @@
 #include "hw/misc/nrf51_rng.h"
 #include "hw/nvram/nrf51_nvm.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
     OBJECT_CHECK(NRF51State, (obj), TYPE_NRF51_SOC)
=20
+#define NRF51_NUM_TIMERS 3
+
 typedef struct NRF51State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -32,6 +35,7 @@ typedef struct NRF51State {
     NRF51RNGState rng;
     NRF51NVMState nvm;
     NRF51GPIOState gpio;
+    NRF51TimerState timer[NRF51_NUM_TIMERS];
=20
     MemoryRegion iomem;
     MemoryRegion sram;
--=20
2.19.1
