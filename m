Received: from eggs.gnu.org ([2001:4830:134:3::10]:38043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPIt-0003JK-Rj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPIn-0001hM-HO
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:56858 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fnPIn-0001en-5y
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:05 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id F0B23AE29
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 14:19:02 +0000 (UTC)
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed,  8 Aug 2018 16:17:00 +0200
Message-Id: <20180808141700.21333-5-jthumshirn@suse.de>
In-Reply-To: <20180808141700.21333-1-jthumshirn@suse.de>
References: <20180808141700.21333-1-jthumshirn@suse.de>
Subject: [Qemu-devel] [PATCH 4/4] wdt_z069: Add support for MEN 16z069
 Watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>

Add 16z069 Watchdog over MEN Chameleon BUS emulation.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 hw/watchdog/Makefile.objs |   1 +
 hw/watchdog/wdt_z069.c    | 212 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 hw/watchdog/wdt_z069.c

diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 9589bed63a3d..ada010f1eb69 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -3,3 +3,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
+common-obj-$(CONFIG_MCB) += wdt_z069.o
diff --git a/hw/watchdog/wdt_z069.c b/hw/watchdog/wdt_z069.c
new file mode 100644
index 000000000000..55e7614e83be
--- /dev/null
+++ b/hw/watchdog/wdt_z069.c
@@ -0,0 +1,212 @@
+/*
+ * QEMU MEN 16z069 Watchdog over MCB emulation
+ *
+ * Copyright (C) 2018 Johannes Thumshirn <jthumshirn@suse.de>
+ *
+ * This code is licensed under the GNU GPL v2 or (at your opinion) any
+ * later version
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "sysemu/watchdog.h"
+#include "hw/mcb/mcb.h"
+
+/* #define Z069_DEBUG 1 */
+
+#ifdef Z069_DEBUG
+#define z069_debug(fmt, ...)                                        \
+    fprintf(stderr, "wdt_z069: %s: "fmt, __func__, ##__VA_ARGS__)
+#else
+#define z069_debug(fmt, ...)
+#endif
+
+#define MEN_Z069_WTR 0x10
+#define MEN_Z069_WTR_WDEN BIT(15)
+#define MEN_Z069_WTR_WDET_MASK  0x7fff
+#define MEN_Z069_WVR 0x14
+
+#define CLK_500(x) ((x) * 2) /* 500Hz in ms */
+
+typedef struct {
+    MCBDevice dev;
+    QEMUTimer *timer;
+
+    bool enabled;
+    unsigned int timeout;
+
+    MemoryRegion mmio;
+
+    /* Registers */
+    uint16_t wtr;
+    uint16_t wvr;
+} MENZ069State;
+
+static void men_z069_wdt_enable(MENZ069State *s)
+{
+    z069_debug("next timeout will fire in +%dms\n", s->timeout);
+    timer_mod(s->timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->timeout);
+}
+
+static void men_z069_wdt_disable(MENZ069State *s)
+{
+    timer_del(s->timer);
+}
+
+static uint64_t men_z069_wdt_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MENZ069State *s = opaque;
+    uint64_t ret;
+
+    switch (addr) {
+    case MEN_Z069_WTR:
+        ret = s->wtr;
+        break;
+    case MEN_Z069_WVR:
+        ret = s->wvr;
+        break;
+    default:
+        ret = 0UL;
+        break;
+    }
+
+    z069_debug("returning: 0x%"PRIx64" @ 0x%lx\n", ret, addr);
+    return ret;
+}
+
+static void men_z069_wdt_write(void *opaque, hwaddr addr, uint64_t v,
+                               unsigned size)
+{
+    MENZ069State *s = opaque;
+    bool old_ena = s->enabled;
+    uint16_t val = v & 0xffff;
+    uint16_t tout;
+
+    z069_debug("got: 0x%"PRIx64" @ 0x%lx\n", v, addr);
+
+    switch (addr) {
+    case MEN_Z069_WTR:
+        s->wtr = val;
+        tout = val & MEN_Z069_WTR_WDET_MASK;
+        s->timeout = CLK_500(tout);
+        s->enabled = val & MEN_Z069_WTR_WDEN;
+        z069_debug("new timeout: %u (0x%x) %u\n", tout, tout, s->timeout);
+
+        if (old_ena && !s->enabled) {
+            men_z069_wdt_disable(s);
+        } else if (!old_ena && s->enabled) {
+            men_z069_wdt_enable(s);
+        }
+
+        break;
+    case MEN_Z069_WVR:
+        /* The watchdog trigger value toggles between 0x5555 and 0xaaaa */
+        if (val == (s->wvr ^ 0xffff)) {
+            s->wvr = val;
+            z069_debug("watchdog triggered, next timeout will fire in +%dms\n",
+                       s->timeout);
+            timer_mod(s->timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->timeout);
+        }
+        break;
+    default:
+        break;
+    }
+    return;
+}
+
+static const MemoryRegionOps men_z069_io_ops = {
+    .read = men_z069_wdt_read,
+    .write = men_z069_wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    },
+};
+
+static void men_z069_timer_expired(void *opaque)
+{
+    MENZ069State *s = opaque;
+
+    watchdog_perform_action();
+    timer_del(s->timer);
+}
+
+static void men_z069_wdt_realize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+    MENZ069State *s = DO_UPCAST(MENZ069State, dev, mdev);
+    MCBus *bus = MCB_BUS(qdev_get_parent_bus(DEVICE(dev)));
+
+    mdev->gdd = mcb_new_chameleon_descriptor(bus, 69, mdev->rev,
+                                             mdev->var, 0x18);
+    if (!mdev->gdd) {
+        return;
+    }
+
+    s->wvr = 0x5555;
+    s->wtr = 0x7fff;
+    s->timeout = CLK_500(s->wtr & MEN_Z069_WTR_WDET_MASK);
+    s->timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                            men_z069_timer_expired, s);
+
+    memory_region_init_io(&s->mmio, OBJECT(s),
+                          &men_z069_io_ops, s, "z069.wdt", 0x16);
+    memory_region_add_subregion(&bus->mmio_region, mdev->gdd->offset,
+                                &s->mmio);
+}
+
+static void men_z069_wdt_unrealize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+
+    g_free(&mdev->gdd);
+}
+
+static const VMStateDescription vmstate_z069_wdt = {
+    .name = "z069-wdt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_MCB_DEVICE(dev, MENZ069State),
+        VMSTATE_TIMER_PTR(timer, MENZ069State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property men_z069_wdt_properties[] = {
+    DEFINE_PROP_UINT8("rev", MENZ069State, dev.rev, 0),
+    DEFINE_PROP_UINT8("var", MENZ069State, dev.var, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void men_z069_wdt_class_intifn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MCBDeviceClass *mc = MCB_DEVICE_CLASS(klass);
+
+    mc->realize = men_z069_wdt_realize;
+    mc->unrealize = men_z069_wdt_unrealize;
+
+    dc->desc = "MEN 16z069 Watchdog Timer";
+    dc->vmsd = &vmstate_z069_wdt;
+    dc->props = men_z069_wdt_properties;
+}
+
+static const TypeInfo men_z069_wdt_info = {
+    .name = "z069-wdt",
+    .parent = TYPE_MCB_DEVICE,
+    .instance_size = sizeof(MENZ069State),
+    .class_init = men_z069_wdt_class_intifn,
+};
+
+static void men_z069_wdt_register_types(void)
+{
+    type_register_static(&men_z069_wdt_info);
+}
+
+type_init(men_z069_wdt_register_types);
-- 
2.16.4
