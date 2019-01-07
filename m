Received: from eggs.gnu.org ([209.51.188.92]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpR-0005jd-9a
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpP-0003H8-CK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:41 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpP-0002SM-4t
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id 96so1091052wrb.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:12 +0000
Message-Id: <20190107163117.16269-33-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/37] arm: Instantiate NRF51 Timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

Instantiates TIMER0 - TIMER2

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-10-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/nrf51_soc.h |  4 ++++
 hw/arm/nrf51_soc.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 84e0278881b..39e613e1c97 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -15,11 +15,14 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/misc/nrf51_rng.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/timer/nrf51_timer.h"
 
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
     OBJECT_CHECK(NRF51State, (obj), TYPE_NRF51_SOC)
 
+#define NRF51_NUM_TIMERS 3
+
 typedef struct NRF51State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -30,6 +33,7 @@ typedef struct NRF51State {
     NRF51UARTState uart;
     NRF51RNGState rng;
     NRF51GPIOState gpio;
+    NRF51TimerState timer[NRF51_NUM_TIMERS];
 
     MemoryRegion iomem;
     MemoryRegion sram;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index db817fe5064..ef70bd62fa4 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -39,6 +39,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     NRF51State *s = NRF51_SOC(dev_soc);
     MemoryRegion *mr;
     Error *err = NULL;
+    uint8_t i = 0;
+    hwaddr base_addr = 0;
 
     if (!s->board_memory) {
         error_setg(errp, "memory property was not set");
@@ -112,6 +114,22 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
 
+    /* TIMER */
+    for (i = 0; i < NRF51_NUM_TIMERS; i++) {
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        base_addr = NRF51_TIMER_BASE + i * NRF51_TIMER_SIZE;
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->cpu),
+                                            BASE_TO_IRQ(base_addr)));
+    }
+
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
@@ -122,6 +140,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
 static void nrf51_soc_init(Object *obj)
 {
+    uint8_t i = 0;
+
     NRF51State *s = NRF51_SOC(obj);
 
     memory_region_init(&s->container, obj, "nrf51-container", UINT64_MAX);
@@ -142,6 +162,12 @@ static void nrf51_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_NRF51_GPIO);
+
+    for (i = 0; i < NRF51_NUM_TIMERS; i++) {
+        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
+                              sizeof(s->timer[i]), TYPE_NRF51_TIMER);
+
+    }
 }
 
 static Property nrf51_soc_properties[] = {
-- 
2.19.2
