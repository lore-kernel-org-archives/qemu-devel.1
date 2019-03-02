Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy4O-0002xb-LY
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy29-00030H-Ag
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:07 -0500
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:48771)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy28-0002tT-OL
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:05 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:33 +0900
Message-Id: <20190302062138.10713-7-ysato@users.sourceforge.jp>
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 06/11] RX62N interrupt contorol uint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

This implementation supported only ICUa.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf?key=086621e01bd70347c18ea7f794aa9cc3

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/intc/Makefile.objs    |   1 +
 hw/intc/rx_icu.c         | 323 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/intc/rx_icu.h |  49 +++++++
 3 files changed, 373 insertions(+)
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 include/hw/intc/rx_icu.h

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 301a8e972d..ff79edb54b 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -48,3 +48,4 @@ obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
+obj-$(CONFIG_RX) += rx_icu.o
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
new file mode 100644
index 0000000000..573cb144c6
--- /dev/null
+++ b/hw/intc/rx_icu.c
@@ -0,0 +1,323 @@
+/*
+ * RX Interrupt control unit
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/intc/rx_icu.h"
+#include "qemu/error-report.h"
+
+#define request(icu, n) (icu->ipr[icu->map[n]] << 8 | n)
+
+static qemu_irq *rxicu_pin(RXICUState *icu, int n_IRQ)
+{
+    if ((icu->fir & 0x8000) && (icu->fir & 0xff) == n_IRQ) {
+        return &icu->_fir;
+    } else {
+        return &icu->_irq;
+    }
+}
+
+static void rxicu_request(RXICUState *icu, int n_IRQ)
+{
+    int enable;
+
+    enable = icu->ier[n_IRQ / 8] & (1 << (n_IRQ & 7));
+    if (enable != 0 && icu->req_irq < 0) {
+        qemu_set_irq(*rxicu_pin(icu, n_IRQ), 0x1000 | request(icu, n_IRQ));
+        icu->req_irq = n_IRQ;
+    }
+}
+
+static void rxicu_set_irq(void *opaque, int n_IRQ, int level)
+{
+    RXICUState *icu = opaque;
+    struct IRQSource *src;
+    int issue;
+
+    if (n_IRQ >= 256) {
+        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
+        return;
+    }
+
+    src = &icu->src[n_IRQ];
+
+    level = (level != 0);
+    switch (src->sense) {
+    case TRG_LEVEL:
+        /* level-sensitive irq */
+        issue = level;
+        src->level = level;
+        break;
+    case TRG_NEDGE:
+        issue = (level == 0 && src->level == 1);
+        src->level = level;
+        break;
+    case TRG_PEDGE:
+        issue = (level == 1 && src->level == 0);
+        src->level = level;
+        break;
+    case TRG_BEDGE:
+        issue = ((level ^ src->level) & 1);
+        src->level = level;
+        break;
+    }
+    if (issue == 0 && src->sense == TRG_LEVEL) {
+        icu->ir[n_IRQ] = 0;
+        if (icu->req_irq == n_IRQ) {
+            qemu_set_irq(*rxicu_pin(icu, n_IRQ), request(icu, n_IRQ));
+            icu->req_irq = -1;
+        }
+        return;
+    }
+    if (issue) {
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static void rxicu_ack_irq(void *opaque, int no, int level)
+{
+    RXICUState *icu = opaque;
+    int i;
+    int n_IRQ;
+    int max_pri;
+
+    if (icu->req_irq < 0) {
+        return;
+    }
+    if (icu->src[icu->req_irq].sense != TRG_LEVEL) {
+        icu->ir[icu->req_irq] = 0;
+    }
+    icu->req_irq = -1;
+
+    max_pri = 0;
+    n_IRQ = -1;
+    for (i = 0; i < 256; i++) {
+        if (icu->ir[i]) {
+            if (max_pri < icu->ipr[icu->map[i]]) {
+                n_IRQ = i;
+                max_pri = icu->ipr[icu->map[i]];
+            }
+        }
+    }
+    if (n_IRQ >= 0) {
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static uint64_t icu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    RXICUState *icu = opaque;
+    int reg = addr & 0xff;
+    int error;
+
+    error = (!(offset == 0x2f0 && size == 2) &&
+             !(offset != 0x2f0 && size == 1));
+    if (!error) {
+        switch (offset) {
+        case 0x000 ... 0x0ff:
+            return icu->ir[reg] & 1;
+        case 0x100 ... 0x1ff:
+            return icu->dtcer[reg] & 1;
+        case 0x200 ... 0x21f:
+            return icu->ier[reg];
+        case 0x2e0:
+            return 0;
+        case 0x2f0:
+            return icu->fir & 0x80ff;
+        case 0x300 ... 0x38f:
+            return icu->ipr[reg] & 0x0f;
+        case 0x400:
+        case 0x404:
+        case 0x408:
+        case 0x40c:
+            return icu->dmasr[reg >> 2];
+        case 0x500 ... 0x51f:
+            return icu->src[64 + reg].sense << 2;
+        case 0x580:
+        case 0x582:
+            return 0;
+        case 0x581:
+            return icu->nmier;
+        case 0x583:
+            return icu->nmicr;
+        default:
+            error = 1;
+        }
+    }
+    if (error) {
+        error_report("rxicu: unsupported read request at %08lx", addr);
+    }
+    return 0xffffffffffffffffULL;
+}
+
+static void icu_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    hwaddr offset = addr & 0xfff;
+    RXICUState *icu = opaque;
+    int reg = addr & 0xff;
+    int error;
+
+    error = (!(offset == 0x2f0 && size == 2) &&
+             !(offset != 0x2f0 && size == 1));
+
+    if (!error) {
+        switch (offset) {
+        case 0x000 ... 0x0ff:
+            if (icu->src[reg].sense != TRG_LEVEL && val == 0) {
+                icu->ir[reg] = 0;
+            }
+            break;
+        case 0x100 ... 0x1ff:
+            icu->dtcer[reg] = val & 1;
+            break;
+        case 0x200 ... 0x21f:
+            icu->ier[reg] = val;
+            break;
+        case 0x2e0:
+            if (val == 1) {
+                qemu_irq_pulse(icu->_swi);
+            }
+            break;
+        case 0x2f0:
+            icu->fir = val;
+            break;
+        case 0x300 ... 0x38f:
+            icu->ipr[reg] = val & 0x0f;
+            break;
+        case 0x400:
+        case 0x404:
+        case 0x408:
+        case 0x40c:
+            icu->dmasr[reg >> 2] = val;
+            break;
+        case 0x500 ... 0x50f:
+            icu->src[64 + reg].sense = val >> 2;
+            break;
+        case 0x582:
+            break;
+        case 0x581:
+            icu->nmier |= val & 7;
+            break;
+        case 0x583:
+            icu->nmicr = val;
+            break;
+        default:
+            error = 1;
+        }
+    }
+    if (error) {
+        error_report("rxicu: unsupported write request at %08lx", addr);
+    }
+}
+
+static const MemoryRegionOps icu_ops = {
+    .write = icu_write,
+    .read  = icu_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void rxicu_realize(DeviceState *dev, Error **errp)
+{
+    RXICUState *icu = RXICU(dev);
+    int i, j;
+
+    for (i = j = 0; i < 256; i++) {
+        if (icu->init_sense[j] == i) {
+            icu->src[i].sense = TRG_LEVEL;
+            if (j < icu->nr_sense) {
+                j++;
+            }
+        } else
+            icu->src[i].sense = TRG_PEDGE;
+    }
+    icu->req_irq = -1;
+}
+
+static void rxicu_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RXICUState *icu = RXICU(obj);
+
+    memory_region_init_io(&icu->memory, OBJECT(icu), &icu_ops,
+                          icu, "rx-icu", 0x600);
+    sysbus_init_mmio(d, &icu->memory);
+
+    qdev_init_gpio_in(DEVICE(d), rxicu_set_irq, 256);
+    qdev_init_gpio_in_named(DEVICE(d), rxicu_ack_irq, "ack", 1);
+    sysbus_init_irq(d, &icu->_irq);
+    sysbus_init_irq(d, &icu->_fir);
+    sysbus_init_irq(d, &icu->_swi);
+}
+
+static void rxicu_fini(Object *obj)
+{
+    RXICUState *icu = RXICU(obj);
+    g_free(icu->map);
+    g_free(icu->init_sense);
+}
+
+static const VMStateDescription vmstate_rxicu = {
+    .name = "rx-icu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rxicu_properties[] = {
+    DEFINE_PROP_STRING("icutype", RXICUState, icutype),
+    DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rxicu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rxicu_realize;
+    dc->props = rxicu_properties;
+    dc->vmsd = &vmstate_rxicu;
+}
+
+static const TypeInfo rxicu_info = {
+    .name       = TYPE_RXICU,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RXICUState),
+    .instance_init = rxicu_init,
+    .instance_finalize = rxicu_fini,
+    .class_init = rxicu_class_init,
+};
+
+static void rxicu_register_types(void)
+{
+    type_register_static(&rxicu_info);
+}
+
+type_init(rxicu_register_types)
diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
new file mode 100644
index 0000000000..bc46b3079b
--- /dev/null
+++ b/include/hw/intc/rx_icu.h
@@ -0,0 +1,49 @@
+#ifndef RX_ICU_H
+#define RX_ICU_H
+
+#include "qemu-common.h"
+#include "hw/irq.h"
+
+struct IRQSource {
+    int sense;
+    int level;
+};
+
+struct RXICUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+    struct IRQSource src[256];
+    char *icutype;
+    uint32_t nr_irqs;
+    uint32_t *map;
+    uint32_t nr_sense;
+    uint32_t *init_sense;
+
+    uint8_t ir[256];
+    uint8_t dtcer[256];
+    uint8_t ier[32];
+    uint8_t ipr[142];
+    uint8_t dmasr[4];
+    uint16_t fir;
+    uint8_t nmisr;
+    uint8_t nmier;
+    uint8_t nmiclr;
+    uint8_t nmicr;
+    int req_irq;
+    qemu_irq _irq;
+    qemu_irq _fir;
+    qemu_irq _swi;
+};
+typedef struct RXICUState RXICUState;
+
+#define TYPE_RXICU "rxicu"
+#define RXICU(obj) OBJECT_CHECK(RXICUState, (obj), TYPE_RXICU)
+
+#define SWI 27
+#define TRG_LEVEL 0
+#define TRG_NEDGE 1
+#define TRG_PEDGE 2
+#define TRG_BEDGE 3
+
+#endif /* RX_ICU_H */
-- 
2.11.0
