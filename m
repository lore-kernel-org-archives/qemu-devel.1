Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0Y-0002Rf-UX
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0X-0000Jm-Pw
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:14 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0X-0000JN-L4
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:13 -0500
Received: by mail-pf0-x241.google.com with SMTP id i88so22106866pfk.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:13 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:46 -0600
Message-Id: <1483111310-24808-16-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 15/19] hw: Add an IRQ interface
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

This allows IRQs to be created that can be found by other devices
so they can be used without having a direct tie to the irq.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/core/Makefile.objs |  1 +
 hw/core/irqif.c       | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/irqif.h    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 hw/core/irqif.c
 create mode 100644 include/hw/irqif.h

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a4c94e5..764af1c 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-y += fw-path-provider.o
 common-obj-y += irq.o
 common-obj-y += hotplug.o
 obj-y += nmi.o
+common-obj-y += irqif.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
diff --git a/hw/core/irqif.c b/hw/core/irqif.c
new file mode 100644
index 0000000..12449af
--- /dev/null
+++ b/hw/core/irqif.c
@@ -0,0 +1,39 @@
+/*
+ * Interrupt Interface class
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
+#include "qemu/osdep.h"
+#include "hw/irqif.h"
+
+static TypeInfo irq_interface_type_info = {
+    .name = TYPE_IRQ_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(IRQInterfaceClass),
+};
+
+static void ipmi_register_types(void)
+{
+    type_register_static(&irq_interface_type_info);
+}
+
+type_init(ipmi_register_types)
diff --git a/include/hw/irqif.h b/include/hw/irqif.h
new file mode 100644
index 0000000..d733363
--- /dev/null
+++ b/include/hw/irqif.h
@@ -0,0 +1,49 @@
+/*
+ * Interrupt Interface class
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
+#ifndef HW_IRQIF_H
+#define HW_IRQIF_H
+
+#include "hw/hw.h"
+#include "hw/irq.h"
+
+#define TYPE_IRQ_INTERFACE "irq-interface"
+#define IRQ_INTERFACE(obj) \
+     INTERFACE_CHECK(IRQInterface, (obj), TYPE_IRQ_INTERFACE)
+#define IRQ_INTERFACE_CLASS(class) \
+     OBJECT_CLASS_CHECK(IRQInterfaceClass, (class), TYPE_IRQ_INTERFACE)
+#define IRQ_INTERFACE_GET_CLASS(class) \
+     OBJECT_GET_CLASS(IRQInterfaceClass, (class), TYPE_IRQ_INTERFACE)
+
+typedef struct IRQInterface {
+    Object parent;
+} IRQInterface;
+
+typedef struct IRQInterfaceClass {
+    InterfaceClass parent;
+
+    qemu_irq *(*get_irq)(struct IRQInterface *ii);
+} IRQInterfaceClass;
+
+#endif /* HW_IRQIF_H */
-- 
2.7.4
