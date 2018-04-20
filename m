Received: from eggs.gnu.org ([2001:4830:134:3::10]:43466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPT-0006Ri-Pq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPO-0007sH-T7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPO-0007mN-JM
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:06 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:44 +0100
Message-Id: <20180420145249.32435-9-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/13] Remove checks on MAX_SERIAL_PORTS that
 are just bounds checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Remove checks on MAX_SERIAL_PORTS that were just checking whether
they were within bounds for the serial_hds[] array and falling
back to NULL if not. This isn't needed with the serial_hd()
function, which returns NULL for all indexes beyond what the
user set up.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx25.c     | 4 +---
 hw/arm/fsl-imx31.c     | 4 +---
 hw/arm/fsl-imx6.c      | 4 +---
 hw/arm/fsl-imx7.c      | 4 +---
 hw/arm/mps2-tz.c       | 3 +--
 hw/arm/mps2.c          | 6 ++----
 hw/arm/stm32f205_soc.c | 3 +--
 7 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9731833fa5..37056f9e34 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -117,9 +117,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_UART5_ADDR, FSL_IMX25_UART5_IRQ }
         };
 
-        if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        }
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
         if (err) {
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 8509915200..891850cf18 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -106,9 +106,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_UART2_ADDR, FSL_IMX31_UART2_IRQ },
         };
 
-        if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        }
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
         if (err) {
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 535ad5888b..4f51bd9eb5 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -188,9 +188,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_UART5_ADDR, FSL_IMX6_UART5_IRQ },
         };
 
-        if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        }
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
         if (err) {
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 2848d76d3c..26c1d27f7c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -390,9 +390,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         };
 
 
-        if (i < MAX_SERIAL_PORTS) {
-            qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        }
+        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
         object_property_set_bool(OBJECT(&s->uart[i]), true, "realized",
                                  &error_abort);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 4ae4a5cb2a..8dc8bfd4ab 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -172,7 +172,6 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
 {
     CMSDKAPBUART *uart = opaque;
     int i = uart - &mms->uart[0];
-    Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
     int rxirqno = i * 2;
     int txirqno = i * 2 + 1;
     int combirqno = i + 10;
@@ -182,7 +181,7 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
 
     init_sysbus_child(OBJECT(mms), name, uart,
                       sizeof(mms->uart[0]), TYPE_CMSDK_APB_UART);
-    qdev_prop_set_chr(DEVICE(uart), "chardev", uartchr);
+    qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", SYSCLK_FRQ);
     object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
     s = SYS_BUS_DEVICE(uart);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index eb550fad34..c3946da317 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -230,7 +230,6 @@ static void mps2_common_init(MachineState *machine)
             static const hwaddr uartbase[] = {0x40004000, 0x40005000,
                                               0x40006000, 0x40007000,
                                               0x40009000};
-            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
             /* RX irq number; TX irq is always one greater */
             static const int uartirq[] = {0, 2, 4, 18, 20};
             qemu_irq txovrint = NULL, rxovrint = NULL;
@@ -245,7 +244,7 @@ static void mps2_common_init(MachineState *machine)
                                   qdev_get_gpio_in(armv7m, uartirq[i]),
                                   txovrint, rxovrint,
                                   NULL,
-                                  uartchr, SYSCLK_FRQ);
+                                  serial_hd(i), SYSCLK_FRQ);
         }
         break;
     }
@@ -270,7 +269,6 @@ static void mps2_common_init(MachineState *machine)
             static const hwaddr uartbase[] = {0x40004000, 0x40005000,
                                               0x4002c000, 0x4002d000,
                                               0x4002e000};
-            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL;
             Object *txrx_orgate;
             DeviceState *txrx_orgate_dev;
 
@@ -287,7 +285,7 @@ static void mps2_common_init(MachineState *machine)
                                   qdev_get_gpio_in(orgate_dev, i * 2),
                                   qdev_get_gpio_in(orgate_dev, i * 2 + 1),
                                   NULL,
-                                  uartchr, SYSCLK_FRQ);
+                                  serial_hd(i), SYSCLK_FRQ);
         }
         break;
     }
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index f59418e7d0..2b2135d382 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -135,8 +135,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* Attach UART (uses USART registers) and USART controllers */
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
-        qdev_prop_set_chr(dev, "chardev",
-                          i < MAX_SERIAL_PORTS ? serial_hd(i) : NULL);
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
-- 
2.17.0
