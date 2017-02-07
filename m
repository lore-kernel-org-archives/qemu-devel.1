Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAeA-0007gl-I6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe8-0002oo-Pq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe8-0002gg-H7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdr-0005Rx-9D
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:14 +0000
Message-Id: <1486492645-27803-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/13] wdt: Add Aspeed watchdog device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

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
Message-id: 1485452251-1593-2-git-send-email-clg@kaod.org
[clg: - fixed compile breakage
      - fixed io region size
      - added watchdog_perform_action() on timer expiry
      - wrote a commit log
      - merged fixes from Andrew Jeffery to scale the reload value ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/Makefile.objs        |   1 +
 include/hw/watchdog/wdt_aspeed.h |  32 ++++++
 hw/watchdog/wdt_aspeed.c         | 225 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 include/hw/watchdog/wdt_aspeed.h
 create mode 100644 hw/watchdog/wdt_aspeed.c

diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 72e3ffd..9589bed 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -2,3 +2,4 @@ common-obj-y += watchdog.o
 common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
+common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
new file mode 100644
index 0000000..080c223
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
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
new file mode 100644
index 0000000..8bbe579
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
+static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedWDTState *s = ASPEED_WDT(opaque);
+
+    offset >>= 2;
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
+                      "%s: uninmplemented read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
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
+        reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
+                          s->pclk_freq);
+    } else {
+        reload = s->regs[WDT_RELOAD_VALUE] * 1000;
+    }
+
+    if (aspeed_wdt_is_enabled(s)) {
+        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + reload);
+    }
+}
+
+static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size)
+{
+    AspeedWDTState *s = ASPEED_WDT(opaque);
+    bool enable = data & WDT_CTRL_ENABLE;
+
+    offset >>= 2;
+
+    switch (offset) {
+    case WDT_STATUS:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only reg at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, offset);
+        break;
+    case WDT_RELOAD_VALUE:
+        s->regs[WDT_RELOAD_VALUE] = data;
+        break;
+    case WDT_RESTART:
+        if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
+            s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
+            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+        }
+        break;
+    case WDT_CTRL:
+        if (enable && !aspeed_wdt_is_enabled(s)) {
+            s->regs[WDT_CTRL] = data;
+            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+        } else if (!enable && aspeed_wdt_is_enabled(s)) {
+            s->regs[WDT_CTRL] = data;
+            timer_del(s->timer);
+        }
+        break;
+    case WDT_TIMEOUT_STATUS:
+    case WDT_TIMEOUT_CLEAR:
+    case WDT_RESET_WDITH:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: uninmplemented write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+    return;
+}
+
+static WatchdogTimerModel model = {
+    .wdt_name = TYPE_ASPEED_WDT,
+    .wdt_description = "Aspeed watchdog device",
+};
+
+static const VMStateDescription vmstate_aspeed_wdt = {
+    .name = "vmstate_aspeed_wdt",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, AspeedWDTState),
+        VMSTATE_UINT32_ARRAY(regs, AspeedWDTState, ASPEED_WDT_REGS_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const MemoryRegionOps aspeed_wdt_ops = {
+    .read = aspeed_wdt_read,
+    .write = aspeed_wdt_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void aspeed_wdt_reset(DeviceState *dev)
+{
+    AspeedWDTState *s = ASPEED_WDT(dev);
+
+    s->regs[WDT_STATUS] = 0x3EF1480;
+    s->regs[WDT_RELOAD_VALUE] = 0x03EF1480;
+    s->regs[WDT_RESTART] = 0;
+    s->regs[WDT_CTRL] = 0;
+
+    timer_del(s->timer);
+}
+
+static void aspeed_wdt_timer_expired(void *dev)
+{
+    AspeedWDTState *s = ASPEED_WDT(dev);
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
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedWDTState *s = ASPEED_WDT(dev);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expired, dev);
+
+    /* FIXME: This setting should be derived from the SCU hw strapping
+     * register SCU70
+     */
+    s->pclk_freq = PCLK_HZ;
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_wdt_ops, s,
+                          TYPE_ASPEED_WDT, ASPEED_WDT_REGS_MAX * 4);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_wdt_realize;
+    dc->reset = aspeed_wdt_reset;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->vmsd = &vmstate_aspeed_wdt;
+}
+
+static const TypeInfo aspeed_wdt_info = {
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .name  = TYPE_ASPEED_WDT,
+    .instance_size  = sizeof(AspeedWDTState),
+    .class_init = aspeed_wdt_class_init,
+};
+
+static void wdt_aspeed_register_types(void)
+{
+    watchdog_add_model(&model);
+    type_register_static(&aspeed_wdt_info);
+}
+
+type_init(wdt_aspeed_register_types)
-- 
2.7.4
