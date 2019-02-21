Received: from eggs.gnu.org ([209.51.188.92]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXt-00005j-W8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXr-0007Vd-I6
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXr-0007UV-9J
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:07 -0500
Received: by mail-wr1-x433.google.com with SMTP id t18so31879910wrx.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:58:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.58.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:58:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:37 +0000
Message-Id: <20190221185739.25362-20-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/21] hw/arm/musca: Wire up PL031 RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Wire up the PL031 RTC for the Musca board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/musca.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index c4095c4579b..378912b7385 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -30,6 +30,7 @@
 #include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/unimp.h"
+#include "hw/timer/pl031.h"
 
 #define MUSCA_NUMIRQ_MAX 96
 #define MUSCA_PPC_MAX 3
@@ -73,7 +74,7 @@ typedef struct {
     UnimplementedDeviceState spi;
     UnimplementedDeviceState scc;
     UnimplementedDeviceState timer;
-    UnimplementedDeviceState rtc;
+    PL031State rtc;
     UnimplementedDeviceState pvt;
     UnimplementedDeviceState sdio;
     UnimplementedDeviceState gpio;
@@ -98,6 +99,14 @@ typedef struct {
  */
 #define SYSCLK_FRQ 40000000
 
+static qemu_irq get_sse_irq_in(MuscaMachineState *mms, int irqno)
+{
+    /* Return a qemu_irq which will signal IRQ n to all CPUs in the SSE. */
+    assert(irqno < MUSCA_NUMIRQ_MAX);
+
+    return qdev_get_gpio_in(DEVICE(&mms->cpu_irq_splitter[irqno]), 0);
+}
+
 /*
  * Most of the devices in the Musca board sit behind Peripheral Protection
  * Controllers. These data structures define the layout of which devices
@@ -265,6 +274,17 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 0);
 }
 
+static MemoryRegion *make_rtc(MuscaMachineState *mms, void *opaque,
+                              const char *name, hwaddr size)
+{
+    PL031State *rtc = opaque;
+
+    sysbus_init_child_obj(OBJECT(mms), name, rtc, sizeof(mms->rtc), TYPE_PL031);
+    object_property_set_bool(OBJECT(rtc), true, "realized", &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(rtc), 0, get_sse_irq_in(mms, 39));
+    return sysbus_mmio_get_region(SYS_BUS_DEVICE(rtc), 0);
+}
+
 static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
                                        const char *name, hwaddr size)
 {
@@ -287,7 +307,7 @@ static MemoryRegion *make_musca_a_devs(MuscaMachineState *mms, void *opaque,
         { "i2c1", make_unimp_dev, &mms->i2c[1], 0x5000, 0x1000 },
         { "i2s", make_unimp_dev, &mms->i2s, 0x6000, 0x1000 },
         { "pwm0", make_unimp_dev, &mms->pwm[0], 0x7000, 0x1000 },
-        { "rtc", make_unimp_dev, &mms->rtc, 0x8000, 0x1000 },
+        { "rtc", make_rtc, &mms->rtc, 0x8000, 0x1000 },
         { "qspi", make_unimp_dev, &mms->qspi, 0xa000, 0x1000 },
         { "timer", make_unimp_dev, &mms->timer, 0xb000, 0x1000 },
         { "scc", make_unimp_dev, &mms->scc, 0xc000, 0x1000 },
@@ -447,7 +467,7 @@ static void musca_init(MachineState *machine)
                 { "spi", make_unimp_dev, &mms->spi, 0x4010a000, 0x1000 },
                 { "scc", make_unimp_dev, &mms->scc, 0x5010b000, 0x1000 },
                 { "timer", make_unimp_dev, &mms->timer, 0x4010c000, 0x1000 },
-                { "rtc", make_unimp_dev, &mms->rtc, 0x4010d000, 0x1000 },
+                { "rtc", make_rtc, &mms->rtc, 0x4010d000, 0x1000 },
                 { "pvt", make_unimp_dev, &mms->pvt, 0x4010e000, 0x1000 },
                 { "sdio", make_unimp_dev, &mms->sdio, 0x4010f000, 0x1000 },
             },
-- 
2.20.1
