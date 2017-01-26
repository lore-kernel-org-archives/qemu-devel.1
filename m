Received: from eggs.gnu.org ([2001:4830:134:3::10]:39099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWges-000541-VV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgen-0000mB-KL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:59 -0500
Received: from greensocs.com ([193.104.36.180]:33017)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cWgen-0000lP-3y
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:47:53 -0500
From: fred.konrad@greensocs.com
Date: Thu, 26 Jan 2017 10:47:31 +0100
Message-Id: <1485424060-12217-2-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 01/10] qemu-clk: introduce qemu-clk qom
 object
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

This introduces qemu-clk qom object.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 Makefile.objs             |  1 +
 include/qemu/qemu-clock.h | 40 +++++++++++++++++++++++++++++++++++++
 qemu-clock.c              | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 include/qemu/qemu-clock.h
 create mode 100644 qemu-clock.c

diff --git a/Makefile.objs b/Makefile.objs
index 01cef86..de0219d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -78,6 +78,7 @@ common-obj-y += backends/
 common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
 
 common-obj-$(CONFIG_FDT) += device_tree.o
+common-obj-y += qemu-clock.o
 
 ######################################################################
 # qapi
diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
new file mode 100644
index 0000000..e7acd68
--- /dev/null
+++ b/include/qemu/qemu-clock.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Clock
+ *
+ *  Copyright (C) 2016 : GreenSocs Ltd
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Frederic Konrad <fred.konrad@greensocs.com>
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
+#ifndef QEMU_CLOCK_H
+#define QEMU_CLOCK_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+
+#define TYPE_CLOCK "qemu-clk"
+#define QEMU_CLOCK(obj) OBJECT_CHECK(struct qemu_clk, (obj), TYPE_CLOCK)
+
+typedef struct qemu_clk {
+    /*< private >*/
+    Object parent_obj;
+} *qemu_clk;
+
+#endif /* QEMU_CLOCK_H */
+
+
diff --git a/qemu-clock.c b/qemu-clock.c
new file mode 100644
index 0000000..ceea98d
--- /dev/null
+++ b/qemu-clock.c
@@ -0,0 +1,50 @@
+/*
+ * QEMU Clock
+ *
+ *  Copyright (C) 2016 : GreenSocs Ltd
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Frederic Konrad <fred.konrad@greensocs.com>
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
+#include "qemu/qemu-clock.h"
+#include "hw/hw.h"
+#include "qemu/log.h"
+
+#ifndef DEBUG_QEMU_CLOCK
+#define DEBUG_QEMU_CLOCK 0
+#endif
+
+#define DPRINTF(fmt, args...) do {                                           \
+    if (DEBUG_QEMU_CLOCK) {                                                  \
+        qemu_log("%s: " fmt, __func__, ## args);                             \
+    }                                                                        \
+} while (0);
+
+static const TypeInfo qemu_clk_info = {
+    .name          = TYPE_CLOCK,
+    .parent        = TYPE_OBJECT,
+    .instance_size = sizeof(struct qemu_clk),
+};
+
+static void qemu_clk_register_types(void)
+{
+    type_register_static(&qemu_clk_info);
+}
+
+type_init(qemu_clk_register_types);
-- 
1.8.3.1
