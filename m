Received: from eggs.gnu.org ([2001:4830:134:3::10]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xy-000226-5Q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xs-0001dP-3V
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:10 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:44995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xr-0001cA-HB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:04 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E1AC5F02AC
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:47:01 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:30 +0200
Message-Id: <20180419124331.3915-35-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 34/35] ppc/pnv: add XIVE support
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

This is simple model of the POWER9 XIVE interrupt controller for the
PowerNV machine. XIVE for baremetal is a complex controller and the
model only addresses the needs of the skiboot firmware. Support is
provided for :

* virtual structure descriptor tables describing the XIVE
  internal tables stored in the machine RAM :

  - IVT
    associate an interrupt source number with an event queue. the
    data to be pushed in the queue is stored there also.

  - EQDT
    describes the queues in the OS RAM, also contains a set of flags,
    a virtual target, etc.

  - VPDT
    describe the virtual targets, which can have different
    natures, a lpar, a cpu.

* translation sets, splitting the overall ESB MMIO in two:
  IPIs and EQs.

* MMIO regions :

  - Interrupt controller registers
  - ESB MMIO for IPIs and EQs
  - Presenter MMIO (Not used)
  - Thread Interrupt Management Area MMIO, direct and indirect

* internal sources for IPIs and CAPI like interrupts.

The integration with the generic XiveFabric routing engine is not
complete yet and the TIMA handlers for the HV privilege level are
duplicating a lot of code. work in progress.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/Makefile.objs      |    2 +-
 hw/intc/pnv_xive.c         | 1234 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/pnv_xive_regs.h    |  314 +++++++++++
 hw/intc/xive.c             |  160 +++++-
 hw/ppc/pnv.c               |   36 +-
 include/hw/ppc/pnv.h       |   21 +
 include/hw/ppc/pnv_xive.h  |   89 ++++
 include/hw/ppc/pnv_xscom.h |    3 +
 include/hw/ppc/xive.h      |    5 +
 include/hw/ppc/xive_regs.h |   22 +
 10 files changed, 1874 insertions(+), 12 deletions(-)
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index dd4d69db2bdd..145bfaf44014 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -40,7 +40,7 @@ obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
 obj-$(CONFIG_XIVE_KVM) +=3D spapr_xive_kvm.o
-obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
+obj-$(CONFIG_POWERNV) +=3D xics_pnv.o pnv_xive.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
 obj-$(CONFIG_S390_FLIC_KVM) +=3D s390_flic_kvm.o
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
new file mode 100644
index 000000000000..ef521b402567
--- /dev/null
+++ b/hw/intc/pnv_xive.c
@@ -0,0 +1,1234 @@
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
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_xive.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/ppc.h"
+
+#include <libfdt.h>
+
+#include "pnv_xive_regs.h"
+
+#define EQ_PER_PAGE           (0x10000 / sizeof(XiveEQ))
+#define VP_PER_PAGE           (0x10000 / sizeof(XiveVP))
+
+static uint64_t pnv_xive_eq_addr(PnvXive *xive, uint32_t idx)
+{
+    uint64_t vsd;
+    uint64_t page_addr;
+
+    if (idx >=3D xive->eqdt_count) {
+        return 0;
+    }
+
+    vsd =3D be64_to_cpu(xive->eqdt[idx / EQ_PER_PAGE]);
+    page_addr =3D vsd & VSD_ADDRESS_MASK;
+    if (!page_addr) {
+        return 0;
+    }
+
+    /* We don't support nested indirect tables */
+    if (VSD_INDIRECT & vsd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: found a nested indirect EQ=
"
+                      " table at index %d\n", idx);
+        return 0;
+    }
+
+    return page_addr + (idx % EQ_PER_PAGE) * sizeof(XiveEQ);
+}
+
+static int pnv_xive_eq_get(PnvXive *xive, uint32_t idx, XiveEQ *eq)
+{
+    uint64_t eq_addr =3D pnv_xive_eq_addr(xive, idx);
+
+    if (!eq_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_read(eq_addr, eq, sizeof(XiveEQ));
+    eq->w0 =3D be32_to_cpu(eq->w0);
+    eq->w1 =3D be32_to_cpu(eq->w1);
+    eq->w2 =3D be32_to_cpu(eq->w2);
+    eq->w3 =3D be32_to_cpu(eq->w3);
+    eq->w4 =3D be32_to_cpu(eq->w4);
+    eq->w5 =3D be32_to_cpu(eq->w5);
+    eq->w6 =3D be32_to_cpu(eq->w6);
+    eq->w7 =3D be32_to_cpu(eq->w7);
+
+    return 0;
+}
+
+static int pnv_xive_eq_set(PnvXive *xive, uint32_t idx, XiveEQ *in_eq)
+{
+    XiveEQ eq;
+    uint64_t eq_addr =3D pnv_xive_eq_addr(xive, idx);
+
+    if (!eq_addr) {
+        return -1;
+    }
+
+    eq.w0 =3D cpu_to_be32(in_eq->w0);
+    eq.w1 =3D cpu_to_be32(in_eq->w1);
+    eq.w2 =3D cpu_to_be32(in_eq->w2);
+    eq.w3 =3D cpu_to_be32(in_eq->w3);
+    eq.w4 =3D cpu_to_be32(in_eq->w4);
+    eq.w5 =3D cpu_to_be32(in_eq->w5);
+    eq.w6 =3D cpu_to_be32(in_eq->w6);
+    eq.w7 =3D cpu_to_be32(in_eq->w7);
+    cpu_physical_memory_write(eq_addr, &eq, sizeof(XiveEQ));
+    return 0;
+}
+
+static void pnv_xive_eq_update(PnvXive *xive, uint32_t idx)
+{
+    uint32_t size =3D 1 << (GETFIELD(VSD_TSIZE, xive->vsds[VST_TSEL_EQDT=
]) + 12);
+    uint64_t eqdt_addr =3D xive->vsds[VST_TSEL_EQDT] & VSD_ADDRESS_MASK;
+    uint64_t eq_addr;
+
+    /* Update the EQ indirect table which might have newly allocated
+     * pages. We could use the idx to limit the transfer */
+    cpu_physical_memory_read(eqdt_addr, xive->eqdt, size);
+
+    eq_addr =3D pnv_xive_eq_addr(xive, idx);
+    if (!eq_addr) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Update failed for EQ %d\n"=
, idx);
+        return;
+    }
+
+    cpu_physical_memory_write(eq_addr, xive->eqc_watch, sizeof(XiveEQ));
+}
+
+static uint64_t pnv_xive_vp_addr(PnvXive *xive, uint32_t idx)
+{
+    uint64_t vsd;
+    uint64_t page_addr;
+
+    if (idx >=3D xive->vpdt_count) {
+        return 0;
+    }
+
+    vsd =3D be64_to_cpu(xive->vpdt[idx / VP_PER_PAGE]);
+    page_addr =3D vsd & VSD_ADDRESS_MASK;
+    if (!page_addr) {
+        return 0;
+    }
+
+    /* We don't support nested indirect tables */
+    if (VSD_INDIRECT & vsd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: found a nested indirect VP=
"
+                      " table at index %x\n", idx);
+        return 0;
+    }
+
+    return page_addr + (idx % VP_PER_PAGE) * sizeof(XiveVP);
+}
+
+static int pnv_xive_vp_get(PnvXive *xive, uint32_t idx, XiveVP *vp)
+{
+    uint64_t vp_addr =3D pnv_xive_vp_addr(xive, idx);
+
+    if (!vp_addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_read(vp_addr, vp, sizeof(XiveVP));
+    vp->w0 =3D cpu_to_be32(vp->w0);
+    vp->w1 =3D cpu_to_be32(vp->w1);
+    vp->w2 =3D cpu_to_be32(vp->w2);
+    vp->w3 =3D cpu_to_be32(vp->w3);
+    vp->w4 =3D cpu_to_be32(vp->w4);
+    vp->w5 =3D cpu_to_be32(vp->w5);
+    vp->w6 =3D cpu_to_be32(vp->w6);
+    vp->w7 =3D cpu_to_be32(vp->w7);
+
+    return 0;
+}
+
+static void pnv_xive_vp_update(PnvXive *xive, uint32_t idx)
+{
+    uint32_t size =3D 1 << (GETFIELD(VSD_TSIZE, xive->vsds[VST_TSEL_VPDT=
]) + 12);
+    uint64_t vpdt_addr =3D xive->vsds[VST_TSEL_VPDT] & VSD_ADDRESS_MASK;
+    uint64_t vp_addr;
+
+    /* Update the VP indirect table which might have newly allocated
+     * pages. We could use the idx to limit the transfer */
+    cpu_physical_memory_read(vpdt_addr, xive->vpdt, size);
+
+    vp_addr =3D pnv_xive_vp_addr(xive, idx);
+    if (!vp_addr) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Update failed for VP %x\n"=
, idx);
+        return;
+    }
+
+    cpu_physical_memory_write(vp_addr, xive->vpc_watch, sizeof(XiveVP));
+}
+
+static void pnv_xive_ive_update(PnvXive *xive, uint32_t idx)
+{
+    uint64_t ivt_addr =3D xive->vsds[VST_TSEL_IVT] & VSD_ADDRESS_MASK;
+    uint64_t ive_addr =3D ivt_addr + idx * sizeof(XiveIVE);
+    XiveIVE *ive =3D &xive->ivt[idx];
+
+    *((uint64_t *) ive) =3D ldq_be_dma(&address_space_memory, ive_addr);
+}
+
+#define PNV_XIVE_SET_XLATE_SIZE  (8ull << 30)
+
+static uint64_t pnv_xive_set_xlate_edt_size(PnvXive *xive, uint64_t type=
)
+{
+    uint64_t size =3D 0;
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(xive->set_xlate_edt); i++) {
+        /* This is supposing that the IPIs and EQs set translations
+         * are contiguous */
+        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->set_xlate_=
edt[i]);
+
+        if (edt_type =3D=3D type) {
+            size +=3D PNV_XIVE_SET_XLATE_SIZE;
+        }
+    }
+
+    return size;
+}
+
+static int pnv_xive_set_xlate_update(PnvXive *xive, uint64_t val)
+{
+    uint8_t index =3D xive->set_xlate_autoinc ?
+        xive->set_xlate_index++ : xive->set_xlate_index;
+
+    switch (xive->set_xlate) {
+    case CQ_TAR_TSEL_EDT:
+        index %=3D sizeof(xive->set_xlate_edt);
+        xive->set_xlate_edt[index] =3D val;
+        break;
+    case CQ_TAR_TSEL_VDT:
+        index %=3D sizeof(xive->set_xlate_vdt);
+        xive->set_xlate_vdt[index] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid table set %d\n",
+                      (int) xive->set_xlate);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int pnv_xive_set_xlate_select(PnvXive *xive, uint64_t val)
+{
+    xive->set_xlate_autoinc =3D val & CQ_TAR_TBL_AUTOINC;
+    xive->set_xlate =3D val & CQ_TAR_TSEL;
+    xive->set_xlate_index =3D GETFIELD(CQ_TAR_TSEL_INDEX, val);
+
+    return 0;
+}
+
+static void pnv_xive_source_realize(PnvXive *xive, uint32_t count,
+                                    Error **errp)
+{
+    XiveSource *xsrc =3D &xive->source;
+    Error *local_err =3D NULL;
+    uint64_t esb_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_=
EDT_IPI);
+
+    /* Remap the ESB region for IPIs now that the set translation have
+     * been configured.
+     */
+    memory_region_transaction_begin();
+    memory_region_set_size(&xive->esb_mmio, esb_mmio_size);
+    memory_region_set_enabled(&xive->esb_mmio, true);
+    memory_region_transaction_commit();
+
+    object_property_set_int(OBJECT(xsrc), xive->esb_base, "bar", &error_=
fatal);
+    object_property_set_int(OBJECT(xsrc), XIVE_ESB_64K_2PAGE, "shift",
+                            &error_fatal);
+    object_property_set_int(OBJECT(xsrc), count, "nr-irqs", &error_fatal=
);
+    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
+
+    /* Install the ESB MMIO region in the overall region configured
+     * for the purpose in the interrupt controller . */
+    memory_region_add_subregion(&xive->esb_mmio, 0, &xsrc->esb_mmio);
+}
+
+static void pnv_xive_eq_source_realize(PnvXive *xive, uint32_t count,
+                                       Error **errp)
+{
+    XiveSource *eq_xsrc =3D &xive->eq_source;
+    Error *local_err =3D NULL;
+    uint64_t esb_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_=
EDT_IPI);
+    uint64_t eq_mmio_size =3D pnv_xive_set_xlate_edt_size(xive, CQ_TDR_E=
DT_EQ);
+
+    xive->eq_base =3D xive->vc_base + esb_mmio_size;
+
+    /* Remap the ESB region for EQs now that the set translation have
+     * been configured.
+     */
+    memory_region_transaction_begin();
+    memory_region_set_size(&xive->eq_mmio, eq_mmio_size);
+    memory_region_set_address(&xive->eq_mmio, esb_mmio_size);
+    memory_region_set_enabled(&xive->eq_mmio, true);
+    memory_region_transaction_commit();
+
+    /* check for some skiboot oddity on the table size */
+    if (xive->eq_base + count * (1ull << XIVE_ESB_64K_2PAGE) >
+        xive->vc_base + PNV_XIVE_VC_SIZE) {
+        uint32_t old =3D count;
+        count =3D (xive->vc_base + PNV_XIVE_VC_SIZE -
+                 xive->eq_base) >> XIVE_ESB_64K_2PAGE;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: EQ count %d too large for =
VC "
+                      "MMIO region. shrinking to %d\n", old, count);
+    }
+
+    object_property_set_int(OBJECT(eq_xsrc), xive->eq_base, "bar",
+                            &error_fatal);
+    object_property_set_int(OBJECT(eq_xsrc), XIVE_ESB_64K_2PAGE, "shift"=
,
+                            &error_fatal);
+    object_property_set_int(OBJECT(eq_xsrc), count, "nr-irqs", &error_fa=
tal);
+    object_property_add_const_link(OBJECT(eq_xsrc), "xive", OBJECT(xive)=
,
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(eq_xsrc), true, "realized", &local_e=
rr);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(eq_xsrc), sysbus_get_default());
+
+    /* Install the EQ ESB MMIO region in the overall region configured
+     * for the purpose in the interrupt controller . */
+    memory_region_add_subregion(&xive->eq_mmio, 0, &eq_xsrc->esb_mmio);
+}
+
+static void pnv_xive_table_set_data(PnvXive *xive, uint64_t val, bool pc=
_engine)
+{
+    uint64_t addr =3D val & VSD_ADDRESS_MASK;
+    uint32_t size =3D 1 << (GETFIELD(VSD_TSIZE, val) + 12);
+    bool indirect =3D VSD_INDIRECT & val;
+    uint8_t mode =3D GETFIELD(VSD_MODE, val);
+
+    if (mode !=3D VSD_MODE_EXCLUSIVE) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no support for non-exclusi=
ve"
+                      " tables");
+        return;
+    }
+
+    switch (xive->vst_tsel) {
+    case VST_TSEL_IVT:
+        if (!xive->ivt) {
+            xive->nr_irqs =3D size / sizeof(XiveIVE);
+
+            xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
+
+            /* Read initial state from the guest RAM */
+            cpu_physical_memory_read(addr, xive->ivt, size);
+            xive->vsds[xive->vst_tsel] =3D val;
+        }
+        break;
+
+    case VST_TSEL_SBE:
+        /* We do not use the SBE bits backed in the guest RAM but
+         * instead, we create our own source. The IVT table should
+         * have been created before.
+         */
+        if (!DEVICE(&xive->source)->realized) {
+
+            pnv_xive_source_realize(xive, xive->nr_irqs, &error_fatal);
+            device_reset(DEVICE(&xive->source));
+            xive->vsds[xive->vst_tsel] =3D val;
+        }
+        break;
+
+    case VST_TSEL_EQDT:
+        if (!xive->eqdt) {
+
+            /* EQDT is expected to be indirect even though skiboot can
+             * be compiled in direct mode */
+            assert(indirect);
+
+            /* FIXME: skiboot set the EQDT as indirect with 64K
+             * subpages, which is too big for the VC MMIO region.
+             */
+            val &=3D ~VSD_TSIZE;
+            val |=3D SETFIELD(VSD_TSIZE, 0ull, 0);
+            size =3D 0x1000;
+
+            xive->eqdt_count =3D size * EQ_PER_PAGE / 8;
+
+            xive->eqdt =3D g_malloc0(size);
+
+            /* Should be all NULL pointers */
+            cpu_physical_memory_read(addr, xive->eqdt, size);
+
+            xive->vsds[xive->vst_tsel] =3D val;
+
+            /* We do not use the ESn bits of the XiveEQ structure
+             * backed in the guest RAM but instead, we create our own
+             * source.
+             */
+            pnv_xive_eq_source_realize(xive, xive->eqdt_count, &error_fa=
tal);
+        }
+        break;
+
+    case VST_TSEL_VPDT:
+
+        /* There is a hack in skiboot to workaround DD1 issue with the
+         * VPT setting in the VC engine in DD1. Skip it, we will get
+         * it from the PC engine anyhow */
+        if (!xive->vpdt && pc_engine) {
+
+            /* VPDT is indirect */
+            assert(indirect);
+
+            /* FIXME: skiboot set the VPDT as indirect with 64K
+             * subpages.
+             */
+            val &=3D ~VSD_TSIZE;
+            val |=3D SETFIELD(VSD_TSIZE, 0ull, 0);
+            size =3D 0x1000;
+
+            xive->vpdt_count =3D size * VP_PER_PAGE / 8;
+
+            xive->vpdt =3D g_malloc0(size);
+
+            /* should be all NULL pointers */
+            cpu_physical_memory_read(addr, xive->vpdt, size);
+
+            xive->vsds[xive->vst_tsel] =3D val;
+        }
+        break;
+    case VST_TSEL_IRQ:
+        /* TODO */
+        xive->vsds[xive->vst_tsel] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid table type %d\n",
+                      xive->vst_tsel);
+        return;
+    }
+}
+
+/*
+ * Some accesses to the TIMA are sometime done from some other thread
+ * context. For resets.
+ */
+static void pnv_xive_thread_indirect_set(PnvXive *xive, uint64_t val)
+{
+    int pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, xive->regs[PC_TCTXT_INDI=
R0 >> 3]);
+
+    if (val & PC_TCTXT_INDIR_VALID) {
+        if (xive->cpu_ind) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: indirect access alread=
y set "
+                          " for invalid PIR %d", pir);
+        }
+
+        pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, val) & 0xff;
+        xive->cpu_ind =3D ppc_get_vcpu_by_pir(pir);
+        if (!xive->cpu_ind) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid PIR %d for"
+                          " indirect access\n", pir);
+        }
+    } else {
+        xive->cpu_ind =3D NULL;
+    }
+}
+
+/*
+ * Interrupt Controller MMIO
+ */
+static void pnv_xive_ic_reg_write(PnvXive *xive, uint32_t offset, uint64=
_t val,
+                               bool mmio)
+{
+    uint32_t reg =3D offset >> 3;
+
+    switch (offset) {
+    case CQ_CFG_PB_GEN:
+    case CQ_MSGSND:
+    case CQ_PBI_CTL:
+    case CQ_FIRMASK_OR:
+
+    case PC_TCTXT_CFG:
+    case PC_TCTXT_TRACK:
+    case PC_TCTXT_INDIR1:
+    case PC_TCTXT_INDIR2:
+    case PC_TCTXT_INDIR3:
+    case PC_GLOBAL_CONFIG:
+        /* set indirect mode for VSDs */
+
+    case PC_VPC_SCRUB_MASK:
+    case PC_VPC_CWATCH_SPEC:
+    case VC_GLOBAL_CONFIG:
+        /* set indirect mode for VSDs */
+
+    case VC_AIB_TX_ORDER_TAG2:
+
+    case VC_IRQ_CONFIG_IPI:
+    case VC_IRQ_CONFIG_HW:
+    case VC_IRQ_CONFIG_CASCADE1:
+    case VC_IRQ_CONFIG_CASCADE2:
+    case VC_IRQ_CONFIG_REDIST:
+    case VC_IRQ_CONFIG_IPI_CASC:
+
+    case VC_EQC_SCRUB_MASK:
+    case VC_EQC_CWATCH_SPEC:
+    case VC_EQC_CONFIG:
+    case VC_IVC_SCRUB_MASK:
+    case PC_AT_KILL_MASK:
+    case VC_AT_MACRO_KILL_MASK:
+        xive->regs[reg] =3D val;
+        break;
+
+    /* TODO: we could set the memory region when the BAR are
+     * configured by firmware instead of hardcoding the adddr/size
+     * values when the object is realized.
+     */
+    case CQ_IC_BAR: /* IC BAR and page size. 8 * 64k */
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_TM1_BAR: /* TM BAR and page size. 4 * 64k */
+    case CQ_TM2_BAR: /* second TM BAR and page size. For hotplug use */
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_PC_BAR:
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_PC_BARM: /* PC BAR size */
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_VC_BAR:
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_VC_BARM: /* VC BAR size */
+        xive->regs[reg] =3D val;
+        break;
+
+    case PC_AT_KILL:
+        /* TODO: reload vpdt because pages were cleared */
+        xive->regs[reg] |=3D val;
+        break;
+
+    case VC_AT_MACRO_KILL:
+        /* TODO: reload eddt because pages were cleared */
+        xive->regs[reg] |=3D val;
+        break;
+
+    case PC_THREAD_EN_REG0_SET: /* Physical Thread Enable */
+    case PC_THREAD_EN_REG1_SET: /* Physical Thread Enable (fused core) *=
/
+        xive->regs[reg] |=3D val;
+        break;
+
+    case PC_THREAD_EN_REG0_CLR:
+        xive->regs[PC_THREAD_EN_REG0_SET >> 3] &=3D ~val;
+        break;
+    case PC_THREAD_EN_REG1_CLR:
+        xive->regs[PC_THREAD_EN_REG1_SET >> 3] &=3D ~val;
+        break;
+
+    case PC_TCTXT_INDIR0: /* set up CPU for indirect TIMA access */
+        pnv_xive_thread_indirect_set(xive, val);
+        xive->regs[reg] =3D val;
+        break;
+
+    case CQ_TAR: /* Set Translation Table Address */
+        pnv_xive_set_xlate_select(xive, val);
+        break;
+
+    case CQ_TDR: /* Set Translation Table Data */
+        pnv_xive_set_xlate_update(xive, val);
+        break;
+
+    case VC_IVC_SCRUB_TRIG:
+        pnv_xive_ive_update(xive, GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+
+    case PC_VPC_CWATCH_DAT0:
+    case PC_VPC_CWATCH_DAT1:
+    case PC_VPC_CWATCH_DAT2:
+    case PC_VPC_CWATCH_DAT3:
+    case PC_VPC_CWATCH_DAT4:
+    case PC_VPC_CWATCH_DAT5:
+    case PC_VPC_CWATCH_DAT6:
+    case PC_VPC_CWATCH_DAT7: /* XiveVP data for update */
+        xive->vpc_watch[(offset - PC_VPC_CWATCH_DAT0) / 8] =3D cpu_to_be=
64(val);
+        break;
+
+    case PC_VPC_SCRUB_TRIG:
+        pnv_xive_vp_update(xive, GETFIELD(PC_SCRUB_OFFSET, val));
+        break;
+
+    case VC_EQC_CWATCH_DAT0:
+    case VC_EQC_CWATCH_DAT1:
+    case VC_EQC_CWATCH_DAT2:
+    case VC_EQC_CWATCH_DAT3: /* XiveEQ data for update */
+        xive->eqc_watch[(offset - VC_EQC_CWATCH_DAT0) / 8] =3D cpu_to_be=
64(val);
+        break;
+
+    case VC_EQC_SCRUB_TRIG:
+        pnv_xive_eq_update(xive, GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+
+    case VC_VSD_TABLE_ADDR:
+    case PC_VSD_TABLE_ADDR:
+        xive->vst_tsel =3D GETFIELD(VST_TABLE_SELECT, val);
+        xive->vst_tidx =3D GETFIELD(VST_TABLE_OFFSET, val);
+        break;
+
+    case VC_VSD_TABLE_DATA:
+        pnv_xive_table_set_data(xive, val, false);
+        break;
+
+    case PC_VSD_TABLE_DATA:
+        pnv_xive_table_set_data(xive, val, true);
+        break;
+
+    case VC_SBC_CONFIG:
+        xive->regs[reg] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid writing to reg=3D=
0x%08x"
+                      " mmio=3D%d\n", offset, mmio);
+    }
+}
+
+static uint64_t pnv_xive_ic_reg_read(PnvXive *xive, uint32_t offset, boo=
l mmio)
+{
+    uint64_t val =3D 0;
+    uint32_t reg =3D offset >> 3;
+
+    switch (offset) {
+    case CQ_CFG_PB_GEN:
+    case CQ_MSGSND: /* activated cores */
+    case CQ_IC_BAR:
+    case CQ_TM1_BAR:
+    case CQ_TM2_BAR:
+    case CQ_PC_BAR:
+    case CQ_PC_BARM:
+    case CQ_VC_BAR:
+    case CQ_VC_BARM:
+    case CQ_TAR:
+    case CQ_TDR:
+    case CQ_PBI_CTL:
+
+    case PC_TCTXT_CFG:
+    case PC_TCTXT_TRACK:
+    case PC_TCTXT_INDIR0:
+    case PC_TCTXT_INDIR1:
+    case PC_TCTXT_INDIR2:
+    case PC_TCTXT_INDIR3:
+    case PC_GLOBAL_CONFIG:
+
+    case PC_VPC_SCRUB_MASK:
+    case PC_VPC_CWATCH_SPEC:
+    case PC_VPC_CWATCH_DAT0:
+    case PC_VPC_CWATCH_DAT1:
+    case PC_VPC_CWATCH_DAT2:
+    case PC_VPC_CWATCH_DAT3:
+    case PC_VPC_CWATCH_DAT4:
+    case PC_VPC_CWATCH_DAT5:
+    case PC_VPC_CWATCH_DAT6:
+    case PC_VPC_CWATCH_DAT7:
+
+    case VC_GLOBAL_CONFIG:
+    case VC_AIB_TX_ORDER_TAG2:
+
+    case VC_IRQ_CONFIG_IPI:
+    case VC_IRQ_CONFIG_HW:
+    case VC_IRQ_CONFIG_CASCADE1:
+    case VC_IRQ_CONFIG_CASCADE2:
+    case VC_IRQ_CONFIG_REDIST:
+    case VC_IRQ_CONFIG_IPI_CASC:
+
+    case VC_EQC_SCRUB_MASK:
+    case VC_EQC_CWATCH_DAT0:
+    case VC_EQC_CWATCH_DAT1:
+    case VC_EQC_CWATCH_DAT2:
+    case VC_EQC_CWATCH_DAT3:
+
+    case VC_EQC_CWATCH_SPEC:
+    case VC_IVC_SCRUB_MASK:
+    case VC_SBC_CONFIG:
+    case VC_AT_MACRO_KILL_MASK:
+    case VC_VSD_TABLE_ADDR:
+    case PC_VSD_TABLE_ADDR:
+    case VC_VSD_TABLE_DATA:
+    case PC_VSD_TABLE_DATA:
+        val =3D xive->regs[reg];
+        break;
+    case PC_VPC_SCRUB_TRIG:
+    case VC_IVC_SCRUB_TRIG:
+    case VC_EQC_SCRUB_TRIG:
+        xive->regs[reg] &=3D ~VC_SCRUB_VALID;
+        val =3D xive->regs[reg];
+        break;
+    case VC_EQC_CONFIG:
+        val =3D SYNC_MASK;
+        break;
+    case PC_AT_KILL:
+        xive->regs[reg] &=3D ~PC_AT_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+    case VC_AT_MACRO_KILL:
+        xive->regs[reg] &=3D ~VC_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid read reg=3D0x%0=
8x"
+                      " mmio=3D%d\n", offset, mmio);
+    }
+
+    return val;
+}
+
+/*
+ * Interrupt Controller MMIO: Notify ports
+ */
+static void pnv_xive_ic_notify_write(PnvXive *xive, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xive);
+
+    xfc->notify(XIVE_FABRIC(xive), val);
+}
+
+/*
+ * Interrupt Controller MMIO: Synchronisation registers
+ */
+#define PNV_XIVE_SYNC_IPI       0x400 /* Sync IPI */
+#define PNV_XIVE_SYNC_HW        0x480 /* Sync HW */
+#define PNV_XIVE_SYNC_OS_ESC    0x500 /* Sync OS escalations */
+#define PNV_XIVE_SYNC_HW_ESC    0x580 /* Sync Hyp escalations */
+#define PNV_XIVE_SYNC_REDIS     0x600 /* Sync Redistribution */
+
+static void pnv_xive_ic_sync_write(void *opaque, hwaddr addr, uint64_t v=
al,
+                                   unsigned size)
+{
+
+    switch (addr) {
+    case PNV_XIVE_SYNC_IPI:
+    case PNV_XIVE_SYNC_HW:
+    case PNV_XIVE_SYNC_OS_ESC:
+    case PNV_XIVE_SYNC_HW_ESC:
+    case PNV_XIVE_SYNC_REDIS:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid sync @%"
+                      HWADDR_PRIx"\n", addr);
+    }
+}
+
+/*
+ * Interrupt controller MMIO regions
+ *
+ * 0x00000 - 0x0FFFF : BARs
+ * 0x10000 - 0x107FF : Notify ports
+ * 0x10800 - 0x10FFF : Synchronisation registers
+ * 0x40000 - 0x7FFFF : indirect TIMA
+ */
+static void pnv_xive_ic_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned size)
+{
+    switch (addr) {
+    case 0x00000 ... 0x0FFFF:
+        pnv_xive_ic_reg_write(opaque, addr, val, true);
+        break;
+    case 0x10000 ... 0x107FF:
+        pnv_xive_ic_notify_write(opaque, addr - 0x10000, val, size);
+        break;
+    case 0x10800 ... 0x10FFF:
+        pnv_xive_ic_sync_write(opaque, addr - 0x10800, val, size);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid write @%"
+                      HWADDR_PRIx"\n", addr);
+        break;
+    }
+}
+
+static uint64_t pnv_xive_ic_read(void *opaque, hwaddr addr, unsigned siz=
e)
+{
+    uint64_t ret =3D 0;
+
+    switch (addr) {
+    case 0x00000 ... 0x0FFFF:
+        ret =3D pnv_xive_ic_reg_read(opaque, addr, true);
+        break;
+    case 0x10800 ... 0x10FFF:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: read IC notify port addr @=
%"
+                      HWADDR_PRIx"\n", addr);
+        break;
+    case 0x10000 ... 0x107FF:
+        /* no writes on synchronisation registers */
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE/IC: invalid read @%"
+                      HWADDR_PRIx"\n", addr);
+        break;
+    }
+
+    return ret;
+}
+
+static const MemoryRegionOps pnv_xive_ic_ops =3D {
+    .read =3D pnv_xive_ic_read,
+    .write =3D pnv_xive_ic_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
+/*
+ * Interrupt controller XSCOM regions. Accesses can nearly all be
+ * redirected to the MMIO region.
+ */
+static uint64_t pnv_xive_xscom_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    switch (addr >> 3) {
+    case X_VC_EQC_CONFIG:
+        /* This is the only XSCOM load done in skiboot. To be checked. *=
/
+        return SYNC_MASK;
+    default:
+        return pnv_xive_ic_reg_read(opaque, addr, false);
+    }
+}
+
+static void pnv_xive_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    pnv_xive_ic_reg_write(opaque, addr, val, false);
+}
+
+static const MemoryRegionOps pnv_xive_xscom_ops =3D {
+    .read =3D pnv_xive_xscom_read,
+    .write =3D pnv_xive_xscom_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    }
+};
+
+/* TODO: finish reconciliating with XIVE generic routing routine */
+static void pnv_xive_notify(XiveFabric *xf, uint32_t lisn)
+{
+    PnvXive *xive =3D PNV_XIVE(xf);
+    XiveIVE *ive;
+    XiveEQ eq;
+    uint32_t eq_idx;
+    uint8_t priority;
+    uint32_t nvt_idx;
+    XiveNVT *nvt;
+
+    ive =3D xive_fabric_get_ive(xf, lisn);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
+        return;
+    }
+
+    if (ive->w & IVE_MASKED) {
+        return;
+    }
+
+    /* Find our XiveEQ */
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    if (pnv_xive_eq_get(xive, eq_idx, &eq)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ %d\n", eq_idx);
+        return;
+    }
+
+    if (!(eq.w0 & EQ_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No valid EQ for LISN %d\n"=
, lisn);
+        return;
+    }
+
+    if (eq.w0 & EQ_W0_ENQUEUE) {
+        xive_eq_push(&eq, GETFIELD(IVE_EQ_DATA, ive->w));
+        pnv_xive_eq_set(xive, eq_idx, &eq);
+    }
+    if (!(eq.w0 & EQ_W0_UCOND_NOTIFY)) {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
+    }
+
+    nvt_idx =3D GETFIELD(EQ_W6_NVT_INDEX, eq.w6);
+    nvt =3D xive_fabric_get_nvt(xf, nvt_idx);
+    if (!nvt) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVT for idx %d\n", nvt_=
idx);
+        return;
+    }
+
+    if (GETFIELD(EQ_W6_FORMAT_BIT, eq.w6) =3D=3D 0) {
+        priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq.w7);
+
+        /* The EQ is masked. Can this happen ?  */
+        if (priority =3D=3D 0xff) {
+            return;
+        }
+
+        /* Update the IPB (Interrupt Pending Buffer) with the priority
+         * of the new notification. HW uses MMIOs to update the VP
+         * structures. Something to address later.
+         */
+        xive_nvt_hv_ipb_update(nvt, priority);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
+    }
+
+    xive_nvt_hv_notify(nvt);
+}
+
+/*
+ * Virtualization Controller MMIO region. It contain the ESB pages for
+ * the IPIs interrupts and ESB pages for the EQs. The split is done
+ * with the set translation tables.
+ */
+static uint64_t pnv_xive_vc_read(void *opaque, hwaddr offset,
+                                   unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/VC: invalid read @%"
+                  HWADDR_PRIx"\n", offset);
+
+    /* if out of scope, specs says to return all ones */
+    return -1;
+}
+
+static void pnv_xive_vc_write(void *opaque, hwaddr offset,
+                                uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/VC: invalid write @%"
+                  HWADDR_PRIx" val=3D0x%"PRIx64"\n", offset, value);
+}
+
+static const MemoryRegionOps pnv_xive_vc_ops =3D {
+    .read =3D pnv_xive_vc_read,
+    .write =3D pnv_xive_vc_write,
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
+/*
+ * Presenter Controller MMIO region. This is used by the
+ * Virtualization Controller to update the IPB and the NVT (XiveVP)
+ * table when required. Not implemented yet.
+ */
+static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
+                                 unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/PC: invalid read @%"HWADDR_PRIx=
"\n",
+                  addr);
+    return -1;
+}
+
+static void pnv_xive_pc_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE/PC: invalid write @%"HWADDR_PRI=
x
+                  " val=3D0x%"PRIx64"\n", offset, value);
+}
+
+static const MemoryRegionOps pnv_xive_pc_ops =3D {
+    .read =3D pnv_xive_pc_read,
+    .write =3D pnv_xive_pc_write,
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
+void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
+{
+    int i;
+
+    monitor_printf(mon, "IVE Table\n");
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+        uint32_t eq_idx;
+
+        if (!(ive->w & IVE_VALID)) {
+            continue;
+        }
+
+        eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+
+        monitor_printf(mon, " %6x %s eqidx:%d ", i,
+                       ive->w & IVE_MASKED ? "M" : " ",
+                       eq_idx);
+
+
+        if (!(ive->w & IVE_MASKED)) {
+            XiveEQ eq;
+
+            if (!pnv_xive_eq_get(xive, eq_idx, &eq)) {
+                xive_eq_pic_print_info(&eq, mon);
+                monitor_printf(mon, " data:%08x",
+                               (int) GETFIELD(IVE_EQ_DATA, ive->w));
+            } else {
+                monitor_printf(mon, "no eq ?!");
+            }
+        }
+        monitor_printf(mon, "\n");
+    }
+
+    xive_source_pic_print_info(&xive->source, mon);
+}
+
+static void pnv_xive_reset(DeviceState *dev)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+    int i;
+
+    device_reset(DEVICE(&xive->source));
+    device_reset(DEVICE(&xive->eq_source));
+
+    /* Mask all valid IVEs in the IRQ number space. */
+    for (i =3D 0; i < xive->nr_irqs; i++) {
+        XiveIVE *ive =3D &xive->ivt[i];
+        if (ive->w & IVE_VALID) {
+            ive->w |=3D IVE_MASKED;
+        }
+    }
+}
+
+static void pnv_xive_init(Object *obj)
+{
+    PnvXive *xive =3D PNV_XIVE(obj);
+
+    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);
+    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
+
+    object_initialize(&xive->eq_source, sizeof(xive->eq_source),
+                      TYPE_XIVE_SOURCE);
+    object_property_add_child(obj, "eq_source", OBJECT(&xive->eq_source)=
, NULL);
+}
+
+static void pnv_xive_realize(DeviceState *dev, Error **errp)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+
+    /* XSCOM region */
+    memory_region_init_io(&xive->xscom_regs, OBJECT(dev), &pnv_xive_xsco=
m_ops,
+                          xive, "xscom-xive", PNV_XSCOM_XIVE_SIZE << 3);
+
+    /* Interrupt controller MMIO region */
+    memory_region_init_io(&xive->ic_mmio, OBJECT(dev), &pnv_xive_ic_ops,=
 xive,
+                          "xive.ic", PNV_XIVE_IC_SIZE);
+
+    /* Overall Virtualization Controller MMIO region.  */
+    memory_region_init_io(&xive->vc_mmio, OBJECT(xive), &pnv_xive_vc_ops=
, xive,
+                          "xive.vc", PNV_XIVE_VC_SIZE);
+
+    /* Virtualization Controller subregions for IPIs & EQs. Their
+     * sizes and offsets will be configured later when the translation
+     * sets are established
+     */
+    xive->esb_base =3D xive->vc_base;
+    memory_region_init_io(&xive->esb_mmio, OBJECT(xive), NULL, xive,
+                          "xive.vc.esb", 0);
+    memory_region_add_subregion(&xive->vc_mmio, 0, &xive->esb_mmio);
+
+    xive->eq_base =3D xive->vc_base;
+    memory_region_init_io(&xive->eq_mmio, OBJECT(xive), NULL, xive,
+                          "xive.vc.eq", 0);
+    memory_region_add_subregion(&xive->vc_mmio, 0, &xive->eq_mmio);
+
+    /* Thread Interrupt Management Area */
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_hv_ops,
+                          &xive->cpu_ind, "xive.tima", PNV_XIVE_TM_SIZE)=
;
+    memory_region_init_alias(&xive->tm_mmio_indirect, OBJECT(xive),
+                             "xive.tima.indirect",
+                             &xive->tm_mmio, 0, PNV_XIVE_TM_SIZE);
+
+    /* Presenter Controller MMIO region */
+    memory_region_init_io(&xive->pc_mmio, OBJECT(xive), &pnv_xive_pc_ops=
, xive,
+                          "xive.pc", PNV_XIVE_PC_SIZE);
+
+    /* Map all regions from the XIVE model realize routine. This is
+     * simpler than from the machine
+     */
+    memory_region_add_subregion(get_system_memory(), xive->ic_base,
+                                &xive->ic_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->ic_base + 0x4=
0000,
+                                &xive->tm_mmio_indirect);
+    memory_region_add_subregion(get_system_memory(), xive->vc_base,
+                                &xive->vc_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->pc_base,
+                                &xive->pc_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->tm_base,
+                                &xive->tm_mmio);
+}
+
+static int pnv_xive_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] =3D "ibm,power9-xive-x";
+    char *name;
+    int offset;
+    uint32_t lpc_pcba =3D PNV_XSCOM_XIVE_BASE;
+    uint32_t reg[] =3D {
+        cpu_to_be32(lpc_pcba),
+        cpu_to_be32(PNV_XSCOM_XIVE_SIZE)
+    };
+
+    name =3D g_strdup_printf("xive@%x", lpc_pcba);
+    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
+    _FDT(offset);
+    g_free(name);
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
+    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
+                      sizeof(compat))));
+    return 0;
+}
+
+static Property pnv_xive_properties[] =3D {
+    DEFINE_PROP_UINT64("ic-bar", PnvXive, ic_base, 0),
+    DEFINE_PROP_UINT64("vc-bar", PnvXive, vc_base, 0),
+    DEFINE_PROP_UINT64("pc-bar", PnvXive, pc_base, 0),
+    DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static XiveNVT *pnv_xive_get_nvt(XiveFabric *xf, uint32_t nvt_idx)
+{
+    PnvXive *xive =3D PNV_XIVE(xf);
+    int server;
+    PowerPCCPU *cpu;
+    XiveVP vp;
+
+    /* only use the VP to check the valid bit */
+    if (pnv_xive_vp_get(xive, nvt_idx, &vp)) {
+        return NULL;
+    }
+
+    if (!(vp.w0 & VP_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: VP idx %x is invalid\n", n=
vt_idx);
+        return NULL;
+    }
+
+    /* TODO: quick and dirty NVT-to-server decoding ... This needs
+     * more care. */
+    server =3D nvt_idx & 0x7f;
+    cpu =3D ppc_get_vcpu_by_pir(server);
+
+    return cpu ? XIVE_NVT(cpu->intc) : NULL;
+}
+
+static XiveIVE *pnv_xive_get_ive(XiveFabric *xf, uint32_t lisn)
+{
+    PnvXive *xive =3D PNV_XIVE(xf);
+
+    return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
+}
+
+static void pnv_xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
+
+    xdc->dt_xscom =3D pnv_xive_dt_xscom;
+
+    dc->desc =3D "PowerNV XIVE Interrupt Controller";
+    dc->realize =3D pnv_xive_realize;
+    dc->props =3D pnv_xive_properties;
+    dc->reset =3D pnv_xive_reset;
+
+    xfc->get_ive =3D pnv_xive_get_ive;
+    xfc->get_nvt =3D pnv_xive_get_nvt;
+    /* TODO : xfc->get_eq */
+    xfc->notify =3D pnv_xive_notify;
+};
+
+static const TypeInfo pnv_xive_info =3D {
+    .name          =3D TYPE_PNV_XIVE,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_init =3D pnv_xive_init,
+    .instance_size =3D sizeof(PnvXive),
+    .class_init    =3D pnv_xive_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { TYPE_XIVE_FABRIC },
+        { }
+    }
+};
+
+static void pnv_xive_register_types(void)
+{
+    type_register_static(&pnv_xive_info);
+}
+
+type_init(pnv_xive_register_types)
+
+void pnv_chip_xive_realize(PnvChip *chip, Error **errp)
+{
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    obj =3D object_new(TYPE_PNV_XIVE);
+    qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+
+    object_property_add_child(OBJECT(chip), "xive", obj, &error_abort);
+    object_property_set_int(obj, PNV_XIVE_IC_BASE(chip), "ic-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_VC_BASE(chip), "vc-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_PC_BASE(chip), "pc-bar",
+                            &error_fatal);
+    object_property_set_int(obj, PNV_XIVE_TM_BASE(chip), "tm-bar",
+                            &error_fatal);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    chip->xive =3D PNV_XIVE(obj);
+
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_XIVE_BASE,
+                            &chip->xive->xscom_regs);
+}
diff --git a/hw/intc/pnv_xive_regs.h b/hw/intc/pnv_xive_regs.h
new file mode 100644
index 000000000000..2ea371211bcc
--- /dev/null
+++ b/hw/intc/pnv_xive_regs.h
@@ -0,0 +1,314 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_XIVE_REGS_H
+#define PPC_PNV_XIVE_REGS_H
+
+/* IC register offsets */
+#define CQ_SWI_CMD_HIST         0x020
+#define CQ_SWI_CMD_POLL         0x028
+#define CQ_SWI_CMD_BCAST        0x030
+#define CQ_SWI_CMD_ASSIGN       0x038
+#define CQ_SWI_CMD_BLK_UPD      0x040
+#define CQ_SWI_RSP              0x048
+#define X_CQ_CFG_PB_GEN         0x0a
+#define CQ_CFG_PB_GEN           0x050
+#define   CQ_INT_ADDR_OPT       PPC_BITMASK(14, 15)
+#define X_CQ_IC_BAR             0x10
+#define X_CQ_MSGSND             0x0b
+#define CQ_MSGSND               0x058
+#define CQ_CNPM_SEL             0x078
+#define CQ_IC_BAR               0x080
+#define   CQ_IC_BAR_VALID       PPC_BIT(0)
+#define   CQ_IC_BAR_64K         PPC_BIT(1)
+#define X_CQ_TM1_BAR            0x12
+#define CQ_TM1_BAR              0x90
+#define X_CQ_TM2_BAR            0x014
+#define CQ_TM2_BAR              0x0a0
+#define   CQ_TM_BAR_VALID       PPC_BIT(0)
+#define   CQ_TM_BAR_64K         PPC_BIT(1)
+#define X_CQ_PC_BAR             0x16
+#define CQ_PC_BAR               0x0b0
+#define  CQ_PC_BAR_VALID        PPC_BIT(0)
+#define X_CQ_PC_BARM            0x17
+#define CQ_PC_BARM              0x0b8
+#define  CQ_PC_BARM_MASK        PPC_BITMASK(26, 38)
+#define X_CQ_VC_BAR             0x18
+#define CQ_VC_BAR               0x0c0
+#define  CQ_VC_BAR_VALID        PPC_BIT(0)
+#define X_CQ_VC_BARM            0x19
+#define CQ_VC_BARM              0x0c8
+#define  CQ_VC_BARM_MASK        PPC_BITMASK(21, 37)
+#define X_CQ_TAR                0x1e
+#define CQ_TAR                  0x0f0
+#define  CQ_TAR_TBL_AUTOINC     PPC_BIT(0)
+#define  CQ_TAR_TSEL            PPC_BITMASK(12, 15)
+#define  CQ_TAR_TSEL_BLK        PPC_BIT(12)
+#define  CQ_TAR_TSEL_MIG        PPC_BIT(13)
+#define  CQ_TAR_TSEL_VDT        PPC_BIT(14)
+#define  CQ_TAR_TSEL_EDT        PPC_BIT(15)
+#define  CQ_TAR_TSEL_INDEX      PPC_BITMASK(26, 31)
+#define X_CQ_TDR                0x1f
+#define CQ_TDR                  0x0f8
+#define  CQ_TDR_VDT_VALID       PPC_BIT(0)
+#define  CQ_TDR_VDT_BLK         PPC_BITMASK(11, 15)
+#define  CQ_TDR_VDT_INDEX       PPC_BITMASK(28, 31)
+#define  CQ_TDR_EDT_TYPE        PPC_BITMASK(0, 1)
+#define  CQ_TDR_EDT_INVALID     0
+#define  CQ_TDR_EDT_IPI         1
+#define  CQ_TDR_EDT_EQ          2
+#define  CQ_TDR_EDT_BLK         PPC_BITMASK(12, 15)
+#define  CQ_TDR_EDT_INDEX       PPC_BITMASK(26, 31)
+#define X_CQ_PBI_CTL            0x20
+#define CQ_PBI_CTL              0x100
+#define  CQ_PBI_PC_64K          PPC_BIT(5)
+#define  CQ_PBI_VC_64K          PPC_BIT(6)
+#define  CQ_PBI_LNX_TRIG        PPC_BIT(7)
+#define  CQ_PBI_FORCE_TM_LOCAL  PPC_BIT(22)
+#define CQ_PBO_CTL              0x108
+#define CQ_AIB_CTL              0x110
+#define X_CQ_RST_CTL            0x23
+#define CQ_RST_CTL              0x118
+#define X_CQ_FIRMASK            0x33
+#define CQ_FIRMASK              0x198
+#define X_CQ_FIRMASK_AND        0x34
+#define CQ_FIRMASK_AND          0x1a0
+#define X_CQ_FIRMASK_OR         0x35
+#define CQ_FIRMASK_OR           0x1a8
+
+/* PC LBS1 register offsets */
+#define X_PC_TCTXT_CFG          0x100
+#define PC_TCTXT_CFG            0x400
+#define  PC_TCTXT_CFG_BLKGRP_EN         PPC_BIT(0)
+#define  PC_TCTXT_CFG_TARGET_EN         PPC_BIT(1)
+#define  PC_TCTXT_CFG_LGS_EN            PPC_BIT(2)
+#define  PC_TCTXT_CFG_STORE_ACK         PPC_BIT(3)
+#define  PC_TCTXT_CFG_HARD_CHIPID_BLK   PPC_BIT(8)
+#define  PC_TCTXT_CHIPID_OVERRIDE       PPC_BIT(9)
+#define  PC_TCTXT_CHIPID                PPC_BITMASK(12, 15)
+#define  PC_TCTXT_INIT_AGE              PPC_BITMASK(30, 31)
+#define X_PC_TCTXT_TRACK        0x101
+#define PC_TCTXT_TRACK          0x408
+#define  PC_TCTXT_TRACK_EN              PPC_BIT(0)
+#define X_PC_TCTXT_INDIR0       0x104
+#define PC_TCTXT_INDIR0         0x420
+#define  PC_TCTXT_INDIR_VALID           PPC_BIT(0)
+#define  PC_TCTXT_INDIR_THRDID          PPC_BITMASK(9, 15)
+#define X_PC_TCTXT_INDIR1       0x105
+#define PC_TCTXT_INDIR1         0x428
+#define X_PC_TCTXT_INDIR2       0x106
+#define PC_TCTXT_INDIR2         0x430
+#define X_PC_TCTXT_INDIR3       0x107
+#define PC_TCTXT_INDIR3         0x438
+#define X_PC_THREAD_EN_REG0     0x108
+#define PC_THREAD_EN_REG0       0x440
+#define X_PC_THREAD_EN_REG0_SET 0x109
+#define PC_THREAD_EN_REG0_SET   0x448
+#define X_PC_THREAD_EN_REG0_CLR 0x10a
+#define PC_THREAD_EN_REG0_CLR   0x450
+#define X_PC_THREAD_EN_REG1     0x10c
+#define PC_THREAD_EN_REG1       0x460
+#define X_PC_THREAD_EN_REG1_SET 0x10d
+#define PC_THREAD_EN_REG1_SET   0x468
+#define X_PC_THREAD_EN_REG1_CLR 0x10e
+#define PC_THREAD_EN_REG1_CLR   0x470
+#define X_PC_GLOBAL_CONFIG      0x110
+#define PC_GLOBAL_CONFIG        0x480
+#define  PC_GCONF_INDIRECT      PPC_BIT(32)
+#define  PC_GCONF_CHIPID_OVR    PPC_BIT(40)
+#define  PC_GCONF_CHIPID        PPC_BITMASK(44, 47)
+#define X_PC_VSD_TABLE_ADDR     0x111
+#define PC_VSD_TABLE_ADDR       0x488
+#define X_PC_VSD_TABLE_DATA     0x112
+#define PC_VSD_TABLE_DATA       0x490
+#define X_PC_AT_KILL            0x116
+#define PC_AT_KILL              0x4b0
+#define  PC_AT_KILL_VALID       PPC_BIT(0)
+#define  PC_AT_KILL_BLOCK_ID    PPC_BITMASK(27, 31)
+#define  PC_AT_KILL_OFFSET      PPC_BITMASK(48, 60)
+#define X_PC_AT_KILL_MASK       0x117
+#define PC_AT_KILL_MASK         0x4b8
+
+/* PC LBS2 register offsets */
+#define X_PC_VPC_CACHE_ENABLE   0x161
+#define PC_VPC_CACHE_ENABLE     0x708
+#define  PC_VPC_CACHE_EN_MASK   PPC_BITMASK(0, 31)
+#define X_PC_VPC_SCRUB_TRIG     0x162
+#define PC_VPC_SCRUB_TRIG       0x710
+#define X_PC_VPC_SCRUB_MASK     0x163
+#define PC_VPC_SCRUB_MASK       0x718
+#define  PC_SCRUB_VALID         PPC_BIT(0)
+#define  PC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  PC_SCRUB_WANT_INVAL    PPC_BIT(2)
+#define  PC_SCRUB_BLOCK_ID      PPC_BITMASK(27, 31)
+#define  PC_SCRUB_OFFSET        PPC_BITMASK(45, 63)
+#define X_PC_VPC_CWATCH_SPEC    0x167
+#define PC_VPC_CWATCH_SPEC      0x738
+#define  PC_VPC_CWATCH_CONFLICT PPC_BIT(0)
+#define  PC_VPC_CWATCH_FULL     PPC_BIT(8)
+#define  PC_VPC_CWATCH_BLOCKID  PPC_BITMASK(27, 31)
+#define  PC_VPC_CWATCH_OFFSET   PPC_BITMASK(45, 63)
+#define X_PC_VPC_CWATCH_DAT0    0x168
+#define PC_VPC_CWATCH_DAT0      0x740
+#define X_PC_VPC_CWATCH_DAT1    0x169
+#define PC_VPC_CWATCH_DAT1      0x748
+#define X_PC_VPC_CWATCH_DAT2    0x16a
+#define PC_VPC_CWATCH_DAT2      0x750
+#define X_PC_VPC_CWATCH_DAT3    0x16b
+#define PC_VPC_CWATCH_DAT3      0x758
+#define X_PC_VPC_CWATCH_DAT4    0x16c
+#define PC_VPC_CWATCH_DAT4      0x760
+#define X_PC_VPC_CWATCH_DAT5    0x16d
+#define PC_VPC_CWATCH_DAT5      0x768
+#define X_PC_VPC_CWATCH_DAT6    0x16e
+#define PC_VPC_CWATCH_DAT6      0x770
+#define X_PC_VPC_CWATCH_DAT7    0x16f
+#define PC_VPC_CWATCH_DAT7      0x778
+
+/* VC0 register offsets */
+#define X_VC_GLOBAL_CONFIG      0x200
+#define VC_GLOBAL_CONFIG        0x800
+#define  VC_GCONF_INDIRECT      PPC_BIT(32)
+#define X_VC_VSD_TABLE_ADDR     0x201
+#define VC_VSD_TABLE_ADDR       0x808
+#define X_VC_VSD_TABLE_DATA     0x202
+#define VC_VSD_TABLE_DATA       0x810
+#define VC_IVE_ISB_BLOCK_MODE   0x818
+#define VC_EQD_BLOCK_MODE       0x820
+#define VC_VPS_BLOCK_MODE       0x828
+#define X_VC_IRQ_CONFIG_IPI     0x208
+#define VC_IRQ_CONFIG_IPI       0x840
+#define  VC_IRQ_CONFIG_MEMB_EN  PPC_BIT(45)
+#define  VC_IRQ_CONFIG_MEMB_SZ  PPC_BITMASK(46, 51)
+#define VC_IRQ_CONFIG_HW        0x848
+#define VC_IRQ_CONFIG_CASCADE1  0x850
+#define VC_IRQ_CONFIG_CASCADE2  0x858
+#define VC_IRQ_CONFIG_REDIST    0x860
+#define VC_IRQ_CONFIG_IPI_CASC  0x868
+#define X_VC_AIB_TX_ORDER_TAG2  0x22d
+#define  VC_AIB_TX_ORDER_TAG2_REL_TF    PPC_BIT(20)
+#define VC_AIB_TX_ORDER_TAG2    0x890
+#define X_VC_AT_MACRO_KILL      0x23e
+#define VC_AT_MACRO_KILL        0x8b0
+#define X_VC_AT_MACRO_KILL_MASK 0x23f
+#define VC_AT_MACRO_KILL_MASK   0x8b8
+#define  VC_KILL_VALID          PPC_BIT(0)
+#define  VC_KILL_TYPE           PPC_BITMASK(14, 15)
+#define   VC_KILL_IRQ   0
+#define   VC_KILL_IVC   1
+#define   VC_KILL_SBC   2
+#define   VC_KILL_EQD   3
+#define  VC_KILL_BLOCK_ID       PPC_BITMASK(27, 31)
+#define  VC_KILL_OFFSET         PPC_BITMASK(48, 60)
+#define X_VC_EQC_CACHE_ENABLE   0x211
+#define VC_EQC_CACHE_ENABLE     0x908
+#define  VC_EQC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define X_VC_EQC_SCRUB_TRIG     0x212
+#define VC_EQC_SCRUB_TRIG       0x910
+#define X_VC_EQC_SCRUB_MASK     0x213
+#define VC_EQC_SCRUB_MASK       0x918
+#define X_VC_EQC_CWATCH_SPEC    0x215
+#define VC_EQC_CONFIG           0x920
+#define X_VC_EQC_CONFIG         0x214
+#define  VC_EQC_CONF_SYNC_IPI           PPC_BIT(32)
+#define  VC_EQC_CONF_SYNC_HW            PPC_BIT(33)
+#define  VC_EQC_CONF_SYNC_ESC1          PPC_BIT(34)
+#define  VC_EQC_CONF_SYNC_ESC2          PPC_BIT(35)
+#define  VC_EQC_CONF_SYNC_REDI          PPC_BIT(36)
+#define  VC_EQC_CONF_EQP_INTERLEAVE     PPC_BIT(38)
+#define  VC_EQC_CONF_ENABLE_END_s_BIT   PPC_BIT(39)
+#define  VC_EQC_CONF_ENABLE_END_u_BIT   PPC_BIT(40)
+#define  VC_EQC_CONF_ENABLE_END_c_BIT   PPC_BIT(41)
+#define  VC_EQC_CONF_ENABLE_MORE_QSZ    PPC_BIT(42)
+#define  VC_EQC_CONF_SKIP_ESCALATE      PPC_BIT(43)
+#define VC_EQC_CWATCH_SPEC      0x928
+#define  VC_EQC_CWATCH_CONFLICT PPC_BIT(0)
+#define  VC_EQC_CWATCH_FULL     PPC_BIT(8)
+#define  VC_EQC_CWATCH_BLOCKID  PPC_BITMASK(28, 31)
+#define  VC_EQC_CWATCH_OFFSET   PPC_BITMASK(40, 63)
+#define X_VC_EQC_CWATCH_DAT0    0x216
+#define VC_EQC_CWATCH_DAT0      0x930
+#define X_VC_EQC_CWATCH_DAT1    0x217
+#define VC_EQC_CWATCH_DAT1      0x938
+#define X_VC_EQC_CWATCH_DAT2    0x218
+#define VC_EQC_CWATCH_DAT2      0x940
+#define X_VC_EQC_CWATCH_DAT3    0x219
+#define VC_EQC_CWATCH_DAT3      0x948
+#define X_VC_IVC_SCRUB_TRIG     0x222
+#define VC_IVC_SCRUB_TRIG       0x990
+#define X_VC_IVC_SCRUB_MASK     0x223
+#define VC_IVC_SCRUB_MASK       0x998
+#define X_VC_SBC_SCRUB_TRIG     0x232
+#define VC_SBC_SCRUB_TRIG       0xa10
+#define X_VC_SBC_SCRUB_MASK     0x233
+#define VC_SBC_SCRUB_MASK       0xa18
+#define  VC_SCRUB_VALID         PPC_BIT(0)
+#define  VC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  VC_SCRUB_WANT_INVAL    PPC_BIT(2) /* EQC and SBC only */
+#define  VC_SCRUB_BLOCK_ID      PPC_BITMASK(28, 31)
+#define  VC_SCRUB_OFFSET        PPC_BITMASK(40, 63)
+#define X_VC_IVC_CACHE_ENABLE   0x221
+#define VC_IVC_CACHE_ENABLE     0x988
+#define  VC_IVC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define X_VC_SBC_CACHE_ENABLE   0x231
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define  VC_SBC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define VC_IVC_CACHE_SCRUB_TRIG 0x990
+#define VC_IVC_CACHE_SCRUB_MASK 0x998
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define VC_SBC_CACHE_SCRUB_TRIG 0xa10
+#define VC_SBC_CACHE_SCRUB_MASK 0xa18
+#define VC_SBC_CONFIG           0xa20
+#define X_VC_SBC_CONFIG         0x234
+#define  VC_SBC_CONF_CPLX_CIST  PPC_BIT(44)
+#define  VC_SBC_CONF_CIST_BOTH  PPC_BIT(45)
+#define  VC_SBC_CONF_NO_UPD_PRF PPC_BIT(59)
+
+/* VC1 register offsets */
+
+/* VSD Table address register definitions (shared) */
+#define VST_ADDR_AUTOINC        PPC_BIT(0)
+#define VST_TABLE_SELECT        PPC_BITMASK(13, 15)
+#define  VST_TSEL_IVT   0
+#define  VST_TSEL_SBE   1
+#define  VST_TSEL_EQDT  2
+#define  VST_TSEL_VPDT  3
+#define  VST_TSEL_IRQ   4       /* VC only */
+#define VST_TABLE_OFFSET        PPC_BITMASK(27, 31)
+
+/* Number of queue overflow pages */
+#define VC_QUEUE_OVF_COUNT      6
+
+/* Bits in a VSD entry.
+ *
+ * Note: the address is naturally aligned,  we don't use a PPC_BITMASK,
+ *       but just a mask to apply to the address before OR'ing it in.
+ *
+ * Note: VSD_FIRMWARE is a SW bit ! It hijacks an unused bit in the
+ *       VSD and is only meant to be used in indirect mode !
+ */
+#define VSD_MODE                PPC_BITMASK(0, 1)
+#define  VSD_MODE_SHARED        1
+#define  VSD_MODE_EXCLUSIVE     2
+#define  VSD_MODE_FORWARD       3
+#define VSD_ADDRESS_MASK        0x0ffffffffffff000ull
+#define VSD_MIGRATION_REG       PPC_BITMASK(52, 55)
+#define VSD_INDIRECT            PPC_BIT(56)
+#define VSD_TSIZE               PPC_BITMASK(59, 63)
+#define VSD_FIRMWARE            PPC_BIT(2) /* Read warning above */
+
+#define SYNC_MASK                \
+        (VC_EQC_CONF_SYNC_IPI  | \
+         VC_EQC_CONF_SYNC_HW   | \
+         VC_EQC_CONF_SYNC_ESC1 | \
+         VC_EQC_CONF_SYNC_ESC2 | \
+         VC_EQC_CONF_SYNC_REDI)
+
+
+#endif /* PPC_PNV_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4a9b09e3d819..782a2f8f5ef2 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -60,7 +60,7 @@ void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon)
                    priority, server, qaddr_base, qindex, qentries, qgen)=
;
 }
=20
-static void xive_eq_push(XiveEQ *eq, uint32_t data)
+void xive_eq_push(XiveEQ *eq, uint32_t data)
 {
     uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
     uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
@@ -137,6 +137,12 @@ static void xive_nvt_ipb_update(XiveNVT *nvt, uint8_=
t priority)
     nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
 }
=20
+void xive_nvt_hv_ipb_update(XiveNVT *nvt, uint8_t priority)
+{
+    nvt->ring_hv[TM_IPB] |=3D priority_to_ipb(priority);
+    nvt->ring_hv[TM_PIPR] =3D ipb_to_pipr(nvt->ring_hv[TM_IPB]);
+}
+
 static uint64_t xive_nvt_accept(XiveNVT *nvt)
 {
     uint8_t nsr =3D nvt->ring_os[TM_NSR];
@@ -337,6 +343,150 @@ const MemoryRegionOps xive_tm_user_ops =3D {
     },
 };
=20
+/*
+ * HV Thread Interrupt Management Area MMIO
+ */
+
+static uint64_t xive_nvt_hv_accept(XiveNVT *nvt)
+{
+    uint8_t nsr =3D nvt->ring_hv[TM_NSR];
+
+    qemu_irq_lower(nvt->output);
+
+    if (nvt->ring_hv[TM_NSR] & TM_QW3_NSR_HE) {
+        uint8_t cppr =3D nvt->ring_hv[TM_PIPR];
+
+        nvt->ring_hv[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        nvt->ring_hv[TM_IPB] &=3D ~priority_to_ipb(cppr);
+        nvt->ring_hv[TM_PIPR] =3D ipb_to_pipr(nvt->ring_hv[TM_IPB]);
+
+        /* Drop Exception bit for HV */
+        nvt->ring_hv[TM_NSR] &=3D ~TM_QW3_NSR_HE;
+    }
+
+    return (nsr << 8) | nvt->ring_hv[TM_CPPR];
+}
+
+void xive_nvt_hv_notify(XiveNVT *nvt)
+{
+    if (nvt->ring_hv[TM_PIPR] < nvt->ring_hv[TM_CPPR]) {
+        nvt->ring_hv[TM_NSR] =3D
+            SETFIELD(TM_QW3_NSR_HE, nvt->ring_hv[TM_NSR], TM_QW3_NSR_HE_=
PHYS);
+        qemu_irq_raise(nvt->output);
+    }
+}
+
+static void xive_nvt_hv_set_cppr(XiveNVT *nvt, uint8_t cppr)
+{
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr =3D 0xff;
+    }
+
+    nvt->ring_hv[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, check if we need to redistribute a pending
+     * exception */
+    xive_nvt_hv_notify(nvt);
+}
+
+static uint64_t xive_tm_hv_read_special(XiveNVT *nvt, hwaddr offset,
+                                           unsigned size)
+{
+    uint64_t ret =3D -1;
+
+    if (offset =3D=3D TM_SPC_ACK_HV_REG && size =3D=3D 2) {
+        return xive_nvt_hv_accept(nvt);
+    }
+
+    if (offset =3D=3D TM_SPC_PULL_POOL_CTX) {
+        ret =3D nvt->regs[TM_QW2_HV_POOL + TM_WORD2] & TM_QW2W2_POOL_CAM=
;
+        nvt->regs[TM_QW2_HV_POOL + TM_WORD2] &=3D ~TM_QW2W2_POOL_CAM;
+        return ret;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
+                 HWADDR_PRIx" size %d\n", offset, size);
+    return ret;
+}
+
+static uint64_t xive_tm_hv_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    PowerPCCPU **cpuptr =3D opaque;
+    PowerPCCPU *cpu =3D *cpuptr ? *cpuptr : POWERPC_CPU(current_cpu);
+    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
+    uint64_t ret =3D -1;
+    int i;
+
+    assert(nvt);
+
+    /* Do not take into account the View */
+    offset &=3D 0xFFF;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        return xive_tm_hv_read_special(nvt, offset, size);
+    }
+
+    ret =3D 0;
+    for (i =3D 0; i < size; i++) {
+        ret |=3D (uint64_t) nvt->regs[offset + i] << (8 * (size - i - 1)=
);
+    }
+
+    return ret;
+}
+
+static void xive_tm_hv_write_special(XiveNVT *nvt, hwaddr offset,
+                                        uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
+                      HWADDR_PRIx" size %d\n", offset, size);
+}
+
+static void xive_tm_hv_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    PowerPCCPU **cpuptr =3D opaque;
+    PowerPCCPU *cpu =3D *cpuptr ? *cpuptr : POWERPC_CPU(current_cpu);
+    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
+    int i;
+
+    /* Do not take into account the View */
+    offset &=3D 0xFFF;
+
+    if (offset >=3D TM_SPC_ACK_EBB) {
+        xive_tm_hv_write_special(nvt, offset, value, size);
+        return;
+    }
+
+    switch (offset) {
+    case TM_QW3_HV_PHYS + TM_CPPR:
+        xive_nvt_hv_set_cppr(nvt, value & 0xff);
+        return;
+    default:
+        break;
+    }
+
+    for (i =3D 0; i < size; i++) {
+        nvt->regs[offset + i] =3D (value >> (8 * (size - i - 1))) & 0xff=
;
+    }
+}
+
+const MemoryRegionOps xive_tm_hv_ops =3D {
+    .read =3D xive_tm_hv_read,
+    .write =3D xive_tm_hv_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 static char *xive_nvt_ring_print(uint8_t *ring)
 {
     uint32_t w2 =3D be32_to_cpu(*((uint32_t *) &ring[TM_WORD2]));
@@ -361,6 +511,12 @@ void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *=
mon)
     monitor_printf(mon, "CPU[%04x]: QW    NSR CPPR IPB LSMFB ACK# INC AG=
E PIPR"
                    " W2\n", cpu_index);
=20
+    s =3D xive_nvt_ring_print(&nvt->regs[TM_QW3_HV_PHYS]);
+    monitor_printf(mon, "CPU[%04x]: HV    %s\n", cpu_index, s);
+    g_free(s);
+    s =3D xive_nvt_ring_print(&nvt->regs[TM_QW2_HV_POOL]);
+    monitor_printf(mon, "CPU[%04x]: POOL  %s\n", cpu_index, s);
+    g_free(s);
     s =3D xive_nvt_ring_print(&nvt->regs[TM_QW1_OS]);
     monitor_printf(mon, "CPU[%04x]: OS    %s\n", cpu_index, s);
     g_free(s);
@@ -381,6 +537,7 @@ static void xive_nvt_reset(void *dev)
      * CPPR is first set.
      */
     nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+    nvt->ring_hv[TM_PIPR] =3D ipb_to_pipr(nvt->ring_hv[TM_IPB]);
=20
     for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
         xive_eq_reset(&nvt->eqt[i]);
@@ -439,6 +596,7 @@ static void xive_nvt_init(Object *obj)
     XiveNVT *nvt =3D XIVE_NVT(obj);
=20
     nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
+    nvt->ring_hv =3D &nvt->regs[TM_QW3_HV_PHYS];
 }
=20
 static const VMStateDescription vmstate_xive_nvt_eq =3D {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d07a8ce38e99..4dd84b83e04c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -300,7 +300,10 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
         pnv_dt_core(chip, pnv_core, fdt);
=20
         /* Interrupt Control Presenters (ICP). One per core. */
-        pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_thre=
ads);
+        if (!pnv_chip_is_power9(chip)) {
+            pnv_dt_icp(chip, fdt, pnv_core->pir,
+                       CPU_CORE(pnv_core)->nr_threads);
+        }
     }
=20
     if (chip->ram_size) {
@@ -923,9 +926,14 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
=20
-    /* Interrupt Management Area. This is the memory region holding
-     * all the Interrupt Control Presenter (ICP) registers */
-    pnv_chip_icp_realize(chip, &error);
+    if (!pnv_chip_is_power9(chip)) {
+        /* Interrupt Management Area. This is the memory region holding
+         * all the Interrupt Control Presenter (ICP) registers */
+        pnv_chip_icp_realize(chip, &error);
+    } else {
+        /* XIVE Interrupt Controller on P9 */
+        pnv_chip_xive_realize(chip, &error);
+    }
     if (error) {
         error_propagate(errp, error);
         return;
@@ -1004,10 +1012,10 @@ Object *pnv_icp_create(PnvMachineState *pnv, Obje=
ct *cpu, Error **errp)
     Error *local_err =3D NULL;
     Object *obj;
=20
-    obj =3D icp_create(cpu, TYPE_PNV_ICP, XICS_FABRIC(pnv), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return NULL;
+    if (!pnv_is_power9(pnv)) {
+        obj =3D icp_create(cpu, TYPE_PNV_ICP, XICS_FABRIC(pnv), &local_e=
rr);
+    } else {
+        obj =3D xive_nvt_create(cpu, TYPE_XIVE_NVT, &local_err);
     }
=20
     return obj;
@@ -1023,11 +1031,19 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        icp_pic_print_info(ICP(cpu->intc), mon);
+        if (!pnv_is_power9(pnv)) {
+            icp_pic_print_info(ICP(cpu->intc), mon);
+        } else {
+            xive_nvt_pic_print_info(XIVE_NVT(cpu->intc), mon);
+        }
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+        if (!pnv_is_power9(pnv)) {
+            ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+        } else {
+            pnv_xive_pic_print_info(pnv->chips[0]->xive, mon);
+        }
     }
 }
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 877c3b79b239..f66fe53c38bb 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -25,6 +25,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
+#include "hw/ppc/pnv_xive.h"
=20
 #define TYPE_PNV_CHIP "pnv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -62,6 +63,8 @@ typedef struct PnvChip {
     PnvLpcController lpc;
     PnvPsi       psi;
     PnvOCC       occ;
+
+    PnvXive      *xive;
 } PnvChip;
=20
 typedef struct PnvChipClass {
@@ -191,6 +194,24 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
     (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
      PNV_PSIHB_FSP_SIZE)
=20
+/*
+ * POWER9 MMIO base addresses
+ */
+#define PNV_XIVE_VC_SIZE             0x0000008000000000ull
+#define PNV_XIVE_VC_BASE(chip)      (0x0006010000000000ull      \
+    + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_XIVE_VC_SIZE)
+
+#define PNV_XIVE_PC_SIZE             0x0000001000000000ull
+#define PNV_XIVE_PC_BASE(chip)      (0x0006018000000000ull      \
+    + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_XIVE_PC_SIZE)
+
+#define PNV_XIVE_IC_SIZE             0x0000000000080000ull
+#define PNV_XIVE_IC_BASE(chip)      (0x0006030203100000ull \
+     + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_XIVE_IC_SIZE)
+
+#define PNV_XIVE_TM_SIZE             0x0000000000040000ull
+#define PNV_XIVE_TM_BASE(chip)       0x0006030203180000ull
+
 Object *pnv_icp_create(PnvMachineState *spapr, Object *cpu, Error **errp=
);
=20
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
new file mode 100644
index 000000000000..723345cc57e2
--- /dev/null
+++ b/include/hw/ppc/pnv_xive.h
@@ -0,0 +1,89 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_XIVE_H
+#define PPC_PNV_XIVE_H
+
+#include "hw/sysbus.h"
+#include "hw/ppc/xive.h"
+
+typedef struct XiveIVE XiveIVE;
+
+#define TYPE_PNV_XIVE "pnv-xive"
+#define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
+
+typedef struct PnvXive {
+    SysBusDevice parent_obj;
+
+    /* Interrupt controller regs */
+    uint64_t     regs[0x300];
+    MemoryRegion xscom_regs;
+
+    /* For IPIs and accelerator interrupts */
+    XiveSource   source;
+    XiveSource   eq_source;
+
+    /* Interrupt Virtualization Entry table */
+    XiveIVE      *ivt;
+    uint32_t     nr_irqs;
+
+    /* Event Queue Descriptor table */
+    uint64_t     *eqdt;
+    uint32_t     eqdt_count;
+    uint64_t     eqc_watch[4]; /* EQ cache update */
+
+    /* Virtual Processor Descriptor table */
+    uint64_t     *vpdt;
+    uint32_t     vpdt_count;
+    uint64_t     vpc_watch[8];  /* VP cache update */
+
+    /* Virtual Structure Tables : IVT, SBE, EQDT, VPDT, IRQ */
+    uint8_t      vst_tsel;
+    uint8_t      vst_tidx;
+    uint64_t     vsds[5];
+
+    /* Set Translation tables */
+    bool         set_xlate_autoinc;
+    uint64_t     set_xlate_index;
+    uint64_t     set_xlate;
+    uint64_t     set_xlate_edt[64]; /* IPIs & EQs */
+    uint64_t     set_xlate_vdt[16];
+
+    /* Interrupt controller MMIO */
+    MemoryRegion ic_mmio;
+    hwaddr       ic_base;
+
+    /* VC memory regions */
+    hwaddr       vc_base;
+    MemoryRegion vc_mmio;
+    hwaddr       esb_base;
+    MemoryRegion esb_mmio;
+    hwaddr       eq_base;
+    MemoryRegion eq_mmio;
+
+    /* PC memory regions */
+    hwaddr       pc_base;
+    MemoryRegion pc_mmio;
+
+    /* TIMA memory regions */
+    hwaddr       tm_base;
+    MemoryRegion tm_mmio;
+    MemoryRegion tm_mmio_indirect;
+
+    /* CPU for indirect TIMA access */
+    PowerPCCPU   *cpu_ind;
+} PnvXive;
+
+void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
+
+typedef struct PnvChip PnvChip;
+
+void pnv_chip_xive_realize(PnvChip *chip, Error **errp);
+
+#endif /* PPC_PNV_XIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 255b26a5aaf6..f4b1649ffffa 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV_XSCOM_XIVE_BASE       0x5013000
+#define PNV_XSCOM_XIVE_SIZE       0x300
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e99cd874ef3c..6c71a02cc39a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -202,6 +202,7 @@ typedef struct XiveNVT {
=20
     /* Shortcuts to rings */
     uint8_t   *ring_os;
+    uint8_t   *ring_hv;
=20
     XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
 } XiveNVT;
@@ -224,13 +225,17 @@ typedef struct XiveNVTClass {
=20
 extern const MemoryRegionOps xive_tm_user_ops;
 extern const MemoryRegionOps xive_tm_os_ops;
+extern const MemoryRegionOps xive_tm_hv_ops;
=20
 void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon);
 XiveEQ *xive_nvt_eq_get(XiveNVT *nvt, uint8_t priority);
 Object *xive_nvt_create(Object *cpu, const char *type, Error **errp);
+void xive_nvt_hv_notify(XiveNVT *nvt);
+void xive_nvt_hv_ipb_update(XiveNVT *nvt, uint8_t priority);
=20
 void xive_eq_reset(XiveEQ *eq);
 void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon);
+void xive_eq_push(XiveEQ *eq, uint32_t data);
=20
 /*
  * XIVE Fabric
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index bcc44e766db9..cd2ffd9f6152 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -160,6 +160,28 @@ typedef struct XiveEQ {
 #define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
 } XiveEQ;
=20
+/* VP */
+typedef struct XiveVP {
+        uint32_t        w0;
+#define VP_W0_VALID             PPC_BIT32(0)
+        uint32_t        w1;
+        uint32_t        w2;
+        uint32_t        w3;
+        uint32_t        w4;
+        uint32_t        w5;
+        uint32_t        w6;
+        uint32_t        w7;
+        uint32_t        w8;
+#define VP_W8_GRP_VALID         PPC_BIT32(0)
+        uint32_t        w9;
+        uint32_t        wa;
+        uint32_t        wb;
+        uint32_t        wc;
+        uint32_t        wd;
+        uint32_t        we;
+        uint32_t        wf;
+} XiveVP;
+
 #define XIVE_PRIORITY_MAX  7
=20
 #endif /* _INTC_XIVE_INTERNAL_H */
--=20
2.13.6
