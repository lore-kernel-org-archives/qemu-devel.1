Received: from eggs.gnu.org ([2001:4830:134:3::10]:39584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dB6CA-0006jD-42
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dB6C6-0001JF-3I
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:09:22 -0400
Received: from sonic315-26.consmr.mail.ir2.yahoo.com ([77.238.176.55]:38525)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1dB6C5-0001J7-Po
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:09:18 -0400
Date: Wed, 17 May 2017 21:05:11 +0000 (UTC)
From: John Bradley <flypie@rocketmail.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <218478942.134698.1495055111655@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <218478942.134698.1495055111655.ref@mail.yahoo.com>
Subject: [Qemu-devel] [PATCH] Add BCM2835 devices to Arm hardware.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-website@weilnetz.de" <qemu-website@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Laurent Vivier <lvivier@redhat.com>, Geert Martin Ijewski <gm.ijewski@web.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

>From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
From: John Bradley <flypie@rocketmail.com>
Date: Wed, 17 May 2017 18:57:21 +0100
Subject: [PATCH] Add BCM2835 devices to Arm hardware.

Signed-off-by: John Bradley <flypie@rocketmail.com>
---
hw/arm/bcm2835.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
1 file changed, 114 insertions(+)

diff --git a/hw/arm/bcm2835.c b/hw/arm/bcm2835.c
new file mode 100644
index 0000000000..e5744c1620
--- /dev/null
+++ b/hw/arm/bcm2835.c
@@ -0,0 +1,114 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/arm/bcm2835.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/sysbus.h"
+#include "exec/address-spaces.h"
+
+
+/* Peripheral base address seen by the CPU */
+#define BCM2835_PERI_BASE       0x20000000
+
+static void bcm2835_init(Object *obj)
+{
+    BCM2835State *s = BCM2835(obj);
+
+    object_initialize(&s->cpus[0], sizeof(s->cpus[0]), "arm1176-" TYPE_ARM_CPU);
+    object_property_add_child(obj, "cpu", OBJECT(&s->cpus[0]), &error_abort);
+
+    object_initialize(&s->peripherals, sizeof(s->peripherals),
+                      TYPE_BCM2835_PERIPHERALS);
+    object_property_add_child(obj, "peripherals", OBJECT(&s->peripherals),
+                              &error_abort);
+    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
+                              "board-rev", &error_abort);
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
+                              "vcram-size", &error_abort);
+    qdev_set_parent_bus(DEVICE(&s->peripherals), sysbus_get_default());
+}
+
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835State *s = BCM2835(dev);
+    Object *obj;
+    Error *err = NULL;
+
+    /* common peripherals from bcm2835 */
+    obj = object_property_get_link(OBJECT(dev), "ram", &err);
+    if (obj == NULL) {
+        error_setg(errp, "%s: required ram link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
+                            BCM2835_PERI_BASE, 1);
+
+    object_property_set_bool(OBJECT(&s->cpus[0]), true, "realized", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpus[0]), ARM_CPU_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+                       qdev_get_gpio_in(DEVICE(&s->cpus[0]), ARM_CPU_FIQ));
+}
+
+static Property bcm2835_props[] = {
+    DEFINE_PROP_UINT32("enabled-cpus", BCM2835State, enabled_cpus, BCM2835_NCPUS),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void bcm2835_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->props = bcm2835_props;
+    dc->realize = bcm2835_realize;
+}
+
+static const TypeInfo bcm2835_type_info = {
+    .name = TYPE_BCM2835,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835State),
+    .instance_init = bcm2835_init,
+    .class_init = bcm2835_class_init,
+};
+
+static void bcm2835_register_types(void)
+{
+    type_register_static(&bcm2835_type_info);
+}
+
+type_init(bcm2835_register_types)


 
John Bradley
Tel: 07896 839635
Skype: flypie125
125B Grove Street
Edge Hill 
Liverpool L7 7AF
