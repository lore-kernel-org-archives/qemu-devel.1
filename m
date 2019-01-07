Received: from eggs.gnu.org ([209.51.188.92]:46647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXp1-0005PK-Sf
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXou-0002cS-FL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoq-0002Lf-Oq
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:06 -0500
Received: by mail-wr1-x430.google.com with SMTP id t27so1066354wra.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:09 +0000
Message-Id: <20190107163117.16269-30-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/37] arm: Instantiate NRF51 general purpose I/O
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

Instantiates GPIO peripheral model

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-7-stefanha@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/nrf51_soc.h |  2 ++
 hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 9e3ba916bd0..84e0278881b 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -14,6 +14,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/misc/nrf51_rng.h"
+#include "hw/gpio/nrf51_gpio.h"
 
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -28,6 +29,7 @@ typedef struct NRF51State {
 
     NRF51UARTState uart;
     NRF51RNGState rng;
+    NRF51GPIOState gpio;
 
     MemoryRegion iomem;
     MemoryRegion sram;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index d2a19b8eadd..db817fe5064 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -99,6 +99,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0);
+    memory_region_add_subregion_overlap(&s->container, NRF51_GPIO_BASE, mr, 0);
+
+    /* Pass all GPIOs to the SOC layer so they are available to the board */
+    qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
+
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
@@ -126,6 +139,9 @@ static void nrf51_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
                            TYPE_NRF51_RNG);
+
+    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
+                          TYPE_NRF51_GPIO);
 }
 
 static Property nrf51_soc_properties[] = {
-- 
2.19.2
