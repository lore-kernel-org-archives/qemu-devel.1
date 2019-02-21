Received: from eggs.gnu.org ([209.51.188.92]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXu-00006F-FU
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXs-0007Wc-SJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXs-0007W1-Ja
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id x7so10568189wmj.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:58:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.58.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:58:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:38 +0000
Message-Id: <20190221185739.25362-21-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/21] hw/arm/musca: Wire up PL011 UARTs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Wire up the two PL011 UARTs in the Musca board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/musca.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 378912b7385..23aff43f4bc 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -23,9 +23,11 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/armsse.h"
 #include "hw/boards.h"
+#include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
 #include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-ppc.h"
@@ -69,7 +71,7 @@ typedef struct {
     UnimplementedDeviceState mhu[2];
     UnimplementedDeviceState pwm[3];
     UnimplementedDeviceState i2s;
-    UnimplementedDeviceState uart[2];
+    PL011State uart[2];
     UnimplementedDeviceState i2c[2];
     UnimplementedDeviceState spi;
     UnimplementedDeviceState scc;
@@ -285,6 +287,28 @@ static MemoryRegion *make_rtc(MuscaMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(rtc), 0);
 }
 
+static MemoryRegion *make_uart(MuscaMachineState *mms, void *opaque,
+                               const char *name, hwaddr size)
+{
+    PL011State *uart = opaque;
+    int i = uart - &mms->uart[0];
+    int irqbase = 7 + i * 6;
+    SysBusDevice *s;
+
+    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(mms->uart[0]),
+                          TYPE_PL011);
+    qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
+    object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
+    s = SYS_BUS_DEVICE(uart);
+    sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqbase + 5)); /* combined */
+    sysbus_connect_irq(s, 1, get_sse_irq_in(mms, irqbase + 0)); /* RX */
+    sysbus_connect_irq(s, 2, get_sse_irq_in(mms, irqbase + 1)); /* TX */
+    sysbus_connect_irq(s, 3, get_sse_irq_in(mms, irqbase + 2)); /* RT */
+    sysbus_connect_irq(s, 4, get_sse_irq_in(mms, irqbase + 3)); /* MS */
+    sysbus_connect_irq(s, 5, get_sse_irq_in(mms, irqbase + 4)); /* E */
+    return sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), 0);
+}
+
 static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
                                        const char *name, hwaddr size)
 {
@@ -300,8 +324,8 @@ static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
     MemoryRegion *container = &mms->container;
 
     const PPCPortInfo devices[] = {
-        { "uart0", make_unimp_dev, &mms->uart[0], 0x1000, 0x1000 },
-        { "uart1", make_unimp_dev, &mms->uart[1], 0x2000, 0x1000 },
+        { "uart0", make_uart, &mms->uart[0], 0x1000, 0x1000 },
+        { "uart1", make_uart, &mms->uart[1], 0x2000, 0x1000 },
         { "spi", make_unimp_dev, &mms->spi, 0x3000, 0x1000 },
         { "i2c0", make_unimp_dev, &mms->i2c[0], 0x4000, 0x1000 },
         { "i2c1", make_unimp_dev, &mms->i2c[1], 0x5000, 0x1000 },
@@ -460,8 +484,8 @@ static void musca_init(MachineState *machine)
                 { "pwm1", make_unimp_dev, &mms->pwm[1], 0x40102000, 0x1000 },
                 { "pwm2", make_unimp_dev, &mms->pwm[2], 0x40103000, 0x1000 },
                 { "i2s", make_unimp_dev, &mms->i2s, 0x40104000, 0x1000 },
-                { "uart0", make_unimp_dev, &mms->uart[0], 0x40105000, 0x1000 },
-                { "uart1", make_unimp_dev, &mms->uart[1], 0x40106000, 0x1000 },
+                { "uart0", make_uart, &mms->uart[0], 0x40105000, 0x1000 },
+                { "uart1", make_uart, &mms->uart[1], 0x40106000, 0x1000 },
                 { "i2c0", make_unimp_dev, &mms->i2c[0], 0x40108000, 0x1000 },
                 { "i2c1", make_unimp_dev, &mms->i2c[1], 0x40109000, 0x1000 },
                 { "spi", make_unimp_dev, &mms->spi, 0x4010a000, 0x1000 },
-- 
2.20.1
