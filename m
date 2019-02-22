Received: from eggs.gnu.org ([209.51.188.92]:48166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michelheily@gmail.com>) id 1gxKVn-0004QO-AZ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 18:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michelheily@gmail.com>) id 1gxKVi-0007bp-OY
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 18:45:45 -0500
From: michelheily@gmail.com
Date: Sat, 23 Feb 2019 01:38:06 +0200
Message-Id: <1550878686-23934-1-git-send-email-michelheily@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/arm/stellaris: Implement watchdog timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michel Heily <michelheily@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:Stellaris" <qemu-arm@nongnu.org>

From: Michel Heily <michelheily@gmail.com>

Signed-off-by: Michel Heily <michelheily@gmail.com>
---
 hw/arm/stellaris.c | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 442529c..08baeb2 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -348,6 +348,241 @@ static void stellaris_gptm_init(Object *obj)
 }
 
 
+/* Hardware watchdog. */
+
+#define TYPE_STELLARIS_WDTIMER "stellaris-wdtimer"
+#define STELLARIS_WDTIMER(obj) \
+    OBJECT_CHECK(wdtimer_state, (obj), TYPE_STELLARIS_WDTIMER)
+
+typedef struct wdtimer_state {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t control;
+    uint32_t load;
+    uint32_t tick;
+    uint32_t state;
+    uint32_t mask;
+    uint32_t stage;
+    bool locked;
+    bool reset;
+
+    struct wdtimer_state *opaque;
+    QEMUTimer *timer;
+    qemu_irq irq;
+} wdtimer_state;
+
+static void wdtimer_reset(wdtimer_state *s)
+{
+    s->load = 0xffffffff;
+    s->tick = 0xffffffff;
+    s->state = 0;
+    s->mask = 0;
+    s->locked = false;
+    s->reset = false;
+    s->stage = 1;
+}
+
+static void wdtimer_update_irq(wdtimer_state *s)
+{
+    int level;
+    level = (s->state & s->mask) != 0;
+    qemu_set_irq(s->irq, level);
+}
+
+
+static void wdtimer_reload(wdtimer_state *s, uint32_t stage)
+{
+    s->stage = stage;
+
+    uint64_t tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(s->timer, tick + s->load * system_clock_scale);
+}
+
+static void wdtimer_expired(void *opaque)
+{
+    wdtimer_state **p = (wdtimer_state **)opaque;
+    wdtimer_state *s;
+
+    s = *p;
+
+    if (s->mask & 1) {
+        s->state = 1; /* assert IRQ */
+        wdtimer_update_irq(s);
+    }
+
+    if (s->stage == 1) {
+        wdtimer_reload(s, 2);
+
+    } else if (s->stage == 2) {
+        if (s->reset && (s->state & s->mask) != 0) {
+            qemu_log_mask(CPU_LOG_RESET,
+                          "WDT: system reset on 2nd time-out\n");
+            wdtimer_reset(s);
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_PANIC);
+        } else {
+            wdtimer_reload(s, 1);
+        }
+    }
+}
+
+/* WDT offsets */
+#define WDT_O_LOAD              0x00000000
+#define WDT_O_VALUE             0x00000004
+#define WDT_O_CTL               0x00000008
+#define WDT_O_ICR               0x0000000C
+#define WDT_O_RIS               0x00000010
+#define WDT_O_MIS               0x00000014
+#define WDT_O_TEST              0x00000418
+#define WDT_O_LOCK              0x00000C00
+#define WDT_O_PeriphID4         0x00000FD0
+#define WDT_O_PeriphID5         0x00000FD4
+#define WDT_O_PeriphID6         0x00000FD8
+#define WDT_O_PeriphID7         0x00000FDC
+#define WDT_O_PeriphID0         0x00000FE0
+#define WDT_O_PeriphID1         0x00000FE4
+#define WDT_O_PeriphID2         0x00000FE8
+#define WDT_O_PeriphID3         0x00000FEC
+#define WDT_O_PCellID0          0x00000FF0
+#define WDT_O_PCellID1          0x00000FF4
+#define WDT_O_PCellID2          0x00000FF8
+#define WDT_O_PCellID3          0x00000FFC
+
+static uint64_t wdtimer_read(void *opaque, hwaddr offset,
+                          unsigned size)
+{
+    wdtimer_state *s = (wdtimer_state *)opaque;
+
+    switch (offset) {
+    case WDT_O_LOAD:
+        return s->load;
+    case WDT_O_VALUE:
+        return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    case WDT_O_CTL:
+        return s->control;
+    case WDT_O_RIS:
+        return s->state;
+    case WDT_O_MIS:
+        return s->state & s->mask;
+    case WDT_O_TEST:
+        qemu_log_mask(LOG_UNIMP,
+                      "WDT: stall not implemented\n");
+        return 0;
+    case WDT_O_LOCK:
+        return s->locked ? 1 : 0;
+    case WDT_O_PeriphID4: /* fallthrough */
+    case WDT_O_PeriphID5:
+    case WDT_O_PeriphID6:
+    case WDT_O_PeriphID7:
+    case WDT_O_PeriphID0:
+    case WDT_O_PeriphID1:
+    case WDT_O_PeriphID2:
+    case WDT_O_PeriphID3:
+        qemu_log_mask(LOG_UNIMP,
+                      "WDT: Peripheral identification not implemented\n");
+        return 0;
+    case WDT_O_PCellID0:
+    case WDT_O_PCellID1:
+    case WDT_O_PCellID2:
+    case WDT_O_PCellID3:
+        qemu_log_mask(LOG_UNIMP,
+                      "WDT: PrimieCell identification not implemented\n");
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "WDT: read at bad offset 0x02%" HWADDR_PRIx "\n",
+                      offset);
+        return 0;
+    }
+}
+
+static void wdtimer_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned size)
+{
+    wdtimer_state *s = (wdtimer_state *)opaque;
+
+    if (s->locked) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "WDT: write to watchdog registers in locked state\n");
+        wdtimer_update_irq(s);
+        return;
+    }
+
+    switch (offset) {
+    case WDT_O_LOAD:
+        s->load = value;
+        wdtimer_reload(s, 1);
+        break;
+    case WDT_O_CTL:
+        if (!(s->mask & 1)) {
+            if (value & 2) {
+                s->reset = true;
+            }
+            if (value & 1) {
+                s->mask = value;
+                wdtimer_reload(s, 1);
+            }
+        }
+        break;
+    case WDT_O_ICR:
+        /* clear the interrupt and reload the counter */
+        s->state &= ~value;
+        wdtimer_reload(s, 1);
+        break;
+    case WDT_O_TEST:
+        qemu_log_mask(LOG_UNIMP,
+                      "WDT: stall not implemented\n");
+        break;
+    case WDT_O_LOCK:
+        s->locked = value == 0x1acce551;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "WDT: write at bad offset 0x02%" HWADDR_PRIx "\n",
+                      offset);
+    }
+    wdtimer_update_irq(s);
+}
+
+static const MemoryRegionOps wdtimer_ops = {
+    .read = wdtimer_read,
+    .write = wdtimer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_stellaris_wdtimer = {
+    .name = "stellaris_wdtimer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, wdtimer_state),
+        VMSTATE_UINT32(load, wdtimer_state),
+        VMSTATE_UINT32(tick, wdtimer_state),
+        VMSTATE_UINT32(state, wdtimer_state),
+        VMSTATE_UINT32(mask, wdtimer_state),
+        VMSTATE_UINT32(stage, wdtimer_state),
+        VMSTATE_BOOL(locked, wdtimer_state),
+        VMSTATE_BOOL(reset, wdtimer_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stellaris_wdtimer_init(Object *obj)
+{
+    wdtimer_state *s = STELLARIS_WDTIMER(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    sysbus_init_irq(sbd, &s->irq);
+    memory_region_init_io(&s->iomem, obj, &wdtimer_ops, s,
+                          "wdtimer", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    s->opaque = s;
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, wdtimer_expired, &s->opaque);
+    wdtimer_reset(s);
+}
+
+
 /* System controller.  */
 
 typedef struct {
@@ -1243,7 +1478,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
      * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
      *
-     * 40000000 wdtimer (unimplemented)
+     * 40000000 wdtimer
      * 40002000 i2c (unimplemented)
      * 40004000 GPIO
      * 40005000 GPIO
@@ -1335,6 +1570,12 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
+    if (board->dc1 & (1  << 3)) { /* watchdog present */
+        dev  = sysbus_create_simple(TYPE_STELLARIS_WDTIMER,
+                                    0x40000000,
+                                    qdev_get_gpio_in(nvic, 18));
+    }
+
     stellaris_sys_init(0x400fe000, qdev_get_gpio_in(nvic, 28),
                        board, nd_table[0].macaddr.a);
 
@@ -1431,7 +1672,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* Add dummy regions for the devices we don't implement yet,
      * so guest accesses don't cause unlogged crashes.
      */
-    create_unimplemented_device("wdtimer", 0x40000000, 0x1000);
     create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
     create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
     create_unimplemented_device("PWM", 0x40028000, 0x1000);
@@ -1517,6 +1757,13 @@ static void stellaris_gptm_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_stellaris_gptm;
 }
 
+static void stellaris_wdtimer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_stellaris_wdtimer;
+}
+
 static const TypeInfo stellaris_gptm_info = {
     .name          = TYPE_STELLARIS_GPTM,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -1525,6 +1772,14 @@ static const TypeInfo stellaris_gptm_info = {
     .class_init    = stellaris_gptm_class_init,
 };
 
+static const TypeInfo stellaris_wdtimer_info = {
+    .name          = TYPE_STELLARIS_WDTIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(wdtimer_state),
+    .instance_init = stellaris_wdtimer_init,
+    .class_init    = stellaris_wdtimer_class_init,
+};
+
 static void stellaris_adc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1545,6 +1800,7 @@ static void stellaris_register_types(void)
     type_register_static(&stellaris_i2c_info);
     type_register_static(&stellaris_gptm_info);
     type_register_static(&stellaris_adc_info);
+    type_register_static(&stellaris_wdtimer_info);
 }
 
 type_init(stellaris_register_types)
-- 
2.7.4
