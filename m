Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMn-0005kf-NV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMm-00014r-8L
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:05 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:33943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLCMl-000149-Tq
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:04 -0400
Received: by mail-lf0-x22e.google.com with SMTP id v20so6460081lfa.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:46:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 14 Jun 2017 19:45:51 +0200
Message-Id: <1497462353-3432-6-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 5/7] introduce mmio_interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: fred.konrad@greensocs.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This introduces mmio_interface object which contains a MemoryRegion
and can be hotplugged/hotunplugged.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V1 -> V2:
  * Fix the qemu_log format.
---
 hw/misc/Makefile.objs            |   1 +
 hw/misc/mmio_interface.c         | 128 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/mmio_interface.h |  49 +++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 hw/misc/mmio_interface.c
 create mode 100644 include/hw/misc/mmio_interface.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 2019846..08a79c3 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -57,3 +57,4 @@ obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+obj-y += mmio_interface.o
diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
new file mode 100644
index 0000000..6f004d2
--- /dev/null
+++ b/hw/misc/mmio_interface.c
@@ -0,0 +1,128 @@
+/*
+ * mmio_interface.c
+ *
+ *  Copyright (C) 2017 : GreenSocs
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Developed by :
+ *  Frederic Konrad   <fred.konrad@greensocs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option)any later version.
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
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/mmio_interface.h"
+#include "qapi/error.h"
+
+#ifndef DEBUG_MMIO_INTERFACE
+#define DEBUG_MMIO_INTERFACE 0
+#endif
+
+static uint64_t mmio_interface_counter;
+
+#define DPRINTF(fmt, ...) do {                                                 \
+    if (DEBUG_MMIO_INTERFACE) {                                                \
+        qemu_log("mmio_interface: 0x%" PRIX64 ": " fmt, s->id, ## __VA_ARGS__);\
+    }                                                                          \
+} while (0);
+
+static void mmio_interface_init(Object *obj)
+{
+    MMIOInterface *s = MMIO_INTERFACE(obj);
+
+    if (DEBUG_MMIO_INTERFACE) {
+        s->id = mmio_interface_counter++;
+    }
+
+    DPRINTF("interface created\n");
+    s->host_ptr = 0;
+    s->subregion = 0;
+}
+
+static void mmio_interface_realize(DeviceState *dev, Error **errp)
+{
+    MMIOInterface *s = MMIO_INTERFACE(dev);
+
+    DPRINTF("realize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
+            " %p\n", s->start, s->end, s->host_ptr);
+
+    if (!s->host_ptr) {
+        error_setg(errp, "host_ptr property must be set");
+    }
+
+    if (!s->subregion) {
+        error_setg(errp, "subregion property must be set");
+    }
+
+    memory_region_init_ram_ptr(&s->ram_mem, OBJECT(s), "ram",
+                               s->end - s->start + 1, s->host_ptr);
+    memory_region_set_readonly(&s->ram_mem, s->ro);
+    memory_region_add_subregion(s->subregion, s->start, &s->ram_mem);
+}
+
+static void mmio_interface_unrealize(DeviceState *dev, Error **errp)
+{
+    MMIOInterface *s = MMIO_INTERFACE(dev);
+
+    DPRINTF("unrealize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
+            " %p\n", s->start, s->end, s->host_ptr);
+    memory_region_del_subregion(s->subregion, &s->ram_mem);
+}
+
+static void mmio_interface_finalize(Object *obj)
+{
+    MMIOInterface *s = MMIO_INTERFACE(obj);
+
+    DPRINTF("finalize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
+            " %p\n", s->start, s->end, s->host_ptr);
+    object_unparent(OBJECT(&s->ram_mem));
+}
+
+static Property mmio_interface_properties[] = {
+    DEFINE_PROP_UINT64("start", MMIOInterface, start, 0),
+    DEFINE_PROP_UINT64("end", MMIOInterface, end, 0),
+    DEFINE_PROP_PTR("host_ptr", MMIOInterface, host_ptr),
+    DEFINE_PROP_BOOL("ro", MMIOInterface, ro, false),
+    DEFINE_PROP_MEMORY_REGION("subregion", MMIOInterface, subregion),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void mmio_interface_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = mmio_interface_realize;
+    dc->unrealize = mmio_interface_unrealize;
+    dc->props = mmio_interface_properties;
+}
+
+static const TypeInfo mmio_interface_info = {
+    .name          = TYPE_MMIO_INTERFACE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(MMIOInterface),
+    .instance_init = mmio_interface_init,
+    .instance_finalize = mmio_interface_finalize,
+    .class_init    = mmio_interface_class_init,
+};
+
+static void mmio_interface_register_types(void)
+{
+    type_register_static(&mmio_interface_info);
+}
+
+type_init(mmio_interface_register_types)
diff --git a/include/hw/misc/mmio_interface.h b/include/hw/misc/mmio_interface.h
new file mode 100644
index 0000000..90d34fb
--- /dev/null
+++ b/include/hw/misc/mmio_interface.h
@@ -0,0 +1,49 @@
+/*
+ * mmio_interface.h
+ *
+ *  Copyright (C) 2017 : GreenSocs
+ *      http://www.greensocs.com/ , email: info@greensocs.com
+ *
+ *  Developed by :
+ *  Frederic Konrad   <fred.konrad@greensocs.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option)any later version.
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
+#ifndef MMIO_INTERFACE_H
+#define MMIO_INTERFACE_H
+
+#include "exec/memory.h"
+
+#define TYPE_MMIO_INTERFACE "mmio_interface"
+#define MMIO_INTERFACE(obj) OBJECT_CHECK(MMIOInterface, (obj),                 \
+                                         TYPE_MMIO_INTERFACE)
+
+typedef struct MMIOInterface {
+    DeviceState parent_obj;
+
+    MemoryRegion *subregion;
+    MemoryRegion ram_mem;
+    uint64_t start;
+    uint64_t end;
+    bool ro;
+    uint64_t id;
+    void *host_ptr;
+} MMIOInterface;
+
+void mmio_interface_map(MMIOInterface *s);
+void mmio_interface_unmap(MMIOInterface *s);
+
+#endif /* MMIO_INTERFACE_H */
-- 
2.7.4
