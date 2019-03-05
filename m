Received: from eggs.gnu.org ([209.51.188.92]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHm-0001m3-DI
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHk-0001AH-TA
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHk-00019A-I3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id r5so10242005wrg.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:51 +0000
Message-Id: <20190305165051.26860-23-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/22] hw/arm/stellaris: Implement watchdog timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michel Heily <michelheily@gmail.com>

Implement the watchdog timer for the stellaris boards.
This device is a close variant of the CMSDK APB watchdog
device, so we can model it by subclassing that device and
tweaking the behaviour of some of its registers.

Signed-off-by: Michel Heily <michelheily@gmail.com>
Reviewed-by: Peter Maydell <petser.maydell@linaro.org>
[PMM: rewrote commit message, fixed a few checkpatch nits,
 added comment giving the URL of the spec for the Stellaris
 variant of the watchdog device]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/cmsdk-apb-watchdog.h |  8 +++
 hw/arm/stellaris.c                       | 22 ++++++-
 hw/watchdog/cmsdk-apb-watchdog.c         | 74 +++++++++++++++++++++++-
 3 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
index ab8b5987a19..6ae9531370f 100644
--- a/include/hw/watchdog/cmsdk-apb-watchdog.h
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -38,6 +38,12 @@
 #define CMSDK_APB_WATCHDOG(obj) OBJECT_CHECK(CMSDKAPBWatchdog, (obj), \
                                               TYPE_CMSDK_APB_WATCHDOG)
 
+/*
+ * This shares the same struct (and cast macro) as the base
+ * cmsdk-apb-watchdog device.
+ */
+#define TYPE_LUMINARY_WATCHDOG "luminary-watchdog"
+
 typedef struct CMSDKAPBWatchdog {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -46,6 +52,7 @@ typedef struct CMSDKAPBWatchdog {
     MemoryRegion iomem;
     qemu_irq wdogint;
     uint32_t wdogclk_frq;
+    bool is_luminary;
     struct ptimer_state *timer;
 
     uint32_t control;
@@ -54,6 +61,7 @@ typedef struct CMSDKAPBWatchdog {
     uint32_t itcr;
     uint32_t itop;
     uint32_t resetstatus;
+    const uint32_t *id;
 } CMSDKAPBWatchdog;
 
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7b45fe3ccf8..05f86749f40 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -22,6 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
 
@@ -1243,7 +1244,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
      * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
      *
-     * 40000000 wdtimer (unimplemented)
+     * 40000000 wdtimer
      * 40002000 i2c (unimplemented)
      * 40004000 GPIO
      * 40005000 GPIO
@@ -1338,6 +1339,24 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     stellaris_sys_init(0x400fe000, qdev_get_gpio_in(nvic, 28),
                        board, nd_table[0].macaddr.a);
 
+
+    if (board->dc1 & (1 << 3)) { /* watchdog present */
+        dev = qdev_create(NULL, TYPE_LUMINARY_WATCHDOG);
+
+        /* system_clock_scale is valid now */
+        uint32_t mainclk = NANOSECONDS_PER_SECOND / system_clock_scale;
+        qdev_prop_set_uint32(dev, "wdogclk-frq", mainclk);
+
+        qdev_init_nofail(dev);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev),
+                        0,
+                        0x40000000u);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev),
+                           0,
+                           qdev_get_gpio_in(nvic, 18));
+    }
+
+
     for (i = 0; i < 7; i++) {
         if (board->dc4 & (1 << i)) {
             gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
@@ -1431,7 +1450,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("wdtimer", 0x40000000, 0x1000);
     create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
     create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index eb79a73fa6c..9c865bce678 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -14,6 +14,10 @@
  * System Design Kit (CMSDK) and documented in the Cortex-M System
  * Design Kit Technical Reference Manual (ARM DDI0479C):
  * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ *
+ * We also support the variant of this device found in the TI
+ * Stellaris/Luminary boards and documented in:
+ * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
  */
 
 #include "qemu/osdep.h"
@@ -37,6 +41,7 @@ REG32(WDOGINTCLR, 0xc)
 REG32(WDOGRIS, 0x10)
     FIELD(WDOGRIS, INT, 0, 1)
 REG32(WDOGMIS, 0x14)
+REG32(WDOGTEST, 0x418) /* only in Stellaris/Luminary version of the device */
 REG32(WDOGLOCK, 0xc00)
 #define WDOG_UNLOCK_VALUE 0x1ACCE551
 REG32(WDOGITCR, 0xf00)
@@ -61,12 +66,18 @@ REG32(CID2, 0xff8)
 REG32(CID3, 0xffc)
 
 /* PID/CID values */
-static const int watchdog_id[] = {
+static const uint32_t cmsdk_apb_watchdog_id[] = {
     0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
     0x24, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const uint32_t luminary_watchdog_id[] = {
+    0x00, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x05, 0x18, 0x18, 0x01, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 static bool cmsdk_apb_watchdog_intstatus(CMSDKAPBWatchdog *s)
 {
     /* Return masked interrupt status */
@@ -85,6 +96,10 @@ static void cmsdk_apb_watchdog_update(CMSDKAPBWatchdog *s)
     bool wdogres;
 
     if (s->itcr) {
+        /*
+         * Not checking that !s->is_luminary since s->itcr can't be written
+         * when s->is_luminary in the first place.
+         */
         wdogint = s->itop & R_WDOGITOP_WDOGINT_MASK;
         wdogres = s->itop & R_WDOGITOP_WDOGRES_MASK;
     } else {
@@ -124,19 +139,34 @@ static uint64_t cmsdk_apb_watchdog_read(void *opaque, hwaddr offset,
         r = s->lock;
         break;
     case A_WDOGITCR:
+        if (s->is_luminary) {
+            goto bad_offset;
+        }
         r = s->itcr;
         break;
     case A_PID4 ... A_CID3:
-        r = watchdog_id[(offset - A_PID4) / 4];
+        r = s->id[(offset - A_PID4) / 4];
         break;
     case A_WDOGINTCLR:
     case A_WDOGITOP:
+        if (s->is_luminary) {
+            goto bad_offset;
+        }
         qemu_log_mask(LOG_GUEST_ERROR,
                       "CMSDK APB watchdog read: read of WO offset %x\n",
                       (int)offset);
         r = 0;
         break;
+    case A_WDOGTEST:
+        if (!s->is_luminary) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "Luminary watchdog read: stall not implemented\n");
+        r = 0;
+        break;
     default:
+bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "CMSDK APB watchdog read: bad offset %x\n", (int)offset);
         r = 0;
@@ -170,6 +200,14 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
         ptimer_run(s->timer, 0);
         break;
     case A_WDOGCONTROL:
+        if (s->is_luminary && 0 != (R_WDOGCONTROL_INTEN_MASK & s->control)) {
+            /*
+             * The Luminary version of this device ignores writes to
+             * this register after the guest has enabled interrupts
+             * (so they can only be disabled again via reset).
+             */
+            break;
+        }
         s->control = value & R_WDOGCONTROL_VALID_MASK;
         cmsdk_apb_watchdog_update(s);
         break;
@@ -182,10 +220,16 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
         s->lock = (value != WDOG_UNLOCK_VALUE);
         break;
     case A_WDOGITCR:
+        if (s->is_luminary) {
+            goto bad_offset;
+        }
         s->itcr = value & R_WDOGITCR_VALID_MASK;
         cmsdk_apb_watchdog_update(s);
         break;
     case A_WDOGITOP:
+        if (s->is_luminary) {
+            goto bad_offset;
+        }
         s->itop = value & R_WDOGITOP_VALID_MASK;
         cmsdk_apb_watchdog_update(s);
         break;
@@ -197,7 +241,15 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
                       "CMSDK APB watchdog write: write to RO offset 0x%x\n",
                       (int)offset);
         break;
+    case A_WDOGTEST:
+        if (!s->is_luminary) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "Luminary watchdog write: stall not implemented\n");
+        break;
     default:
+bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "CMSDK APB watchdog write: bad offset 0x%x\n",
                       (int)offset);
@@ -256,6 +308,9 @@ static void cmsdk_apb_watchdog_init(Object *obj)
                           s, "cmsdk-apb-watchdog", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->wdogint);
+
+    s->is_luminary = false;
+    s->id = cmsdk_apb_watchdog_id;
 }
 
 static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
@@ -318,9 +373,24 @@ static const TypeInfo cmsdk_apb_watchdog_info = {
     .class_init = cmsdk_apb_watchdog_class_init,
 };
 
+static void luminary_watchdog_init(Object *obj)
+{
+    CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(obj);
+
+    s->is_luminary = true;
+    s->id = luminary_watchdog_id;
+}
+
+static const TypeInfo luminary_watchdog_info = {
+    .name = TYPE_LUMINARY_WATCHDOG,
+    .parent = TYPE_CMSDK_APB_WATCHDOG,
+    .instance_init = luminary_watchdog_init
+};
+
 static void cmsdk_apb_watchdog_register_types(void)
 {
     type_register_static(&cmsdk_apb_watchdog_info);
+    type_register_static(&luminary_watchdog_info);
 }
 
 type_init(cmsdk_apb_watchdog_register_types);
-- 
2.20.1
