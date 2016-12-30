Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0X-0002Pf-CV
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0V-0000Il-GJ
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0V-0000IV-8z
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:11 -0500
Received: by mail-pg0-x242.google.com with SMTP id i5so22381290pgh.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:11 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:49 -0600
Message-Id: <1483111310-24808-19-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 18/19] i2c: Add an SMBus alert device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This adds a device that conforms to the SMBus alert extension.  This
allows other I2C devices to register with this device so that when
they have data ready, it will interrupt the processor and allow the
processor to read from the alert device to see which i2c device has
data.

To use this, you must first create a named irq and then create
this device with:
  -device smbus-alert,name=<name>,irqname=<irqname>,address=..,bus=..
where the name is the value that other I2C devices will use to attach
to this device and the irqname is the name of the named irq that will
be raised when the data is ready.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/Makefile.objs         |   2 +-
 hw/i2c/smbus_alert.c         | 130 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i2c/smbus.h       |   1 +
 include/hw/i2c/smbus_alert.h |  65 ++++++++++++++++++++++
 4 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/smbus_alert.c
 create mode 100644 include/hw/i2c/smbus_alert.h

diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index a081b8e..7ad3d04 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += core.o smbus.o smbus_eeprom.o
+common-obj-y += core.o smbus.o smbus_eeprom.o smbus_alert.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
diff --git a/hw/i2c/smbus_alert.c b/hw/i2c/smbus_alert.c
new file mode 100644
index 0000000..5be83e7
--- /dev/null
+++ b/hw/i2c/smbus_alert.c
@@ -0,0 +1,130 @@
+/*
+ * QEMU SMBus alert
+ *
+ * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
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
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i2c/smbus_alert.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+
+static void smbus_alert(SMBusAlertDevice *sad, SMBusAlertEntry *alert)
+{
+    if (alert->enqueued) {
+        return;
+    }
+
+    alert->enqueued = true;
+    QSIMPLEQ_INSERT_TAIL(&sad->alert_queue, alert, link);
+    qemu_irq_raise(*sad->irq);
+}
+
+static uint8_t alert_receive_byte(SMBusDevice *dev)
+{
+    SMBusAlertDevice *sad = (SMBusAlertDevice *) dev;
+    SMBusAlertEntry *alert = QSIMPLEQ_FIRST(&sad->alert_queue);
+
+    if (!alert) {
+        return -1;
+    }
+
+    alert->enqueued = false;
+    QSIMPLEQ_REMOVE_HEAD(&sad->alert_queue, link);
+
+    if (QSIMPLEQ_EMPTY(&sad->alert_queue)) {
+            qemu_irq_lower(*sad->irq);
+    }
+
+    return alert->val;
+}
+
+static int smbus_alert_event(SMBusDevice *dev, enum i2c_event event)
+{
+    SMBusAlertDevice *sad = (SMBusAlertDevice *) dev;
+
+    if (event == I2C_START_RECV && QSIMPLEQ_EMPTY(&sad->alert_queue)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static void smbus_alert_realize(DeviceState *dev, Error **errp)
+{
+    SMBusAlertDevice *sad = SMBUS_ALERT_DEVICE(dev);
+    IRQInterfaceClass *iic;
+
+    if (!sad->irqdev) {
+        error_setg(errp, "SMBus alert device created without irqid");
+        return;
+    }
+
+    iic = IRQ_INTERFACE_GET_CLASS(sad->irqdev);
+
+    sad->irq = iic->get_irq(sad->irqdev);
+}
+
+static void irq_check(Object *obj, const char *name,
+                      Object *val, Error **errp)
+{
+    /* Always succeed. */
+}
+
+static void smbus_alert_init(Object *obj)
+{
+    SMBusAlertDevice *sad = SMBUS_ALERT_DEVICE(obj);
+
+    QSIMPLEQ_INIT(&sad->alert_queue);
+
+    object_property_add_link(obj, "irqid", TYPE_IRQ_INTERFACE,
+                             (Object **) &sad->irqdev, irq_check,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             &error_abort);
+}
+
+static void smbus_alert_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(oc);
+    SMBusAlertDeviceClass *sadc = SMBUS_ALERT_DEVICE_CLASS(oc);
+
+    dc->realize = smbus_alert_realize;
+    sc->receive_byte = alert_receive_byte;
+    sc->event = smbus_alert_event;
+    sadc->alert = smbus_alert;
+}
+
+static const TypeInfo smbus_alert_info = {
+    .name          = TYPE_SMBUS_ALERT_DEVICE,
+    .parent        = TYPE_SMBUS_DEVICE,
+    .instance_size = sizeof(SMBusAlertDevice),
+    .instance_init = smbus_alert_init,
+    .class_init    = smbus_alert_class_init,
+    .class_size    = sizeof(SMBusAlertDeviceClass),
+};
+
+static void smbus_alert_register_types(void)
+{
+    type_register_static(&smbus_alert_info);
+}
+
+type_init(smbus_alert_register_types)
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index fc995eb..b6e149a 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -26,6 +26,7 @@
  */
 
 #include "hw/i2c/i2c.h"
+#include "qemu/queue.h"
 
 #define TYPE_SMBUS_DEVICE "smbus-device"
 #define SMBUS_DEVICE(obj) \
diff --git a/include/hw/i2c/smbus_alert.h b/include/hw/i2c/smbus_alert.h
new file mode 100644
index 0000000..0b01be7
--- /dev/null
+++ b/include/hw/i2c/smbus_alert.h
@@ -0,0 +1,65 @@
+/*
+ * QEMU SMBus alert
+ *
+ * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
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
+#include "hw/irqif.h"
+#include "qemu/queue.h"
+#include "hw/i2c/smbus.h"
+
+#ifndef HW_I2C_SMBUS_ALERT
+#define HW_I2C_SMBUS_ALERT
+
+typedef struct SMBusAlertEntry {
+    uint8_t val;
+
+    /* Internal use */
+    bool enqueued;
+    QSIMPLEQ_ENTRY(SMBusAlertEntry) link;
+} SMBusAlertEntry;
+
+typedef struct SMBusAlertDevice {
+    SMBusDevice parent;
+
+    IRQInterface *irqdev;
+    qemu_irq *irq;
+
+    QSIMPLEQ_HEAD(, SMBusAlertEntry) alert_queue;
+} SMBusAlertDevice;
+
+typedef struct SMBusAlertDeviceClass {
+    SMBusDeviceClass parent;
+
+    void (*alert)(SMBusAlertDevice *sad, SMBusAlertEntry *alert);
+} SMBusAlertDeviceClass;
+
+#define TYPE_SMBUS_ALERT_DEVICE "smbus-alert"
+#define SMBUS_ALERT_DEVICE(obj) OBJECT_CHECK(SMBusAlertDevice, (obj),    \
+                                             TYPE_SMBUS_ALERT_DEVICE)
+#define SMBUS_ALERT_DEVICE_CLASS(obj) OBJECT_CLASS_CHECK(SMBusAlertDeviceClass,\
+                                             (obj),            \
+                                             TYPE_SMBUS_ALERT_DEVICE)
+#define SMBUS_ALERT_DEVICE_GET_CLASS(obj) \
+                OBJECT_GET_CLASS(SMBusAlertDeviceClass,  (obj),            \
+                                 TYPE_SMBUS_ALERT_DEVICE)
+
+#endif /* HW_I2C_SMBUS_ALERT */
-- 
2.7.4
