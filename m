Received: from eggs.gnu.org ([2001:4830:134:3::10]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtWs-0003i6-5p
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtWo-00085u-9B
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:56:10 -0500
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:56986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTtWo-000852-08
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:56:06 -0500
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 409D93CB75
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 17:56:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 18 Jan 2017 17:55:30 +0100
Message-Id: <1484758531-15093-2-git-send-email-clg@kaod.org>
In-Reply-To: <1484758531-15093-1-git-send-email-clg@kaod.org>
References: <1484758531-15093-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] wdt: Add Aspeed watchdog device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Joel Stanley <joel@jms.id.au>

The Aspeed SoC includes a set of watchdog timers using 32-bit
decrement counters, which can be based either on the APB clock or
a 1 MHz clock.

The watchdog timer is designed to prevent system deadlock and, in
general, it should be restarted before timeout. When a timeout occurs,
different types of signals can be generated, ARM reset, SOC reset,
System reset, CPU Interrupt, external signal or boot from alternate
block. The current model only performs the system reset function as
this is used by U-Boot and Linux.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: - fixed compile breakage
      - fixed io region size
      - added watchdog_perform_action() on timer expiry
      - wrote a commit log     =20
      - merged fixes from Andrew Jeffery to scale the reload value ]     =
=20
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/watchdog/Makefile.objs        |   1 +
 hw/watchdog/wdt_aspeed.c         | 214 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/watchdog/wdt_aspeed.h |  37 +++++++
 3 files changed, 252 insertions(+)
 create mode 100644 hw/watchdog/wdt_aspeed.c
 create mode 100644 include/hw/watchdog/wdt_aspeed.h

diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 72e3ffd93c59..9589bed63a3d 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -2,3 +2,4 @@ common-obj-y +=3D watchdog.o
 common-obj-$(CONFIG_WDT_IB6300ESB) +=3D wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) +=3D wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) +=3D wdt_diag288.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D wdt_aspeed.o
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
new file mode 100644
index 000000000000..96e62c54dc04
--- /dev/null
+++ b/hw/watchdog/wdt_aspeed.c
@@ -0,0 +1,214 @@
+/*
+ * ASPEED Watchdog Controller
+ *
+ * Copyright (C) 2016-2017 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "sysemu/watchdog.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "hw/watchdog/wdt_aspeed.h"
+
+#define WDT_IO_REGION_SIZE      0x20
+
+#define WDT_STATUS              0x00
+#define WDT_RELOAD_VALUE        0x04
+#define WDT_RESTART             0x08
+#define WDT_CTRL                0x0C
+#define WDT_TIMEOUT_STATUS      0x10
+#define WDT_TIMEOUT_CLEAR       0x14
+#define WDT_RESET_WDITH         0x18
+
+#define WDT_RESTART_MAGIC       0x4755
+
+static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned si=
ze)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(opaque);
+
+    switch (offset) {
+    case WDT_STATUS:
+        return s->reg_status;
+    case WDT_RELOAD_VALUE:
+        return s->reg_reload_value;
+    case WDT_RESTART:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from write-only reg at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, offset);
+        return 0;
+    case WDT_CTRL:
+        return s->reg_ctrl;
+    case WDT_TIMEOUT_STATUS:
+    case WDT_TIMEOUT_CLEAR:
+    case WDT_RESET_WDITH:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: uninmplemented read at offset 0x%" HWADDR_PRI=
x "\n",
+                      __func__, offset);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx=
 "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+}
+
+#define PCLK_HZ 24000000
+
+static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(opaque);
+    bool en =3D data & BIT(0);
+    bool pclk =3D !(data & BIT(4));
+
+    switch (offset) {
+    case WDT_STATUS:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only reg at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, offset);
+        break;
+    case WDT_RELOAD_VALUE:
+        s->reg_reload_value =3D data;
+        break;
+    case WDT_RESTART:
+        if ((data & 0xFFFF) =3D=3D 0x4755) {
+            uint32_t reload;
+
+            s->reg_status =3D s->reg_reload_value;
+
+            if (pclk) {
+                reload =3D muldiv64(s->reg_reload_value, NANOSECONDS_PER=
_SECOND,
+                                  PCLK_HZ) ;
+            } else {
+                reload =3D s->reg_reload_value * 1000;
+            }
+
+            if (s->enabled) {
+                timer_mod(s->timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload=
);
+            }
+        }
+        break;
+    case WDT_CTRL:
+        if (en && !s->enabled) {
+            uint32_t reload;
+
+            if (pclk) {
+                reload =3D muldiv64(s->reg_reload_value, NANOSECONDS_PER=
_SECOND,
+                                  PCLK_HZ);
+            } else {
+                reload =3D s->reg_reload_value * 1000;
+            }
+
+            s->enabled =3D true;
+            timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
reload);
+        } else if (!en && s->enabled) {
+            s->enabled =3D false;
+            timer_del(s->timer);
+        }
+        break;
+    case WDT_TIMEOUT_STATUS:
+    case WDT_TIMEOUT_CLEAR:
+    case WDT_RESET_WDITH:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: uninmplemented write at offset 0x%" HWADDR_PR=
Ix "\n",
+                      __func__, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRI=
x "\n",
+                      __func__, offset);
+    }
+    return;
+}
+
+static WatchdogTimerModel model =3D {
+    .wdt_name =3D TYPE_ASPEED_WDT,
+    .wdt_description =3D "aspeed watchdog device",
+};
+
+static const VMStateDescription vmstate_aspeed_wdt =3D {
+    .name =3D "vmstate_aspeed_wdt",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, AspeedWDTState),
+        VMSTATE_BOOL(enabled, AspeedWDTState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const MemoryRegionOps aspeed_wdt_ops =3D {
+    .read =3D aspeed_wdt_read,
+    .write =3D aspeed_wdt_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .valid.unaligned =3D false,
+};
+
+static void aspeed_wdt_reset(DeviceState *dev)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(dev);
+
+    s->reg_status =3D 0x3EF1480;
+    s->reg_reload_value =3D 0x03EF1480;
+    s->reg_restart =3D 0;
+    s->reg_ctrl =3D 0;
+
+    s->enabled =3D false;
+    timer_del(s->timer);
+}
+
+static void aspeed_wdt_timer_expired(void *dev)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(dev);
+
+    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+    watchdog_perform_action();
+    timer_del(s->timer);
+}
+
+static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedWDTState *s =3D ASPEED_WDT(dev);
+
+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expir=
ed,
+                            dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_wdt_ops, s,
+                          TYPE_ASPEED_WDT, WDT_IO_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D aspeed_wdt_realize;
+    dc->reset =3D aspeed_wdt_reset;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->vmsd =3D &vmstate_aspeed_wdt;
+}
+
+static const TypeInfo aspeed_wdt_info =3D {
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .name  =3D TYPE_ASPEED_WDT,
+    .instance_size  =3D sizeof(AspeedWDTState),
+    .class_init =3D aspeed_wdt_class_init,
+};
+
+static void wdt_aspeed_register_types(void)
+{
+    watchdog_add_model(&model);
+    type_register_static(&aspeed_wdt_info);
+}
+
+type_init(wdt_aspeed_register_types)
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
new file mode 100644
index 000000000000..a11b687b6aff
--- /dev/null
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -0,0 +1,37 @@
+/*
+ * ASPEED Watchdog Controller
+ *
+ * Copyright (C) 2016-2017 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#ifndef ASPEED_WDT_H
+#define ASPEED_WDT_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_WDT "aspeed.wdt"
+#define ASPEED_WDT(obj) \
+    OBJECT_CHECK(AspeedWDTState, (obj), TYPE_ASPEED_WDT)
+#define ASPEED_WDT_CLASS(klass) \
+    OBJECT_CLASS_CHECK(AspeedWDTClass, (klass), TYPE_ASPEED_WDT)
+#define ASPEED_WDT_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(AspeedWDTClass, (obj), TYPE_ASPEED_WDT)
+
+typedef struct AspeedWDTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    QEMUTimer *timer;
+    bool enabled;
+
+    /*< public >*/
+    MemoryRegion iomem;
+
+    uint32_t reg_status;
+    uint32_t reg_reload_value;
+    uint32_t reg_restart;
+    uint32_t reg_ctrl;
+} AspeedWDTState;
+
+#endif  /* ASPEED_WDT_H */
--=20
2.7.4
