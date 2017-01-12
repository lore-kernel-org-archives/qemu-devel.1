Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZN-0000bU-JA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZM-0006tF-Km
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:53 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZM-0006t9-Gq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:52 -0500
Received: by mail-qk0-x241.google.com with SMTP id 11so961694qkl.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:52 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:56:04 -0800
Message-Id: <20170112025606.27332-29-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 28/30] target-sparc: implement sun4v RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <f4e117a2b91e3da064b3b98d86b0f1f3c011097c.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 MAINTAINERS                  |   6 +++
 hw/timer/Makefile.objs       |   2 +
 hw/timer/sun4v-rtc.c         | 102 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/timer/sun4v-rtc.h |   1 +
 4 files changed, 111 insertions(+)
 create mode 100644 hw/timer/sun4v-rtc.c
 create mode 100644 include/hw/timer/sun4v-rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1444b26..54588e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,12 @@ F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
 F: tests/prom-env-test.c
 
+sun4v RTC
+M: Artyom Tarasenko <atar4qemu@gmail.com>
+S: Maintained
+F: hw/timer/sun4v-rtc.c
+F: include/hw/timer/sun4v-rtc.h
+
 Subsystems
 ----------
 Audio
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 7ba8c23..c1e93a3 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -34,3 +34,5 @@ obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
+
+common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
new file mode 100644
index 0000000..82e9e14
--- /dev/null
+++ b/hw/timer/sun4v-rtc.c
@@ -0,0 +1,102 @@
+/*
+ * QEMU sun4v Real Time Clock device
+ *
+ * The sun4v_rtc device (sun4v tod clock)
+ *
+ * Copyright (c) 2016 Artyom Tarasenko
+ *
+ * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "hw/timer/sun4v-rtc.h"
+
+//#define DEBUG_SUN4V_RTC
+
+#ifdef DEBUG_SUN4V_RTC
+#define DPRINTF(fmt, ...)                                       \
+    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#endif
+
+#define TYPE_SUN4V_RTC "sun4v_rtc"
+#define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
+
+typedef struct Sun4vRtc {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+} Sun4vRtc;
+
+static uint64_t sun4v_rtc_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    uint64_t val = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+    if (!(addr & 4ULL)) {
+        /* accessing the high 32 bits */
+        val >>= 32;
+    }
+    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
+    return val;
+}
+
+static void sun4v_rtc_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
+}
+
+static const MemoryRegionOps sun4v_rtc_ops = {
+    .read = sun4v_rtc_read,
+    .write = sun4v_rtc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+void sun4v_rtc_init(hwaddr addr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, TYPE_SUN4V_RTC);
+    s = SYS_BUS_DEVICE(dev);
+
+    qdev_init_nofail(dev);
+
+    sysbus_mmio_map(s, 0, addr);
+}
+
+static int sun4v_rtc_init1(SysBusDevice *dev)
+{
+    Sun4vRtc *s = SUN4V_RTC(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &sun4v_rtc_ops, s,
+                          "sun4v-rtc", 0x08ULL);
+    sysbus_init_mmio(dev, &s->iomem);
+    return 0;
+}
+
+static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+
+    k->init = sun4v_rtc_init1;
+}
+
+static const TypeInfo sun4v_rtc_info = {
+    .name          = TYPE_SUN4V_RTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Sun4vRtc),
+    .class_init    = sun4v_rtc_class_init,
+};
+
+static void sun4v_rtc_register_types(void)
+{
+    type_register_static(&sun4v_rtc_info);
+}
+
+type_init(sun4v_rtc_register_types)
diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
new file mode 100644
index 0000000..407278f
--- /dev/null
+++ b/include/hw/timer/sun4v-rtc.h
@@ -0,0 +1 @@
+void sun4v_rtc_init(hwaddr addr);
-- 
2.9.3
