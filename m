Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEh-0005VG-O5
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEX-00040A-R8
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:07 +1000
Message-Id: <20180618035324.19907-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/28] mac_newworld: add PMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The PMU device supercedes the CUDA device found on older New World Macs and
is supported by a larger number of guest OSs from OS 9 to OS X 10.5.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/macio/Makefile.objs     |   1 +
 hw/misc/macio/macio.c           |  69 ++-
 hw/misc/macio/pmu.c             | 871 ++++++++++++++++++++++++++++++++
 hw/misc/macio/trace-events      |  21 +
 hw/ppc/mac.h                    |   1 +
 hw/ppc/mac_newworld.c           |  10 +-
 include/hw/misc/macio/macio.h   |   2 +
 include/hw/misc/macio/pmu.h     | 237 +++++++++
 9 files changed, 1193 insertions(+), 20 deletions(-)
 create mode 100644 hw/misc/macio/pmu.c
 create mode 100644 include/hw/misc/macio/pmu.h

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 38197e39eb..abeeb0418a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -38,6 +38,7 @@ CONFIG_CUDA=y
 CONFIG_ADB=y
 CONFIG_MAC_NVRAM=y
 CONFIG_MAC_DBDMA=y
+CONFIG_MAC_PMU=y
 CONFIG_HEATHROW_PIC=y
 CONFIG_GRACKLE_PCI=y
 CONFIG_UNIN_PCI=y
diff --git a/hw/misc/macio/Makefile.objs b/hw/misc/macio/Makefile.objs
index fb9dbf91b5..07fdb320d4 100644
--- a/hw/misc/macio/Makefile.objs
+++ b/hw/misc/macio/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y += macio.o
 common-obj-$(CONFIG_CUDA) += cuda.o
+common-obj-$(CONFIG_MAC_PMU) += pmu.o
 common-obj-$(CONFIG_MAC_DBDMA) += mac_dbdma.o
 common-obj-$(CONFIG_MACIO_GPIO) += gpio.o
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 8dfcbc3d9b..d135e3bc2b 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -105,17 +105,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&s->bar, 0x08000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
-    qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
-                         s->frequency);
-    object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
-    memory_region_add_subregion(&s->bar, 0x16000,
-                                sysbus_mmio_get_region(sysbus_dev, 0));
-
     qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
     qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
@@ -163,7 +152,16 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
         return;
     }
 
+    qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
+                         s->frequency);
+    object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
+    memory_region_add_subregion(&s->bar, 0x16000,
+                                sysbus_mmio_get_region(sysbus_dev, 0));
     sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_CUDA_IRQ));
 
@@ -234,6 +232,10 @@ static void macio_oldworld_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
+    object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
+    qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
+    object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
+
     object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
     dev = DEVICE(&os->nvram);
     qdev_prop_set_uint32(dev, "size", 0x2000);
@@ -293,10 +295,6 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         return;
     }
 
-    sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
-    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
-                                                       NEWWORLD_CUDA_IRQ));
-
     sysbus_dev = SYS_BUS_DEVICE(&s->escc);
     sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
                                                        NEWWORLD_ESCCB_IRQ));
@@ -341,6 +339,43 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
         object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+
+        /* PMU */
+        object_initialize(&s->pmu, sizeof(s->pmu), TYPE_VIA_PMU);
+        object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
+                                 &error_abort);
+        qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
+        qdev_set_parent_bus(DEVICE(&s->pmu), sysbus_get_default());
+        object_property_add_child(OBJECT(s), "pmu", OBJECT(&s->pmu), NULL);
+
+        object_property_set_bool(OBJECT(&s->pmu), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_dev = SYS_BUS_DEVICE(&s->pmu);
+        sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                           NEWWORLD_PMU_IRQ));
+        memory_region_add_subregion(&s->bar, 0x16000,
+                                    sysbus_mmio_get_region(sysbus_dev, 0));
+    } else {
+        /* CUDA */
+        object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
+        qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
+        object_property_add_child(OBJECT(s), "cuda", OBJECT(&s->cuda), NULL);
+        qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
+                             s->frequency);
+
+        object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
+        sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
+                                                           NEWWORLD_CUDA_IRQ));
+        memory_region_add_subregion(&s->bar, 0x16000,
+                                    sysbus_mmio_get_region(sysbus_dev, 0));
     }
 }
 
@@ -369,10 +404,6 @@ static void macio_instance_init(Object *obj)
 
     memory_region_init(&s->bar, obj, "macio", 0x80000);
 
-    object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
-    qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
-    object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
-
     object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
     qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
     object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
new file mode 100644
index 0000000000..e246b0fd41
--- /dev/null
+++ b/hw/misc/macio/pmu.c
@@ -0,0 +1,871 @@
+/*
+ * QEMU PowerMac PMU device support
+ *
+ * Copyright (c) 2016 Benjamin Herrenschmidt, IBM Corp.
+ * Copyright (c) 2018 Mark Cave-Ayland
+ *
+ * Based on the CUDA device by:
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/ppc/mac.h"
+#include "hw/input/adb.h"
+#include "hw/misc/mos6522.h"
+#include "hw/misc/macio/gpio.h"
+#include "hw/misc/macio/pmu.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+
+/* Bits in B data register: all active low */
+#define TACK    0x08    /* Transfer request (input) */
+#define TREQ    0x10    /* Transfer acknowledge (output) */
+
+/* PMU returns time_t's offset from Jan 1, 1904, not 1970 */
+#define RTC_OFFSET                      2082844800
+
+#define VIA_TIMER_FREQ (4700000 / 6)
+
+static void via_update_irq(PMUState *s)
+{
+    MOS6522PMUState *mps = MOS6522_PMU(&s->mos6522_pmu);
+    MOS6522State *ms = MOS6522(mps);
+
+    bool new_state = !!(ms->ifr & ms->ier & (SR_INT | T1_INT | T2_INT));
+
+    if (new_state != s->via_irq_state) {
+        s->via_irq_state = new_state;
+        qemu_set_irq(s->via_irq, new_state);
+    }
+}
+
+static void via_set_sr_int(void *opaque)
+{
+    PMUState *s = opaque;
+    MOS6522PMUState *mps = MOS6522_PMU(&s->mos6522_pmu);
+    MOS6522State *ms = MOS6522(mps);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+
+    mdc->set_sr_int(ms);
+}
+
+static void pmu_update_extirq(PMUState *s)
+{
+    if ((s->intbits & s->intmask) != 0) {
+        macio_set_gpio(s->gpio, 1, false);
+    } else {
+        macio_set_gpio(s->gpio, 1, true);
+    }
+}
+
+static void pmu_adb_poll(void *opaque)
+{
+    PMUState *s = opaque;
+    int olen;
+
+    if (!(s->intbits & PMU_INT_ADB)) {
+        olen = adb_poll(&s->adb_bus, s->adb_reply, s->adb_poll_mask);
+        trace_pmu_adb_poll(olen);
+
+        if (olen > 0) {
+            s->adb_reply_size = olen;
+            s->intbits |= PMU_INT_ADB | PMU_INT_ADB_AUTO;
+            pmu_update_extirq(s);
+        }
+    }
+
+    timer_mod(s->adb_poll_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 30);
+}
+
+static void pmu_one_sec_timer(void *opaque)
+{
+    PMUState *s = opaque;
+
+    trace_pmu_one_sec_timer();
+
+    s->intbits |= PMU_INT_TICK;
+    pmu_update_extirq(s);
+    s->one_sec_target += 1000;
+
+    timer_mod(s->one_sec_timer, s->one_sec_target);
+}
+
+static void pmu_cmd_int_ack(PMUState *s,
+                            const uint8_t *in_data, uint8_t in_len,
+                            uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: INT_ACK command, invalid len: %d want: 0\n",
+                      in_len);
+        return;
+    }
+
+    /* Make appropriate reply packet */
+    if (s->intbits & PMU_INT_ADB) {
+        if (!s->adb_reply_size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Odd, PMU_INT_ADB set with no reply in buffer\n");
+        }
+
+        memcpy(out_data + 1, s->adb_reply, s->adb_reply_size);
+        out_data[0] = s->intbits & (PMU_INT_ADB | PMU_INT_ADB_AUTO);
+        *out_len = s->adb_reply_size + 1;
+        s->intbits &= ~(PMU_INT_ADB | PMU_INT_ADB_AUTO);
+        s->adb_reply_size = 0;
+    } else {
+        out_data[0] = s->intbits;
+        s->intbits = 0;
+        *out_len = 1;
+    }
+
+    pmu_update_extirq(s);
+}
+
+static void pmu_cmd_set_int_mask(PMUState *s,
+                                 const uint8_t *in_data, uint8_t in_len,
+                                 uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: SET_INT_MASK command, invalid len: %d want: 1\n",
+                      in_len);
+        return;
+    }
+
+    trace_pmu_cmd_set_int_mask(s->intmask);
+    s->intmask = in_data[0];
+
+    pmu_update_extirq(s);
+}
+
+static void pmu_cmd_set_adb_autopoll(PMUState *s, uint16_t mask)
+{
+    trace_pmu_cmd_set_adb_autopoll(mask);
+
+    if (s->autopoll_mask == mask) {
+        return;
+    }
+
+    s->autopoll_mask = mask;
+    if (mask) {
+        timer_mod(s->adb_poll_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 30);
+    } else {
+        timer_del(s->adb_poll_timer);
+    }
+}
+
+static void pmu_cmd_adb(PMUState *s,
+                        const uint8_t *in_data, uint8_t in_len,
+                        uint8_t *out_data, uint8_t *out_len)
+{
+    int len, adblen;
+    uint8_t adb_cmd[255];
+
+    if (in_len < 2) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: ADB PACKET, invalid len: %d want at least 2\n",
+                      in_len);
+        return;
+    }
+
+    *out_len = 0;
+
+    if (!s->has_adb) {
+        trace_pmu_cmd_adb_nobus();
+        return;
+    }
+
+    /* Set autopoll is a special form of the command */
+    if (in_data[0] == 0 && in_data[1] == 0x86) {
+        uint16_t mask = in_data[2];
+        mask = (mask << 8) | in_data[3];
+        if (in_len != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "PMU: ADB Autopoll requires 4 bytes, got %d\n",
+                          in_len);
+            return;
+        }
+
+        pmu_cmd_set_adb_autopoll(s, mask);
+        return;
+    }
+
+    trace_pmu_cmd_adb_request(in_len, in_data[0], in_data[1], in_data[2],
+                              in_data[3], in_data[4]);
+
+    *out_len = 0;
+
+    /* Check ADB len */
+    adblen = in_data[2];
+    if (adblen > (in_len - 3)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: ADB len is %d > %d (in_len -3)...erroring\n",
+                      adblen, in_len - 3);
+        len = -1;
+    } else if (adblen > 252) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PMU: ADB command too big!\n");
+        len = -1;
+    } else {
+        /* Format command */
+        adb_cmd[0] = in_data[0];
+        memcpy(&adb_cmd[1], &in_data[3], in_len - 3);
+        len = adb_request(&s->adb_bus, s->adb_reply + 2, adb_cmd, in_len - 2);
+
+        trace_pmu_cmd_adb_reply(len);
+    }
+
+    if (len > 0) {
+        /* XXX Check this */
+        s->adb_reply_size = len + 2;
+        s->adb_reply[0] = 0x01;
+        s->adb_reply[1] = len;
+    } else {
+        /* XXX Check this */
+        s->adb_reply_size = 1;
+        s->adb_reply[0] = 0x00;
+    }
+
+    s->intbits |= PMU_INT_ADB;
+    pmu_update_extirq(s);
+}
+
+static void pmu_cmd_adb_poll_off(PMUState *s,
+                                 const uint8_t *in_data, uint8_t in_len,
+                                 uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: ADB POLL OFF command, invalid len: %d want: 0\n",
+                      in_len);
+        return;
+    }
+
+    if (s->has_adb && s->autopoll_mask) {
+        timer_del(s->adb_poll_timer);
+        s->autopoll_mask = false;
+    }
+}
+
+static void pmu_cmd_shutdown(PMUState *s,
+                             const uint8_t *in_data, uint8_t in_len,
+                             uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: SHUTDOWN command, invalid len: %d want: 4\n",
+                      in_len);
+        return;
+    }
+
+    *out_len = 1;
+    out_data[0] = 0;
+
+    if (in_data[0] != 'M' || in_data[1] != 'A' || in_data[2] != 'T' ||
+        in_data[3] != 'T') {
+
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: SHUTDOWN command, Bad MATT signature\n");
+        return;
+    }
+
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
+static void pmu_cmd_reset(PMUState *s,
+                          const uint8_t *in_data, uint8_t in_len,
+                          uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: RESET command, invalid len: %d want: 0\n",
+                      in_len);
+        return;
+    }
+
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void pmu_cmd_get_rtc(PMUState *s,
+                            const uint8_t *in_data, uint8_t in_len,
+                            uint8_t *out_data, uint8_t *out_len)
+{
+    uint32_t ti;
+
+    if (in_len != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: GET_RTC command, invalid len: %d want: 0\n",
+                      in_len);
+        return;
+    }
+
+    ti = s->tick_offset + (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                           / NANOSECONDS_PER_SECOND);
+    out_data[0] = ti >> 24;
+    out_data[1] = ti >> 16;
+    out_data[2] = ti >> 8;
+    out_data[3] = ti;
+    *out_len = 4;
+}
+
+static void pmu_cmd_set_rtc(PMUState *s,
+                            const uint8_t *in_data, uint8_t in_len,
+                            uint8_t *out_data, uint8_t *out_len)
+{
+    uint32_t ti;
+
+    if (in_len != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: SET_RTC command, invalid len: %d want: 4\n",
+                      in_len);
+        return;
+    }
+
+    ti = (((uint32_t)in_data[0]) << 24) + (((uint32_t)in_data[1]) << 16)
+         + (((uint32_t)in_data[2]) << 8) + in_data[3];
+
+    s->tick_offset = ti - (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                           / NANOSECONDS_PER_SECOND);
+}
+
+static void pmu_cmd_system_ready(PMUState *s,
+                                 const uint8_t *in_data, uint8_t in_len,
+                                 uint8_t *out_data, uint8_t *out_len)
+{
+    /* Do nothing */
+}
+
+static void pmu_cmd_get_version(PMUState *s,
+                                const uint8_t *in_data, uint8_t in_len,
+                                uint8_t *out_data, uint8_t *out_len)
+{
+    *out_len = 1;
+    *out_data = 1; /* ??? Check what Apple does */
+}
+
+static void pmu_cmd_power_events(PMUState *s,
+                                 const uint8_t *in_data, uint8_t in_len,
+                                 uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len < 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: POWER EVENTS command, invalid len %d, want at least 1\n",
+                      in_len);
+        return;
+    }
+
+    switch (in_data[0]) {
+    /* Dummies for now */
+    case PMU_PWR_GET_POWERUP_EVENTS:
+        *out_len = 2;
+        out_data[0] = 0;
+        out_data[1] = 0;
+        break;
+    case PMU_PWR_SET_POWERUP_EVENTS:
+    case PMU_PWR_CLR_POWERUP_EVENTS:
+        break;
+    case PMU_PWR_GET_WAKEUP_EVENTS:
+        *out_len = 2;
+        out_data[0] = 0;
+        out_data[1] = 0;
+        break;
+    case PMU_PWR_SET_WAKEUP_EVENTS:
+    case PMU_PWR_CLR_WAKEUP_EVENTS:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: POWER EVENTS unknown subcommand 0x%02x\n",
+                      in_data[0]);
+    }
+}
+
+static void pmu_cmd_get_cover(PMUState *s,
+                              const uint8_t *in_data, uint8_t in_len,
+                              uint8_t *out_data, uint8_t *out_len)
+{
+    /* Not 100% sure here, will have to check what a real Mac
+     * returns other than byte 0 bit 0 is LID closed on laptops
+     */
+    *out_len = 1;
+    *out_data = 0x00;
+}
+
+static void pmu_cmd_download_status(PMUState *s,
+                                    const uint8_t *in_data, uint8_t in_len,
+                                    uint8_t *out_data, uint8_t *out_len)
+{
+    /* This has to do with PMU firmware updates as far as I can tell.
+     *
+     * We return 0x62 which is what OpenPMU expects
+     */
+    *out_len = 1;
+    *out_data = 0x62;
+}
+
+static void pmu_cmd_read_pmu_ram(PMUState *s,
+                                 const uint8_t *in_data, uint8_t in_len,
+                                 uint8_t *out_data, uint8_t *out_len)
+{
+    if (in_len < 3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "PMU: READ_PMU_RAM command, invalid len %d, expected 3\n",
+                      in_len);
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "PMU: Unsupported READ_PMU_RAM, args: %02x %02x %02x\n",
+                  in_data[0], in_data[1], in_data[2]);
+
+    *out_len = 0;
+}
+
+/* description of commands */
+typedef struct PMUCmdHandler {
+    uint8_t command;
+    const char *name;
+    void (*handler)(PMUState *s,
+                    const uint8_t *in_args, uint8_t in_len,
+                    uint8_t *out_args, uint8_t *out_len);
+} PMUCmdHandler;
+
+static const PMUCmdHandler PMUCmdHandlers[] = {
+    { PMU_INT_ACK, "INT ACK", pmu_cmd_int_ack },
+    { PMU_SET_INTR_MASK, "SET INT MASK", pmu_cmd_set_int_mask },
+    { PMU_ADB_CMD, "ADB COMMAND", pmu_cmd_adb },
+    { PMU_ADB_POLL_OFF, "ADB POLL OFF", pmu_cmd_adb_poll_off },
+    { PMU_RESET, "REBOOT", pmu_cmd_reset },
+    { PMU_SHUTDOWN, "SHUTDOWN", pmu_cmd_shutdown },
+    { PMU_READ_RTC, "GET RTC", pmu_cmd_get_rtc },
+    { PMU_SET_RTC, "SET RTC", pmu_cmd_set_rtc },
+    { PMU_SYSTEM_READY, "SYSTEM READY", pmu_cmd_system_ready },
+    { PMU_GET_VERSION, "GET VERSION", pmu_cmd_get_version },
+    { PMU_POWER_EVENTS, "POWER EVENTS", pmu_cmd_power_events },
+    { PMU_GET_COVER, "GET_COVER", pmu_cmd_get_cover },
+    { PMU_DOWNLOAD_STATUS, "DOWNLOAD STATUS", pmu_cmd_download_status },
+    { PMU_READ_PMU_RAM, "READ PMGR RAM", pmu_cmd_read_pmu_ram },
+};
+
+static void pmu_dispatch_cmd(PMUState *s)
+{
+    unsigned int i;
+
+    /* No response by default */
+    s->cmd_rsp_sz = 0;
+
+    for (i = 0; i < ARRAY_SIZE(PMUCmdHandlers); i++) {
+        const PMUCmdHandler *desc = &PMUCmdHandlers[i];
+
+        if (desc->command != s->cmd) {
+            continue;
+        }
+
+        trace_pmu_dispatch_cmd(desc->name);
+        desc->handler(s, s->cmd_buf, s->cmd_buf_pos,
+                      s->cmd_rsp, &s->cmd_rsp_sz);
+
+        if (s->rsplen != -1 && s->rsplen != s->cmd_rsp_sz) {
+            trace_pmu_debug_protocol_string("QEMU internal cmd resp mismatch!");
+        } else {
+            trace_pmu_debug_protocol_resp_size(s->cmd_rsp_sz);
+        }
+
+        return;
+    }
+
+    trace_pmu_dispatch_unknown_cmd(s->cmd);
+
+    /* Manufacture fake response with 0's */
+    if (s->rsplen == -1) {
+        s->cmd_rsp_sz = 0;
+    } else {
+        s->cmd_rsp_sz = s->rsplen;
+        memset(s->cmd_rsp, 0, s->rsplen);
+    }
+}
+
+static void pmu_update(PMUState *s)
+{
+    MOS6522PMUState *mps = &s->mos6522_pmu;
+    MOS6522State *ms = MOS6522(mps);
+
+    /* Only react to changes in reg B */
+    if (ms->b == s->last_b) {
+        return;
+    }
+    s->last_b = ms->b;
+
+    /* Check the TREQ / TACK state */
+    switch (ms->b & (TREQ | TACK)) {
+    case TREQ:
+        /* This is an ack release, handle it and bail out */
+        ms->b |= TACK;
+        s->last_b = ms->b;
+
+        trace_pmu_debug_protocol_string("handshake: TREQ high, setting TACK");
+        return;
+    case TACK:
+        /* This is a valid request, handle below */
+        break;
+    case TREQ | TACK:
+        /* This is an idle state */
+        return;
+    default:
+        /* Invalid state, log and ignore */
+        trace_pmu_debug_protocol_error(ms->b);
+        return;
+    }
+
+    /* If we wanted to handle commands asynchronously, this is where
+     * we would delay the clearing of TACK until we are ready to send
+     * the response
+     */
+
+    /* We have a request, handshake TACK so we don't stay in
+     * an invalid state. If we were concurrent with the OS we
+     * should only do this after we grabbed the SR but that isn't
+     * a problem here.
+     */
+
+    trace_pmu_debug_protocol_clear_treq(s->cmd_state);
+
+    ms->b &= ~TACK;
+    s->last_b = ms->b;
+
+    /* Act according to state */
+    switch (s->cmd_state) {
+    case pmu_state_idle:
+        if (!(ms->acr & SR_OUT)) {
+            trace_pmu_debug_protocol_string("protocol error! "
+                                            "state idle, ACR reading");
+            break;
+        }
+
+        s->cmd = ms->sr;
+        via_set_sr_int(s);
+        s->cmdlen = pmu_data_len[s->cmd][0];
+        s->rsplen = pmu_data_len[s->cmd][1];
+        s->cmd_buf_pos = 0;
+        s->cmd_rsp_pos = 0;
+        s->cmd_state = pmu_state_cmd;
+
+        trace_pmu_debug_protocol_cmd(s->cmd, s->cmdlen, s->rsplen);
+        break;
+
+    case pmu_state_cmd:
+        if (!(ms->acr & SR_OUT)) {
+            trace_pmu_debug_protocol_string("protocol error! "
+                                            "state cmd, ACR reading");
+            break;
+        }
+
+        if (s->cmdlen == -1) {
+            trace_pmu_debug_protocol_cmdlen(ms->sr);
+
+            s->cmdlen = ms->sr;
+            if (s->cmdlen > sizeof(s->cmd_buf)) {
+                trace_pmu_debug_protocol_cmd_toobig(s->cmdlen);
+            }
+        } else if (s->cmd_buf_pos < sizeof(s->cmd_buf)) {
+            s->cmd_buf[s->cmd_buf_pos++] = ms->sr;
+        }
+
+        via_set_sr_int(s);
+        break;
+
+    case pmu_state_rsp:
+        if (ms->acr & SR_OUT) {
+            trace_pmu_debug_protocol_string("protocol error! "
+                                            "state resp, ACR writing");
+            break;
+        }
+
+        if (s->rsplen == -1) {
+            trace_pmu_debug_protocol_cmd_send_resp_size(s->cmd_rsp_sz);
+
+            ms->sr = s->cmd_rsp_sz;
+            s->rsplen = s->cmd_rsp_sz;
+        } else if (s->cmd_rsp_pos < s->cmd_rsp_sz) {
+            trace_pmu_debug_protocol_cmd_send_resp(s->cmd_rsp_pos, s->rsplen);
+
+            ms->sr = s->cmd_rsp[s->cmd_rsp_pos++];
+        }
+
+        via_set_sr_int(s);
+        break;
+    }
+
+    /* Check for state completion */
+    if (s->cmd_state == pmu_state_cmd && s->cmdlen == s->cmd_buf_pos) {
+        trace_pmu_debug_protocol_string("Command reception complete, "
+                                        "dispatching...");
+
+        pmu_dispatch_cmd(s);
+        s->cmd_state = pmu_state_rsp;
+    }
+
+    if (s->cmd_state == pmu_state_rsp && s->rsplen == s->cmd_rsp_pos) {
+        trace_pmu_debug_protocol_cmd_resp_complete(ms->ier);
+
+        s->cmd_state = pmu_state_idle;
+    }
+}
+
+static uint64_t mos6522_pmu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PMUState *s = opaque;
+    MOS6522PMUState *mps = &s->mos6522_pmu;
+    MOS6522State *ms = MOS6522(mps);
+
+    addr = (addr >> 9) & 0xf;
+    return mos6522_read(ms, addr, size);
+}
+
+static void mos6522_pmu_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    PMUState *s = opaque;
+    MOS6522PMUState *mps = &s->mos6522_pmu;
+    MOS6522State *ms = MOS6522(mps);
+
+    addr = (addr >> 9) & 0xf;
+    mos6522_write(ms, addr, val, size);
+}
+
+static const MemoryRegionOps mos6522_pmu_ops = {
+    .read = mos6522_pmu_read,
+    .write = mos6522_pmu_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static bool pmu_adb_state_needed(void *opaque)
+{
+    PMUState *s = opaque;
+
+    return s->has_adb;
+}
+
+static const VMStateDescription vmstate_pmu_adb = {
+    .name = "pmu/adb",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = pmu_adb_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(adb_poll_mask, PMUState),
+        VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
+        VMSTATE_UINT8(adb_reply_size, PMUState),
+        VMSTATE_BUFFER(adb_reply, PMUState),
+    }
+};
+
+static const VMStateDescription vmstate_pmu = {
+    .name = "pmu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(mos6522_pmu.parent_obj, PMUState, 0, vmstate_mos6522,
+                       MOS6522State),
+        VMSTATE_UINT8(last_b, PMUState),
+        VMSTATE_UINT8(cmd, PMUState),
+        VMSTATE_UINT32(cmdlen, PMUState),
+        VMSTATE_UINT32(rsplen, PMUState),
+        VMSTATE_UINT8(cmd_buf_pos, PMUState),
+        VMSTATE_BUFFER(cmd_buf, PMUState),
+        VMSTATE_UINT8(cmd_rsp_pos, PMUState),
+        VMSTATE_UINT8(cmd_rsp_sz, PMUState),
+        VMSTATE_BUFFER(cmd_rsp, PMUState),
+        VMSTATE_UINT8(intbits, PMUState),
+        VMSTATE_UINT8(intmask, PMUState),
+        VMSTATE_UINT8(autopoll_rate_ms, PMUState),
+        VMSTATE_UINT8(autopoll_mask, PMUState),
+        VMSTATE_UINT32(tick_offset, PMUState),
+        VMSTATE_TIMER_PTR(one_sec_timer, PMUState),
+        VMSTATE_INT64(one_sec_target, PMUState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pmu_adb,
+    }
+};
+
+static void pmu_reset(DeviceState *dev)
+{
+    PMUState *s = VIA_PMU(dev);
+
+    /* OpenBIOS needs to do this? MacOS 9 needs it */
+    s->intmask = PMU_INT_ADB | PMU_INT_TICK;
+    s->intbits = 0;
+
+    s->cmd_state = pmu_state_idle;
+    s->autopoll_mask = 0;
+}
+
+static void pmu_realize(DeviceState *dev, Error **errp)
+{
+    PMUState *s = VIA_PMU(dev);
+    SysBusDevice *sbd;
+    MOS6522State *ms;
+    DeviceState *d;
+    struct tm tm;
+
+    /* Pass IRQ from 6522 */
+    d = DEVICE(&s->mos6522_pmu);
+    ms = MOS6522(d);
+    sbd = SYS_BUS_DEVICE(s);
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+    s->one_sec_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_one_sec_timer, s);
+    s->one_sec_target = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000;
+    timer_mod(s->one_sec_timer, s->one_sec_target);
+
+    if (s->has_adb) {
+        qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
+                            DEVICE(dev), "adb.0");
+        s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_adb_poll, s);
+        s->adb_poll_mask = 0xffff;
+        s->autopoll_rate_ms = 20;
+    }
+}
+
+static void pmu_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    PMUState *s = VIA_PMU(obj);
+
+    object_property_add_link(obj, "gpio", TYPE_MACIO_GPIO,
+                             (Object **) &s->gpio,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
+    object_initialize(&s->mos6522_pmu, sizeof(s->mos6522_pmu),
+                      TYPE_MOS6522_PMU);
+    qdev_set_parent_bus(DEVICE(&s->mos6522_pmu), sysbus_get_default());
+
+    memory_region_init_io(&s->mem, obj, &mos6522_pmu_ops, s, "via-pmu",
+                          0x2000);
+    sysbus_init_mmio(d, &s->mem);
+}
+
+static Property pmu_properties[] = {
+    DEFINE_PROP_BOOL("has-adb", PMUState, has_adb, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void pmu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = pmu_realize;
+    dc->reset = pmu_reset;
+    dc->vmsd = &vmstate_pmu;
+    dc->props = pmu_properties;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo pmu_type_info = {
+    .name = TYPE_VIA_PMU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PMUState),
+    .instance_init = pmu_init,
+    .class_init = pmu_class_init,
+};
+
+static void mos6522_pmu_portB_write(MOS6522State *s)
+{
+    MOS6522PMUState *mps = container_of(s, MOS6522PMUState, parent_obj);
+    PMUState *ps = container_of(mps, PMUState, mos6522_pmu);
+
+    if ((s->pcr & 0xe0) == 0x20 || (s->pcr & 0xe0) == 0x60) {
+        s->ifr &= ~CB2_INT;
+    }
+    s->ifr &= ~CB1_INT;
+
+    via_update_irq(ps);
+    pmu_update(ps);
+}
+
+static void mos6522_pmu_portA_write(MOS6522State *s)
+{
+    MOS6522PMUState *mps = container_of(s, MOS6522PMUState, parent_obj);
+    PMUState *ps = container_of(mps, PMUState, mos6522_pmu);
+
+    if ((s->pcr & 0x0e) == 0x02 || (s->pcr & 0x0e) == 0x06) {
+        s->ifr &= ~CA2_INT;
+    }
+    s->ifr &= ~CA1_INT;
+
+    via_update_irq(ps);
+}
+
+static void mos6522_pmu_reset(DeviceState *dev)
+{
+    MOS6522State *ms = MOS6522(dev);
+    MOS6522PMUState *mps = container_of(ms, MOS6522PMUState, parent_obj);
+    PMUState *s = container_of(mps, PMUState, mos6522_pmu);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+
+    mdc->parent_reset(dev);
+
+    ms->timers[0].frequency = VIA_TIMER_FREQ;
+    ms->timers[1].frequency = (SCALE_US * 6000) / 4700;
+
+    s->last_b = ms->b = TACK | TREQ;
+}
+
+static void mos6522_pmu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+
+    dc->reset = mos6522_pmu_reset;
+    mdc->portB_write = mos6522_pmu_portB_write;
+    mdc->portA_write = mos6522_pmu_portA_write;
+}
+
+static const TypeInfo mos6522_pmu_type_info = {
+    .name = TYPE_MOS6522_PMU,
+    .parent = TYPE_MOS6522,
+    .instance_size = sizeof(MOS6522PMUState),
+    .class_init = mos6522_pmu_class_init,
+};
+
+static void pmu_register_types(void)
+{
+    type_register_static(&pmu_type_info);
+    type_register_static(&mos6522_pmu_type_info);
+}
+
+type_init(pmu_register_types)
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
index 71c47520eb..05019262fa 100644
--- a/hw/misc/macio/trace-events
+++ b/hw/misc/macio/trace-events
@@ -20,3 +20,24 @@ macio_gpio_irq_assert(int gpio) "asserting GPIO %d"
 macio_gpio_irq_deassert(int gpio) "deasserting GPIO %d"
 macio_gpio_write(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
 macio_gpio_read(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64" value: 0x%"PRIx64
+
+# hw/misc/macio/pmu.c
+pmu_adb_poll(int olen) "ADB autopoll, olen=%d"
+pmu_one_sec_timer(void) "PMU one sec..."
+pmu_cmd_set_int_mask(int intmask) "Setting PMU int mask to 0x%02x"
+pmu_cmd_set_adb_autopoll(int mask) "ADB set autopoll, mask=0x%04x"
+pmu_cmd_adb_nobus(void) "ADB PACKET with no ADB bus!"
+pmu_cmd_adb_request(int inlen, int indata0, int indata1, int indata2, int indata3, int indata4) "ADB request: len=%d, cmd=0x%02x, pflags=0x%02x, adblen=%d: 0x%02x 0x%02x..."
+pmu_cmd_adb_reply(int len) "ADB reply is %d bytes"
+pmu_dispatch_cmd(const char *name) "handling command %s"
+pmu_dispatch_unknown_cmd(int cmd) "Unknown PMU command 0x%02x"
+pmu_debug_protocol_string(const char *str) "%s"
+pmu_debug_protocol_resp_size(int size) "sending %d resp bytes"
+pmu_debug_protocol_error(int portB) "protocol error! portB=0x%02x"
+pmu_debug_protocol_clear_treq(int state) "TREQ cleared, clearing TACK, state: %d"
+pmu_debug_protocol_cmd(int cmd, int cmdlen, int rsplen) "Got command byte 0x%02x, clen=%d, rlen=%d"
+pmu_debug_protocol_cmdlen(int len) "got cmd length byte: %d"
+pmu_debug_protocol_cmd_toobig(int len) "command too big (%d bytes)"
+pmu_debug_protocol_cmd_send_resp_size(int len) "sending length byte: %d"
+pmu_debug_protocol_cmd_send_resp(int pos, int len) "sending byte: %d/%d"
+pmu_debug_protocol_cmd_resp_complete(int ier) "Response send complete. IER=0x%02x"
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index b3b7f9d8ae..c0217e66f2 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -59,6 +59,7 @@
 
 /* New World IRQs */
 #define NEWWORLD_CUDA_IRQ      0x19
+#define NEWWORLD_PMU_IRQ       0x19
 #define NEWWORLD_ESCCB_IRQ     0x24
 #define NEWWORLD_ESCCA_IRQ     0x25
 #define NEWWORLD_IDE0_IRQ      0xd
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index ca21d47234..ff715ffffd 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -399,11 +399,19 @@ static void ppc_core99_init(MachineState *machine)
     macio_ide_init_drives(macio_ide, &hd[MAX_IDE_DEVS]);
 
     if (has_adb) {
-        dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
+        if (has_pmu) {
+            dev = DEVICE(object_resolve_path_component(OBJECT(macio), "pmu"));
+        } else {
+            dev = DEVICE(object_resolve_path_component(OBJECT(macio), "cuda"));
+        }
+
         adb_bus = qdev_get_child_bus(dev, "adb.0");
         dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
+        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
         qdev_init_nofail(dev);
+
         dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
+        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", has_pmu);
         qdev_init_nofail(dev);
     }
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index d43883a893..cfaa145500 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -30,6 +30,7 @@
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/misc/macio/gpio.h"
+#include "hw/misc/macio/pmu.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
 
@@ -43,6 +44,7 @@ typedef struct MacIOState {
 
     MemoryRegion bar;
     CUDAState cuda;
+    PMUState pmu;
     DBDMAState dbdma;
     ESCCState escc;
     uint64_t frequency;
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
new file mode 100644
index 0000000000..d10895ba5f
--- /dev/null
+++ b/include/hw/misc/macio/pmu.h
@@ -0,0 +1,237 @@
+/*
+ * Definitions for talking to the PMU.  The PMU is a microcontroller
+ * which controls battery charging and system power on PowerBook 3400
+ * and 2400 models as well as the RTC and various other things.
+ *
+ * Copyright (C) 1998 Paul Mackerras.
+ * Copyright (C) 2016 Ben Herrenschmidt
+ */
+
+#ifndef PMU_H
+#define PMU_H
+
+/*
+ * PMU commands
+ */
+
+#define PMU_POWER_CTRL0            0x10  /* control power of some devices */
+#define PMU_POWER_CTRL             0x11  /* control power of some devices */
+#define PMU_ADB_CMD                0x20  /* send ADB packet */
+#define PMU_ADB_POLL_OFF           0x21  /* disable ADB auto-poll */
+#define PMU_WRITE_NVRAM            0x33  /* write non-volatile RAM */
+#define PMU_READ_NVRAM             0x3b  /* read non-volatile RAM */
+#define PMU_SET_RTC                0x30  /* set real-time clock */
+#define PMU_READ_RTC               0x38  /* read real-time clock */
+#define PMU_SET_VOLBUTTON          0x40  /* set volume up/down position */
+#define PMU_BACKLIGHT_BRIGHT       0x41  /* set backlight brightness */
+#define PMU_GET_VOLBUTTON          0x48  /* get volume up/down position */
+#define PMU_PCEJECT                0x4c  /* eject PC-card from slot */
+#define PMU_BATTERY_STATE          0x6b  /* report battery state etc. */
+#define PMU_SMART_BATTERY_STATE    0x6f  /* report battery state (new way) */
+#define PMU_SET_INTR_MASK          0x70  /* set PMU interrupt mask */
+#define PMU_INT_ACK                0x78  /* read interrupt bits */
+#define PMU_SHUTDOWN               0x7e  /* turn power off */
+#define PMU_CPU_SPEED              0x7d  /* control CPU speed on some models */
+#define PMU_SLEEP                  0x7f  /* put CPU to sleep */
+#define PMU_POWER_EVENTS           0x8f  /* Send power-event commands to PMU */
+#define PMU_I2C_CMD                0x9a  /* I2C operations */
+#define PMU_RESET                  0xd0  /* reset CPU */
+#define PMU_GET_BRIGHTBUTTON       0xd9  /* report brightness up/down pos */
+#define PMU_GET_COVER              0xdc  /* report cover open/closed */
+#define PMU_SYSTEM_READY           0xdf  /* tell PMU we are awake */
+#define PMU_DOWNLOAD_STATUS        0xe2  /* Called by MacOS during boot... */
+#define PMU_READ_PMU_RAM           0xe8  /* read the PMU RAM... ??? */
+#define PMU_GET_VERSION            0xea  /* read the PMU version */
+
+/* Bits to use with the PMU_POWER_CTRL0 command */
+#define PMU_POW0_ON            0x80    /* OR this to power ON the device */
+#define PMU_POW0_OFF           0x00    /* leave bit 7 to 0 to power it OFF */
+#define PMU_POW0_HARD_DRIVE    0x04    /* Hard drive power
+                                        * (on wallstreet/lombard ?) */
+
+/* Bits to use with the PMU_POWER_CTRL command */
+#define PMU_POW_ON             0x80    /* OR this to power ON the device */
+#define PMU_POW_OFF            0x00    /* leave bit 7 to 0 to power it OFF */
+#define PMU_POW_BACKLIGHT      0x01    /* backlight power */
+#define PMU_POW_CHARGER        0x02    /* battery charger power */
+#define PMU_POW_IRLED          0x04    /* IR led power (on wallstreet) */
+#define PMU_POW_MEDIABAY       0x08    /* media bay power
+                                        * (wallstreet/lombard ?) */
+
+/* Bits in PMU interrupt and interrupt mask bytes */
+#define PMU_INT_PCEJECT        0x04    /* PC-card eject buttons */
+#define PMU_INT_SNDBRT         0x08    /* sound/brightness up/down buttons */
+#define PMU_INT_ADB            0x10    /* ADB autopoll or reply data */
+#define PMU_INT_BATTERY        0x20    /* Battery state change */
+#define PMU_INT_ENVIRONMENT    0x40    /* Environment interrupts */
+#define PMU_INT_TICK           0x80    /* 1-second tick interrupt */
+
+/* Other bits in PMU interrupt valid when PMU_INT_ADB is set */
+#define PMU_INT_ADB_AUTO           0x04    /* ADB autopoll, when PMU_INT_ADB */
+#define PMU_INT_WAITING_CHARGER    0x01    /* ??? */
+#define PMU_INT_AUTO_SRQ_POLL      0x02    /* ??? */
+
+/* Bits in the environement message (either obtained via PMU_GET_COVER,
+ * or via PMU_INT_ENVIRONMENT on core99 */
+#define PMU_ENV_LID_CLOSED     0x01    /* The lid is closed */
+
+/* I2C related definitions */
+#define PMU_I2C_MODE_SIMPLE    0
+#define PMU_I2C_MODE_STDSUB    1
+#define PMU_I2C_MODE_COMBINED  2
+
+#define PMU_I2C_BUS_STATUS     0
+#define PMU_I2C_BUS_SYSCLK     1
+#define PMU_I2C_BUS_POWER      2
+
+#define PMU_I2C_STATUS_OK          0
+#define PMU_I2C_STATUS_DATAREAD    1
+#define PMU_I2C_STATUS_BUSY        0xfe
+
+/* Kind of PMU (model) */
+enum {
+    PMU_UNKNOWN,
+    PMU_OHARE_BASED,        /* 2400, 3400, 3500 (old G3 powerbook) */
+    PMU_HEATHROW_BASED,     /* PowerBook G3 series */
+    PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
+    PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
+    PMU_68K_V1,             /* 68K PMU, version 1 */
+    PMU_68K_V2,             /* 68K PMU, version 2 */
+};
+
+/* PMU PMU_POWER_EVENTS commands */
+enum {
+    PMU_PWR_GET_POWERUP_EVENTS = 0x00,
+    PMU_PWR_SET_POWERUP_EVENTS = 0x01,
+    PMU_PWR_CLR_POWERUP_EVENTS = 0x02,
+    PMU_PWR_GET_WAKEUP_EVENTS = 0x03,
+    PMU_PWR_SET_WAKEUP_EVENTS = 0x04,
+    PMU_PWR_CLR_WAKEUP_EVENTS = 0x05,
+};
+
+/* Power events wakeup bits */
+enum {
+    PMU_PWR_WAKEUP_KEY = 0x01,           /* Wake on key press */
+    PMU_PWR_WAKEUP_AC_INSERT = 0x02,     /* Wake on AC adapter plug */
+    PMU_PWR_WAKEUP_AC_CHANGE = 0x04,
+    PMU_PWR_WAKEUP_LID_OPEN = 0x08,
+    PMU_PWR_WAKEUP_RING = 0x10,
+};
+
+/*
+ * This table indicates for each PMU opcode:
+ * - the number of data bytes to be sent with the command, or -1
+ *   if a length byte should be sent,
+ * - the number of response bytes which the PMU will return, or
+ *   -1 if it will send a length byte.
+ */
+
+static const int8_t pmu_data_len[256][2] = {
+/*  0        1        2        3        4        5        6        7  */
+    {-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    {-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    { 1,  0},{ 1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  1},{ 0,  1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{ 0,  0},
+    {-1,  0},{ 0,  0},{ 2,  0},{ 1,  0},{ 1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0, -1},{ 0, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{ 0, -1},
+    { 4,  0},{20,  0},{-1,  0},{ 3,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  4},{ 0, 20},{ 2, -1},{ 2,  1},{ 3, -1},{-1, -1},{-1, -1},{ 4,  0},
+    { 1,  0},{ 1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  1},{ 0,  1},{-1, -1},{ 1,  0},{ 1,  0},{-1, -1},{-1, -1},{-1, -1},
+    { 1,  0},{ 0,  0},{ 2,  0},{ 2,  0},{-1,  0},{ 1,  0},{ 3,  0},{ 1,  0},
+    { 0,  1},{ 1,  0},{ 0,  2},{ 0,  2},{ 0, -1},{-1, -1},{-1, -1},{-1, -1},
+    { 2,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  3},{ 0,  3},{ 0,  2},{ 0,  8},{ 0, -1},{ 0, -1},{-1, -1},{-1, -1},
+    { 1,  0},{ 1,  0},{ 1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0, -1},{ 0, -1},{-1, -1},{-1, -1},{-1, -1},{ 5,  1},{ 4,  1},{ 4,  1},
+    { 4,  0},{-1,  0},{ 0,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  5},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    { 1,  0},{ 2,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 0,  1},{ 0,  1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    { 2,  0},{ 2,  0},{ 2,  0},{ 4,  0},{-1,  0},{ 0,  0},{-1,  0},{-1,  0},
+    { 1,  1},{ 1,  0},{ 3,  0},{ 2,  0},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    {-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    {-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    {-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    {-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+    { 0,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    { 1,  1},{ 1,  1},{-1, -1},{-1, -1},{ 0,  1},{ 0, -1},{-1, -1},{-1, -1},
+    {-1,  0},{ 4,  0},{ 0,  1},{-1,  0},{-1,  0},{ 4,  0},{-1,  0},{-1,  0},
+    { 3, -1},{-1, -1},{ 0,  1},{-1, -1},{ 0, -1},{-1, -1},{-1, -1},{ 0,  0},
+    {-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},{-1,  0},
+    {-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},{-1, -1},
+};
+
+/* Command protocol state machine */
+typedef enum {
+    pmu_state_idle, /* Waiting for command */
+    pmu_state_cmd,  /* Receiving command */
+    pmu_state_rsp,  /* Responding to command */
+} PMUCmdState;
+
+/* MOS6522 PMU */
+typedef struct MOS6522PMUState {
+    /*< private >*/
+    MOS6522State parent_obj;
+} MOS6522PMUState;
+
+#define TYPE_MOS6522_PMU "mos6522-pmu"
+#define MOS6522_PMU(obj) OBJECT_CHECK(MOS6522PMUState, (obj), \
+                                      TYPE_MOS6522_PMU)
+/**
+ * PMUState:
+ * @last_b: last value of B register
+ */
+
+typedef struct PMUState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mem;
+    uint64_t frequency;
+    qemu_irq via_irq;
+    bool via_irq_state;
+
+    /* PMU state */
+    MOS6522PMUState mos6522_pmu;
+
+    /* PMU low level protocol state */
+    PMUCmdState cmd_state;
+    uint8_t last_b;
+    uint8_t cmd;
+    uint32_t cmdlen;
+    uint32_t rsplen;
+    uint8_t cmd_buf_pos;
+    uint8_t cmd_buf[128];
+    uint8_t cmd_rsp_pos;
+    uint8_t cmd_rsp_sz;
+    uint8_t cmd_rsp[128];
+
+    /* PMU events/interrupts */
+    uint8_t intbits;
+    uint8_t intmask;
+
+    /* ADB */
+    bool has_adb;
+    ADBBusState adb_bus;
+    uint16_t adb_poll_mask;
+    uint8_t autopoll_rate_ms;
+    uint8_t autopoll_mask;
+    QEMUTimer *adb_poll_timer;
+    uint8_t adb_reply_size;
+    uint8_t adb_reply[ADB_MAX_OUT_LEN];
+
+    /* RTC */
+    uint32_t tick_offset;
+    QEMUTimer *one_sec_timer;
+    int64_t one_sec_target;
+
+    /* GPIO */
+    MacIOGPIOState *gpio;
+} PMUState;
+
+#define TYPE_VIA_PMU "via-pmu"
+#define VIA_PMU(obj) OBJECT_CHECK(PMUState, (obj), TYPE_VIA_PMU)
+
+#endif /* PMU_H */
-- 
2.17.1
