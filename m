Received: from eggs.gnu.org ([2001:4830:134:3::10]:43448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWf-0002ys-K5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWd-0004us-Ez
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWd-0004uL-3w
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:55 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWb-0001Mo-Qf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:19 +0000
Message-Id: <20180302110640.28004-19-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/39] hw/misc/tz-ppc: Model TrustZone
 peripheral protection controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a model of the TrustZone peripheral protection controller (PPC),
which is used to gate transactions to non-TZ-aware peripherals so
that secure software can configure them to not be accessible to
non-secure software.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-15-peter.maydell@linaro.org
---
 hw/misc/Makefile.objs           |   2 +
 include/hw/misc/tz-ppc.h        | 101 ++++++++++++++
 hw/misc/tz-ppc.c                | 302 ++++++++++++++++++++++++++++++++++++++++
 default-configs/arm-softmmu.mak |   2 +
 hw/misc/trace-events            |  11 ++
 5 files changed, 418 insertions(+)
 create mode 100644 include/hw/misc/tz-ppc.h
 create mode 100644 hw/misc/tz-ppc.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 31f83dcfe7..dcf413d730 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -61,6 +61,8 @@ obj-$(CONFIG_MIPS_ITU) += mips_itu.o
 obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
 obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 
+obj-$(CONFIG_TZ_PPC) += tz-ppc.o
+
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
diff --git a/include/hw/misc/tz-ppc.h b/include/hw/misc/tz-ppc.h
new file mode 100644
index 0000000000..fc8b806e4d
--- /dev/null
+++ b/include/hw/misc/tz-ppc.h
@@ -0,0 +1,101 @@
+/*
+ * ARM TrustZone peripheral protection controller emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+/* This is a model of the TrustZone peripheral protection controller (PPC).
+ * It is documented in the ARM CoreLink SIE-200 System IP for Embedded TRM
+ * (DDI 0571G):
+ * https://developer.arm.com/products/architecture/m-profile/docs/ddi0571/g
+ *
+ * The PPC sits in front of peripherals and allows secure software to
+ * configure it to either pass through or reject transactions.
+ * Rejected transactions may be configured to either be aborted, or to
+ * behave as RAZ/WI. An interrupt can be signalled for a rejected transaction.
+ *
+ * The PPC has no register interface -- it is configured purely by a
+ * collection of input signals from other hardware in the system. Typically
+ * they are either hardwired or exposed in an ad-hoc register interface by
+ * the SoC that uses the PPC.
+ *
+ * This QEMU model can be used to model either the AHB5 or APB4 TZ PPC,
+ * since the only difference between them is that the AHB version has a
+ * "default" port which has no security checks applied. In QEMU the default
+ * port can be emulated simply by wiring its downstream devices directly
+ * into the parent address space, since the PPC does not need to intercept
+ * transactions there.
+ *
+ * In the hardware, selection of which downstream port to use is done by
+ * the user's decode logic asserting one of the hsel[] signals. In QEMU,
+ * we provide 16 MMIO regions, one per port, and the user maps these into
+ * the desired addresses to implement the address decode.
+ *
+ * QEMU interface:
+ * + sysbus MMIO regions 0..15: MemoryRegions defining the upstream end
+ *   of each of the 16 ports of the PPC
+ * + Property "port[0..15]": MemoryRegion defining the downstream device(s)
+ *   for each of the 16 ports of the PPC
+ * + Named GPIO inputs "cfg_nonsec[0..15]": set to 1 if the port should be
+ *   accessible to NonSecure transactions
+ * + Named GPIO inputs "cfg_ap[0..15]": set to 1 if the port should be
+ *   accessible to non-privileged transactions
+ * + Named GPIO input "cfg_sec_resp": set to 1 if a rejected transaction should
+ *   result in a transaction error, or 0 for the transaction to RAZ/WI
+ * + Named GPIO input "irq_enable": set to 1 to enable interrupts
+ * + Named GPIO input "irq_clear": set to 1 to clear a pending interrupt
+ * + Named GPIO output "irq": set for a transaction-failed interrupt
+ * + Property "NONSEC_MASK": if a bit is set in this mask then accesses to
+ *   the associated port do not have the TZ security check performed. (This
+ *   corresponds to the hardware allowing this to be set as a Verilog
+ *   parameter.)
+ */
+
+#ifndef TZ_PPC_H
+#define TZ_PPC_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_TZ_PPC "tz-ppc"
+#define TZ_PPC(obj) OBJECT_CHECK(TZPPC, (obj), TYPE_TZ_PPC)
+
+#define TZ_NUM_PORTS 16
+
+typedef struct TZPPC TZPPC;
+
+typedef struct TZPPCPort {
+    TZPPC *ppc;
+    MemoryRegion upstream;
+    AddressSpace downstream_as;
+    MemoryRegion *downstream;
+} TZPPCPort;
+
+struct TZPPC {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    /* State: these just track the values of our input signals */
+    bool cfg_nonsec[TZ_NUM_PORTS];
+    bool cfg_ap[TZ_NUM_PORTS];
+    bool cfg_sec_resp;
+    bool irq_enable;
+    bool irq_clear;
+    /* State: are we asserting irq ? */
+    bool irq_status;
+
+    qemu_irq irq;
+
+    /* Properties */
+    uint32_t nonsec_mask;
+
+    TZPPCPort port[TZ_NUM_PORTS];
+};
+
+#endif
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
new file mode 100644
index 0000000000..3dd045c15f
--- /dev/null
+++ b/hw/misc/tz-ppc.c
@@ -0,0 +1,302 @@
+/*
+ * ARM TrustZone peripheral protection controller emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/misc/tz-ppc.h"
+
+static void tz_ppc_update_irq(TZPPC *s)
+{
+    bool level = s->irq_status && s->irq_enable;
+
+    trace_tz_ppc_update_irq(level);
+    qemu_set_irq(s->irq, level);
+}
+
+static void tz_ppc_cfg_nonsec(void *opaque, int n, int level)
+{
+    TZPPC *s = TZ_PPC(opaque);
+
+    assert(n < TZ_NUM_PORTS);
+    trace_tz_ppc_cfg_nonsec(n, level);
+    s->cfg_nonsec[n] = level;
+}
+
+static void tz_ppc_cfg_ap(void *opaque, int n, int level)
+{
+    TZPPC *s = TZ_PPC(opaque);
+
+    assert(n < TZ_NUM_PORTS);
+    trace_tz_ppc_cfg_ap(n, level);
+    s->cfg_ap[n] = level;
+}
+
+static void tz_ppc_cfg_sec_resp(void *opaque, int n, int level)
+{
+    TZPPC *s = TZ_PPC(opaque);
+
+    trace_tz_ppc_cfg_sec_resp(level);
+    s->cfg_sec_resp = level;
+}
+
+static void tz_ppc_irq_enable(void *opaque, int n, int level)
+{
+    TZPPC *s = TZ_PPC(opaque);
+
+    trace_tz_ppc_irq_enable(level);
+    s->irq_enable = level;
+    tz_ppc_update_irq(s);
+}
+
+static void tz_ppc_irq_clear(void *opaque, int n, int level)
+{
+    TZPPC *s = TZ_PPC(opaque);
+
+    trace_tz_ppc_irq_clear(level);
+
+    s->irq_clear = level;
+    if (level) {
+        s->irq_status = false;
+        tz_ppc_update_irq(s);
+    }
+}
+
+static bool tz_ppc_check(TZPPC *s, int n, MemTxAttrs attrs)
+{
+    /* Check whether to allow an access to port n; return true if
+     * the check passes, and false if the transaction must be blocked.
+     * If the latter, the caller must check cfg_sec_resp to determine
+     * whether to abort or RAZ/WI the transaction.
+     * The checks are:
+     *  + nonsec_mask suppresses any check of the secure attribute
+     *  + otherwise, block if cfg_nonsec is 1 and transaction is secure,
+     *    or if cfg_nonsec is 0 and transaction is non-secure
+     *  + block if transaction is usermode and cfg_ap is 0
+     */
+    if ((attrs.secure == s->cfg_nonsec[n] && !(s->nonsec_mask & (1 << n))) ||
+        (attrs.user && !s->cfg_ap[n])) {
+        /* Block the transaction. */
+        if (!s->irq_clear) {
+            /* Note that holding irq_clear high suppresses interrupts */
+            s->irq_status = true;
+            tz_ppc_update_irq(s);
+        }
+        return false;
+    }
+    return true;
+}
+
+static MemTxResult tz_ppc_read(void *opaque, hwaddr addr, uint64_t *pdata,
+                               unsigned size, MemTxAttrs attrs)
+{
+    TZPPCPort *p = opaque;
+    TZPPC *s = p->ppc;
+    int n = p - s->port;
+    AddressSpace *as = &p->downstream_as;
+    uint64_t data;
+    MemTxResult res;
+
+    if (!tz_ppc_check(s, n, attrs)) {
+        trace_tz_ppc_read_blocked(n, addr, attrs.secure, attrs.user);
+        if (s->cfg_sec_resp) {
+            return MEMTX_ERROR;
+        } else {
+            *pdata = 0;
+            return MEMTX_OK;
+        }
+    }
+
+    switch (size) {
+    case 1:
+        data = address_space_ldub(as, addr, attrs, &res);
+        break;
+    case 2:
+        data = address_space_lduw_le(as, addr, attrs, &res);
+        break;
+    case 4:
+        data = address_space_ldl_le(as, addr, attrs, &res);
+        break;
+    case 8:
+        data = address_space_ldq_le(as, addr, attrs, &res);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    *pdata = data;
+    return res;
+}
+
+static MemTxResult tz_ppc_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size, MemTxAttrs attrs)
+{
+    TZPPCPort *p = opaque;
+    TZPPC *s = p->ppc;
+    AddressSpace *as = &p->downstream_as;
+    int n = p - s->port;
+    MemTxResult res;
+
+    if (!tz_ppc_check(s, n, attrs)) {
+        trace_tz_ppc_write_blocked(n, addr, attrs.secure, attrs.user);
+        if (s->cfg_sec_resp) {
+            return MEMTX_ERROR;
+        } else {
+            return MEMTX_OK;
+        }
+    }
+
+    switch (size) {
+    case 1:
+        address_space_stb(as, addr, val, attrs, &res);
+        break;
+    case 2:
+        address_space_stw_le(as, addr, val, attrs, &res);
+        break;
+    case 4:
+        address_space_stl_le(as, addr, val, attrs, &res);
+        break;
+    case 8:
+        address_space_stq_le(as, addr, val, attrs, &res);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return res;
+}
+
+static const MemoryRegionOps tz_ppc_ops = {
+    .read_with_attrs = tz_ppc_read,
+    .write_with_attrs = tz_ppc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tz_ppc_reset(DeviceState *dev)
+{
+    TZPPC *s = TZ_PPC(dev);
+
+    trace_tz_ppc_reset();
+    s->cfg_sec_resp = false;
+    memset(s->cfg_nonsec, 0, sizeof(s->cfg_nonsec));
+    memset(s->cfg_ap, 0, sizeof(s->cfg_ap));
+}
+
+static void tz_ppc_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    TZPPC *s = TZ_PPC(obj);
+
+    qdev_init_gpio_in_named(dev, tz_ppc_cfg_nonsec, "cfg_nonsec", TZ_NUM_PORTS);
+    qdev_init_gpio_in_named(dev, tz_ppc_cfg_ap, "cfg_ap", TZ_NUM_PORTS);
+    qdev_init_gpio_in_named(dev, tz_ppc_cfg_sec_resp, "cfg_sec_resp", 1);
+    qdev_init_gpio_in_named(dev, tz_ppc_irq_enable, "irq_enable", 1);
+    qdev_init_gpio_in_named(dev, tz_ppc_irq_clear, "irq_clear", 1);
+    qdev_init_gpio_out_named(dev, &s->irq, "irq", 1);
+}
+
+static void tz_ppc_realize(DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    TZPPC *s = TZ_PPC(dev);
+    int i;
+
+    /* We can't create the upstream end of the port until realize,
+     * as we don't know the size of the MR used as the downstream until then.
+     */
+    for (i = 0; i < TZ_NUM_PORTS; i++) {
+        TZPPCPort *port = &s->port[i];
+        char *name;
+        uint64_t size;
+
+        if (!port->downstream) {
+            continue;
+        }
+
+        name = g_strdup_printf("tz-ppc-port[%d]", i);
+
+        port->ppc = s;
+        address_space_init(&port->downstream_as, port->downstream, name);
+
+        size = memory_region_size(port->downstream);
+        memory_region_init_io(&port->upstream, obj, &tz_ppc_ops,
+                              port, name, size);
+        sysbus_init_mmio(sbd, &port->upstream);
+        g_free(name);
+    }
+}
+
+static const VMStateDescription tz_ppc_vmstate = {
+    .name = "tz-ppc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL_ARRAY(cfg_nonsec, TZPPC, 16),
+        VMSTATE_BOOL_ARRAY(cfg_ap, TZPPC, 16),
+        VMSTATE_BOOL(cfg_sec_resp, TZPPC),
+        VMSTATE_BOOL(irq_enable, TZPPC),
+        VMSTATE_BOOL(irq_clear, TZPPC),
+        VMSTATE_BOOL(irq_status, TZPPC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define DEFINE_PORT(N)                                          \
+    DEFINE_PROP_LINK("port[" #N "]", TZPPC, port[N].downstream, \
+                     TYPE_MEMORY_REGION, MemoryRegion *)
+
+static Property tz_ppc_properties[] = {
+    DEFINE_PROP_UINT32("NONSEC_MASK", TZPPC, nonsec_mask, 0),
+    DEFINE_PORT(0),
+    DEFINE_PORT(1),
+    DEFINE_PORT(2),
+    DEFINE_PORT(3),
+    DEFINE_PORT(4),
+    DEFINE_PORT(5),
+    DEFINE_PORT(6),
+    DEFINE_PORT(7),
+    DEFINE_PORT(8),
+    DEFINE_PORT(9),
+    DEFINE_PORT(10),
+    DEFINE_PORT(11),
+    DEFINE_PORT(12),
+    DEFINE_PORT(13),
+    DEFINE_PORT(14),
+    DEFINE_PORT(15),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tz_ppc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = tz_ppc_realize;
+    dc->vmsd = &tz_ppc_vmstate;
+    dc->reset = tz_ppc_reset;
+    dc->props = tz_ppc_properties;
+}
+
+static const TypeInfo tz_ppc_info = {
+    .name = TYPE_TZ_PPC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TZPPC),
+    .instance_init = tz_ppc_init,
+    .class_init = tz_ppc_class_init,
+};
+
+static void tz_ppc_register_types(void)
+{
+    type_register_static(&tz_ppc_info);
+}
+
+type_init(tz_ppc_register_types);
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5eaafee394..b51ff2db9d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -105,6 +105,8 @@ CONFIG_CMSDK_APB_UART=y
 CONFIG_MPS2_FPGAIO=y
 CONFIG_MPS2_SCC=y
 
+CONFIG_TZ_PPC=y
+
 CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ef852ffae7..0b638de682 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -83,3 +83,14 @@ mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "latch=%d co
 mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
+
+# hw/misc/tz-ppc.c
+tz_ppc_reset(void) "TZ PPC: reset"
+tz_ppc_cfg_nonsec(int n, int level) "TZ PPC: cfg_nonsec[%d] = %d"
+tz_ppc_cfg_ap(int n, int level) "TZ PPC: cfg_ap[%d] = %d"
+tz_ppc_cfg_sec_resp(int level) "TZ PPC: cfg_sec_resp = %d"
+tz_ppc_irq_enable(int level) "TZ PPC: int_enable = %d"
+tz_ppc_irq_clear(int level) "TZ PPC: int_clear = %d"
+tz_ppc_update_irq(int level) "TZ PPC: setting irq line to %d"
+tz_ppc_read_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
+tz_ppc_write_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked"
-- 
2.16.2
