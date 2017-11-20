Received: from eggs.gnu.org ([2001:4830:134:3::10]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchh-0001qw-0l
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchf-0006YA-B1
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:25:01 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:18 -0600
Message-Id: <20171120032420.9134-11-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 10/12] timer: add ds1375 RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

only basic functionality implemented (read time and sram).
no set time or alarms.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 default-configs/ppc-softmmu.mak |   1 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/ds1375-i2c.c           | 293 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 hw/timer/ds1375-i2c.c

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index bb225c6e46..04bfa79154 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -52,3 +52,4 @@ CONFIG_SERIAL_ISA=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_RS6000_MC=y
+CONFIG_DS1375=y
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8c19eac3b6..6521d47367 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
 common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
 common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
 common-obj-$(CONFIG_DS1338) += ds1338.o
+common-obj-$(CONFIG_DS1375) += ds1375-i2c.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
 common-obj-$(CONFIG_M48T59) += m48t59.o
diff --git a/hw/timer/ds1375-i2c.c b/hw/timer/ds1375-i2c.c
new file mode 100644
index 0000000000..dba9cc05c4
--- /dev/null
+++ b/hw/timer/ds1375-i2c.c
@@ -0,0 +1,293 @@
+/*
+ * Dallas/Maxim ds1375 I2C RTC w/ SRAM
+ *
+ * Copyright (c) 2017 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ *
+ * Only basic functionality is modeled (time and user SRAM).
+ * Alarms not modeled.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/bcd.h"
+#include "hw/hw.h"
+#include "hw/registerfields.h"
+#include "hw/i2c/i2c.h"
+
+#define DEBUG_DS1375
+
+#ifdef DEBUG_DS1375
+#define DPRINTK(FMT, ...) printf(TYPE_DS1375 " : " FMT, ## __VA_ARGS__)
+#else
+#define DPRINTK(FMT, ...) do {} while (0)
+#endif
+
+#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_DS1375 " : " FMT, \
+                            ## __VA_ARGS__)
+
+#define TYPE_DS1375 "ds1375"
+#define DS1375(obj) OBJECT_CHECK(DS1375State, (obj), TYPE_DS1375)
+
+#define DS1375_REGSIZE 0x20
+
+#define R_SEC   (0x0)
+#define R_MIN   (0x1)
+#define R_HOUR  (0x2)
+#define R_WDAY  (0x3)
+#define R_DATE  (0x4)
+#define R_MONTH (0x5)
+#define R_YEAR  (0x6)
+#define R_A1SEC   (0x7)
+#define R_A1MIN   (0x8)
+#define R_A1HOUR  (0x9)
+#define R_A1DAY   (0xa)
+#define R_A2SEC   (0xb)
+#define R_A2MIN   (0xc)
+#define R_A2HOUR  (0xd)
+#define R_CTRL  (0xe)
+#define R_STS   (0xf)
+
+FIELD(HOUR, SET12, 6, 1)
+FIELD(HOUR, HOUR24, 0, 6)
+FIELD(HOUR, AMPM, 5, 1)
+FIELD(HOUR, HOUR12, 0, 5)
+
+FIELD(MONTH, MONTH, 0, 5)
+FIELD(MONTH, CENTURY, 7, 1)
+
+FIELD(CTRL, ECLK, 7, 1)
+FIELD(CTRL, CLKSEL, 5, 2)
+FIELD(CTRL, RS, 3, 2)
+FIELD(CTRL, INTCN, 2, 1)
+FIELD(CTRL, A2IE, 1, 1)
+FIELD(CTRL, A1IE, 0, 1)
+
+typedef struct DS1375State {
+    I2CSlave parent_obj;
+
+    /* register address counter */
+    uint8_t addr;
+    /* when writing, whether the address has been sent */
+    bool addrd;
+
+    int time_offset;
+
+    uint8_t regs[DS1375_REGSIZE];
+} DS1375State;
+
+/* update current time register if clock enabled */
+static
+void ds1375_latch(DS1375State *ds)
+{
+    struct tm now;
+
+    if (!ARRAY_FIELD_EX32(ds->regs, CTRL, ECLK)) {
+        return;
+    }
+
+    qemu_get_timedate(&now, ds->time_offset);
+
+    DPRINTK("Current Time %3u/%2u/%u %2u:%2u:%2u (wday %u)\n",
+            now.tm_year, now.tm_mon, now.tm_mday,
+            now.tm_hour, now.tm_min, now.tm_sec,
+            now.tm_wday);
+
+    /* ensure unused bits are zero */
+    memset(ds->regs, 0, R_YEAR + 1);
+
+    ds->regs[R_SEC] = to_bcd(now.tm_sec);
+    ds->regs[R_MIN] = to_bcd(now.tm_min);
+
+    if (ARRAY_FIELD_EX32(ds->regs, HOUR, SET12) == 0) {
+        /* 24 hour */
+        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR24, to_bcd(now.tm_hour));
+    } else {
+        /* 12 hour am/pm */
+        ARRAY_FIELD_DP32(ds->regs, HOUR, AMPM, now.tm_hour >= 12);
+        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR12, to_bcd(now.tm_hour % 12u));
+    }
+
+    ds->regs[R_WDAY] = now.tm_wday; /* day of the week */
+    ds->regs[R_DATE] = to_bcd(now.tm_mday);
+
+    ARRAY_FIELD_DP32(ds->regs, MONTH, MONTH, to_bcd(now.tm_mon + 1));
+    ARRAY_FIELD_DP32(ds->regs, MONTH, CENTURY, now.tm_year > 99);
+
+    ds->regs[R_YEAR] = to_bcd(now.tm_year % 100u);
+
+    DPRINTK("Latched time\n");
+}
+
+static
+void ds1375_update(DS1375State *ds)
+{
+    struct tm now;
+
+    now.tm_sec = from_bcd(ds->regs[R_SEC]);
+    now.tm_min = from_bcd(ds->regs[R_MIN]);
+
+    if (ARRAY_FIELD_EX32(ds->regs, HOUR, SET12)) {
+        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR12));
+        if (ARRAY_FIELD_EX32(ds->regs, HOUR, AMPM)) {
+            now.tm_hour += 12;
+        }
+
+    } else {
+        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR24));
+    }
+
+    now.tm_wday = from_bcd(ds->regs[R_WDAY]);
+    now.tm_mday = from_bcd(ds->regs[R_DATE]);
+    now.tm_mon = from_bcd(ARRAY_FIELD_EX32(ds->regs, MONTH, MONTH)) - 1;
+
+    now.tm_year = from_bcd(ds->regs[R_YEAR]) % 100u;
+    if (ARRAY_FIELD_EX32(ds->regs, MONTH, CENTURY)) {
+        now.tm_year += 100;
+    }
+
+    DPRINTK("New Time %3u/%2u/%u %2u:%2u:%2u (wday %u)\n",
+            now.tm_year, now.tm_mon, now.tm_mday,
+            now.tm_hour, now.tm_min, now.tm_sec,
+            now.tm_wday);
+
+    ds->time_offset = qemu_timedate_diff(&now);
+    DPRINTK("Update offset = %d\n", ds->time_offset);
+}
+
+static
+int ds1375_event(I2CSlave *s, enum i2c_event event)
+{
+    DS1375State *ds = container_of(s, DS1375State, parent_obj);
+
+    switch (event) {
+    case I2C_START_SEND:
+        ds->addrd = false;
+    case I2C_START_RECV:
+        ds1375_latch(ds);
+    case I2C_FINISH:
+        DPRINTK("Event %d\n", (int)event);
+    case I2C_NACK:
+        break;
+    }
+    return 0;
+}
+
+static
+int ds1375_recv(I2CSlave *s)
+{
+    DS1375State *ds = container_of(s, DS1375State, parent_obj);
+    int ret = 0;
+
+    switch (ds->addr) {
+    case R_SEC ... R_YEAR:
+    case R_CTRL:
+    case R_STS:
+    case 0x10 ... 0x1f:
+        ret = ds->regs[ds->addr];
+        break;
+    default:
+        LOG(LOG_UNIMP, "Read from unimplemented (%02x) %02x\n", ds->addr, ret);
+    }
+
+    DPRINTK("Recv (%02x) %02x\n", ds->addr, ret);
+
+    ds->addr++;
+    ds->addr &= 0x1f;
+    if (ds->addr == 0) {
+        ds1375_latch(ds);
+    }
+
+    return ret;
+}
+
+static
+int ds1375_send(I2CSlave *s, uint8_t data)
+{
+    DS1375State *ds = container_of(s, DS1375State, parent_obj);
+
+    if (!ds->addrd) {
+        data &= 0x1f;
+        ds->addr = data;
+        DPRINTK("Set address pointer %02x\n", data);
+        ds->addrd = true;
+        return 0;
+
+    } else {
+        DPRINTK("Send (%02x) %02x\n", ds->addr, data);
+        switch (ds->addr) {
+        case R_SEC ... R_YEAR:
+            ds->regs[ds->addr] = data;
+            ds1375_update(ds);
+            break;
+        case R_CTRL:
+            if (data & 0x7) {
+                LOG(LOG_UNIMP, "Alarm interrupt/output not modeled\n");
+            }
+            ds->regs[ds->addr] = data;
+            break;
+        case 0x10 ... 0x1f:
+            ds->regs[ds->addr] = data;
+            break;
+        default:
+            LOG(LOG_UNIMP, "Write to unimplemented (%02x) %02x\n",
+                ds->addr, data);
+        }
+
+        ds->addr++;
+        ds->addr &= 0x1f;
+        if (ds->addr == 0) {
+            ds1375_latch(ds);
+        }
+
+        return 0;
+    }
+}
+
+static
+void ds1375_reset(DeviceState *device)
+{
+    DS1375State *ds = DS1375(device);
+
+    memset(ds->regs, 0, sizeof(ds->regs));
+    /* TODO: not clear SRAM? */
+
+    /* Default to 12-hour mode */
+    ARRAY_FIELD_DP32(ds->regs, CTRL, ECLK, 1);
+
+    ds->addr = 0;
+
+    /* do not re-zero time offset */
+}
+
+static
+void ds1375_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = &ds1375_event;
+    k->recv = &ds1375_recv;
+    k->send = &ds1375_send;
+
+    dc->reset = &ds1375_reset;
+}
+
+static
+const TypeInfo ds1375_type = {
+    .name = TYPE_DS1375,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(DS1375State),
+    .class_size = sizeof(I2CSlaveClass),
+    .class_init = ds1375_class_init,
+};
+
+static void ds1375_register(void)
+{
+    type_register_static(&ds1375_type);
+}
+
+type_init(ds1375_register)
-- 
2.11.0
