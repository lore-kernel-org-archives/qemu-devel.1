Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWh-00031j-Vw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWb-0004uQ-U2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWb-0004tj-Km
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWa-0001MJ-Eu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:52 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:17 +0000
Message-Id: <20180302110640.28004-17-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/39] hw/core/split-irq: Device that splits IRQ
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In some board or SoC models it is necessary to split a qemu_irq line
so that one input can feed multiple outputs.  We currently have
qemu_irq_split() for this, but that has several deficiencies:
 * it can only handle splitting a line into two
 * it unavoidably leaks memory, so it can't be used
   in a device that can be deleted

Implement a qdev device that encapsulates splitting of IRQs, with a
configurable number of outputs.  (This is in some ways the inverse of
the TYPE_OR_IRQ device.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-13-peter.maydell@linaro.org
---
 hw/core/Makefile.objs       |  1 +
 include/hw/core/split-irq.h | 57 +++++++++++++++++++++++++++++
 include/hw/irq.h            |  4 +-
 hw/core/split-irq.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/core/split-irq.h
 create mode 100644 hw/core/split-irq.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1240728c87..eb88ca979e 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -18,6 +18,7 @@ common-obj-$(CONFIG_FITLOADER) += loader-fit.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_SOFTMMU) += or-irq.o
+common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 
 obj-$(CONFIG_SOFTMMU) += generic-loader.o
diff --git a/include/hw/core/split-irq.h b/include/hw/core/split-irq.h
new file mode 100644
index 0000000000..bb87157c5a
--- /dev/null
+++ b/include/hw/core/split-irq.h
@@ -0,0 +1,57 @@
+/*
+ * IRQ splitter device.
+ *
+ * Copyright (c) 2018 Linaro Limited.
+ * Written by Peter Maydell
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
+/* This is a simple device which has one GPIO input line and multiple
+ * GPIO output lines. Any change on the input line is forwarded to all
+ * of the outputs.
+ *
+ * QEMU interface:
+ *  + one unnamed GPIO input: the input line
+ *  + N unnamed GPIO outputs: the output lines
+ *  + QOM property "num-lines": sets the number of output lines
+ */
+#ifndef HW_SPLIT_IRQ_H
+#define HW_SPLIT_IRQ_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_SPLIT_IRQ "split-irq"
+
+#define MAX_SPLIT_LINES 16
+
+typedef struct SplitIRQ SplitIRQ;
+
+#define SPLIT_IRQ(obj) OBJECT_CHECK(SplitIRQ, (obj), TYPE_SPLIT_IRQ)
+
+struct SplitIRQ {
+    DeviceState parent_obj;
+
+    qemu_irq out_irq[MAX_SPLIT_LINES];
+    uint16_t num_lines;
+};
+
+#endif
diff --git a/include/hw/irq.h b/include/hw/irq.h
index 4c4c2eaf9a..7a40e3ed26 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -50,7 +50,9 @@ void qemu_free_irq(qemu_irq irq);
 /* Returns a new IRQ with opposite polarity.  */
 qemu_irq qemu_irq_invert(qemu_irq irq);
 
-/* Returns a new IRQ which feeds into both the passed IRQs */
+/* Returns a new IRQ which feeds into both the passed IRQs.
+ * It's probably better to use the TYPE_SPLIT_IRQ device instead.
+ */
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
 
 /* Returns a new IRQ set which connects 1:1 to another IRQ set, which
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
new file mode 100644
index 0000000000..7e64cd4969
--- /dev/null
+++ b/hw/core/split-irq.c
@@ -0,0 +1,89 @@
+/*
+ * IRQ splitter device.
+ *
+ * Copyright (c) 2018 Linaro Limited.
+ * Written by Peter Maydell
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
+#include "hw/core/split-irq.h"
+#include "qapi/error.h"
+
+static void split_irq_handler(void *opaque, int n, int level)
+{
+    SplitIRQ *s = SPLIT_IRQ(opaque);
+    int i;
+
+    for (i = 0; i < s->num_lines; i++) {
+        qemu_set_irq(s->out_irq[i], level);
+    }
+}
+
+static void split_irq_init(Object *obj)
+{
+    qdev_init_gpio_in(DEVICE(obj), split_irq_handler, 1);
+}
+
+static void split_irq_realize(DeviceState *dev, Error **errp)
+{
+    SplitIRQ *s = SPLIT_IRQ(dev);
+
+    if (s->num_lines < 1 || s->num_lines >= MAX_SPLIT_LINES) {
+        error_setg(errp,
+                   "IRQ splitter number of lines %d is not between 1 and %d",
+                   s->num_lines, MAX_SPLIT_LINES);
+        return;
+    }
+
+    qdev_init_gpio_out(dev, s->out_irq, s->num_lines);
+}
+
+static Property split_irq_properties[] = {
+    DEFINE_PROP_UINT16("num-lines", SplitIRQ, num_lines, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void split_irq_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /* No state to reset or migrate */
+    dc->props = split_irq_properties;
+    dc->realize = split_irq_realize;
+
+    /* Reason: Needs to be wired up to work */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo split_irq_type_info = {
+   .name = TYPE_SPLIT_IRQ,
+   .parent = TYPE_DEVICE,
+   .instance_size = sizeof(SplitIRQ),
+   .instance_init = split_irq_init,
+   .class_init = split_irq_class_init,
+};
+
+static void split_irq_register_types(void)
+{
+    type_register_static(&split_irq_type_info);
+}
+
+type_init(split_irq_register_types)
-- 
2.16.2
