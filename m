Received: from eggs.gnu.org ([2001:4830:134:3::10]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjE9-0001nY-TY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjE8-00022t-Rf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:46 -0300
Message-Id: <20180109020054.32553-2-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 1/9] hw/sysbus: add helpers to register
 FDT aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sysbus-fdt.h | 18 ++++++++++++++++++
 hw/core/sysbus-fdt.c    | 30 ++++++++++++++++++++++++++++++
 hw/core/Makefile.objs   |  1 +
 3 files changed, 49 insertions(+)
 create mode 100644 include/hw/sysbus-fdt.h
 create mode 100644 hw/core/sysbus-fdt.c

diff --git a/include/hw/sysbus-fdt.h b/include/hw/sysbus-fdt.h
new file mode 100644
index 0000000000..21f42dbbad
--- /dev/null
+++ b/include/hw/sysbus-fdt.h
@@ -0,0 +1,18 @@
+/*
+ * Flattened Device Tree alias helpers
+ *
+ * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#ifndef HW_SYSBUS_FDT_H
+#define HW_SYSBUS_FDT_H
+
+void type_register_fdt_alias(const char *name, const char *alias);
+void type_register_fdt_aliases(const char *name, const char **aliases);
+
+const char *type_resolve_fdt_alias(const char *alias);
+
+#endif /* HW_SYSBUS_FDT_H */
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
new file mode 100644
index 0000000000..0d817ba230
--- /dev/null
+++ b/hw/core/sysbus-fdt.c
@@ -0,0 +1,30 @@
+#include "qemu/osdep.h"
+#include "hw/sysbus-fdt.h"
+
+static GHashTable *fdt_aliases(void)
+{
+    static GHashTable *fdt_aliases_singleton;
+
+    if (!fdt_aliases_singleton) {
+        fdt_aliases_singleton = g_hash_table_new(g_str_hash, g_str_equal);
+    }
+    return fdt_aliases_singleton;
+}
+
+void type_register_fdt_alias(const char *name, const char *alias)
+{
+    g_hash_table_insert(fdt_aliases(), (gpointer)name, (gpointer)name);
+    g_hash_table_insert(fdt_aliases(), (gpointer)alias, (gpointer)name);
+}
+
+void type_register_fdt_aliases(const char *name, const char **aliases)
+{
+    for (; *aliases; aliases++) {
+        type_register_fdt_alias(name, *aliases);
+    }
+}
+
+const char *type_resolve_fdt_alias(const char *alias)
+{
+    return g_hash_table_lookup(fdt_aliases(), alias);
+}
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8d7a4aaed..f56f0755a5 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
+common-obj-$(CONFIG_SOFTMMU) += sysbus-fdt.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_FITLOADER) += loader-fit.o
-- 
2.15.1
