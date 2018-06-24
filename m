Received: from eggs.gnu.org ([2001:4830:134:3::10]:55968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fX3Pd-0001E6-SL
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 07:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fX3PZ-0007nE-5y
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 07:42:33 -0400
Message-Id: <8ea68a0d623241bfa190e295debe66765c9a3cfb.1529839203.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529839203.git.balaton@eik.bme.hu>
References: <cover.1529839203.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 24 Jun 2018 13:20:03 +0200
Subject: [Qemu-devel] [PATCH v5 2/4] hw/timer: Add basic M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
of day is implemented. Setting time and RTC alarm are not supported.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   1 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 hw/timer/m41t80.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2874ddc..3bfc4a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -839,6 +839,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ide/sii3112.c
+F: hw/timer/m41t80.c
 
 SH4 Machines
 ------------
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 851b4af..b8b0526 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -27,6 +27,7 @@ CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
+CONFIG_M41T80=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8b27a4b..e16b2b9 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
 common-obj-$(CONFIG_DS1338) += ds1338.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
+common-obj-$(CONFIG_M41T80) += m41t80.o
 common-obj-$(CONFIG_M48T59) += m48t59.o
 ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) += m48t59-isa.o
diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
new file mode 100644
index 0000000..734d7d9
--- /dev/null
+++ b/hw/timer/m41t80.c
@@ -0,0 +1,117 @@
+/*
+ * M41T80 serial rtc emulation
+ *
+ * Copyright (c) 2018 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/bcd.h"
+#include "hw/i2c/i2c.h"
+
+#define TYPE_M41T80 "m41t80"
+#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
+
+typedef struct M41t80State {
+    I2CSlave parent_obj;
+    int8_t addr;
+} M41t80State;
+
+static void m41t80_realize(DeviceState *dev, Error **errp)
+{
+    M41t80State *s = M41T80(dev);
+
+    s->addr = -1;
+}
+
+static int m41t80_send(I2CSlave *i2c, uint8_t data)
+{
+    M41t80State *s = M41T80(i2c);
+
+    if (s->addr < 0) {
+        s->addr = data;
+    } else {
+        s->addr++;
+    }
+    return 0;
+}
+
+static int m41t80_recv(I2CSlave *i2c)
+{
+    M41t80State *s = M41T80(i2c);
+    struct tm now;
+    qemu_timeval tv;
+
+    if (s->addr < 0) {
+        s->addr = 0;
+    }
+    if (s->addr >= 1 && s->addr <= 7) {
+        qemu_get_timedate(&now, -1);
+    }
+    switch (s->addr++) {
+    case 0:
+        qemu_gettimeofday(&tv);
+        return to_bcd(tv.tv_usec / 10000);
+    case 1:
+        return to_bcd(now.tm_sec);
+    case 2:
+        return to_bcd(now.tm_min);
+    case 3:
+        return to_bcd(now.tm_hour);
+    case 4:
+        return to_bcd(now.tm_wday);
+    case 5:
+        return to_bcd(now.tm_mday);
+    case 6:
+        return to_bcd(now.tm_mon + 1);
+    case 7:
+        return to_bcd(now.tm_year % 100);
+    case 8 ... 19:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register: %d\n",
+                      __func__, s->addr - 1);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register: %d\n",
+                      __func__, s->addr - 1);
+        return 0;
+    }
+}
+
+static int m41t80_event(I2CSlave *i2c, enum i2c_event event)
+{
+    M41t80State *s = M41T80(i2c);
+
+    if (event == I2C_START_SEND) {
+        s->addr = -1;
+    }
+    return 0;
+}
+
+static void m41t80_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
+
+    dc->realize = m41t80_realize;
+    sc->send = m41t80_send;
+    sc->recv = m41t80_recv;
+    sc->event = m41t80_event;
+}
+
+static const TypeInfo m41t80_info = {
+    .name          = TYPE_M41T80,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(M41t80State),
+    .class_init    = m41t80_class_init,
+};
+
+static void m41t80_register_types(void)
+{
+    type_register_static(&m41t80_info);
+}
+
+type_init(m41t80_register_types)
-- 
2.7.6
