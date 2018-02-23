Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep11e-0001bU-Jc
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ep10f-0006yb-7t
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:15:46 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ep10e-0006wD-KQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 19:14:44 -0500
Received: by mail-pf0-x243.google.com with SMTP id a17so2776532pff.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 16:14:44 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 23 Feb 2018 13:12:06 +1300
Message-Id: <1519344729-73482-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1519344729-73482-1-git-send-email-mjc@sifive.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 20/23] SiFive RISC-V Test Finisher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Test finisher memory mapped device used to exit simulation.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/sifive_test.c         | 99 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_test.h | 48 ++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 hw/riscv/sifive_test.c
 create mode 100644 include/hw/riscv/sifive_test.h

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
new file mode 100644
index 0000000..9696f15
--- /dev/null
+++ b/hw/riscv/sifive_test.c
@@ -0,0 +1,99 @@
+/*
+ * QEMU SiFive Test Finisher
+ *
+ * Copyright (c) 2018 SiFive, Inc.
+ *
+ * Test finisher memory mapped device used to exit simulation
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
+#include "hw/riscv/sifive_test.h"
+
+static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    return 0;
+}
+
+static void sifive_test_write(void *opaque, hwaddr addr,
+           uint64_t val64, unsigned int size)
+{
+    if (addr == 0) {
+        int status = val64 & 0xffff;
+        int code = (val64 >> 16) & 0xffff;
+        switch (status) {
+        case FINISHER_FAIL:
+            exit(code);
+        case FINISHER_PASS:
+            exit(0);
+        default:
+            break;
+        }
+    }
+    hw_error("%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
+        __func__, (int)addr, val64);
+}
+
+static const MemoryRegionOps sifive_test_ops = {
+    .read = sifive_test_read,
+    .write = sifive_test_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static void sifive_test_init(Object *obj)
+{
+    SiFiveTestState *s = SIFIVE_TEST(obj);
+
+    memory_region_init_io(&s->mmio, obj, &sifive_test_ops, s,
+                          TYPE_SIFIVE_TEST, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const TypeInfo sifive_test_info = {
+    .name          = TYPE_SIFIVE_TEST,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveTestState),
+    .instance_init = sifive_test_init,
+};
+
+static void sifive_test_register_types(void)
+{
+    type_register_static(&sifive_test_info);
+}
+
+type_init(sifive_test_register_types)
+
+
+/*
+ * Create Test device.
+ */
+DeviceState *sifive_test_create(hwaddr addr)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_TEST);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    return dev;
+}
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
new file mode 100644
index 0000000..6a0f5bb
--- /dev/null
+++ b/include/hw/riscv/sifive_test.h
@@ -0,0 +1,48 @@
+/*
+ * QEMU Test Finisher interface
+ *
+ * Copyright (c) 2018 SiFive, Inc.
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
+#ifndef HW_SIFIVE_TEST_H
+#define HW_SIFIVE_TEST_H
+
+#define TYPE_SIFIVE_TEST "riscv.sifive.test"
+
+#define SIFIVE_TEST(obj) \
+    OBJECT_CHECK(SiFiveTestState, (obj), TYPE_SIFIVE_TEST)
+
+typedef struct SiFiveTestState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+} SiFiveTestState;
+
+enum {
+    FINISHER_FAIL = 0x3333,
+    FINISHER_PASS = 0x5555
+};
+
+DeviceState *sifive_test_create(hwaddr addr);
+
+#endif
-- 
2.7.0
