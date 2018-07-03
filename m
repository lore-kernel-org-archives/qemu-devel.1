Received: from eggs.gnu.org ([2001:4830:134:3::10]:39900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKY-0002sv-HE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKW-00072f-7X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:56 +1000
Message-Id: <20180703055804.13449-28-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/35] hw/timer: Add basic M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
of day is implemented. Setting time and RTC alarm are not supported.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   1 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 ++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 hw/timer/m41t80.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42a1892d6a..6630d691d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -851,6 +851,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ide/sii3112.c
+F: hw/timer/m41t80.c
=20
 SH4 Machines
 ------------
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index 475120bda2..7e1a3d8135 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -28,6 +28,7 @@ CONFIG_SM501=3Dy
 CONFIG_IDE_SII3112=3Dy
 CONFIG_I2C=3Dy
 CONFIG_BITBANG_I2C=3Dy
+CONFIG_M41T80=3Dy
=20
 # For Macs
 CONFIG_MAC=3Dy
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8b27a4b7ef..e16b2b913c 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
 common-obj-$(CONFIG_DS1338) +=3D ds1338.o
 common-obj-$(CONFIG_HPET) +=3D hpet.o
 common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
+common-obj-$(CONFIG_M41T80) +=3D m41t80.o
 common-obj-$(CONFIG_M48T59) +=3D m48t59.o
 ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
new file mode 100644
index 0000000000..734d7d95fc
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
+    M41t80State *s =3D M41T80(dev);
+
+    s->addr =3D -1;
+}
+
+static int m41t80_send(I2CSlave *i2c, uint8_t data)
+{
+    M41t80State *s =3D M41T80(i2c);
+
+    if (s->addr < 0) {
+        s->addr =3D data;
+    } else {
+        s->addr++;
+    }
+    return 0;
+}
+
+static int m41t80_recv(I2CSlave *i2c)
+{
+    M41t80State *s =3D M41T80(i2c);
+    struct tm now;
+    qemu_timeval tv;
+
+    if (s->addr < 0) {
+        s->addr =3D 0;
+    }
+    if (s->addr >=3D 1 && s->addr <=3D 7) {
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
+    M41t80State *s =3D M41T80(i2c);
+
+    if (event =3D=3D I2C_START_SEND) {
+        s->addr =3D -1;
+    }
+    return 0;
+}
+
+static void m41t80_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
+
+    dc->realize =3D m41t80_realize;
+    sc->send =3D m41t80_send;
+    sc->recv =3D m41t80_recv;
+    sc->event =3D m41t80_event;
+}
+
+static const TypeInfo m41t80_info =3D {
+    .name          =3D TYPE_M41T80,
+    .parent        =3D TYPE_I2C_SLAVE,
+    .instance_size =3D sizeof(M41t80State),
+    .class_init    =3D m41t80_class_init,
+};
+
+static void m41t80_register_types(void)
+{
+    type_register_static(&m41t80_info);
+}
+
+type_init(m41t80_register_types)
--=20
2.17.1
