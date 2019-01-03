Received: from eggs.gnu.org ([208.118.235.92]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3f-0003Sh-Tq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3f-0006bx-5M
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 09:11:12 +0000
Message-Id: <20190103091119.9367-5-stefanha@redhat.com>
In-Reply-To: <20190103091119.9367-1-stefanha@redhat.com>
References: <20190103091119.9367-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/11] arm: Instantiate NRF51 random number
 generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Use RNG in SOC.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/arm/nrf51_soc.h |  2 ++
 hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 73fc92e9a8..9e3ba916bd 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/nrf51_uart.h"
+#include "hw/misc/nrf51_rng.h"
=20
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -26,6 +27,7 @@ typedef struct NRF51State {
     ARMv7MState cpu;
=20
     NRF51UARTState uart;
+    NRF51RNGState rng;
=20
     MemoryRegion iomem;
     MemoryRegion sram;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 55f8eaafcb..d2a19b8ead 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -86,6 +86,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Er=
ror **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu),
                        BASE_TO_IRQ(NRF51_UART_BASE)));
=20
+    /* RNG */
+    object_property_set_bool(OBJECT(&s->rng), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
+    memory_region_add_subregion_overlap(&s->container, NRF51_RNG_BASE, m=
r, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       BASE_TO_IRQ(NRF51_RNG_BASE)));
+
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
@@ -110,6 +123,9 @@ static void nrf51_soc_init(Object *obj)
                            TYPE_NRF51_UART);
     object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev=
",
                               &error_abort);
+
+    sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
+                           TYPE_NRF51_RNG);
 }
=20
 static Property nrf51_soc_properties[] =3D {
--=20
2.19.2
