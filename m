Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0T-0002KL-0f
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0R-0000GX-Q6
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:09 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0R-0000Fj-Kg
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:07 -0500
Received: by mail-pg0-x243.google.com with SMTP id i5so22381151pgh.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:07 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:47 -0600
Message-Id: <1483111310-24808-17-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 16/19] isa: Add an irq device.
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

This uses the new irq interface to allow an ISA irq to be specified
by name.  This will let other things (like the upcoming smbus alert
device) to specify ISA irqs by name.

To create an name ISA irq, add:
  -device isa-irq,irq=<name>,irq=<n>
where you will use the name to look up the irq on a following device.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/isa/Makefile.objs |  2 +-
 hw/isa/isa-irq.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 hw/isa/isa-irq.c

diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 9164556..338dd08 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += isa-bus.o
+common-obj-y += isa-bus.o isa-irq.o
 common-obj-$(CONFIG_APM) += apm.o
 common-obj-$(CONFIG_I82378) += i82378.o
 common-obj-$(CONFIG_PC87312) += pc87312.o
diff --git a/hw/isa/isa-irq.c b/hw/isa/isa-irq.c
new file mode 100644
index 0000000..eee6c0e
--- /dev/null
+++ b/hw/isa/isa-irq.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU ISA named IRQ
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
+#include "hw/irqif.h"
+#include "hw/isa/isa.h"
+
+/* This is the type the user specifies on the -device command line */
+#define TYPE_ISA_IRQ           "isa-irq"
+#define ISA_IRQ(obj) OBJECT_CHECK(ISAIRQDevice, (obj), TYPE_ISA_IRQ)
+
+typedef struct ISAIRQDevice {
+    ISADevice dev;
+    int32_t isairq;
+    qemu_irq irq;
+} ISAIRQDevice;
+
+static qemu_irq *irq_isa_get_irq(IRQInterface *ii)
+{
+    ISAIRQDevice *iid = ISA_IRQ(ii);
+
+    return &iid->irq;
+}
+
+static void irq_isa_realizefn(DeviceState *dev, Error **errp)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    ISAIRQDevice *iid = ISA_IRQ(dev);
+
+    isa_init_irq(isadev, &iid->irq, iid->isairq);
+}
+
+static Property irq_isa_properties[] = {
+    DEFINE_PROP_INT32("irq",   ISAIRQDevice, isairq,  5),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void irq_isa_class_initfn(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    IRQInterfaceClass *ii = IRQ_INTERFACE_CLASS(oc);
+
+    dc->realize = irq_isa_realizefn;
+    dc->props = irq_isa_properties;
+    ii->get_irq = irq_isa_get_irq;
+}
+
+static const TypeInfo irq_isa_info = {
+    .name          = TYPE_ISA_IRQ,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ISAIRQDevice),
+    .class_init    = irq_isa_class_initfn,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IRQ_INTERFACE },
+        { }
+    }
+};
+
+static void irq_register_types(void)
+{
+    type_register_static(&irq_isa_info);
+}
+
+type_init(irq_register_types)
-- 
2.7.4
