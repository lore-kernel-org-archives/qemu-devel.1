Received: from eggs.gnu.org ([2001:4830:134:3::10]:47776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtHI-0007Jg-BN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtHD-0008Fk-Ja
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:40:04 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:51621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTtHD-0008FH-AT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:39:59 -0500
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9C7653BD64
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 17:39:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 18 Jan 2017 17:39:41 +0100
Message-Id: <1484757581-13124-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] hw/misc: add a TMP42{1,2,3} device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Largely inspired by the TMP105 temperature sensor, here is a model for
the TMP42{1,2,3} temperature sensors.

Specs can be found here :

	http://www.ti.com/lit/gpn/tmp421

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Changes since v1:

 - simplified tmp421_tx() as tmp421 does not need to support 2 bytes
   writes.  =20
 - extended tmp421_read() to support 2 bytes reads
=20
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/Makefile.objs           |   1 +
 hw/misc/tmp421.c                | 401 ++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 403 insertions(+)
 create mode 100644 hw/misc/tmp421.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 612f6e69f255..81def25bfd54 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -14,6 +14,7 @@ CONFIG_TWL92230=3Dy
 CONFIG_TSC2005=3Dy
 CONFIG_LM832X=3Dy
 CONFIG_TMP105=3Dy
+CONFIG_TMP421=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_STELLARIS_INPUT=3Dy
 CONFIG_STELLARIS_ENET=3Dy
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 1a89615a6270..69610caa325d 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -1,6 +1,7 @@
 common-obj-$(CONFIG_APPLESMC) +=3D applesmc.o
 common-obj-$(CONFIG_MAX111X) +=3D max111x.o
 common-obj-$(CONFIG_TMP105) +=3D tmp105.o
+common-obj-$(CONFIG_TMP421) +=3D tmp421.o
 common-obj-$(CONFIG_ISA_DEBUG) +=3D debugexit.o
 common-obj-$(CONFIG_SGA) +=3D sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) +=3D pc-testdev.o
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
new file mode 100644
index 000000000000..a57cf93f1658
--- /dev/null
+++ b/hw/misc/tmp421.c
@@ -0,0 +1,401 @@
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
+ * You should have received a copy of the GNU General Public License alo=
ng
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
+static const DeviceInfo devices[] =3D {
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
+static const int32_t mins[2] =3D { -40000, -55000 };
+static const int32_t maxs[2] =3D { 127000, 150000 };
+
+static void tmp421_get_temperature(Object *obj, Visitor *v, const char *=
name,
+                                   void *opaque, Error **errp)
+{
+    TMP421State *s =3D TMP421(obj);
+    bool ext_range =3D (s->config[0] & TMP421_CONFIG_RANGE);
+    int offset =3D ext_range * 64 * 256;
+    int64_t value;
+    int tempid;
+
+    if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
+        error_setg(errp, "error reading %s: %m", name);
+        return;
+    }
+
+    if (tempid >=3D 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    value =3D ((s->temperature[tempid] - offset) * 1000 + 128) / 256;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
+ * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
+ */
+static void tmp421_set_temperature(Object *obj, Visitor *v, const char *=
name,
+                                   void *opaque, Error **errp)
+{
+    TMP421State *s =3D TMP421(obj);
+    Error *local_err =3D NULL;
+    int64_t temp;
+    bool ext_range =3D (s->config[0] & TMP421_CONFIG_RANGE);
+    int offset =3D ext_range * 64 * 256;
+    int tempid;
+
+    visit_type_int(v, name, &temp, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (temp >=3D maxs[ext_range] || temp < mins[ext_range]) {
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " =C2=B0C is out=
 of range",
+                   temp / 1000, temp % 1000);
+        return;
+    }
+
+    if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
+        error_setg(errp, "error reading %s: %m", name);
+        return;
+    }
+
+    if (tempid >=3D 4 || tempid < 0) {
+        error_setg(errp, "error reading %s", name);
+        return;
+    }
+
+    s->temperature[tempid] =3D (int16_t) ((temp * 256 - 128) / 1000) + o=
ffset;
+}
+
+static void tmp421_read(TMP421State *s)
+{
+    TMP421Class *sc =3D TMP421_GET_CLASS(s);
+
+    s->len =3D 0;
+
+    switch (s->pointer) {
+    case TMP421_MANUFACTURER_ID_REG:
+        s->buf[s->len++] =3D TMP421_MANUFACTURER_ID;
+        break;
+    case TMP421_DEVICE_ID_REG:
+        s->buf[s->len++] =3D sc->dev->model;
+        break;
+    case TMP421_CONFIG_REG_1:
+        s->buf[s->len++] =3D s->config[0];
+        break;
+    case TMP421_CONFIG_REG_2:
+        s->buf[s->len++] =3D s->config[1];
+        break;
+    case TMP421_CONVERSION_RATE_REG:
+        s->buf[s->len++] =3D s->rate;
+        break;
+    case TMP421_STATUS_REG:
+        s->buf[s->len++] =3D s->status;
+        break;
+
+        /* FIXME: check for channel enablement in config registers */
+    case TMP421_TEMP_MSB0:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[0]) >> 8);
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[0]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_MSB1:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[1]) >> 8);
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[1]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_MSB2:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[2]) >> 8);
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[2]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_MSB3:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[3]) >> 8);
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[3]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_LSB0:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[0]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_LSB1:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[1]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_LSB2:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[2]) >> 0) & 0xf=
0;
+        break;
+    case TMP421_TEMP_LSB3:
+        s->buf[s->len++] =3D (((uint16_t) s->temperature[3]) >> 0) & 0xf=
0;
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
+        s->rate =3D s->buf[0];
+        break;
+    case TMP421_CONFIG_REG_1:
+        s->config[0] =3D s->buf[0];
+        break;
+    case TMP421_CONFIG_REG_2:
+        s->config[1] =3D s->buf[0];
+        break;
+    case TMP421_RESET:
+        tmp421_reset(I2C_SLAVE(s));
+        break;
+    }
+}
+
+static int tmp421_rx(I2CSlave *i2c)
+{
+    TMP421State *s =3D TMP421(i2c);
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
+    TMP421State *s =3D TMP421(i2c);
+
+    if (s->len =3D=3D 0) {
+        /* first byte is the register pointer for a read or write
+         * operation */
+        s->pointer =3D data;
+        s->len++;
+    } else if (s->len =3D=3D 1) {
+        /* second byte is the data to write. The device only supports
+         * one byte writes */
+        s->buf[0] =3D data;
+        tmp421_write(s);
+    }
+
+    return 0;
+}
+
+static int tmp421_event(I2CSlave *i2c, enum i2c_event event)
+{
+    TMP421State *s =3D TMP421(i2c);
+
+    if (event =3D=3D I2C_START_RECV) {
+        tmp421_read(s);
+    }
+
+    s->len =3D 0;
+    return 0;
+}
+
+static const VMStateDescription vmstate_tmp421 =3D {
+    .name =3D "TMP421",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
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
+    TMP421State *s =3D TMP421(i2c);
+    TMP421Class *sc =3D TMP421_GET_CLASS(s);
+
+    memset(s->temperature, 0, sizeof(s->temperature));
+    s->pointer =3D 0;
+
+    s->config[0] =3D 0; /* TMP421_CONFIG_RANGE */
+
+     /* resistance correction and channel enablement */
+    switch (sc->dev->model) {
+    case TMP421_DEVICE_ID:
+        s->config[1] =3D 0x1c;
+        break;
+    case TMP422_DEVICE_ID:
+        s->config[1] =3D 0x3c;
+        break;
+    case TMP423_DEVICE_ID:
+        s->config[1] =3D 0x7c;
+        break;
+    }
+
+    s->rate =3D 0x7;       /* 8Hz */
+    s->status =3D 0;
+}
+
+static int tmp421_init(I2CSlave *i2c)
+{
+    TMP421State *s =3D TMP421(i2c);
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
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+    TMP421Class *sc =3D TMP421_CLASS(klass);
+
+    k->init =3D tmp421_init;
+    k->event =3D tmp421_event;
+    k->recv =3D tmp421_rx;
+    k->send =3D tmp421_tx;
+    dc->vmsd =3D &vmstate_tmp421;
+    sc->dev =3D (DeviceInfo *) data;
+}
+
+static const TypeInfo tmp421_info =3D {
+    .name          =3D TYPE_TMP421,
+    .parent        =3D TYPE_I2C_SLAVE,
+    .instance_size =3D sizeof(TMP421State),
+    .instance_init =3D tmp421_initfn,
+    .class_init    =3D tmp421_class_init,
+};
+
+static void tmp421_register_types(void)
+{
+    int i;
+
+    type_register_static(&tmp421_info);
+    for (i =3D 0; i < ARRAY_SIZE(devices); ++i) {
+        TypeInfo ti =3D {
+            .name       =3D devices[i].name,
+            .parent     =3D TYPE_TMP421,
+            .class_init =3D tmp421_class_init,
+            .class_data =3D (void *) &devices[i],
+        };
+        type_register(&ti);
+    }
+}
+
+type_init(tmp421_register_types)
--=20
2.7.4
