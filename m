Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtK-000610-Sv
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtG-0001PY-TG
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:58 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:35 +0200
Message-Id: <20180811090836.4024-7-contrib@steffen-goertz.de>
In-Reply-To: <20180811090836.4024-1-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] arm: Instantiate nRF51 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

Instantiate NVMs, NVMC, UART, RNG, GPIO and TIMERs.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---
 hw/arm/nrf51_soc.c         | 153 +++++++++++++++++++++++++++++++++++--
 include/hw/arm/nrf51_soc.h |  16 +++-
 2 files changed, 161 insertions(+), 8 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 88a848de8b..a395d3a00d 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -25,15 +25,20 @@
=20
 #include "hw/arm/nrf51_soc.h"
=20
-#define IOMEM_BASE      0x40000000
-#define IOMEM_SIZE      0x20000000
-
-#define FICR_BASE       0x10000000
-#define FICR_SIZE       0x000000fc
-
 #define FLASH_BASE      0x00000000
+#define FICR_BASE       0x10000000
+#define UICR_BASE       0x10001000
 #define SRAM_BASE       0x20000000
=20
+#define IOMEM_BASE      0x40000000
+#define IOMEM_SIZE      0x20000000
+
+#define UART_BASE       0x40002000
+#define TIMER_BASE      0x40008000
+#define RNG_BASE        0x4000D000
+#define NVMC_BASE       0x4001E000
+#define GPIO_BASE       0x50000000
+
 #define PAGE_SIZE       1024
=20
 /* IRQ lines can be derived from peripheral base addresses */
@@ -49,10 +54,33 @@ struct {
         [NRF51_VARIANT_AC] =3D {.ram_size =3D 32, .flash_size =3D 256 },
 };
=20
+
+static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+                  __func__, addr, size);
+    return 1;
+}
+
+static void clock_write(void *opaque, hwaddr addr, uint64_t data,
+                        unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
+                  __func__, addr, data, size);
+}
+
+static const MemoryRegionOps clock_ops =3D {
+    .read =3D clock_read,
+    .write =3D clock_write
+};
+
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s =3D NRF51_SOC(dev_soc);
     Error *err =3D NULL;
+    MemoryRegion *mr =3D NULL;
+    size_t i;
+    qemu_irq irq;
=20
     if (!s->board_memory) {
         error_setg(errp, "memory property was not set");
@@ -100,14 +128,102 @@ static void nrf51_soc_realize(DeviceState *dev_soc=
, Error **errp)
     }
     memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
=20
+
+    /* UART */
+    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
+    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0)=
;
+    irq =3D qdev_get_gpio_in(DEVICE(&s->cpu), BASE_TO_IRQ(UART_BASE));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0, irq);
+
+    /* TIMER */
+    for (i =3D 0; i < NRF51_TIMER_NUM; i++) {
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",=
 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0,
+                     TIMER_BASE + i * 0x1000);
+
+        irq =3D qdev_get_gpio_in(DEVICE(&s->cpu),
+                               BASE_TO_IRQ(TIMER_BASE + i * 0x1000));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0, irq);
+    }
+
+    /* NVMC */
+    object_property_set_link(OBJECT(&s->nvm), OBJECT(&s->container),
+                                         "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_uint(OBJECT(&s->nvm),
+            NRF51VariantAttributes[s->part_variant].flash_size, "code_si=
ze",
+            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->nvm), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 0);
+    memory_region_add_subregion_overlap(&s->container, NVMC_BASE, mr, 0)=
;
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 1);
+    memory_region_add_subregion_overlap(&s->container, FICR_BASE, mr, 0)=
;
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 2);
+    memory_region_add_subregion_overlap(&s->container, UICR_BASE, mr, 0)=
;
+
+    /* RNG */
+    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
+    memory_region_add_subregion_overlap(&s->container, RNG_BASE, mr, 0);
+    irq =3D qdev_get_gpio_in(DEVICE(&s->cpu), BASE_TO_IRQ(RNG_BASE));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0, irq);
+
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0);
+    memory_region_add_subregion_overlap(&s->container, GPIO_BASE, mr, 0)=
;
+
+    /* Pass all GPIOs to the SOC layer so they are available to the boar=
d */
+    qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
+
+    /* STUB Peripherals */
+    memory_region_init_io(&s->clock, NULL, &clock_ops, NULL,
+                          "nrf51_soc.clock", 0x1000);
+    memory_region_add_subregion_overlap(&s->container, IOMEM_BASE, &s->c=
lock,
+                                        -1);
+
     create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
-    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
     create_unimplemented_device("nrf51_soc.private", 0xF0000000, 0x10000=
000);
 }
=20
 static void nrf51_soc_init(Object *obj)
 {
     NRF51State *s =3D NRF51_SOC(obj);
+    size_t i;
=20
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX=
);
=20
@@ -118,6 +234,29 @@ static void nrf51_soc_init(Object *obj)
     qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m0"));
     qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
+
+    object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
+    object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abor=
t);
+    qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
+
+    object_initialize(&s->nvm, sizeof(s->nvm), TYPE_NRF51_NVM);
+    object_property_add_child(obj, "nvm", OBJECT(&s->nvm), &error_abort)=
;
+    qdev_set_parent_bus(DEVICE(&s->nvm), sysbus_get_default());
+
+    object_initialize(&s->rng, sizeof(s->rng), TYPE_NRF51_RNG);
+    object_property_add_child(obj, "rng", OBJECT(&s->rng), &error_abort)=
;
+    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
+
+    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_NRF51_GPIO);
+    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), &error_abor=
t);
+    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
+
+    for (i =3D 0; i < NRF51_TIMER_NUM; i++) {
+        object_initialize(&s->timer[i], sizeof(s->timer[i]), TYPE_NRF51_=
TIMER);
+        object_property_add_child(obj, "timer[*]", OBJECT(&s->timer[i]),=
 NULL);
+        qdev_set_parent_bus(DEVICE(&s->timer[i]), sysbus_get_default());
+    }
+
 }
=20
 static Property nrf51_soc_properties[] =3D {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 45d9671dc3..d47b42fa37 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -14,11 +14,18 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
+#include "hw/char/nrf51_uart.h"
+#include "hw/misc/nrf51_rng.h"
+#include "hw/nvram/nrf51_nvm.h"
+#include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
     OBJECT_CHECK(NRF51State, (obj), TYPE_NRF51_SOC)
=20
+#define NRF51_TIMER_NUM 3
+
 typedef struct NRF51State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -31,9 +38,16 @@ typedef struct NRF51State {
     MemoryRegion flash;
=20
     MemoryRegion *board_memory;
-
     MemoryRegion container;
=20
+    MemoryRegion clock;
+
+    Nrf51UART uart;
+    Nrf51NVMState nvm;
+    Nrf51RNGState rng;
+    Nrf51GPIOState gpio;
+    Nrf51TimerState timer[NRF51_TIMER_NUM];
+
     /* Properties */
     int32_t part_variant;
 } NRF51State;
--=20
2.18.0
