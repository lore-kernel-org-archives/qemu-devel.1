Received: from eggs.gnu.org ([2001:4830:134:3::10]:47763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmv9-0004Lt-KH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmv8-0007ok-3l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:03 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVmv8-0007oQ-0d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:02 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so20495386qtb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 14:17:01 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 14:16:47 -0800
Message-Id: <20170123221650.9267-5-rth@twiddle.net>
In-Reply-To: <20170123221650.9267-1-rth@twiddle.net>
References: <20170123221650.9267-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 4/7] nios2: Add IIC interrupt controller
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>

From: Chris Wulff <crwulff@gmail.com>

Add the Altera Nios2 internal interrupt controller model.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Message-Id: <20170118220146.489-5-marex@denx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 hw/intc/Makefile.objs |   1 +
 hw/intc/nios2_iic.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 hw/intc/nios2_iic.c

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 2f44a2d..8948106 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -41,3 +41,4 @@ obj-$(CONFIG_S390_FLIC_KVM) += s390_flic_kvm.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_vic.o
 obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
+obj-$(CONFIG_NIOS2) += nios2_iic.o
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
new file mode 100644
index 0000000..818ab1b
--- /dev/null
+++ b/hw/intc/nios2_iic.c
@@ -0,0 +1,103 @@
+/*
+ * QEMU Altera Internal Interrupt Controller.
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+
+#include "hw/sysbus.h"
+#include "cpu.h"
+
+#define TYPE_ALTERA_IIC "altera,iic"
+#define ALTERA_IIC(obj) \
+    OBJECT_CHECK(AlteraIIC, (obj), TYPE_ALTERA_IIC)
+
+typedef struct AlteraIIC {
+    SysBusDevice  parent_obj;
+    void         *cpu;
+    qemu_irq      parent_irq;
+} AlteraIIC;
+
+static void update_irq(AlteraIIC *pv)
+{
+    CPUNios2State *env = &((Nios2CPU *)(pv->cpu))->env;
+
+    qemu_set_irq(pv->parent_irq,
+                 env->regs[CR_IPENDING] & env->regs[CR_IENABLE]);
+}
+
+static void irq_handler(void *opaque, int irq, int level)
+{
+    AlteraIIC *pv = opaque;
+    CPUNios2State *env = &((Nios2CPU *)(pv->cpu))->env;
+
+    env->regs[CR_IPENDING] &= ~(1 << irq);
+    env->regs[CR_IPENDING] |= !!level << irq;
+
+    update_irq(pv);
+}
+
+static void altera_iic_init(Object *obj)
+{
+    AlteraIIC *pv = ALTERA_IIC(obj);
+
+    qdev_init_gpio_in(DEVICE(pv), irq_handler, 32);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &pv->parent_irq);
+}
+
+static Property altera_iic_properties[] = {
+    DEFINE_PROP_PTR("cpu", AlteraIIC, cpu),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void altera_iic_realize(DeviceState *dev, Error **errp)
+{
+    struct AlteraIIC *pv = ALTERA_IIC(dev);
+
+    if (!pv->cpu) {
+        error_setg(errp, "altera,iic: CPU not connected");
+        return;
+    }
+}
+
+static void altera_iic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = altera_iic_properties;
+    /* Reason: pointer property "cpu" */
+    dc->cannot_instantiate_with_device_add_yet = true;
+    dc->realize = altera_iic_realize;
+}
+
+static TypeInfo altera_iic_info = {
+    .name          = "altera,iic",
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AlteraIIC),
+    .instance_init = altera_iic_init,
+    .class_init    = altera_iic_class_init,
+};
+
+static void altera_iic_register(void)
+{
+    type_register_static(&altera_iic_info);
+}
+
+type_init(altera_iic_register)
-- 
2.9.3
