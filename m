Received: from eggs.gnu.org ([2001:4830:134:3::10]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXD8-00061q-Er
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXD7-0008JS-4E
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:14 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWXD6-0008J9-SW
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:47:13 -0500
Received: by mail-pl0-x242.google.com with SMTP id bd8so136067plb.9
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:47:12 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  3 Jan 2018 13:44:22 +1300
Message-Id: <1514940265-18093-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 18/21] SiFive RISC-V PRCI Block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Simple model of the PRCI  (Power, Reset, Clock, Interrupt) to emulate
register reads made by the SDK BSP.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_prci.c         | 107 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_prci.h |  43 +++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 hw/riscv/sifive_prci.c
 create mode 100644 include/hw/riscv/sifive_prci.h

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
new file mode 100644
index 0000000..5c27696
--- /dev/null
+++ b/hw/riscv/sifive_prci.c
@@ -0,0 +1,107 @@
+/*
+ * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * Simple model of the PRCI to emulate register reads made by the SDK BSP
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
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/sifive_prci.h"
+
+/* currently implements enough to mock freedom-e-sdk BSP clock programming */
+
+static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    if (addr == 0 /* PRCI_HFROSCCFG */) {
+        return 1 << 31; /* ROSC_RDY */
+    }
+    if (addr == 8 /* PRCI_PLLCFG    */) {
+        return 1 << 31; /* PLL_LOCK */
+    }
+    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
+    return 0;
+}
+
+static void sifive_prci_write(void *opaque, hwaddr addr,
+           uint64_t val64, unsigned int size)
+{
+    /* discard writes */
+}
+
+static const MemoryRegionOps sifive_prci_ops = {
+    .read = sifive_prci_read,
+    .write = sifive_prci_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static Property sifive_prci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sifive_prci_init(Object *obj)
+{
+    SiFivePRCIState *s = SIFIVE_PRCI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
+                          TYPE_SIFIVE_PRCI, 0x8000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void sifive_prci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = sifive_prci_properties;
+}
+
+static const TypeInfo sifive_prci_info = {
+    .name          = TYPE_SIFIVE_PRCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFivePRCIState),
+    .instance_init = sifive_prci_init,
+    .class_init    = sifive_prci_class_init,
+};
+
+static void sifive_prci_register_types(void)
+{
+    type_register_static(&sifive_prci_info);
+}
+
+type_init(sifive_prci_register_types)
+
+
+/*
+ * Create PRCI device.
+ */
+DeviceState *sifive_prci_create(hwaddr addr)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PRCI);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    return dev;
+}
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prci.h
new file mode 100644
index 0000000..0e032e5
--- /dev/null
+++ b/include/hw/riscv/sifive_prci.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt) interface
+ *
+ * Copyright (c) 2017 SiFive, Inc.
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
+#ifndef HW_SIFIVE_PRCI_H
+#define HW_SIFIVE_PRCI_H
+
+#define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
+
+#define SIFIVE_PRCI(obj) \
+    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_PRCI)
+
+typedef struct SiFivePRCIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+} SiFivePRCIState;
+
+DeviceState *sifive_prci_create(hwaddr addr);
+
+#endif
-- 
2.7.0
