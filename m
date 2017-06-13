Received: from eggs.gnu.org ([2001:4830:134:3::10]:33169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTc-0005Ij-SA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTa-0006h9-DZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTa-0006cz-1X
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTT-00014R-EV
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:07:00 +0100
Message-Id: <1497362826-21125-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/17] hw/misc: add a TMP42{1, 2, 3} device model
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

Largely inspired by the TMP105 temperature sensor, here is a model for
the TMP42{1,2,3} temperature sensors.

Specs can be found here :

	http://www.ti.com/lit/gpn/tmp421

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1496739230-32109-2-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs           |   1 +
 hw/misc/tmp421.c                | 402 ++++++++++++++++++++++++++++++++++++++++
 default-configs/arm-softmmu.mak |   1 +
 3 files changed, 404 insertions(+)
 create mode 100644 hw/misc/tmp421.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c8b4893..2019846 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -1,6 +1,7 @@
 common-obj-$(CONFIG_APPLESMC) += applesmc.o
 common-obj-$(CONFIG_MAX111X) += max111x.o
 common-obj-$(CONFIG_TMP105) += tmp105.o
+common-obj-$(CONFIG_TMP421) += tmp421.o
 common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
 common-obj-$(CONFIG_SGA) += sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
new file mode 100644
index 0000000..4a505ab
--- /dev/null
+++ b/hw/misc/tmp421.c
@@ -0,0 +1,402 @@
+/*
+ * Texas Instruments TMP421 temperature sensor.
+ *
+ * Copyright (c) 2016 IBM Corporation.
+ *
+ * Largely inspired by :
+ *
+ * Texas Instruments TMP105 temperature sensor.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Andrzej Zaborowski <andrew@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i2c/i2c.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+
+/* Manufacturer / Device ID's */
+#define TMP421_MANUFACTURER_ID          0x55
+#define TMP421_DEVICE_ID                0x21
+#define TMP422_DEVICE_ID                0x22
+#define TMP423_DEVICE_ID                0x23
+
+typedef struct DeviceInfo {
+    int model;
+    const char *name;
+} DeviceInfo;
+
+static const DeviceInfo devices[] = {
+    { TMP421_DEVICE_ID, "tmp421" },
+    { TMP422_DEVICE_ID, "tmp422" },
+    { TMP423_DEVICE_ID, "tmp423" },
+};
+
+typedef struct TMP421State {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    int16_t temperature[4];
+
+    uint8_t status;
+    uint8_t config[2];
+    uint8_t rate;
+
+    uint8_t len;
+    uint8_t buf[2];
+    uint8_t pointer;
+
+} TMP421State;
+
+typedef struct TMP421Class {
+    I2CSlaveClass parent_class;
+    DeviceInfo *dev;
+} TMP421Class;
+
+#define TYPE_TMP421 "tmp421-generic"
+#define TMP421(obj) OBJECT_CHECK(TMP421State, (obj), TYPE_TMP421)
+
+#define TMP421_CLASS(klass) \
+     OBJECT_CLASS_CHECK(TMP421Class, (klass), TYPE_TMP421)
+#define TMP421_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(TMP421Class, (obj), TYPE_TMP421)
+
+/* the TMP421 registers */
+#define TMP421_STATUS_REG               0x08
+#define    TMP421_STATUS_BUSY             (1 << 7)
+#define TMP421_CONFIG_REG_1             0x09
+#define    TMP421_CONFIG_RANGE            (1 << 2)
+#define    TMP421_CONFIG_SHUTDOWN         (1 << 6)
+#define TMP421_CONFIG_REG_2             0x0A
+#define    TMP421_CONFIG_RC               (1 << 2)
+#define    TMP421_CONFIG_LEN              (1 << 3)
+#define    TMP421_CONFIG_REN              (1 << 4)
+#define    TMP421_CONFIG_REN2             (1 << 5)
+#define    TMP421_CONFIG_REN3             (1 << 6)
+
+#define TMP421_CONVERSION_RATE_REG      0x0B
+#define TMP421_ONE_SHOT                 0x0F
+
+#define TMP421_RESET                    0xFC
+#define TMP421_MANUFACTURER_ID_REG      0xFE
+#define TMP421_DEVICE_ID_REG            0xFF
+
+#define TMP421_TEMP_MSB0                0x00
+#define TMP421_TEMP_MSB1                0x01
+#define TMP421_TEMP_MSB2                0x02
+#define TMP421_TEMP_MSB3                0x03
+#define TMP421_TEMP_LSB0                0x10
+#define TMP421_TEMP_LSB1                0x11
+#define TMP421_TEMP_LSB2                0x12
+#define TMP421_TEMP_LSB3                0x13
+
+static const int32_t mins[2] = { -40000, -55000 };
+static const int32_t maxs[2] = { 127000, 150000 };
+
+static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    TMP421State *s = TMP421(obj);
+    bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
+    int offset = ext_range * 64 * 256;
+    int64_t value;
+    int tempid;
+
+    if (sscanf(name, "temperature%d", &tempid) != 1) {
+        error_setg(errp, "error reading %s: %m", name);
+        return;
+    }
+
+    if (tempid >= 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    value = ((s->temperature[tempid] - offset) * 1000 + 128) / 256;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
+ * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
+ */
+static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    TMP421State *s = TMP421(obj);
+    Error *local_err = NULL;
+    int64_t temp;
+    bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
+    int offset = ext_range * 64 * 256;
+    int tempid;
+
+    visit_type_int(v, name, &temp, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (temp >= maxs[ext_range] || temp < mins[ext_range]) {
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " °C is out of range",
+                   temp / 1000, temp % 1000);
+        return;
+    }
+
+    if (sscanf(name, "temperature%d", &tempid) != 1) {
+        error_setg(errp, "error reading %s: %m", name);
+        return;
+    }
+
+    if (tempid >= 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    s->temperature[tempid] = (int16_t) ((temp * 256 - 128) / 1000) + offset;
+}
+
+static void tmp421_read(TMP421State *s)
+{
+    TMP421Class *sc = TMP421_GET_CLASS(s);
+
+    s->len = 0;
+
+    switch (s->pointer) {
+    case TMP421_MANUFACTURER_ID_REG:
+        s->buf[s->len++] = TMP421_MANUFACTURER_ID;
+        break;
+    case TMP421_DEVICE_ID_REG:
+        s->buf[s->len++] = sc->dev->model;
+        break;
+    case TMP421_CONFIG_REG_1:
+        s->buf[s->len++] = s->config[0];
+        break;
+    case TMP421_CONFIG_REG_2:
+        s->buf[s->len++] = s->config[1];
+        break;
+    case TMP421_CONVERSION_RATE_REG:
+        s->buf[s->len++] = s->rate;
+        break;
+    case TMP421_STATUS_REG:
+        s->buf[s->len++] = s->status;
+        break;
+
+        /* FIXME: check for channel enablement in config registers */
+    case TMP421_TEMP_MSB0:
+        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_MSB1:
+        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_MSB2:
+        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_MSB3:
+        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_LSB0:
+        s->buf[s->len++] = (((uint16_t) s->temperature[0]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_LSB1:
+        s->buf[s->len++] = (((uint16_t) s->temperature[1]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_LSB2:
+        s->buf[s->len++] = (((uint16_t) s->temperature[2]) >> 0) & 0xf0;
+        break;
+    case TMP421_TEMP_LSB3:
+        s->buf[s->len++] = (((uint16_t) s->temperature[3]) >> 0) & 0xf0;
+        break;
+    }
+}
+
+static void tmp421_reset(I2CSlave *i2c);
+
+static void tmp421_write(TMP421State *s)
+{
+    switch (s->pointer) {
+    case TMP421_CONVERSION_RATE_REG:
+        s->rate = s->buf[0];
+        break;
+    case TMP421_CONFIG_REG_1:
+        s->config[0] = s->buf[0];
+        break;
+    case TMP421_CONFIG_REG_2:
+        s->config[1] = s->buf[0];
+        break;
+    case TMP421_RESET:
+        tmp421_reset(I2C_SLAVE(s));
+        break;
+    }
+}
+
+static int tmp421_rx(I2CSlave *i2c)
+{
+    TMP421State *s = TMP421(i2c);
+
+    if (s->len < 2) {
+        return s->buf[s->len++];
+    } else {
+        return 0xff;
+    }
+}
+
+static int tmp421_tx(I2CSlave *i2c, uint8_t data)
+{
+    TMP421State *s = TMP421(i2c);
+
+    if (s->len == 0) {
+        /* first byte is the register pointer for a read or write
+         * operation */
+        s->pointer = data;
+        s->len++;
+    } else if (s->len == 1) {
+        /* second byte is the data to write. The device only supports
+         * one byte writes */
+        s->buf[0] = data;
+        tmp421_write(s);
+    }
+
+    return 0;
+}
+
+static int tmp421_event(I2CSlave *i2c, enum i2c_event event)
+{
+    TMP421State *s = TMP421(i2c);
+
+    if (event == I2C_START_RECV) {
+        tmp421_read(s);
+    }
+
+    s->len = 0;
+    return 0;
+}
+
+static const VMStateDescription vmstate_tmp421 = {
+    .name = "TMP421",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(len, TMP421State),
+        VMSTATE_UINT8_ARRAY(buf, TMP421State, 2),
+        VMSTATE_UINT8(pointer, TMP421State),
+        VMSTATE_UINT8_ARRAY(config, TMP421State, 2),
+        VMSTATE_UINT8(status, TMP421State),
+        VMSTATE_UINT8(rate, TMP421State),
+        VMSTATE_INT16_ARRAY(temperature, TMP421State, 4),
+        VMSTATE_I2C_SLAVE(i2c, TMP421State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void tmp421_reset(I2CSlave *i2c)
+{
+    TMP421State *s = TMP421(i2c);
+    TMP421Class *sc = TMP421_GET_CLASS(s);
+
+    memset(s->temperature, 0, sizeof(s->temperature));
+    s->pointer = 0;
+
+    s->config[0] = 0; /* TMP421_CONFIG_RANGE */
+
+     /* resistance correction and channel enablement */
+    switch (sc->dev->model) {
+    case TMP421_DEVICE_ID:
+        s->config[1] = 0x1c;
+        break;
+    case TMP422_DEVICE_ID:
+        s->config[1] = 0x3c;
+        break;
+    case TMP423_DEVICE_ID:
+        s->config[1] = 0x7c;
+        break;
+    }
+
+    s->rate = 0x7;       /* 8Hz */
+    s->status = 0;
+}
+
+static int tmp421_init(I2CSlave *i2c)
+{
+    TMP421State *s = TMP421(i2c);
+
+    tmp421_reset(&s->i2c);
+
+    return 0;
+}
+
+static void tmp421_initfn(Object *obj)
+{
+    object_property_add(obj, "temperature0", "int",
+                        tmp421_get_temperature,
+                        tmp421_set_temperature, NULL, NULL, NULL);
+    object_property_add(obj, "temperature1", "int",
+                        tmp421_get_temperature,
+                        tmp421_set_temperature, NULL, NULL, NULL);
+    object_property_add(obj, "temperature2", "int",
+                        tmp421_get_temperature,
+                        tmp421_set_temperature, NULL, NULL, NULL);
+    object_property_add(obj, "temperature3", "int",
+                        tmp421_get_temperature,
+                        tmp421_set_temperature, NULL, NULL, NULL);
+}
+
+static void tmp421_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    TMP421Class *sc = TMP421_CLASS(klass);
+
+    k->init = tmp421_init;
+    k->event = tmp421_event;
+    k->recv = tmp421_rx;
+    k->send = tmp421_tx;
+    dc->vmsd = &vmstate_tmp421;
+    sc->dev = (DeviceInfo *) data;
+}
+
+static const TypeInfo tmp421_info = {
+    .name          = TYPE_TMP421,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(TMP421State),
+    .class_size    = sizeof(TMP421Class),
+    .instance_init = tmp421_initfn,
+    .abstract      = true,
+};
+
+static void tmp421_register_types(void)
+{
+    int i;
+
+    type_register_static(&tmp421_info);
+    for (i = 0; i < ARRAY_SIZE(devices); ++i) {
+        TypeInfo ti = {
+            .name       = devices[i].name,
+            .parent     = TYPE_TMP421,
+            .class_init = tmp421_class_init,
+            .class_data = (void *) &devices[i],
+        };
+        type_register(&ti);
+    }
+}
+
+type_init(tmp421_register_types)
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 78d7af0..93e995d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -15,6 +15,7 @@ CONFIG_TWL92230=y
 CONFIG_TSC2005=y
 CONFIG_LM832X=y
 CONFIG_TMP105=y
+CONFIG_TMP421=y
 CONFIG_STELLARIS=y
 CONFIG_STELLARIS_INPUT=y
 CONFIG_STELLARIS_ENET=y
-- 
2.7.4
