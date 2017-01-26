Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgex-0005HR-Fw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWges-0000s2-L0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:03 -0500
Received: from greensocs.com ([193.104.36.180]:33119)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWges-0000qk-A5
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:58 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:37 +0100
Message-Id: <1485424060-12217-8-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 07/10] introduce fixed-clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This is a fixed clock device.
It justs behave as an empty device with a parametrable output rate.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 hw/misc/Makefile.objs         |  1 +
 hw/misc/fixed-clock.c         | 88 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/fixed-clock.h | 30 +++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 hw/misc/fixed-clock.c
 create mode 100644 include/hw/misc/fixed-clock.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 1a89615..2670c2d 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,3 +53,4 @@ obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+obj-y += fixed-clock.o
diff --git a/hw/misc/fixed-clock.c b/hw/misc/fixed-clock.c
new file mode 100644
index 0000000..aa124d8
--- /dev/null
+++ b/hw/misc/fixed-clock.c
@@ -0,0 +1,88 @@
+/*
+ * Fixed clock
+ *
+ *  Copyright (C) 2016 : GreenSocs Ltd
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Frederic Konrad   <fred.konrad@greensocs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "hw/misc/fixed-clock.h"
+#include "qemu/qemu-clock.h"
+#include "qapi/error.h"
+
+#ifndef DEBUG_FIXED_CLOCK
+#define DEBUG_FIXED_CLOCK 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                               \
+    if (DEBUG_FIXED_CLOCK) {                                                 \
+        qemu_log(__FILE__": " fmt , ## __VA_ARGS__);                         \
+    }                                                                        \
+} while (0);
+
+typedef struct {
+    DeviceState parent_obj;
+
+    uint32_t rate;
+    struct qemu_clk out;
+} FixedClock;
+
+static Property fixed_clock_properties[] = {
+    DEFINE_PROP_UINT32("rate", FixedClock, rate, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void fixed_clock_realizefn(DeviceState *dev, Error **errp)
+{
+    FixedClock *s = FIXED_CLOCK(dev);
+
+    qemu_clk_update_rate(&s->out, s->rate);
+}
+
+static void fixed_clock_instance_init(Object *obj)
+{
+    FixedClock *s = FIXED_CLOCK(obj);
+
+    object_initialize(&s->out, sizeof(s->out), TYPE_CLOCK);
+    qemu_clk_device_add_clock(DEVICE(obj), &s->out, "clk_out");
+}
+
+static void fixed_clock_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = fixed_clock_realizefn;
+    dc->props = fixed_clock_properties;
+}
+
+static const TypeInfo fixed_clock_info = {
+    .name          = TYPE_FIXED_CLOCK,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(FixedClock),
+    .instance_init = fixed_clock_instance_init,
+    .class_init    = fixed_clock_class_init,
+};
+
+static void fixed_clock_register_types(void)
+{
+    type_register_static(&fixed_clock_info);
+}
+
+type_init(fixed_clock_register_types);
diff --git a/include/hw/misc/fixed-clock.h b/include/hw/misc/fixed-clock.h
new file mode 100644
index 0000000..1376444
--- /dev/null
+++ b/include/hw/misc/fixed-clock.h
@@ -0,0 +1,30 @@
+/*
+ * Fixed clock
+ *
+ *  Copyright (C) 2016 : GreenSocs Ltd
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Frederic Konrad   <fred.konrad@greensocs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef FIXED_CLOCK_H
+#define FIXED_CLOCK_H
+
+#define TYPE_FIXED_CLOCK "fixed-clock"
+#define FIXED_CLOCK(obj) OBJECT_CHECK(FixedClock, (obj), TYPE_FIXED_CLOCK)
+
+#endif /* FIXED_CLOCK_H */
-- 
1.8.3.1
