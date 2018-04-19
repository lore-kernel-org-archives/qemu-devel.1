Received: from eggs.gnu.org ([2001:4830:134:3::10]:56331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98ut-0007Q1-8J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98uo-0007bS-5t
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:43:59 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:36643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98un-0007Zb-SG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:43:54 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.85])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5C4621458F
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:43:50 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:42:57 +0200
Message-Id: <20180419124331.3915-2-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/35] ppc/xive: introduce a XIVE interrupt
 source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Each XIVE interrupt source is associated with a two bit state machine
called an Event State Buffer (ESB) : the first bit "P" means that an
interrupt is "pending" and waiting for an EOI and the bit "Q" (queued)
means a new interrupt was triggered while another was still pending.

When an event is triggered, the associated interrupt state bits are
fetched and modified and forwarded to the virtualization engine of the
controller doing the routing. These can also be controlled by MMIO, to
trigger events or turn off the sources for instance. See code for more
details on the states and transitions.

On a sPAPR machine, the OS will obtain the address of the MMIO page of
the ESB entry associated with a source and its characteristic using
the H_INT_GET_SOURCE_INFO hcall. On PowerNV, a similar OPAL call is
used.

The xive_source_notify() routine is in charge forwarding the source
event notification to the routing engine. It will be filled later on.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Changes since v2:

 - added support for Store EOI
 - added support for two page MMIO setting like on KVM

 default-configs/ppc64-softmmu.mak |   1 +
 hw/intc/Makefile.objs             |   1 +
 hw/intc/xive.c                    | 335 ++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/xive.h             | 130 +++++++++++++++
 4 files changed, 467 insertions(+)
 create mode 100644 hw/intc/xive.c
 create mode 100644 include/hw/ppc/xive.h

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
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
new file mode 100644
index 000000000000..c70578759d02
--- /dev/null
+++ b/hw/intc/xive.c
@@ -0,0 +1,335 @@
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
+ * XIVE Interrupt Source
+ */
+
+uint8_t xive_source_pq_get(XiveSource *xsrc, uint32_t srcno)
+{
+    uint32_t byte =3D srcno / 4;
+    uint32_t bit  =3D (srcno % 4) * 2;
+
+    assert(byte < xsrc->sbe_size);
+
+    return (xsrc->sbe[byte] >> bit) & 0x3;
+}
+
+uint8_t xive_source_pq_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq)
+{
+    uint32_t byte =3D srcno / 4;
+    uint32_t bit  =3D (srcno % 4) * 2;
+    uint8_t old, new;
+
+    assert(byte < xsrc->sbe_size);
+
+    old =3D xsrc->sbe[byte];
+
+    new =3D xsrc->sbe[byte] & ~(0x3 << bit);
+    new |=3D (pq & 0x3) << bit;
+
+    xsrc->sbe[byte] =3D new;
+
+    return (old >> bit) & 0x3;
+}
+
+static bool xive_source_pq_eoi(XiveSource *xsrc, uint32_t srcno)
+{
+    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
+
+    switch (old_pq) {
+    case XIVE_ESB_RESET:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_RESET);
+        return false;
+    case XIVE_ESB_PENDING:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_RESET);
+        return false;
+    case XIVE_ESB_QUEUED:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
+        return true;
+    case XIVE_ESB_OFF:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_OFF);
+        return false;
+    default:
+         g_assert_not_reached();
+    }
+}
+
+/*
+ * Returns whether the event notification should be forwarded.
+ */
+static bool xive_source_pq_trigger(XiveSource *xsrc, uint32_t srcno)
+{
+    uint8_t old_pq =3D xive_source_pq_get(xsrc, srcno);
+
+    switch (old_pq) {
+    case XIVE_ESB_RESET:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_PENDING);
+        return true;
+    case XIVE_ESB_PENDING:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_QUEUED);
+        return false;
+    case XIVE_ESB_QUEUED:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_QUEUED);
+        return false;
+    case XIVE_ESB_OFF:
+        xive_source_pq_set(xsrc, srcno, XIVE_ESB_OFF);
+        return false;
+    default:
+         g_assert_not_reached();
+    }
+}
+
+/*
+ * Forward the source event notification to the associated XiveFabric,
+ * the device owning the sources.
+ */
+static void xive_source_notify(XiveSource *xsrc, int srcno)
+{
+
+}
+
+/* In a two pages ESB MMIO setting, even page is the trigger page, odd
+ * page is for management */
+static inline bool xive_source_is_trigger_page(hwaddr addr)
+{
+    return !((addr >> 16) & 1);
+}
+
+static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
+    uint32_t offset =3D addr & 0xF00;
+    uint32_t srcno =3D addr >> xsrc->esb_shift;
+    uint64_t ret =3D -1;
+
+    if (xive_source_esb_2page(xsrc) && xive_source_is_trigger_page(addr)=
) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid load on IRQ %d trigger page at "
+                      "0x%"HWADDR_PRIx"\n", srcno, addr);
+        return -1;
+    }
+
+    switch (offset) {
+    case XIVE_ESB_LOAD_EOI:
+        /*
+         * Load EOI is not the default source setting under QEMU, but
+         * this is what HW uses currently.
+         */
+        ret =3D xive_source_pq_eoi(xsrc, srcno);
+
+        break;
+
+    case XIVE_ESB_GET:
+        ret =3D xive_source_pq_get(xsrc, srcno);
+        break;
+
+    case XIVE_ESB_SET_PQ_00:
+    case XIVE_ESB_SET_PQ_01:
+    case XIVE_ESB_SET_PQ_10:
+    case XIVE_ESB_SET_PQ_11:
+        ret =3D xive_source_pq_set(xsrc, srcno, (offset >> 8) & 0x3);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB addr %d\n", of=
fset);
+    }
+
+    return ret;
+}
+
+static void xive_source_esb_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(opaque);
+    uint32_t offset =3D addr & 0xF00;
+    uint32_t srcno =3D addr >> xsrc->esb_shift;
+    bool notify =3D false;
+
+    switch (offset) {
+    case 0:
+        notify =3D xive_source_pq_trigger(xsrc, srcno);
+        break;
+
+    case XIVE_ESB_STORE_EOI:
+        if (xive_source_is_trigger_page(addr)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "XIVE: invalid store on IRQ %d trigger page at=
 "
+                          "0x%"HWADDR_PRIx"\n", srcno, addr);
+            return;
+        }
+
+        if (!(xsrc->esb_flags & XIVE_SRC_STORE_EOI)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "XIVE: invalid Store EOI for IRQ %d\n", srcno)=
;
+            return;
+        }
+
+        /* If the Q bit is set, we should forward a new source event
+         * notification
+         */
+        notify =3D xive_source_pq_eoi(xsrc, srcno);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr %d\=
n",
+                      offset);
+        return;
+    }
+
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
+        notify =3D xive_source_pq_trigger(xsrc, srcno);
+    }
+
+    /* Forward the source event notification for routing */
+    if (notify) {
+        xive_source_notify(xsrc, srcno);
+    }
+}
+
+void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon)
+{
+    int i;
+
+    monitor_printf(mon, "XIVE Source %6x ..%6x\n",
+                   xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq =3D xive_source_pq_get(xsrc, i);
+        uint32_t lisn =3D i  + xsrc->offset;
+
+        if (pq =3D=3D XIVE_ESB_OFF) {
+            continue;
+        }
+
+        monitor_printf(mon, "  %4x %c%c\n", lisn,
+                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
+    }
+}
+
+static void xive_source_reset(DeviceState *dev)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(dev);
+
+    /* SBEs are initialized to 0b01 which corresponds to "ints off" */
+    memset(xsrc->sbe, 0x55, xsrc->sbe_size);
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
+    /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries per byt=
e */
+    xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
+    xsrc->sbe =3D g_malloc0(xsrc->sbe_size);
+
+    /* TODO: H_INT_ESB support, which removing the ESB MMIOs */
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
+        VMSTATE_VBUFFER_UINT32(sbe, XiveSource, 1, NULL, sbe_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/*
+ * The default XIVE interrupt source setting for ESB MMIO is two 64k
+ * pages without Store EOI. This is in sync with KVM.
+ */
+static Property xive_source_properties[] =3D {
+    DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
+    DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
+    DEFINE_PROP_UINT64("bar", XiveSource, esb_base, 0),
+    DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAG=
E),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_source_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D xive_source_realize;
+    dc->reset =3D xive_source_reset;
+    dc->props =3D xive_source_properties;
+    dc->desc =3D "XIVE interrupt source";
+    dc->vmsd =3D &vmstate_xive_source;
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
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
new file mode 100644
index 000000000000..d92a50519edf
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
+ * XIVE Source Interrupt source characteristics, which define how the
+ * ESB are controlled.
+ */
+#define XIVE_SRC_H_INT_ESB     0x1 /* ESB managed with hcall H_INT_ESB *=
/
+#define XIVE_SRC_STORE_EOI     0x4 /* Store EOI supported */
+
+typedef struct XiveSource {
+    SysBusDevice parent;
+
+    /* IRQs */
+    uint32_t     nr_irqs;
+    uint32_t     offset;
+    qemu_irq     *qirqs;
+
+    /* PQ bits */
+    uint8_t      *sbe;
+    uint32_t     sbe_size;
+
+    /* ESB memory region */
+    uint64_t     esb_flags;
+    hwaddr       esb_base;
+    uint32_t     esb_shift;
+    MemoryRegion esb_mmio;
+} XiveSource;
+
+/*
+ * ESB MMIO setting. Can be one page, for both source triggering and
+ * source management, or two different pages. See below for magic
+ * values.
+ */
+#define XIVE_ESB_4K          12 /* PSI HB */
+#define XIVE_ESB_4K_2PAGE    17
+#define XIVE_ESB_64K         16
+#define XIVE_ESB_64K_2PAGE   17
+
+static inline bool xive_source_esb_2page(XiveSource *xsrc)
+{
+    return xsrc->esb_shift =3D=3D XIVE_ESB_64K_2PAGE;
+}
+
+static inline hwaddr xive_source_esb_base(XiveSource *xsrc, uint32_t src=
no)
+{
+    assert(srcno < xsrc->nr_irqs);
+    return xsrc->esb_base + (1ull << xsrc->esb_shift) * srcno;
+}
+
+/* The trigger page is always the first/even page */
+#define xive_source_esb_trigger xive_source_esb_base
+
+/* In a two pages ESB MMIO setting, the odd page is for management */
+static inline hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
+{
+    hwaddr addr =3D xive_source_esb_base(xsrc, srcno);
+
+    if (xive_source_esb_2page(xsrc)) {
+        addr +=3D (1 << (xsrc->esb_shift - 1));
+    }
+
+    return addr;
+}
+
+/*
+ * Each interrupt source has a 2-bit state machine called ESB which
+ * can be controlled by MMIO. It's made of 2 bits, P and Q. P
+ * indicates that an interrupt is pending (has been sent to a queue
+ * and is waiting for an EOI). Q indicates that the interrupt has been
+ * triggered while pending.
+ *
+ * This acts as a coalescing mechanism in order to guarantee
+ * that a given interrupt only occurs at most once in a queue.
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
+ * The following offsets into the ESB MMIO allow to read or
+ * manipulate the PQ bits. They must be used with an 8-bytes
+ * load instruction. They all return the previous state of the
+ * interrupt (atomically).
+ *
+ * Additionally, some ESB pages support doing an EOI via a
+ * store at 0 and some ESBs support doing a trigger via a
+ * separate trigger page.
+ */
+#define XIVE_ESB_STORE_EOI      0x400 /* Store */
+#define XIVE_ESB_LOAD_EOI       0x000 /* Load */
+#define XIVE_ESB_GET            0x800 /* Load */
+#define XIVE_ESB_SET_PQ_00      0xc00 /* Load */
+#define XIVE_ESB_SET_PQ_01      0xd00 /* Load */
+#define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
+#define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
+
+uint8_t xive_source_pq_get(XiveSource *xsrc, uint32_t srcno);
+uint8_t xive_source_pq_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq)=
;
+
+void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon);
+
+#endif /* PPC_XIVE_H */
--=20
2.13.6
