Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWnzl-0005hn-Mw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWnzh-0003jC-Kp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:38:01 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:49316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cWnzh-0003ha-BU
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:37:57 -0500
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D36349533C
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 18:37:55 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 26 Jan 2017 18:37:30 +0100
Message-Id: <1485452251-1593-2-git-send-email-clg@kaod.org>
In-Reply-To: <1485452251-1593-1-git-send-email-clg@kaod.org>
References: <1485452251-1593-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] wdt: Add Aspeed watchdog device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
      - wrote a commit log
      - merged fixes from Andrew Jeffery to scale the reload value ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:
  - added bits definitions
  - added a register array
  - fixed vmstate
  - added initial pclk support
  - added a reload routine
  - took ownership

 hw/watchdog/Makefile.objs        |   1 +
 hw/watchdog/wdt_aspeed.c         | 225 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/watchdog/wdt_aspeed.h |  32 ++++++
 3 files changed, 258 insertions(+)
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
index 000000000000..8bbe579b6b66
--- /dev/null
+++ b/hw/watchdog/wdt_aspeed.c
@@ -0,0 +1,225 @@
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
+#define WDT_STATUS              (0x00 / 4)
+#define WDT_RELOAD_VALUE        (0x04 / 4)
+#define WDT_RESTART             (0x08 / 4)
+#define WDT_CTRL                (0x0C / 4)
+#define   WDT_CTRL_RESET_MODE_SOC       (0x00 << 5)
+#define   WDT_CTRL_RESET_MODE_FULL_CHIP (0x01 << 5)
+#define   WDT_CTRL_1MHZ_CLK             BIT(4)
+#define   WDT_CTRL_WDT_EXT              BIT(3)
+#define   WDT_CTRL_WDT_INTR             BIT(2)
+#define   WDT_CTRL_RESET_SYSTEM         BIT(1)
+#define   WDT_CTRL_ENABLE               BIT(0)
+
+#define WDT_TIMEOUT_STATUS      (0x10 / 4)
+#define WDT_TIMEOUT_CLEAR       (0x14 / 4)
+#define WDT_RESET_WDITH         (0x18 / 4)
+
+#define WDT_RESTART_MAGIC       0x4755
+
+static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
+{
+    return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
+}
+
+static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned si=
ze)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(opaque);
+
+    offset >>=3D 2;
+
+    switch (offset) {
+    case WDT_STATUS:
+        return s->regs[WDT_STATUS];
+    case WDT_RELOAD_VALUE:
+        return s->regs[WDT_RELOAD_VALUE];
+    case WDT_RESTART:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from write-only reg at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, offset);
+        return 0;
+    case WDT_CTRL:
+        return s->regs[WDT_CTRL];
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
+static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
+{
+    uint32_t reload;
+
+    if (pclk) {
+        reload =3D muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_S=
ECOND,
+                          s->pclk_freq);
+    } else {
+        reload =3D s->regs[WDT_RELOAD_VALUE] * 1000;
+    }
+
+    if (aspeed_wdt_is_enabled(s)) {
+        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + relo=
ad);
+    }
+}
+
+static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size)
+{
+    AspeedWDTState *s =3D ASPEED_WDT(opaque);
+    bool enable =3D data & WDT_CTRL_ENABLE;
+
+    offset >>=3D 2;
+
+    switch (offset) {
+    case WDT_STATUS:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only reg at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, offset);
+        break;
+    case WDT_RELOAD_VALUE:
+        s->regs[WDT_RELOAD_VALUE] =3D data;
+        break;
+    case WDT_RESTART:
+        if ((data & 0xFFFF) =3D=3D WDT_RESTART_MAGIC) {
+            s->regs[WDT_STATUS] =3D s->regs[WDT_RELOAD_VALUE];
+            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+        }
+        break;
+    case WDT_CTRL:
+        if (enable && !aspeed_wdt_is_enabled(s)) {
+            s->regs[WDT_CTRL] =3D data;
+            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+        } else if (!enable && aspeed_wdt_is_enabled(s)) {
+            s->regs[WDT_CTRL] =3D data;
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
+    .wdt_description =3D "Aspeed watchdog device",
+};
+
+static const VMStateDescription vmstate_aspeed_wdt =3D {
+    .name =3D "vmstate_aspeed_wdt",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, AspeedWDTState),
+        VMSTATE_UINT32_ARRAY(regs, AspeedWDTState, ASPEED_WDT_REGS_MAX),
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
+    s->regs[WDT_STATUS] =3D 0x3EF1480;
+    s->regs[WDT_RELOAD_VALUE] =3D 0x03EF1480;
+    s->regs[WDT_RESTART] =3D 0;
+    s->regs[WDT_CTRL] =3D 0;
+
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
+#define PCLK_HZ 24000000
+
+static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedWDTState *s =3D ASPEED_WDT(dev);
+
+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expir=
ed, dev);
+
+    /* FIXME: This setting should be derived from the SCU hw strapping
+     * register SCU70
+     */
+    s->pclk_freq =3D PCLK_HZ;
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_wdt_ops, s,
+                          TYPE_ASPEED_WDT, ASPEED_WDT_REGS_MAX * 4);
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
index 000000000000..080c2231222e
--- /dev/null
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -0,0 +1,32 @@
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
+
+#define ASPEED_WDT_REGS_MAX        (0x20 / 4)
+
+typedef struct AspeedWDTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    QEMUTimer *timer;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t regs[ASPEED_WDT_REGS_MAX];
+
+    uint32_t pclk_freq;
+} AspeedWDTState;
+
+#endif  /* ASPEED_WDT_H */
--=20
2.7.4
