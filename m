Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBV-0001kP-5H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBQ-0003W5-AL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:45 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:45061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBP-0003Ux-Pt
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:40 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.110])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1BA79154BF
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:39 +0200
Message-Id: <20180607155003.1580-5-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/28] ppc/xive: introduce a XIVE interrupt
 source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The first sub-engine of the overall XIVE architecture is the Interrupt
Virtualization Source Engine (IVSE). An IVSE can be integrated into
another logic, like in a PCI PHB or in the main interrupt controller
to manage IPIs.

Each IVSE instance is associated with an Event State Buffer (ESB) that
contains a two bit state entry for each possible event source. When an
event is signaled to the IVSE, by MMIO or some other means, the
associated interrupt state bits are fetched from the ESB and
modified. Depending on the resulting ESB state, the event is forwarded
to the IVRE sub-engine of the controller doing the routing.

Each supported ESB entry is associated with either a single or a
even/odd pair of pages which provides commands to manage the source:
to EOI, to turn off the source for instance.

On a sPAPR machine, the OS will obtain the page address of the ESB
entry associated with a source and its characteristic using the
H_INT_GET_SOURCE_INFO hcall. On PowerNV, a similar OPAL call is used.

The xive_source_notify() routine is in charge forwarding the source
event notification to the routing engine. It will be filled later on.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 default-configs/ppc64-softmmu.mak |   1 +
 include/hw/ppc/xive.h             | 130 +++++++++++++
 hw/intc/xive.c                    | 379 ++++++++++++++++++++++++++++++++=
++++++
 hw/intc/Makefile.objs             |   1 +
 4 files changed, 511 insertions(+)
 create mode 100644 include/hw/ppc/xive.h
 create mode 100644 hw/intc/xive.c

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index b94af6c7c62a..c6d13e757977 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -16,4 +16,5 @@ CONFIG_VIRTIO_VGA=3Dy
 CONFIG_XICS=3D$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
+CONFIG_XIVE=3D$(CONFIG_PSERIES)
 CONFIG_MEM_HOTPLUG=3Dy
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
new file mode 100644
index 000000000000..5fec4b08705d
--- /dev/null
+++ b/include/hw/ppc/xive.h
@@ -0,0 +1,130 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_XIVE_H
+#define PPC_XIVE_H
+
+#include "hw/sysbus.h"
+
+/*
+ * XIVE Interrupt Source
+ */
+
+#define TYPE_XIVE_SOURCE "xive-source"
+#define XIVE_SOURCE(obj) OBJECT_CHECK(XiveSource, (obj), TYPE_XIVE_SOURC=
E)
+
+/*
+ * XIVE Interrupt Source characteristics, which define how the ESB are
+ * controlled.
+ */
+#define XIVE_SRC_H_INT_ESB     0x1 /* ESB managed with hcall H_INT_ESB *=
/
+#define XIVE_SRC_STORE_EOI     0x2 /* Store EOI supported */
+
+typedef struct XiveSource {
+    SysBusDevice parent;
+
+    /* IRQs */
+    uint32_t        nr_irqs;
+    qemu_irq        *qirqs;
+
+    /* PQ bits */
+    uint8_t         *status;
+
+    /* ESB memory region */
+    uint64_t        esb_flags;
+    uint32_t        esb_shift;
+    MemoryRegion    esb_mmio;
+} XiveSource;
+
+/*
+ * ESB MMIO setting. Can be one page, for both source triggering and
+ * source management, or two different pages. See below for magic
+ * values.
+ */
+#define XIVE_ESB_4K          12 /* PSI HB only */
+#define XIVE_ESB_4K_2PAGE    13
+#define XIVE_ESB_64K         16
+#define XIVE_ESB_64K_2PAGE   17
+
+static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
+{
+    return xsrc->esb_shift =3D=3D XIVE_ESB_64K_2PAGE ||
+        xsrc->esb_shift =3D=3D XIVE_ESB_4K_2PAGE;
+}
+
+/* The trigger page is always the first/even page */
+static inline hwaddr xive_source_esb_page(XiveSource *xsrc, uint32_t src=
no)
+{
+    assert(srcno < xsrc->nr_irqs);
+    return (1ull << xsrc->esb_shift) * srcno;
+}
+
+/* In a two pages ESB MMIO setting, the odd page is for management */
+static inline hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
+{
+    hwaddr addr =3D xive_source_esb_page(xsrc, srcno);
+
+    if (xive_source_esb_has_2page(xsrc)) {
+        addr +=3D (1 << (xsrc->esb_shift - 1));
+    }
+
+    return addr;
+}
+
+/*
+ * Each interrupt source has a 2-bit state machine which can be
+ * controlled by MMIO. P indicates that an interrupt is pending (has
+ * been sent to a queue and is waiting for an EOI). Q indicates that
+ * the interrupt has been triggered while pending.
+ *
+ * This acts as a coalescing mechanism in order to guarantee that a
+ * given interrupt only occurs at most once in a queue.
+ *
+ * When doing an EOI, the Q bit will indicate if the interrupt
+ * needs to be re-triggered.
+ */
+#define XIVE_ESB_VAL_P        0x2
+#define XIVE_ESB_VAL_Q        0x1
+
+#define XIVE_ESB_RESET        0x0
+#define XIVE_ESB_PENDING      XIVE_ESB_VAL_P
+#define XIVE_ESB_QUEUED       (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
+#define XIVE_ESB_OFF          XIVE_ESB_VAL_Q
+
+/*
+ * "magic" Event State Buffer (ESB) MMIO offsets.
+ *
+ * The following offsets into the ESB MMIO allow to read or manipulate
+ * the PQ bits. They must be used with an 8-byte load instruction.
+ * They all return the previous state of the interrupt (atomically).
+ *
+ * Additionally, some ESB pages support doing an EOI via a store and
+ * some ESBs support doing a trigger via a separate trigger page.
+ */
+#define XIVE_ESB_STORE_EOI      0x400 /* Store */
+#define XIVE_ESB_LOAD_EOI       0x000 /* Load */
+#define XIVE_ESB_GET            0x800 /* Load */
+#define XIVE_ESB_SET_PQ_00      0xc00 /* Load */
+#define XIVE_ESB_SET_PQ_01      0xd00 /* Load */
+#define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
+#define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
+
+uint8_t xive_source_esb_get(XiveSource *xsrc, uint32_t srcno);
+uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq=
);
+
+void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset,
+                                Monitor *mon);
+
+static inline qemu_irq xive_source_qirq(XiveSource *xsrc, uint32_t srcno=
)
+{
+    assert(srcno < xsrc->nr_irqs);
+    return xsrc->qirqs[srcno];
+}
+
+#endif /* PPC_XIVE_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
new file mode 100644
index 000000000000..4d1cb2497237
--- /dev/null
+++ b/hw/intc/xive.c
@@ -0,0 +1,379 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "target/ppc/cpu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/dma.h"
+#include "monitor/monitor.h"
+#include "hw/ppc/xive.h"
+
+/*
+ * XIVE ESB helpers
+ */
+
+static uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
+{
+    uint8_t old_pq =3D *pq & 0x3;
+
+    *pq &=3D ~0x3;
+    *pq |=3D value & 0x3;
+
+    return old_pq;
+}
+
+static bool xive_esb_trigger(uint8_t *pq)
+{
+    uint8_t old_pq =3D *pq & 0x3;
+
+    switch (old_pq) {
+    case XIVE_ESB_RESET:
+        xive_esb_set(pq, XIVE_ESB_PENDING);
+        return true;
+    case XIVE_ESB_PENDING:
+    case XIVE_ESB_QUEUED:
+        xive_esb_set(pq, XIVE_ESB_QUEUED);
+        return false;
+    case XIVE_ESB_OFF:
+        xive_esb_set(pq, XIVE_ESB_OFF);
+        return false;
+    default:
+         g_assert_not_reached();
+    }
+}
+
+static bool xive_esb_eoi(uint8_t *pq)
+{
+    uint8_t old_pq =3D *pq & 0x3;
+
+    switch (old_pq) {
+    case XIVE_ESB_RESET:
+    case XIVE_ESB_PENDING:
+        xive_esb_set(pq, XIVE_ESB_RESET);
+        return false;
+    case XIVE_ESB_QUEUED:
+        xive_esb_set(pq, XIVE_ESB_PENDING);
+        return true;
+    case XIVE_ESB_OFF:
+        xive_esb_set(pq, XIVE_ESB_OFF);
+        return false;
+    default:
+         g_assert_not_reached();
+    }
+}
+
+/*
+ * XIVE Interrupt Source (or IVSE)
+ */
+
+uint8_t xive_source_esb_get(XiveSource *xsrc, uint32_t srcno)
+{
+    assert(srcno < xsrc->nr_irqs);
+
+    return xsrc->status[srcno] & 0x3;
+}
+
+uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq=
)
+{
+    assert(srcno < xsrc->nr_irqs);
+
+    return xive_esb_set(&xsrc->status[srcno], pq);
+}
+
+/*
+ * Returns whether the event notification should be forwarded.
+ */
+static bool xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
+{
+    assert(srcno < xsrc->nr_irqs);
+
+    return xive_esb_trigger(&xsrc->status[srcno]);
+}
+
+/*
+ * Returns whether the event notification should be forwarded.
+ */
+static bool xive_source_esb_eoi(XiveSource *xsrc, uint32_t srcno)
+{
+    assert(srcno < xsrc->nr_irqs);
+
+    return xive_esb_eoi(&xsrc->status[srcno]);
+}
+
+/*
+ * Forward the source event notification to the Router
+ */
+static void xive_source_notify(XiveSource *xsrc, int srcno)
+{
+
+}
+
+/* In a two pages ESB MMIO setting, even page is the trigger page, odd
+ * page is for management */
+static inline bool addr_is_even(hwaddr addr, uint32_t shift)
+{
+    return !((addr >> shift) & 1);
+}
+
+static inline bool xive_source_is_trigger_page(XiveSource *xsrc, hwaddr =
addr)
+{
+    return xive_source_esb_has_2page(xsrc) &&
+        addr_is_even(addr, xsrc->esb_shift - 1);
+}
+
+/*
+ * ESB MMIO loads
+ *                      Trigger page    Management/EOI page
+ * 2 pages setting      even            odd
+ *
+ * 0x000 .. 0x3FF       -1              EOI and return 0|1
+ * 0x400 .. 0x7FF       -1              EOI and return 0|1
+ * 0x800 .. 0xBFF       -1              return PQ
+ * 0xC00 .. 0xCFF       -1              return PQ and atomically PQ=3D0
+ * 0xD00 .. 0xDFF       -1              return PQ and atomically PQ=3D0
+ * 0xE00 .. 0xDFF       -1              return PQ and atomically PQ=3D1
+ * 0xF00 .. 0xDFF       -1              return PQ and atomically PQ=3D1
+ */
+static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
+    uint32_t offset =3D addr & 0xFFF;
+    uint32_t srcno =3D addr >> xsrc->esb_shift;
+    uint64_t ret =3D -1;
+
+    /* In a two pages ESB MMIO setting, trigger page should not be read =
*/
+    if (xive_source_is_trigger_page(xsrc, addr)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid load on IRQ %d trigger page at "
+                      "0x%"HWADDR_PRIx"\n", srcno, addr);
+        return -1;
+    }
+
+    switch (offset) {
+    case XIVE_ESB_LOAD_EOI ... XIVE_ESB_LOAD_EOI + 0x7FF:
+        ret =3D xive_source_esb_eoi(xsrc, srcno);
+
+        /* Forward the source event notification for routing */
+        if (ret) {
+            xive_source_notify(xsrc, srcno);
+        }
+        break;
+
+    case XIVE_ESB_GET ... XIVE_ESB_GET + 0x3FF:
+        ret =3D xive_source_esb_get(xsrc, srcno);
+        break;
+
+    case XIVE_ESB_SET_PQ_00 ... XIVE_ESB_SET_PQ_00 + 0x0FF:
+    case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
+    case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
+    case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
+        ret =3D xive_source_esb_set(xsrc, srcno, (offset >> 8) & 0x3);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB load addr %x\n=
",
+                      offset);
+    }
+
+    return ret;
+}
+
+/*
+ * ESB MMIO stores
+ *                      Trigger page    Management/EOI page
+ * 2 pages setting      even            odd
+ *
+ * 0x000 .. 0x3FF       Trigger         Trigger
+ * 0x400 .. 0x7FF       Trigger         EOI
+ * 0x800 .. 0xBFF       Trigger         undefined
+ * 0xC00 .. 0xCFF       Trigger         PQ=3D00
+ * 0xD00 .. 0xDFF       Trigger         PQ=3D01
+ * 0xE00 .. 0xDFF       Trigger         PQ=3D10
+ * 0xF00 .. 0xDFF       Trigger         PQ=3D11
+ */
+static void xive_source_esb_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
+    uint32_t offset =3D addr & 0xFFF;
+    uint32_t srcno =3D addr >> xsrc->esb_shift;
+    bool notify =3D false;
+
+    /* In a two pages ESB MMIO setting, trigger page only triggers */
+    if (xive_source_is_trigger_page(xsrc, addr)) {
+        notify =3D xive_source_esb_trigger(xsrc, srcno);
+        goto out;
+    }
+
+    switch (offset) {
+    case 0 ... 0x3FF:
+        notify =3D xive_source_esb_trigger(xsrc, srcno);
+        break;
+
+    case XIVE_ESB_STORE_EOI ... XIVE_ESB_STORE_EOI + 0x3FF:
+        if (!(xsrc->esb_flags & XIVE_SRC_STORE_EOI)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "XIVE: invalid Store EOI for IRQ %d\n", srcno)=
;
+            return;
+        }
+
+        notify =3D xive_source_esb_eoi(xsrc, srcno);
+        break;
+
+    case XIVE_ESB_SET_PQ_00 ... XIVE_ESB_SET_PQ_00 + 0x0FF:
+    case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
+    case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
+    case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
+        xive_source_esb_set(xsrc, srcno, (offset >> 8) & 0x3);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr %x\=
n",
+                      offset);
+        return;
+    }
+
+out:
+    /* Forward the source event notification for routing */
+    if (notify) {
+        xive_source_notify(xsrc, srcno);
+    }
+}
+
+static const MemoryRegionOps xive_source_esb_ops =3D {
+    .read =3D xive_source_esb_read,
+    .write =3D xive_source_esb_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+static void xive_source_set_irq(void *opaque, int srcno, int val)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
+    bool notify =3D false;
+
+    if (val) {
+        notify =3D xive_source_esb_trigger(xsrc, srcno);
+    }
+
+    /* Forward the source event notification for routing */
+    if (notify) {
+        xive_source_notify(xsrc, srcno);
+    }
+}
+
+void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset, Monit=
or *mon)
+{
+    int i;
+
+    monitor_printf(mon, "XIVE Source %8x ..%8x\n",
+                   offset, offset + xsrc->nr_irqs - 1);
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_esb_get(xsrc, i);
+
+        if (pq =3D=3D XIVE_ESB_OFF) {
+            continue;
+        }
+
+        monitor_printf(mon, "  %8x %c%c\n", i + offset,
+                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
+    }
+}
+
+static void xive_source_reset(DeviceState *dev)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(dev);
+
+    /* PQs are initialized to 0b01 which corresponds to "ints off" */
+    memset(xsrc->status, 0x1, xsrc->nr_irqs);
+}
+
+static void xive_source_realize(DeviceState *dev, Error **errp)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(dev);
+
+    if (!xsrc->nr_irqs) {
+        error_setg(errp, "Number of interrupt needs to be greater than 0=
");
+        return;
+    }
+
+    if (xsrc->esb_shift !=3D XIVE_ESB_4K &&
+        xsrc->esb_shift !=3D XIVE_ESB_4K_2PAGE &&
+        xsrc->esb_shift !=3D XIVE_ESB_64K &&
+        xsrc->esb_shift !=3D XIVE_ESB_64K_2PAGE) {
+        error_setg(errp, "Invalid ESB shift setting");
+        return;
+    }
+
+    xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
+                                     xsrc->nr_irqs);
+
+    xsrc->status =3D g_malloc0(xsrc->nr_irqs);
+
+    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
+                          &xive_source_esb_ops, xsrc, "xive.esb",
+                          (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
+}
+
+static const VMStateDescription vmstate_xive_source =3D {
+    .name =3D TYPE_XIVE_SOURCE,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
+        VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/*
+ * The default XIVE interrupt source setting for the ESB MMIOs is two
+ * 64k pages without Store EOI, to be in sync with KVM.
+ */
+static Property xive_source_properties[] =3D {
+    DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
+    DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
+    DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAG=
E),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_source_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc    =3D "XIVE Interrupt Source";
+    dc->props   =3D xive_source_properties;
+    dc->realize =3D xive_source_realize;
+    dc->reset   =3D xive_source_reset;
+    dc->vmsd    =3D &vmstate_xive_source;
+}
+
+static const TypeInfo xive_source_info =3D {
+    .name          =3D TYPE_XIVE_SOURCE,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(XiveSource),
+    .class_init    =3D xive_source_class_init,
+};
+
+static void xive_register_types(void)
+{
+    type_register_static(&xive_source_info);
+}
+
+type_init(xive_register_types)
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 0e9963f5eecc..72a46ed91c31 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -37,6 +37,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
 obj-$(CONFIG_XICS) +=3D xics.o
 obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
+obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
--=20
2.13.6
