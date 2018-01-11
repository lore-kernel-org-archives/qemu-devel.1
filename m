Received: from eggs.gnu.org ([2001:4830:134:3::10]:48098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWk-0003G8-Ki
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWi-0008KS-H4
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:34 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWi-0008K0-8b
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:32 -0500
Received: by mail-pg0-x242.google.com with SMTP id 136so1113344pgd.8
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:32 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:55 -0800
Message-Id: <1515637324-96034-13-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 12/21] RISC-V HART Array
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

Holds the state of a heterogenous array of RISC-V hardware threads.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/riscv_hart.c         | 95 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/riscv_hart.h | 45 ++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 hw/riscv/riscv_hart.c
 create mode 100644 include/hw/riscv/riscv_hart.h

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
new file mode 100644
index 0000000..a7e079e
--- /dev/null
+++ b/hw/riscv/riscv_hart.c
@@ -0,0 +1,95 @@
+/*
+ * QEMU RISCV Hart Array
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * Holds the state of a heterogenous array of RISC-V harts
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
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_hart.h"
+
+static Property riscv_harts_props[] = {
+    DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
+    DEFINE_PROP_STRING("cpu-model", RISCVHartArrayState, cpu_model),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void riscv_harts_cpu_reset(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    cpu_reset(CPU(cpu));
+}
+
+static void riscv_harts_realize(DeviceState *dev, Error **errp)
+{
+    RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
+    Error *err = NULL;
+    int n;
+
+    s->harts = g_new0(RISCVCPU, s->num_harts);
+
+    for (n = 0; n < s->num_harts; n++) {
+
+        object_initialize(&s->harts[n], sizeof(RISCVCPU), s->cpu_model);
+        s->harts[n].env.mhartid = n;
+        object_property_add_child(OBJECT(s), "harts[*]", OBJECT(&s->harts[n]),
+                                  &error_abort);
+        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
+        object_property_set_bool(OBJECT(&s->harts[n]), true,
+                                 "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+}
+
+static void riscv_harts_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = riscv_harts_props;
+    dc->realize = riscv_harts_realize;
+}
+
+static void riscv_harts_init(Object *obj)
+{
+    /* RISCVHartArrayState *s = SIFIVE_COREPLEX(obj); */
+}
+
+static const TypeInfo riscv_harts_info = {
+    .name          = TYPE_RISCV_HART_ARRAY,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVHartArrayState),
+    .instance_init = riscv_harts_init,
+    .class_init    = riscv_harts_class_init,
+};
+
+static void riscv_harts_register_types(void)
+{
+    type_register_static(&riscv_harts_info);
+}
+
+type_init(riscv_harts_register_types)
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
new file mode 100644
index 0000000..c45e987
--- /dev/null
+++ b/include/hw/riscv/riscv_hart.h
@@ -0,0 +1,45 @@
+/*
+ * QEMU RISC-V Hart Array interface
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * Holds the state of a heterogenous array of RISC-V harts
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
+#ifndef HW_RISCV_HART_H
+#define HW_RISCV_HART_H
+
+#define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
+
+#define RISCV_HART_ARRAY(obj) \
+    OBJECT_CHECK(RISCVHartArrayState, (obj), TYPE_RISCV_HART_ARRAY)
+
+typedef struct RISCVHartArrayState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    uint32_t num_harts;
+    char *cpu_model;
+    RISCVCPU *harts;
+} RISCVHartArrayState;
+
+#endif
-- 
2.7.0
