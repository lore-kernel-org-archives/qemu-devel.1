Received: from eggs.gnu.org ([2001:4830:134:3::10]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOft-0004JI-FH
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOfs-0003Tm-EM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:57 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dkOfs-0003TN-6B
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:57:56 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so753709pgb.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 22:57:55 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:09 +0900
Message-Id: <ededad1a3abe4ca8dc25fc6eb368fe15a4ccfe12.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 1/5] openrisc/ompic: Add OpenRISC Multicore PIC
 (OMPIC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

Add OpenRISC Multicore PIC which handles inter processor interrupts
(IPI) between cores.  In OpenRISC all device interrupts are routed to
each core enabling this device to be simple.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 default-configs/or1k-softmmu.mak |   1 +
 hw/intc/Makefile.objs            |   1 +
 hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 hw/intc/ompic.c

diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
index 10bfa7abb8..6f5824fd48 100644
--- a/default-configs/or1k-softmmu.mak
+++ b/default-configs/or1k-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
+CONFIG_OMPIC=y
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 78426a7daf..ae358569a1 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -43,3 +43,4 @@ obj-$(CONFIG_ASPEED_SOC) += aspeed_vic.o
 obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
+obj-$(CONFIG_OMPIC) += ompic.o
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
new file mode 100644
index 0000000000..c0e34d1268
--- /dev/null
+++ b/hw/intc/ompic.c
@@ -0,0 +1,179 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Authors: Stafford Horne <shorne@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "exec/memory.h"
+
+#define TYPE_OR1K_OMPIC "or1k-ompic"
+#define OR1K_OMPIC(obj) OBJECT_CHECK(OR1KOMPICState, (obj), TYPE_OR1K_OMPIC)
+
+#define OMPIC_CTRL_IRQ_ACK  (1 << 31)
+#define OMPIC_CTRL_IRQ_GEN  (1 << 30)
+#define OMPIC_CTRL_DST(cpu) (((cpu) >> 16) & 0x3fff)
+
+#define OMPIC_REG(addr)     (((addr) >> 2) & 0x1)
+#define OMPIC_SRC_CPU(addr) (((addr) >> 3) & 0x4f)
+#define OMPIC_DST_CPU(addr) (((addr) >> 3) & 0x4f)
+
+#define OMPIC_STATUS_IRQ_PENDING (1 << 30)
+#define OMPIC_STATUS_SRC(cpu)    (((cpu) & 0x3fff) << 16)
+#define OMPIC_STATUS_DATA(data)  ((data) & 0xffff)
+
+#define OMPIC_CONTROL 0
+#define OMPIC_STATUS  1
+
+#define OMPIC_MAX_CPUS 4 /* Real max is much higher, but dont waste memory */
+#define OMPIC_ADDRSPACE_SZ (OMPIC_MAX_CPUS * 2 * 4) /* 2 32-bit regs per cpu */
+
+typedef struct OR1KOMPICState OR1KOMPICState;
+typedef struct OR1KOMPICCPUState OR1KOMPICCPUState;
+
+struct OR1KOMPICCPUState {
+    qemu_irq irq;
+    uint32_t status;
+    uint32_t control;
+};
+
+struct OR1KOMPICState {
+    SysBusDevice parent_obj;
+    MemoryRegion mr;
+
+    OR1KOMPICCPUState cpus[OMPIC_MAX_CPUS];
+
+    uint32_t num_cpus;
+};
+
+static uint64_t ompic_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OR1KOMPICState *s = opaque;
+    int src_cpu = OMPIC_SRC_CPU(addr);
+
+    /* We can only write to control control, write control + update status */
+    if (OMPIC_REG(addr) == OMPIC_CONTROL) {
+        return s->cpus[src_cpu].control;
+    } else {
+        return s->cpus[src_cpu].status;
+   }
+
+}
+
+static void ompic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
+{
+    OR1KOMPICState *s = opaque;
+    /* We can only write to control control, write control + update status */
+    if (OMPIC_REG(addr) == OMPIC_CONTROL) {
+        int src_cpu = OMPIC_SRC_CPU(addr);
+
+        s->cpus[src_cpu].control = data;
+
+        if (data & OMPIC_CTRL_IRQ_GEN) {
+            int dst_cpu = OMPIC_CTRL_DST(data);
+
+            s->cpus[dst_cpu].status = OMPIC_STATUS_IRQ_PENDING |
+                OMPIC_STATUS_SRC(src_cpu) |
+                OMPIC_STATUS_DATA(data);
+
+            qemu_irq_raise(s->cpus[dst_cpu].irq);
+        }
+        if (data & OMPIC_CTRL_IRQ_ACK) {
+            s->cpus[src_cpu].status &= ~OMPIC_STATUS_IRQ_PENDING;
+            qemu_irq_lower(s->cpus[src_cpu].irq);
+        }
+    }
+}
+
+static const MemoryRegionOps ompic_ops = {
+    .read = ompic_read,
+    .write = ompic_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 8,
+    },
+};
+
+static void or1k_ompic_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    OR1KOMPICState *s = OR1K_OMPIC(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &ompic_ops, s,
+                          "or1k-ompic", OMPIC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void or1k_ompic_realize(DeviceState *dev, Error **errp)
+{
+    OR1KOMPICState *s = OR1K_OMPIC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpus > OMPIC_MAX_CPUS) {
+        error_setg(errp, "Exceeded maximum CPUs %d", s->num_cpus);
+        return;
+    }
+    /* Init IRQ sources for all CPUs */
+    for (i = 0; i < s->num_cpus; i++) {
+        sysbus_init_irq(sbd, &s->cpus[i].irq);
+    }
+}
+
+static Property or1k_ompic_properties[] = {
+    DEFINE_PROP_UINT32("num-cpus", OR1KOMPICState, num_cpus, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_or1k_ompic_cpu = {
+    .name = "or1k_ompic_cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+         VMSTATE_UINT32(status, OR1KOMPICCPUState),
+         VMSTATE_UINT32(control, OR1KOMPICCPUState),
+         VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_or1k_ompic = {
+    .name = TYPE_OR1K_OMPIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+         VMSTATE_STRUCT_ARRAY(cpus, OR1KOMPICState, OMPIC_MAX_CPUS, 1,
+             vmstate_or1k_ompic_cpu, OR1KOMPICCPUState),
+         VMSTATE_UINT32(num_cpus, OR1KOMPICState),
+         VMSTATE_END_OF_LIST()
+    }
+};
+
+static void or1k_ompic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = or1k_ompic_properties;
+    dc->realize = or1k_ompic_realize;
+    dc->vmsd = &vmstate_or1k_ompic;
+}
+
+static const TypeInfo or1k_ompic_info = {
+    .name          = TYPE_OR1K_OMPIC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OR1KOMPICState),
+    .instance_init = or1k_ompic_init,
+    .class_init    = or1k_ompic_class_init,
+};
+
+static void or1k_ompic_register_types(void)
+{
+    type_register_static(&or1k_ompic_info);
+}
+
+type_init(or1k_ompic_register_types)
-- 
2.13.5
