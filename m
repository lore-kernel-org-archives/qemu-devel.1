Received: from eggs.gnu.org ([209.51.188.92]:43179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toa-0001S2-1d
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001Yy-82
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:29 +1100
Message-Id: <20190310082703.1245-27-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/60] ppc/pnv: add a XIVE interrupt controller
 model for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This is a simple model of the POWER9 XIVE interrupt controller for the
PowerNV machine which only addresses the needs of the skiboot
firmware. The PowerNV model reuses the common XIVE framework developed
for sPAPR as the fundamentals aspects are quite the same. The
difference are outlined below.

The controller initial BAR configuration is performed using the XSCOM
bus from there, MMIO are used for further configuration.

The MMIO regions exposed are :

 - Interrupt controller registers
 - ESB pages for IPIs and ENDs
 - Presenter MMIO (Not used)
 - Thread Interrupt Management Area MMIO, direct and indirect

The virtualization controller MMIO region containing the IPI ESB pages
and END ESB pages is sub-divided into "sets" which map portions of the
VC region to the different ESB pages. These are modeled with custom
address spaces and the XiveSource and XiveENDSource objects are sized
to the maximum allowed by HW. The memory regions are resized at
run-time using the configuration of EDT set translation table provided
by the firmware.

The XIVE virtualization structure tables (EAT, ENDT, NVTT) are now in
the machine RAM and not in the hypervisor anymore. The firmware
(skiboot) configures these tables using Virtual Structure Descriptor
defining the characteristics of each table : SBE, EAS, END and
NVT. These are later used to access the virtual interrupt entries. The
internal cache of these tables in the interrupt controller is updated
and invalidated using a set of registers.

Still to address to complete the model but not fully required is the
support for block grouping. Escalation support will be necessary for
KVM guests.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/Makefile.objs      |    2 +-
 hw/intc/pnv_xive.c         | 1753 ++++++++++++++++++++++++++++++++++++
 hw/intc/pnv_xive_regs.h    |  248 +++++
 hw/ppc/pnv.c               |   44 +-
 include/hw/ppc/pnv.h       |   21 +
 include/hw/ppc/pnv_xive.h  |   93 ++
 include/hw/ppc/pnv_xscom.h |    3 +
 7 files changed, 2162 insertions(+), 2 deletions(-)
 create mode 100644 hw/intc/pnv_xive.c
 create mode 100644 hw/intc/pnv_xive_regs.h
 create mode 100644 include/hw/ppc/pnv_xive.h

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 301a8e972d..df712c3e6c 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -39,7 +39,7 @@ obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
 obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
 obj-$(CONFIG_XIVE) +=3D xive.o
 obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
-obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
+obj-$(CONFIG_POWERNV) +=3D xics_pnv.o pnv_xive.o
 obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
 obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
 obj-$(CONFIG_S390_FLIC_KVM) +=3D s390_flic_kvm.o
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
new file mode 100644
index 0000000000..bb0877cbdf
--- /dev/null
+++ b/hw/intc/pnv_xive.c
@@ -0,0 +1,1753 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2019, IBM Corporation.
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
+#include "hw/ppc/pnv_core.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_xive.h"
+#include "hw/ppc/xive_regs.h"
+#include "hw/ppc/ppc.h"
+
+#include <libfdt.h>
+
+#include "pnv_xive_regs.h"
+
+#define XIVE_DEBUG
+
+/*
+ * Virtual structures table (VST)
+ */
+#define SBE_PER_BYTE   4
+
+typedef struct XiveVstInfo {
+    const char *name;
+    uint32_t    size;
+    uint32_t    max_blocks;
+} XiveVstInfo;
+
+static const XiveVstInfo vst_infos[] =3D {
+    [VST_TSEL_IVT]  =3D { "EAT",  sizeof(XiveEAS), 16 },
+    [VST_TSEL_SBE]  =3D { "SBE",  1,               16 },
+    [VST_TSEL_EQDT] =3D { "ENDT", sizeof(XiveEND), 16 },
+    [VST_TSEL_VPDT] =3D { "VPDT", sizeof(XiveNVT), 32 },
+
+    /*
+     *  Interrupt fifo backing store table (not modeled) :
+     *
+     * 0 - IPI,
+     * 1 - HWD,
+     * 2 - First escalate,
+     * 3 - Second escalate,
+     * 4 - Redistribution,
+     * 5 - IPI cascaded queue ?
+     */
+    [VST_TSEL_IRQ]  =3D { "IRQ",  1,               6  },
+};
+
+#define xive_error(xive, fmt, ...)                                      =
\
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE[%x] - " fmt "\n",              =
\
+                  (xive)->chip->chip_id, ## __VA_ARGS__);
+
+/*
+ * QEMU version of the GETFIELD/SETFIELD macros
+ *
+ * TODO: It might be better to use the existing extract64() and
+ * deposit64() but this means that all the register definitions will
+ * change and become incompatible with the ones found in skiboot.
+ *
+ * Keep it as it is for now until we find a common ground.
+ */
+static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
+{
+    return (word & mask) >> ctz64(mask);
+}
+
+static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
+                                uint64_t value)
+{
+    return (word & ~mask) | ((value << ctz64(mask)) & mask);
+}
+
+/*
+ * Remote access to controllers. HW uses MMIOs. For now, a simple scan
+ * of the chips is good enough.
+ *
+ * TODO: Block scope support
+ */
+static PnvXive *pnv_xive_get_ic(uint8_t blk)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
+        PnvXive *xive =3D &chip9->xive;
+
+        if (xive->chip->chip_id =3D=3D blk) {
+            return xive;
+        }
+    }
+    return NULL;
+}
+
+/*
+ * VST accessors for SBE, EAT, ENDT, NVT
+ *
+ * Indirect VST tables are arrays of VSDs pointing to a page (of same
+ * size). Each page is a direct VST table.
+ */
+
+#define XIVE_VSD_SIZE 8
+
+/* Indirect page size can be 4K, 64K, 2M, 16M. */
+static uint64_t pnv_xive_vst_page_size_allowed(uint32_t page_shift)
+{
+     return page_shift =3D=3D 12 || page_shift =3D=3D 16 ||
+         page_shift =3D=3D 21 || page_shift =3D=3D 24;
+}
+
+static uint64_t pnv_xive_vst_size(uint64_t vsd)
+{
+    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
+
+    /*
+     * Read the first descriptor to get the page size of the indirect
+     * table.
+     */
+    if (VSD_INDIRECT & vsd) {
+        uint32_t nr_pages =3D vst_tsize / XIVE_VSD_SIZE;
+        uint32_t page_shift;
+
+        vsd =3D ldq_be_dma(&address_space_memory, vsd & VSD_ADDRESS_MASK=
);
+        page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+
+        if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+            return 0;
+        }
+
+        return nr_pages * (1ull << page_shift);
+    }
+
+    return vst_tsize;
+}
+
+static uint64_t pnv_xive_vst_addr_direct(PnvXive *xive, uint32_t type,
+                                         uint64_t vsd, uint32_t idx)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
+
+    return vst_addr + idx * info->size;
+}
+
+static uint64_t pnv_xive_vst_addr_indirect(PnvXive *xive, uint32_t type,
+                                           uint64_t vsd, uint32_t idx)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t vsd_addr;
+    uint32_t vsd_idx;
+    uint32_t page_shift;
+    uint32_t vst_per_page;
+
+    /* Get the page size of the indirect table. */
+    vsd_addr =3D vsd & VSD_ADDRESS_MASK;
+    vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
+
+    if (!(vsd & VSD_ADDRESS_MASK)) {
+        xive_error(xive, "VST: invalid %s entry %x !?", info->name, 0);
+        return 0;
+    }
+
+    page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+
+    if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+        xive_error(xive, "VST: invalid %s page shift %d", info->name,
+                   page_shift);
+        return 0;
+    }
+
+    vst_per_page =3D (1ull << page_shift) / info->size;
+    vsd_idx =3D idx / vst_per_page;
+
+    /* Load the VSD we are looking for, if not already done */
+    if (vsd_idx) {
+        vsd_addr =3D vsd_addr + vsd_idx * XIVE_VSD_SIZE;
+        vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
+
+        if (!(vsd & VSD_ADDRESS_MASK)) {
+            xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
0);
+            return 0;
+        }
+
+        /*
+         * Check that the pages have a consistent size across the
+         * indirect table
+         */
+        if (page_shift !=3D GETFIELD(VSD_TSIZE, vsd) + 12) {
+            xive_error(xive, "VST: %s entry %x indirect page size differ=
 !?",
+                       info->name, idx);
+            return 0;
+        }
+    }
+
+    return pnv_xive_vst_addr_direct(xive, type, vsd, (idx % vst_per_page=
));
+}
+
+static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t =
blk,
+                                  uint32_t idx)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t vsd;
+    uint32_t idx_max;
+
+    if (blk >=3D info->max_blocks) {
+        xive_error(xive, "VST: invalid block id %d for VST %s %d !?",
+                   blk, info->name, idx);
+        return 0;
+    }
+
+    vsd =3D xive->vsds[type][blk];
+
+    /* Remote VST access */
+    if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
+        xive =3D pnv_xive_get_ic(blk);
+
+        return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
+    }
+
+    idx_max =3D pnv_xive_vst_size(vsd) / info->size - 1;
+    if (idx > idx_max) {
+#ifdef XIVE_DEBUG
+        xive_error(xive, "VST: %s entry %x/%x out of range [ 0 .. %x ] !=
?",
+                   info->name, blk, idx, idx_max);
+#endif
+        return 0;
+    }
+
+    if (VSD_INDIRECT & vsd) {
+        return pnv_xive_vst_addr_indirect(xive, type, vsd, idx);
+    }
+
+    return pnv_xive_vst_addr_direct(xive, type, vsd, idx);
+}
+
+static int pnv_xive_vst_read(PnvXive *xive, uint32_t type, uint8_t blk,
+                             uint32_t idx, void *data)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t addr =3D pnv_xive_vst_addr(xive, type, blk, idx);
+
+    if (!addr) {
+        return -1;
+    }
+
+    cpu_physical_memory_read(addr, data, info->size);
+    return 0;
+}
+
+#define XIVE_VST_WORD_ALL -1
+
+static int pnv_xive_vst_write(PnvXive *xive, uint32_t type, uint8_t blk,
+                              uint32_t idx, void *data, uint32_t word_nu=
mber)
+{
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint64_t addr =3D pnv_xive_vst_addr(xive, type, blk, idx);
+
+    if (!addr) {
+        return -1;
+    }
+
+    if (word_number =3D=3D XIVE_VST_WORD_ALL) {
+        cpu_physical_memory_write(addr, data, info->size);
+    } else {
+        cpu_physical_memory_write(addr + word_number * 4,
+                                  data + word_number * 4, 4);
+    }
+    return 0;
+}
+
+static int pnv_xive_get_end(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                            XiveEND *end)
+{
+    return pnv_xive_vst_read(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, en=
d);
+}
+
+static int pnv_xive_write_end(XiveRouter *xrtr, uint8_t blk, uint32_t id=
x,
+                              XiveEND *end, uint8_t word_number)
+{
+    return pnv_xive_vst_write(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, e=
nd,
+                              word_number);
+}
+
+static int pnv_xive_end_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+{
+    int i;
+    uint64_t eqc_watch[4];
+
+    for (i =3D 0; i < ARRAY_SIZE(eqc_watch); i++) {
+        eqc_watch[i] =3D cpu_to_be64(xive->regs[(VC_EQC_CWATCH_DAT0 >> 3=
) + i]);
+    }
+
+    return pnv_xive_vst_write(xive, VST_TSEL_EQDT, blk, idx, eqc_watch,
+                              XIVE_VST_WORD_ALL);
+}
+
+static int pnv_xive_get_nvt(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                            XiveNVT *nvt)
+{
+    return pnv_xive_vst_read(PNV_XIVE(xrtr), VST_TSEL_VPDT, blk, idx, nv=
t);
+}
+
+static int pnv_xive_write_nvt(XiveRouter *xrtr, uint8_t blk, uint32_t id=
x,
+                              XiveNVT *nvt, uint8_t word_number)
+{
+    return pnv_xive_vst_write(PNV_XIVE(xrtr), VST_TSEL_VPDT, blk, idx, n=
vt,
+                              word_number);
+}
+
+static int pnv_xive_nvt_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+{
+    int i;
+    uint64_t vpc_watch[8];
+
+    for (i =3D 0; i < ARRAY_SIZE(vpc_watch); i++) {
+        vpc_watch[i] =3D cpu_to_be64(xive->regs[(PC_VPC_CWATCH_DAT0 >> 3=
) + i]);
+    }
+
+    return pnv_xive_vst_write(xive, VST_TSEL_VPDT, blk, idx, vpc_watch,
+                              XIVE_VST_WORD_ALL);
+}
+
+static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
+                            XiveEAS *eas)
+{
+    PnvXive *xive =3D PNV_XIVE(xrtr);
+
+    if (pnv_xive_get_ic(blk) !=3D xive) {
+        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
+        return -1;
+    }
+
+    return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
+}
+
+static int pnv_xive_eas_update(PnvXive *xive, uint8_t blk, uint32_t idx)
+{
+    /* All done. */
+    return 0;
+}
+
+static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+    PnvXive *xive =3D NULL;
+    CPUPPCState *env =3D &cpu->env;
+    int pir =3D env->spr_cb[SPR_PIR].default_value;
+
+    /*
+     * Perform an extra check on the HW thread enablement.
+     *
+     * The TIMA is shared among the chips and to identify the chip
+     * from which the access is being done, we extract the chip id
+     * from the PIR.
+     */
+    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
+    if (!xive) {
+        return NULL;
+    }
+
+    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
+        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
+    }
+
+    return tctx;
+}
+
+/*
+ * The internal sources (IPIs) of the interrupt controller have no
+ * knowledge of the XIVE chip on which they reside. Encode the block
+ * id in the source interrupt number before forwarding the source
+ * event notification to the Router. This is required on a multichip
+ * system.
+ */
+static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno)
+{
+    PnvXive *xive =3D PNV_XIVE(xn);
+    uint8_t blk =3D xive->chip->chip_id;
+
+    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
+}
+
+/*
+ * XIVE helpers
+ */
+
+static uint64_t pnv_xive_vc_size(PnvXive *xive)
+{
+    return (~xive->regs[CQ_VC_BARM >> 3] + 1) & CQ_VC_BARM_MASK;
+}
+
+static uint64_t pnv_xive_edt_shift(PnvXive *xive)
+{
+    return ctz64(pnv_xive_vc_size(xive) / XIVE_TABLE_EDT_MAX);
+}
+
+static uint64_t pnv_xive_pc_size(PnvXive *xive)
+{
+    return (~xive->regs[CQ_PC_BARM >> 3] + 1) & CQ_PC_BARM_MASK;
+}
+
+static uint32_t pnv_xive_nr_ipis(PnvXive *xive)
+{
+    uint8_t blk =3D xive->chip->chip_id;
+
+    return pnv_xive_vst_size(xive->vsds[VST_TSEL_SBE][blk]) * SBE_PER_BY=
TE;
+}
+
+static uint32_t pnv_xive_nr_ends(PnvXive *xive)
+{
+    uint8_t blk =3D xive->chip->chip_id;
+
+    return pnv_xive_vst_size(xive->vsds[VST_TSEL_EQDT][blk])
+        / vst_infos[VST_TSEL_EQDT].size;
+}
+
+/*
+ * EDT Table
+ *
+ * The Virtualization Controller MMIO region containing the IPI ESB
+ * pages and END ESB pages is sub-divided into "sets" which map
+ * portions of the VC region to the different ESB pages. It is
+ * configured at runtime through the EDT "Domain Table" to let the
+ * firmware decide how to split the VC address space between IPI ESB
+ * pages and END ESB pages.
+ */
+
+/*
+ * Computes the overall size of the IPI or the END ESB pages
+ */
+static uint64_t pnv_xive_edt_size(PnvXive *xive, uint64_t type)
+{
+    uint64_t edt_size =3D 1ull << pnv_xive_edt_shift(xive);
+    uint64_t size =3D 0;
+    int i;
+
+    for (i =3D 0; i < XIVE_TABLE_EDT_MAX; i++) {
+        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[i]);
+
+        if (edt_type =3D=3D type) {
+            size +=3D edt_size;
+        }
+    }
+
+    return size;
+}
+
+/*
+ * Maps an offset of the VC region in the IPI or END region using the
+ * layout defined by the EDT "Domaine Table"
+ */
+static uint64_t pnv_xive_edt_offset(PnvXive *xive, uint64_t vc_offset,
+                                              uint64_t type)
+{
+    int i;
+    uint64_t edt_size =3D 1ull << pnv_xive_edt_shift(xive);
+    uint64_t edt_offset =3D vc_offset;
+
+    for (i =3D 0; i < XIVE_TABLE_EDT_MAX && (i * edt_size) < vc_offset; =
i++) {
+        uint64_t edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[i]);
+
+        if (edt_type !=3D type) {
+            edt_offset -=3D edt_size;
+        }
+    }
+
+    return edt_offset;
+}
+
+static void pnv_xive_edt_resize(PnvXive *xive)
+{
+    uint64_t ipi_edt_size =3D pnv_xive_edt_size(xive, CQ_TDR_EDT_IPI);
+    uint64_t end_edt_size =3D pnv_xive_edt_size(xive, CQ_TDR_EDT_EQ);
+
+    memory_region_set_size(&xive->ipi_edt_mmio, ipi_edt_size);
+    memory_region_add_subregion(&xive->ipi_mmio, 0, &xive->ipi_edt_mmio)=
;
+
+    memory_region_set_size(&xive->end_edt_mmio, end_edt_size);
+    memory_region_add_subregion(&xive->end_mmio, 0, &xive->end_edt_mmio)=
;
+}
+
+/*
+ * XIVE Table configuration. Only EDT is supported.
+ */
+static int pnv_xive_table_set_data(PnvXive *xive, uint64_t val)
+{
+    uint64_t tsel =3D xive->regs[CQ_TAR >> 3] & CQ_TAR_TSEL;
+    uint8_t tsel_index =3D GETFIELD(CQ_TAR_TSEL_INDEX, xive->regs[CQ_TAR=
 >> 3]);
+    uint64_t *xive_table;
+    uint8_t max_index;
+
+    switch (tsel) {
+    case CQ_TAR_TSEL_BLK:
+        max_index =3D ARRAY_SIZE(xive->blk);
+        xive_table =3D xive->blk;
+        break;
+    case CQ_TAR_TSEL_MIG:
+        max_index =3D ARRAY_SIZE(xive->mig);
+        xive_table =3D xive->mig;
+        break;
+    case CQ_TAR_TSEL_EDT:
+        max_index =3D ARRAY_SIZE(xive->edt);
+        xive_table =3D xive->edt;
+        break;
+    case CQ_TAR_TSEL_VDT:
+        max_index =3D ARRAY_SIZE(xive->vdt);
+        xive_table =3D xive->vdt;
+        break;
+    default:
+        xive_error(xive, "IC: invalid table %d", (int) tsel);
+        return -1;
+    }
+
+    if (tsel_index >=3D max_index) {
+        xive_error(xive, "IC: invalid index %d", (int) tsel_index);
+        return -1;
+    }
+
+    xive_table[tsel_index] =3D val;
+
+    if (xive->regs[CQ_TAR >> 3] & CQ_TAR_TBL_AUTOINC) {
+        xive->regs[CQ_TAR >> 3] =3D
+            SETFIELD(CQ_TAR_TSEL_INDEX, xive->regs[CQ_TAR >> 3], ++tsel_=
index);
+    }
+
+    /*
+     * EDT configuration is complete. Resize the MMIO windows exposing
+     * the IPI and the END ESBs in the VC region.
+     */
+    if (tsel =3D=3D CQ_TAR_TSEL_EDT && tsel_index =3D=3D ARRAY_SIZE(xive=
->edt)) {
+        pnv_xive_edt_resize(xive);
+    }
+
+    return 0;
+}
+
+/*
+ * Virtual Structure Tables (VST) configuration
+ */
+static void pnv_xive_vst_set_exclusive(PnvXive *xive, uint8_t type,
+                                       uint8_t blk, uint64_t vsd)
+{
+    XiveENDSource *end_xsrc =3D &xive->end_source;
+    XiveSource *xsrc =3D &xive->ipi_source;
+    const XiveVstInfo *info =3D &vst_infos[type];
+    uint32_t page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
+    uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
+
+    /* Basic checks */
+
+    if (VSD_INDIRECT & vsd) {
+        if (!(xive->regs[VC_GLOBAL_CONFIG >> 3] & VC_GCONF_INDIRECT)) {
+            xive_error(xive, "VST: %s indirect tables are not enabled",
+                       info->name);
+            return;
+        }
+
+        if (!pnv_xive_vst_page_size_allowed(page_shift)) {
+            xive_error(xive, "VST: invalid %s page shift %d", info->name=
,
+                       page_shift);
+            return;
+        }
+    }
+
+    if (!QEMU_IS_ALIGNED(vst_addr, 1ull << page_shift)) {
+        xive_error(xive, "VST: %s table address 0x%"PRIx64" is not align=
ed with"
+                   " page shift %d", info->name, vst_addr, page_shift);
+        return;
+    }
+
+    /* Record the table configuration (in SRAM on HW) */
+    xive->vsds[type][blk] =3D vsd;
+
+    /* Now tune the models with the configuration provided by the FW */
+
+    switch (type) {
+    case VST_TSEL_IVT:  /* Nothing to be done */
+        break;
+
+    case VST_TSEL_EQDT:
+        /*
+         * Backing store pages for the END. Compute the number of ENDs
+         * provisioned by FW and resize the END ESB window accordingly.
+         */
+        memory_region_set_size(&end_xsrc->esb_mmio, pnv_xive_nr_ends(xiv=
e) *
+                               (1ull << (end_xsrc->esb_shift + 1)));
+        memory_region_add_subregion(&xive->end_edt_mmio, 0,
+                                    &end_xsrc->esb_mmio);
+        break;
+
+    case VST_TSEL_SBE:
+        /*
+         * Backing store pages for the source PQ bits. The model does
+         * not use these PQ bits backed in RAM because the XiveSource
+         * model has its own. Compute the number of IRQs provisioned
+         * by FW and resize the IPI ESB window accordingly.
+         */
+        memory_region_set_size(&xsrc->esb_mmio, pnv_xive_nr_ipis(xive) *
+                               (1ull << xsrc->esb_shift));
+        memory_region_add_subregion(&xive->ipi_edt_mmio, 0, &xsrc->esb_m=
mio);
+        break;
+
+    case VST_TSEL_VPDT: /* Not modeled */
+    case VST_TSEL_IRQ:  /* Not modeled */
+        /*
+         * These tables contains the backing store pages for the
+         * interrupt fifos of the VC sub-engine in case of overflow.
+         */
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*
+ * Both PC and VC sub-engines are configured as each use the Virtual
+ * Structure Tables : SBE, EAS, END and NVT.
+ */
+static void pnv_xive_vst_set_data(PnvXive *xive, uint64_t vsd, bool pc_e=
ngine)
+{
+    uint8_t mode =3D GETFIELD(VSD_MODE, vsd);
+    uint8_t type =3D GETFIELD(VST_TABLE_SELECT,
+                            xive->regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk =3D GETFIELD(VST_TABLE_BLOCK,
+                           xive->regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
+
+    if (type > VST_TSEL_IRQ) {
+        xive_error(xive, "VST: invalid table type %d", type);
+        return;
+    }
+
+    if (blk >=3D vst_infos[type].max_blocks) {
+        xive_error(xive, "VST: invalid block id %d for"
+                      " %s table", blk, vst_infos[type].name);
+        return;
+    }
+
+    /*
+     * Only take the VC sub-engine configuration into account because
+     * the XiveRouter model combines both VC and PC sub-engines
+     */
+    if (pc_engine) {
+        return;
+    }
+
+    if (!vst_addr) {
+        xive_error(xive, "VST: invalid %s table address", vst_infos[type=
].name);
+        return;
+    }
+
+    switch (mode) {
+    case VSD_MODE_FORWARD:
+        xive->vsds[type][blk] =3D vsd;
+        break;
+
+    case VSD_MODE_EXCLUSIVE:
+        pnv_xive_vst_set_exclusive(xive, type, blk, vsd);
+        break;
+
+    default:
+        xive_error(xive, "VST: unsupported table mode %d", mode);
+        return;
+    }
+}
+
+/*
+ * Interrupt controller MMIO region. The layout is compatible between
+ * 4K and 64K pages :
+ *
+ * Page 0           sub-engine BARs
+ *  0x000 - 0x3FF   IC registers
+ *  0x400 - 0x7FF   PC registers
+ *  0x800 - 0xFFF   VC registers
+ *
+ * Page 1           Notify page (writes only)
+ *  0x000 - 0x7FF   HW interrupt triggers (PSI, PHB)
+ *  0x800 - 0xFFF   forwards and syncs
+ *
+ * Page 2           LSI Trigger page (writes only) (not modeled)
+ * Page 3           LSI SB EOI page (reads only) (not modeled)
+ *
+ * Page 4-7         indirect TIMA
+ */
+
+/*
+ * IC - registers MMIO
+ */
+static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
+                                  uint64_t val, unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+    MemoryRegion *sysmem =3D get_system_memory();
+    uint32_t reg =3D offset >> 3;
+    bool is_chip0 =3D xive->chip->chip_id =3D=3D 0;
+
+    switch (offset) {
+
+    /*
+     * XIVE CQ (PowerBus bridge) settings
+     */
+    case CQ_MSGSND:     /* msgsnd for doorbells */
+    case CQ_FIRMASK_OR: /* FIR error reporting */
+        break;
+    case CQ_PBI_CTL:
+        if (val & CQ_PBI_PC_64K) {
+            xive->pc_shift =3D 16;
+        }
+        if (val & CQ_PBI_VC_64K) {
+            xive->vc_shift =3D 16;
+        }
+        break;
+    case CQ_CFG_PB_GEN: /* PowerBus General Configuration */
+        /*
+         * TODO: CQ_INT_ADDR_OPT for 1-block-per-chip mode
+         */
+        break;
+
+    /*
+     * XIVE Virtualization Controller settings
+     */
+    case VC_GLOBAL_CONFIG:
+        break;
+
+    /*
+     * XIVE Presenter Controller settings
+     */
+    case PC_GLOBAL_CONFIG:
+        /*
+         * PC_GCONF_CHIPID_OVR
+         *   Overrides Int command Chip ID with the Chip ID field (DEBUG=
)
+         */
+        break;
+    case PC_TCTXT_CFG:
+        /*
+         * TODO: block group support
+         *
+         * PC_TCTXT_CFG_BLKGRP_EN
+         * PC_TCTXT_CFG_HARD_CHIPID_BLK :
+         *   Moves the chipid into block field for hardwired CAM compare=
s.
+         *   Block offset value is adjusted to 0b0..01 & ThrdId
+         *
+         *   Will require changes in xive_presenter_tctx_match(). I am
+         *   not sure how to handle that yet.
+         */
+
+        /* Overrides hardwired chip ID with the chip ID field */
+        if (val & PC_TCTXT_CHIPID_OVERRIDE) {
+            xive->tctx_chipid =3D GETFIELD(PC_TCTXT_CHIPID, val);
+        }
+        break;
+    case PC_TCTXT_TRACK:
+        /*
+         * PC_TCTXT_TRACK_EN:
+         *   enable block tracking and exchange of block ownership
+         *   information between Interrupt controllers
+         */
+        break;
+
+    /*
+     * Misc settings
+     */
+    case VC_SBC_CONFIG: /* Store EOI configuration */
+        /*
+         * Configure store EOI if required by firwmare (skiboot has remo=
ved
+         * support recently though)
+         */
+        if (val & (VC_SBC_CONF_CPLX_CIST | VC_SBC_CONF_CIST_BOTH)) {
+            object_property_set_int(OBJECT(&xive->ipi_source),
+                                    XIVE_SRC_STORE_EOI, "flags", &error_=
fatal);
+        }
+        break;
+
+    case VC_EQC_CONFIG: /* TODO: silent escalation */
+    case VC_AIB_TX_ORDER_TAG2: /* relax ordering */
+        break;
+
+    /*
+     * XIVE BAR settings (XSCOM only)
+     */
+    case CQ_RST_CTL:
+        /* bit4: resets all BAR registers */
+        break;
+
+    case CQ_IC_BAR: /* IC BAR. 8 pages */
+        xive->ic_shift =3D val & CQ_IC_BAR_64K ? 16 : 12;
+        if (!(val & CQ_IC_BAR_VALID)) {
+            xive->ic_base =3D 0;
+            if (xive->regs[reg] & CQ_IC_BAR_VALID) {
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->ic_reg_mmio);
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->ic_notify_mmio);
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->ic_lsi_mmio);
+                memory_region_del_subregion(&xive->ic_mmio,
+                                            &xive->tm_indirect_mmio);
+
+                memory_region_del_subregion(sysmem, &xive->ic_mmio);
+            }
+        } else {
+            xive->ic_base =3D val & ~(CQ_IC_BAR_VALID | CQ_IC_BAR_64K);
+            if (!(xive->regs[reg] & CQ_IC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->ic_base,
+                                            &xive->ic_mmio);
+
+                memory_region_add_subregion(&xive->ic_mmio,  0,
+                                            &xive->ic_reg_mmio);
+                memory_region_add_subregion(&xive->ic_mmio,
+                                            1ul << xive->ic_shift,
+                                            &xive->ic_notify_mmio);
+                memory_region_add_subregion(&xive->ic_mmio,
+                                            2ul << xive->ic_shift,
+                                            &xive->ic_lsi_mmio);
+                memory_region_add_subregion(&xive->ic_mmio,
+                                            4ull << xive->ic_shift,
+                                            &xive->tm_indirect_mmio);
+            }
+        }
+        break;
+
+    case CQ_TM1_BAR: /* TM BAR. 4 pages. Map only once */
+    case CQ_TM2_BAR: /* second TM BAR. for hotplug. Not modeled */
+        xive->tm_shift =3D val & CQ_TM_BAR_64K ? 16 : 12;
+        if (!(val & CQ_TM_BAR_VALID)) {
+            xive->tm_base =3D 0;
+            if (xive->regs[reg] & CQ_TM_BAR_VALID && is_chip0) {
+                memory_region_del_subregion(sysmem, &xive->tm_mmio);
+            }
+        } else {
+            xive->tm_base =3D val & ~(CQ_TM_BAR_VALID | CQ_TM_BAR_64K);
+            if (!(xive->regs[reg] & CQ_TM_BAR_VALID) && is_chip0) {
+                memory_region_add_subregion(sysmem, xive->tm_base,
+                                            &xive->tm_mmio);
+            }
+        }
+        break;
+
+    case CQ_PC_BARM:
+        xive->regs[reg] =3D val;
+        memory_region_set_size(&xive->pc_mmio, pnv_xive_pc_size(xive));
+        break;
+    case CQ_PC_BAR: /* From 32M to 512G */
+        if (!(val & CQ_PC_BAR_VALID)) {
+            xive->pc_base =3D 0;
+            if (xive->regs[reg] & CQ_PC_BAR_VALID) {
+                memory_region_del_subregion(sysmem, &xive->pc_mmio);
+            }
+        } else {
+            xive->pc_base =3D val & ~(CQ_PC_BAR_VALID);
+            if (!(xive->regs[reg] & CQ_PC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->pc_base,
+                                            &xive->pc_mmio);
+            }
+        }
+        break;
+
+    case CQ_VC_BARM:
+        xive->regs[reg] =3D val;
+        memory_region_set_size(&xive->vc_mmio, pnv_xive_vc_size(xive));
+        break;
+    case CQ_VC_BAR: /* From 64M to 4TB */
+        if (!(val & CQ_VC_BAR_VALID)) {
+            xive->vc_base =3D 0;
+            if (xive->regs[reg] & CQ_VC_BAR_VALID) {
+                memory_region_del_subregion(sysmem, &xive->vc_mmio);
+            }
+        } else {
+            xive->vc_base =3D val & ~(CQ_VC_BAR_VALID);
+            if (!(xive->regs[reg] & CQ_VC_BAR_VALID)) {
+                memory_region_add_subregion(sysmem, xive->vc_base,
+                                            &xive->vc_mmio);
+            }
+        }
+        break;
+
+    /*
+     * XIVE Table settings.
+     */
+    case CQ_TAR: /* Table Address */
+        break;
+    case CQ_TDR: /* Table Data */
+        pnv_xive_table_set_data(xive, val);
+        break;
+
+    /*
+     * XIVE VC & PC Virtual Structure Table settings
+     */
+    case VC_VSD_TABLE_ADDR:
+    case PC_VSD_TABLE_ADDR: /* Virtual table selector */
+        break;
+    case VC_VSD_TABLE_DATA: /* Virtual table setting */
+    case PC_VSD_TABLE_DATA:
+        pnv_xive_vst_set_data(xive, val, offset =3D=3D PC_VSD_TABLE_DATA=
);
+        break;
+
+    /*
+     * Interrupt fifo overflow in memory backing store (Not modeled)
+     */
+    case VC_IRQ_CONFIG_IPI:
+    case VC_IRQ_CONFIG_HW:
+    case VC_IRQ_CONFIG_CASCADE1:
+    case VC_IRQ_CONFIG_CASCADE2:
+    case VC_IRQ_CONFIG_REDIST:
+    case VC_IRQ_CONFIG_IPI_CASC:
+        break;
+
+    /*
+     * XIVE hardware thread enablement
+     */
+    case PC_THREAD_EN_REG0: /* Physical Thread Enable */
+    case PC_THREAD_EN_REG1: /* Physical Thread Enable (fused core) */
+        break;
+
+    case PC_THREAD_EN_REG0_SET:
+        xive->regs[PC_THREAD_EN_REG0 >> 3] |=3D val;
+        break;
+    case PC_THREAD_EN_REG1_SET:
+        xive->regs[PC_THREAD_EN_REG1 >> 3] |=3D val;
+        break;
+    case PC_THREAD_EN_REG0_CLR:
+        xive->regs[PC_THREAD_EN_REG0 >> 3] &=3D ~val;
+        break;
+    case PC_THREAD_EN_REG1_CLR:
+        xive->regs[PC_THREAD_EN_REG1 >> 3] &=3D ~val;
+        break;
+
+    /*
+     * Indirect TIMA access set up. Defines the PIR of the HW thread
+     * to use.
+     */
+    case PC_TCTXT_INDIR0 ... PC_TCTXT_INDIR3:
+        break;
+
+    /*
+     * XIVE PC & VC cache updates for EAS, NVT and END
+     */
+    case VC_IVC_SCRUB_MASK:
+        break;
+    case VC_IVC_SCRUB_TRIG:
+        pnv_xive_eas_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
+                            GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+
+    case VC_EQC_SCRUB_MASK:
+    case VC_EQC_CWATCH_SPEC:
+    case VC_EQC_CWATCH_DAT0 ... VC_EQC_CWATCH_DAT3:
+        break;
+    case VC_EQC_SCRUB_TRIG:
+        pnv_xive_end_update(xive, GETFIELD(VC_SCRUB_BLOCK_ID, val),
+                            GETFIELD(VC_SCRUB_OFFSET, val));
+        break;
+
+    case PC_VPC_SCRUB_MASK:
+    case PC_VPC_CWATCH_SPEC:
+    case PC_VPC_CWATCH_DAT0 ... PC_VPC_CWATCH_DAT7:
+        break;
+    case PC_VPC_SCRUB_TRIG:
+        pnv_xive_nvt_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
+                           GETFIELD(PC_SCRUB_OFFSET, val));
+        break;
+
+
+    /*
+     * XIVE PC & VC cache invalidation
+     */
+    case PC_AT_KILL:
+        break;
+    case VC_AT_MACRO_KILL:
+        break;
+    case PC_AT_KILL_MASK:
+    case VC_AT_MACRO_KILL_MASK:
+        break;
+
+    default:
+        xive_error(xive, "IC: invalid write to reg=3D0x%"HWADDR_PRIx, of=
fset);
+        return;
+    }
+
+    xive->regs[reg] =3D val;
+}
+
+static uint64_t pnv_xive_ic_reg_read(void *opaque, hwaddr offset, unsign=
ed size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+    uint64_t val =3D 0;
+    uint32_t reg =3D offset >> 3;
+
+    switch (offset) {
+    case CQ_CFG_PB_GEN:
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
+    case PC_THREAD_EN_REG0:
+    case PC_THREAD_EN_REG1:
+        val =3D xive->regs[reg];
+        break;
+
+    /*
+     * XIVE hardware thread enablement
+     */
+    case PC_THREAD_EN_REG0_SET:
+    case PC_THREAD_EN_REG0_CLR:
+        val =3D xive->regs[PC_THREAD_EN_REG0 >> 3];
+        break;
+    case PC_THREAD_EN_REG1_SET:
+    case PC_THREAD_EN_REG1_CLR:
+        val =3D xive->regs[PC_THREAD_EN_REG1 >> 3];
+        break;
+
+    case CQ_MSGSND: /* Identifies which cores have msgsnd enabled. */
+        val =3D 0xffffff0000000000;
+        break;
+
+    /*
+     * XIVE PC & VC cache updates for EAS, NVT and END
+     */
+    case PC_VPC_SCRUB_TRIG:
+    case VC_IVC_SCRUB_TRIG:
+    case VC_EQC_SCRUB_TRIG:
+        xive->regs[reg] &=3D ~VC_SCRUB_VALID;
+        val =3D xive->regs[reg];
+        break;
+
+    /*
+     * XIVE PC & VC cache invalidation
+     */
+    case PC_AT_KILL:
+        xive->regs[reg] &=3D ~PC_AT_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+    case VC_AT_MACRO_KILL:
+        xive->regs[reg] &=3D ~VC_KILL_VALID;
+        val =3D xive->regs[reg];
+        break;
+
+    /*
+     * XIVE synchronisation
+     */
+    case VC_EQC_CONFIG:
+        val =3D VC_EQC_SYNC_MASK;
+        break;
+
+    default:
+        xive_error(xive, "IC: invalid read reg=3D0x%"HWADDR_PRIx, offset=
);
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps pnv_xive_ic_reg_ops =3D {
+    .read =3D pnv_xive_ic_reg_read,
+    .write =3D pnv_xive_ic_reg_write,
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
+ * IC - Notify MMIO port page (write only)
+ */
+#define PNV_XIVE_FORWARD_IPI        0x800 /* Forward IPI */
+#define PNV_XIVE_FORWARD_HW         0x880 /* Forward HW */
+#define PNV_XIVE_FORWARD_OS_ESC     0x900 /* Forward OS escalation */
+#define PNV_XIVE_FORWARD_HW_ESC     0x980 /* Forward Hyp escalation */
+#define PNV_XIVE_FORWARD_REDIS      0xa00 /* Forward Redistribution */
+#define PNV_XIVE_RESERVED5          0xa80 /* Cache line 5 PowerBUS opera=
tion */
+#define PNV_XIVE_RESERVED6          0xb00 /* Cache line 6 PowerBUS opera=
tion */
+#define PNV_XIVE_RESERVED7          0xb80 /* Cache line 7 PowerBUS opera=
tion */
+
+/* VC synchronisation */
+#define PNV_XIVE_SYNC_IPI           0xc00 /* Sync IPI */
+#define PNV_XIVE_SYNC_HW            0xc80 /* Sync HW */
+#define PNV_XIVE_SYNC_OS_ESC        0xd00 /* Sync OS escalation */
+#define PNV_XIVE_SYNC_HW_ESC        0xd80 /* Sync Hyp escalation */
+#define PNV_XIVE_SYNC_REDIS         0xe00 /* Sync Redistribution */
+
+/* PC synchronisation */
+#define PNV_XIVE_SYNC_PULL          0xe80 /* Sync pull context */
+#define PNV_XIVE_SYNC_PUSH          0xf00 /* Sync push context */
+#define PNV_XIVE_SYNC_VPC           0xf80 /* Sync remove VPC store */
+
+static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
+{
+    /*
+     * Forward the source event notification directly to the Router.
+     * The source interrupt number should already be correctly encoded
+     * with the chip block id by the sending device (PHB, PSI).
+     */
+    xive_router_notify(XIVE_NOTIFIER(xive), val);
+}
+
+static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
+                                     unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    /* VC: HW triggers */
+    switch (addr) {
+    case 0x000 ... 0x7FF:
+        pnv_xive_ic_hw_trigger(opaque, addr, val);
+        break;
+
+    /* VC: Forwarded IRQs */
+    case PNV_XIVE_FORWARD_IPI:
+    case PNV_XIVE_FORWARD_HW:
+    case PNV_XIVE_FORWARD_OS_ESC:
+    case PNV_XIVE_FORWARD_HW_ESC:
+    case PNV_XIVE_FORWARD_REDIS:
+        /* TODO: forwarded IRQs. Should be like HW triggers */
+        xive_error(xive, "IC: forwarded at @0x%"HWADDR_PRIx" IRQ 0x%"PRI=
x64,
+                   addr, val);
+        break;
+
+    /* VC syncs */
+    case PNV_XIVE_SYNC_IPI:
+    case PNV_XIVE_SYNC_HW:
+    case PNV_XIVE_SYNC_OS_ESC:
+    case PNV_XIVE_SYNC_HW_ESC:
+    case PNV_XIVE_SYNC_REDIS:
+        break;
+
+    /* PC syncs */
+    case PNV_XIVE_SYNC_PULL:
+    case PNV_XIVE_SYNC_PUSH:
+    case PNV_XIVE_SYNC_VPC:
+        break;
+
+    default:
+        xive_error(xive, "IC: invalid notify write @%"HWADDR_PRIx, addr)=
;
+    }
+}
+
+static uint64_t pnv_xive_ic_notify_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    /* loads are invalid */
+    xive_error(xive, "IC: invalid notify read @%"HWADDR_PRIx, addr);
+    return -1;
+}
+
+static const MemoryRegionOps pnv_xive_ic_notify_ops =3D {
+    .read =3D pnv_xive_ic_notify_read,
+    .write =3D pnv_xive_ic_notify_write,
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
+ * IC - LSI MMIO handlers (not modeled)
+ */
+
+static void pnv_xive_ic_lsi_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    xive_error(xive, "IC: LSI invalid write @%"HWADDR_PRIx, addr);
+}
+
+static uint64_t pnv_xive_ic_lsi_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    xive_error(xive, "IC: LSI invalid read @%"HWADDR_PRIx, addr);
+    return -1;
+}
+
+static const MemoryRegionOps pnv_xive_ic_lsi_ops =3D {
+    .read =3D pnv_xive_ic_lsi_read,
+    .write =3D pnv_xive_ic_lsi_write,
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
+ * IC - Indirect TIMA MMIO handlers
+ */
+
+/*
+ * When the TIMA is accessed from the indirect page, the thread id
+ * (PIR) has to be configured in the IC registers before. This is used
+ * for resets and for debug purpose also.
+ */
+static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXive *xive)
+{
+    uint64_t tctxt_indir =3D xive->regs[PC_TCTXT_INDIR0 >> 3];
+    PowerPCCPU *cpu =3D NULL;
+    int pir;
+
+    if (!(tctxt_indir & PC_TCTXT_INDIR_VALID)) {
+        xive_error(xive, "IC: no indirect TIMA access in progress");
+        return NULL;
+    }
+
+    pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt_indir) & 0xff;
+    cpu =3D ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        xive_error(xive, "IC: invalid PIR %x for indirect access", pir);
+        return NULL;
+    }
+
+    /* Check that HW thread is XIVE enabled */
+    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
+        xive_error(xive, "IC: CPU %x is not enabled", pir);
+    }
+
+    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+}
+
+static void xive_tm_indirect_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    XiveTCTX *tctx =3D pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
+
+    xive_tctx_tm_write(tctx, offset, value, size);
+}
+
+static uint64_t xive_tm_indirect_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    XiveTCTX *tctx =3D pnv_xive_get_indirect_tctx(PNV_XIVE(opaque));
+
+    return xive_tctx_tm_read(tctx, offset, size);
+}
+
+static const MemoryRegionOps xive_tm_indirect_ops =3D {
+    .read =3D xive_tm_indirect_read,
+    .write =3D xive_tm_indirect_write,
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
+ * Interrupt controller XSCOM region.
+ */
+static uint64_t pnv_xive_xscom_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    switch (addr >> 3) {
+    case X_VC_EQC_CONFIG:
+        /* FIXME (skiboot): This is the only XSCOM load. Bizarre. */
+        return VC_EQC_SYNC_MASK;
+    default:
+        return pnv_xive_ic_reg_read(opaque, addr, size);
+    }
+}
+
+static void pnv_xive_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    pnv_xive_ic_reg_write(opaque, addr, val, size);
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
+/*
+ * Virtualization Controller MMIO region containing the IPI and END ESB =
pages
+ */
+static uint64_t pnv_xive_vc_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+    uint64_t edt_index =3D offset >> pnv_xive_edt_shift(xive);
+    uint64_t edt_type =3D 0;
+    uint64_t edt_offset;
+    MemTxResult result;
+    AddressSpace *edt_as =3D NULL;
+    uint64_t ret =3D -1;
+
+    if (edt_index < XIVE_TABLE_EDT_MAX) {
+        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]);
+    }
+
+    switch (edt_type) {
+    case CQ_TDR_EDT_IPI:
+        edt_as =3D &xive->ipi_as;
+        break;
+    case CQ_TDR_EDT_EQ:
+        edt_as =3D &xive->end_as;
+        break;
+    default:
+        xive_error(xive, "VC: invalid EDT type for read @%"HWADDR_PRIx, =
offset);
+        return -1;
+    }
+
+    /* Remap the offset for the targeted address space */
+    edt_offset =3D pnv_xive_edt_offset(xive, offset, edt_type);
+
+    ret =3D address_space_ldq(edt_as, edt_offset, MEMTXATTRS_UNSPECIFIED=
,
+                            &result);
+
+    if (result !=3D MEMTX_OK) {
+        xive_error(xive, "VC: %s read failed at @0x%"HWADDR_PRIx " -> @0=
x%"
+                   HWADDR_PRIx, edt_type =3D=3D CQ_TDR_EDT_IPI ? "IPI" :=
 "END",
+                   offset, edt_offset);
+        return -1;
+    }
+
+    return ret;
+}
+
+static void pnv_xive_vc_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+    uint64_t edt_index =3D offset >> pnv_xive_edt_shift(xive);
+    uint64_t edt_type =3D 0;
+    uint64_t edt_offset;
+    MemTxResult result;
+    AddressSpace *edt_as =3D NULL;
+
+    if (edt_index < XIVE_TABLE_EDT_MAX) {
+        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]);
+    }
+
+    switch (edt_type) {
+    case CQ_TDR_EDT_IPI:
+        edt_as =3D &xive->ipi_as;
+        break;
+    case CQ_TDR_EDT_EQ:
+        edt_as =3D &xive->end_as;
+        break;
+    default:
+        xive_error(xive, "VC: invalid EDT type for write @%"HWADDR_PRIx,
+                   offset);
+        return;
+    }
+
+    /* Remap the offset for the targeted address space */
+    edt_offset =3D pnv_xive_edt_offset(xive, offset, edt_type);
+
+    address_space_stq(edt_as, edt_offset, val, MEMTXATTRS_UNSPECIFIED, &=
result);
+    if (result !=3D MEMTX_OK) {
+        xive_error(xive, "VC: write failed at @0x%"HWADDR_PRIx, edt_offs=
et);
+    }
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
+ * Presenter Controller MMIO region. The Virtualization Controller
+ * updates the IPB in the NVT table when required. Not modeled.
+ */
+static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
+                                 unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    xive_error(xive, "PC: invalid read @%"HWADDR_PRIx, addr);
+    return -1;
+}
+
+static void pnv_xive_pc_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    PnvXive *xive =3D PNV_XIVE(opaque);
+
+    xive_error(xive, "PC: invalid write to VC @%"HWADDR_PRIx, addr);
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
+    XiveRouter *xrtr =3D XIVE_ROUTER(xive);
+    uint8_t blk =3D xive->chip->chip_id;
+    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
+    uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
+    uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
+    XiveEAS eas;
+    XiveEND end;
+    int i;
+
+    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
+                   srcno0 + nr_ipis - 1);
+    xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
+
+    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
+                   srcno0 + nr_ipis - 1);
+    for (i =3D 0; i < nr_ipis; i++) {
+        if (xive_router_get_eas(xrtr, blk, i, &eas)) {
+            break;
+        }
+        if (!xive_eas_is_masked(&eas)) {
+            xive_eas_pic_print_info(&eas, i, mon);
+        }
+    }
+
+    monitor_printf(mon, "XIVE[%x] ENDT %08x .. %08x\n", blk, 0, nr_ends =
- 1);
+    for (i =3D 0; i < nr_ends; i++) {
+        if (xive_router_get_end(xrtr, blk, i, &end)) {
+            break;
+        }
+        xive_end_pic_print_info(&end, i, mon);
+    }
+}
+
+static void pnv_xive_reset(void *dev)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+    XiveSource *xsrc =3D &xive->ipi_source;
+    XiveENDSource *end_xsrc =3D &xive->end_source;
+
+    /*
+     * Use the PnvChip id to identify the XIVE interrupt controller.
+     * It can be overriden by configuration at runtime.
+     */
+    xive->tctx_chipid =3D xive->chip->chip_id;
+
+    /* Default page size (Should be changed at runtime to 64k) */
+    xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
+
+    /* Clear subregions */
+    if (memory_region_is_mapped(&xsrc->esb_mmio)) {
+        memory_region_del_subregion(&xive->ipi_edt_mmio, &xsrc->esb_mmio=
);
+    }
+
+    if (memory_region_is_mapped(&xive->ipi_edt_mmio)) {
+        memory_region_del_subregion(&xive->ipi_mmio, &xive->ipi_edt_mmio=
);
+    }
+
+    if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
+        memory_region_del_subregion(&xive->end_edt_mmio, &end_xsrc->esb_=
mmio);
+    }
+
+    if (memory_region_is_mapped(&xive->end_edt_mmio)) {
+        memory_region_del_subregion(&xive->end_mmio, &xive->end_edt_mmio=
);
+    }
+}
+
+static void pnv_xive_init(Object *obj)
+{
+    PnvXive *xive =3D PNV_XIVE(obj);
+
+    object_initialize_child(obj, "ipi_source", &xive->ipi_source,
+                            sizeof(xive->ipi_source), TYPE_XIVE_SOURCE,
+                            &error_abort, NULL);
+    object_initialize_child(obj, "end_source", &xive->end_source,
+                            sizeof(xive->end_source), TYPE_XIVE_END_SOUR=
CE,
+                            &error_abort, NULL);
+}
+
+/*
+ *  Maximum number of IRQs and ENDs supported by HW
+ */
+#define PNV_XIVE_NR_IRQS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K_2PAG=
E))
+#define PNV_XIVE_NR_ENDS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K_2PAG=
E))
+
+static void pnv_xive_realize(DeviceState *dev, Error **errp)
+{
+    PnvXive *xive =3D PNV_XIVE(dev);
+    XiveSource *xsrc =3D &xive->ipi_source;
+    XiveENDSource *end_xsrc =3D &xive->end_source;
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'chip' not found: ");
+        return;
+    }
+
+    /* The PnvChip id identifies the XIVE interrupt controller. */
+    xive->chip =3D PNV_CHIP(obj);
+
+    /*
+     * The XiveSource and XiveENDSource objects are realized with the
+     * maximum allowed HW configuration. The ESB MMIO regions will be
+     * resized dynamically when the controller is configured by the FW
+     * to limit accesses to resources not provisioned.
+     */
+    object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    object_property_set_int(OBJECT(end_xsrc), PNV_XIVE_NR_ENDS, "nr-ends=
",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive=
),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_=
err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Default page size. Generally changed at runtime to 64k */
+    xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
+
+    /* XSCOM region, used for initial configuration of the BARs */
+    memory_region_init_io(&xive->xscom_regs, OBJECT(dev), &pnv_xive_xsco=
m_ops,
+                          xive, "xscom-xive", PNV9_XSCOM_XIVE_SIZE << 3)=
;
+
+    /* Interrupt controller MMIO regions */
+    memory_region_init(&xive->ic_mmio, OBJECT(dev), "xive-ic",
+                       PNV9_XIVE_IC_SIZE);
+
+    memory_region_init_io(&xive->ic_reg_mmio, OBJECT(dev), &pnv_xive_ic_=
reg_ops,
+                          xive, "xive-ic-reg", 1 << xive->ic_shift);
+    memory_region_init_io(&xive->ic_notify_mmio, OBJECT(dev),
+                          &pnv_xive_ic_notify_ops,
+                          xive, "xive-ic-notify", 1 << xive->ic_shift);
+
+    /* The Pervasive LSI trigger and EOI pages (not modeled) */
+    memory_region_init_io(&xive->ic_lsi_mmio, OBJECT(dev), &pnv_xive_ic_=
lsi_ops,
+                          xive, "xive-ic-lsi", 2 << xive->ic_shift);
+
+    /* Thread Interrupt Management Area (Indirect) */
+    memory_region_init_io(&xive->tm_indirect_mmio, OBJECT(dev),
+                          &xive_tm_indirect_ops,
+                          xive, "xive-tima-indirect", PNV9_XIVE_TM_SIZE)=
;
+    /*
+     * Overall Virtualization Controller MMIO region containing the
+     * IPI ESB pages and END ESB pages. The layout is defined by the
+     * EDT "Domain table" and the accesses are dispatched using
+     * address spaces for each.
+     */
+    memory_region_init_io(&xive->vc_mmio, OBJECT(xive), &pnv_xive_vc_ops=
, xive,
+                          "xive-vc", PNV9_XIVE_VC_SIZE);
+
+    memory_region_init(&xive->ipi_mmio, OBJECT(xive), "xive-vc-ipi",
+                       PNV9_XIVE_VC_SIZE);
+    address_space_init(&xive->ipi_as, &xive->ipi_mmio, "xive-vc-ipi");
+    memory_region_init(&xive->end_mmio, OBJECT(xive), "xive-vc-end",
+                       PNV9_XIVE_VC_SIZE);
+    address_space_init(&xive->end_as, &xive->end_mmio, "xive-vc-end");
+
+    /*
+     * The MMIO windows exposing the IPI ESBs and the END ESBs in the
+     * VC region. Their size is configured by the FW in the EDT table.
+     */
+    memory_region_init(&xive->ipi_edt_mmio, OBJECT(xive), "xive-vc-ipi-e=
dt", 0);
+    memory_region_init(&xive->end_edt_mmio, OBJECT(xive), "xive-vc-end-e=
dt", 0);
+
+    /* Presenter Controller MMIO region (not modeled) */
+    memory_region_init_io(&xive->pc_mmio, OBJECT(xive), &pnv_xive_pc_ops=
, xive,
+                          "xive-pc", PNV9_XIVE_PC_SIZE);
+
+    /* Thread Interrupt Management Area (Direct) */
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
+                          xive, "xive-tima", PNV9_XIVE_TM_SIZE);
+
+    qemu_register_reset(pnv_xive_reset, dev);
+}
+
+static int pnv_xive_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] =3D "ibm,power9-xive-x";
+    char *name;
+    int offset;
+    uint32_t lpc_pcba =3D PNV9_XSCOM_XIVE_BASE;
+    uint32_t reg[] =3D {
+        cpu_to_be32(lpc_pcba),
+        cpu_to_be32(PNV9_XSCOM_XIVE_SIZE)
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
+static void pnv_xive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+    XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
+    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
+
+    xdc->dt_xscom =3D pnv_xive_dt_xscom;
+
+    dc->desc =3D "PowerNV XIVE Interrupt Controller";
+    dc->realize =3D pnv_xive_realize;
+    dc->props =3D pnv_xive_properties;
+
+    xrc->get_eas =3D pnv_xive_get_eas;
+    xrc->get_end =3D pnv_xive_get_end;
+    xrc->write_end =3D pnv_xive_write_end;
+    xrc->get_nvt =3D pnv_xive_get_nvt;
+    xrc->write_nvt =3D pnv_xive_write_nvt;
+    xrc->get_tctx =3D pnv_xive_get_tctx;
+
+    xnc->notify =3D pnv_xive_notify;
+};
+
+static const TypeInfo pnv_xive_info =3D {
+    .name          =3D TYPE_PNV_XIVE,
+    .parent        =3D TYPE_XIVE_ROUTER,
+    .instance_init =3D pnv_xive_init,
+    .instance_size =3D sizeof(PnvXive),
+    .class_init    =3D pnv_xive_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
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
diff --git a/hw/intc/pnv_xive_regs.h b/hw/intc/pnv_xive_regs.h
new file mode 100644
index 0000000000..c78f030c02
--- /dev/null
+++ b/hw/intc/pnv_xive_regs.h
@@ -0,0 +1,248 @@
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
+/* IC register offsets 0x0 - 0x400 */
+#define CQ_SWI_CMD_HIST         0x020
+#define CQ_SWI_CMD_POLL         0x028
+#define CQ_SWI_CMD_BCAST        0x030
+#define CQ_SWI_CMD_ASSIGN       0x038
+#define CQ_SWI_CMD_BLK_UPD      0x040
+#define CQ_SWI_RSP              0x048
+#define CQ_CFG_PB_GEN           0x050
+#define   CQ_INT_ADDR_OPT       PPC_BITMASK(14, 15)
+#define CQ_MSGSND               0x058
+#define CQ_CNPM_SEL             0x078
+#define CQ_IC_BAR               0x080
+#define   CQ_IC_BAR_VALID       PPC_BIT(0)
+#define   CQ_IC_BAR_64K         PPC_BIT(1)
+#define CQ_TM1_BAR              0x90
+#define CQ_TM2_BAR              0x0a0
+#define   CQ_TM_BAR_VALID       PPC_BIT(0)
+#define   CQ_TM_BAR_64K         PPC_BIT(1)
+#define CQ_PC_BAR               0x0b0
+#define  CQ_PC_BAR_VALID        PPC_BIT(0)
+#define CQ_PC_BARM              0x0b8
+#define  CQ_PC_BARM_MASK        PPC_BITMASK(26, 38)
+#define CQ_VC_BAR               0x0c0
+#define  CQ_VC_BAR_VALID        PPC_BIT(0)
+#define CQ_VC_BARM              0x0c8
+#define  CQ_VC_BARM_MASK        PPC_BITMASK(21, 37)
+#define CQ_TAR                  0x0f0
+#define  CQ_TAR_TBL_AUTOINC     PPC_BIT(0)
+#define  CQ_TAR_TSEL            PPC_BITMASK(12, 15)
+#define  CQ_TAR_TSEL_BLK        PPC_BIT(12)
+#define  CQ_TAR_TSEL_MIG        PPC_BIT(13)
+#define  CQ_TAR_TSEL_VDT        PPC_BIT(14)
+#define  CQ_TAR_TSEL_EDT        PPC_BIT(15)
+#define  CQ_TAR_TSEL_INDEX      PPC_BITMASK(26, 31)
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
+#define CQ_PBI_CTL              0x100
+#define  CQ_PBI_PC_64K          PPC_BIT(5)
+#define  CQ_PBI_VC_64K          PPC_BIT(6)
+#define  CQ_PBI_LNX_TRIG        PPC_BIT(7)
+#define  CQ_PBI_FORCE_TM_LOCAL  PPC_BIT(22)
+#define CQ_PBO_CTL              0x108
+#define CQ_AIB_CTL              0x110
+#define CQ_RST_CTL              0x118
+#define CQ_FIRMASK              0x198
+#define CQ_FIRMASK_AND          0x1a0
+#define CQ_FIRMASK_OR           0x1a8
+
+/* PC LBS1 register offsets 0x400 - 0x800 */
+#define PC_TCTXT_CFG            0x400
+#define  PC_TCTXT_CFG_BLKGRP_EN         PPC_BIT(0)
+#define  PC_TCTXT_CFG_TARGET_EN         PPC_BIT(1)
+#define  PC_TCTXT_CFG_LGS_EN            PPC_BIT(2)
+#define  PC_TCTXT_CFG_STORE_ACK         PPC_BIT(3)
+#define  PC_TCTXT_CFG_HARD_CHIPID_BLK   PPC_BIT(8)
+#define  PC_TCTXT_CHIPID_OVERRIDE       PPC_BIT(9)
+#define  PC_TCTXT_CHIPID                PPC_BITMASK(12, 15)
+#define  PC_TCTXT_INIT_AGE              PPC_BITMASK(30, 31)
+#define PC_TCTXT_TRACK          0x408
+#define  PC_TCTXT_TRACK_EN              PPC_BIT(0)
+#define PC_TCTXT_INDIR0         0x420
+#define  PC_TCTXT_INDIR_VALID           PPC_BIT(0)
+#define  PC_TCTXT_INDIR_THRDID          PPC_BITMASK(9, 15)
+#define PC_TCTXT_INDIR1         0x428
+#define PC_TCTXT_INDIR2         0x430
+#define PC_TCTXT_INDIR3         0x438
+#define PC_THREAD_EN_REG0       0x440
+#define PC_THREAD_EN_REG0_SET   0x448
+#define PC_THREAD_EN_REG0_CLR   0x450
+#define PC_THREAD_EN_REG1       0x460
+#define PC_THREAD_EN_REG1_SET   0x468
+#define PC_THREAD_EN_REG1_CLR   0x470
+#define PC_GLOBAL_CONFIG        0x480
+#define  PC_GCONF_INDIRECT      PPC_BIT(32)
+#define  PC_GCONF_CHIPID_OVR    PPC_BIT(40)
+#define  PC_GCONF_CHIPID        PPC_BITMASK(44, 47)
+#define PC_VSD_TABLE_ADDR       0x488
+#define PC_VSD_TABLE_DATA       0x490
+#define PC_AT_KILL              0x4b0
+#define  PC_AT_KILL_VALID       PPC_BIT(0)
+#define  PC_AT_KILL_BLOCK_ID    PPC_BITMASK(27, 31)
+#define  PC_AT_KILL_OFFSET      PPC_BITMASK(48, 60)
+#define PC_AT_KILL_MASK         0x4b8
+
+/* PC LBS2 register offsets */
+#define PC_VPC_CACHE_ENABLE     0x708
+#define  PC_VPC_CACHE_EN_MASK   PPC_BITMASK(0, 31)
+#define PC_VPC_SCRUB_TRIG       0x710
+#define PC_VPC_SCRUB_MASK       0x718
+#define  PC_SCRUB_VALID         PPC_BIT(0)
+#define  PC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  PC_SCRUB_WANT_INVAL    PPC_BIT(2)
+#define  PC_SCRUB_BLOCK_ID      PPC_BITMASK(27, 31)
+#define  PC_SCRUB_OFFSET        PPC_BITMASK(45, 63)
+#define PC_VPC_CWATCH_SPEC      0x738
+#define  PC_VPC_CWATCH_CONFLICT PPC_BIT(0)
+#define  PC_VPC_CWATCH_FULL     PPC_BIT(8)
+#define  PC_VPC_CWATCH_BLOCKID  PPC_BITMASK(27, 31)
+#define  PC_VPC_CWATCH_OFFSET   PPC_BITMASK(45, 63)
+#define PC_VPC_CWATCH_DAT0      0x740
+#define PC_VPC_CWATCH_DAT1      0x748
+#define PC_VPC_CWATCH_DAT2      0x750
+#define PC_VPC_CWATCH_DAT3      0x758
+#define PC_VPC_CWATCH_DAT4      0x760
+#define PC_VPC_CWATCH_DAT5      0x768
+#define PC_VPC_CWATCH_DAT6      0x770
+#define PC_VPC_CWATCH_DAT7      0x778
+
+/* VC0 register offsets 0x800 - 0xFFF */
+#define VC_GLOBAL_CONFIG        0x800
+#define  VC_GCONF_INDIRECT      PPC_BIT(32)
+#define VC_VSD_TABLE_ADDR       0x808
+#define VC_VSD_TABLE_DATA       0x810
+#define VC_IVE_ISB_BLOCK_MODE   0x818
+#define VC_EQD_BLOCK_MODE       0x820
+#define VC_VPS_BLOCK_MODE       0x828
+#define VC_IRQ_CONFIG_IPI       0x840
+#define  VC_IRQ_CONFIG_MEMB_EN  PPC_BIT(45)
+#define  VC_IRQ_CONFIG_MEMB_SZ  PPC_BITMASK(46, 51)
+#define VC_IRQ_CONFIG_HW        0x848
+#define VC_IRQ_CONFIG_CASCADE1  0x850
+#define VC_IRQ_CONFIG_CASCADE2  0x858
+#define VC_IRQ_CONFIG_REDIST    0x860
+#define VC_IRQ_CONFIG_IPI_CASC  0x868
+#define  VC_AIB_TX_ORDER_TAG2_REL_TF    PPC_BIT(20)
+#define VC_AIB_TX_ORDER_TAG2    0x890
+#define VC_AT_MACRO_KILL        0x8b0
+#define VC_AT_MACRO_KILL_MASK   0x8b8
+#define  VC_KILL_VALID          PPC_BIT(0)
+#define  VC_KILL_TYPE           PPC_BITMASK(14, 15)
+#define   VC_KILL_IRQ   0
+#define   VC_KILL_IVC   1
+#define   VC_KILL_SBC   2
+#define   VC_KILL_EQD   3
+#define  VC_KILL_BLOCK_ID       PPC_BITMASK(27, 31)
+#define  VC_KILL_OFFSET         PPC_BITMASK(48, 60)
+#define VC_EQC_CACHE_ENABLE     0x908
+#define  VC_EQC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define VC_EQC_SCRUB_TRIG       0x910
+#define VC_EQC_SCRUB_MASK       0x918
+#define VC_EQC_CONFIG           0x920
+#define X_VC_EQC_CONFIG         0x214 /* XSCOM register */
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
+#define VC_EQC_CWATCH_DAT0      0x930
+#define VC_EQC_CWATCH_DAT1      0x938
+#define VC_EQC_CWATCH_DAT2      0x940
+#define VC_EQC_CWATCH_DAT3      0x948
+#define VC_IVC_SCRUB_TRIG       0x990
+#define VC_IVC_SCRUB_MASK       0x998
+#define VC_SBC_SCRUB_TRIG       0xa10
+#define VC_SBC_SCRUB_MASK       0xa18
+#define  VC_SCRUB_VALID         PPC_BIT(0)
+#define  VC_SCRUB_WANT_DISABLE  PPC_BIT(1)
+#define  VC_SCRUB_WANT_INVAL    PPC_BIT(2) /* EQC and SBC only */
+#define  VC_SCRUB_BLOCK_ID      PPC_BITMASK(28, 31)
+#define  VC_SCRUB_OFFSET        PPC_BITMASK(40, 63)
+#define VC_IVC_CACHE_ENABLE     0x988
+#define  VC_IVC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define  VC_SBC_CACHE_EN_MASK   PPC_BITMASK(0, 15)
+#define VC_IVC_CACHE_SCRUB_TRIG 0x990
+#define VC_IVC_CACHE_SCRUB_MASK 0x998
+#define VC_SBC_CACHE_ENABLE     0xa08
+#define VC_SBC_CACHE_SCRUB_TRIG 0xa10
+#define VC_SBC_CACHE_SCRUB_MASK 0xa18
+#define VC_SBC_CONFIG           0xa20
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
+#define VST_TABLE_BLOCK        PPC_BITMASK(27, 31)
+
+/* Number of queue overflow pages */
+#define VC_QUEUE_OVF_COUNT      6
+
+/*
+ * Bits in a VSD entry.
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
+#define VC_EQC_SYNC_MASK         \
+        (VC_EQC_CONF_SYNC_IPI  | \
+         VC_EQC_CONF_SYNC_HW   | \
+         VC_EQC_CONF_SYNC_ESC1 | \
+         VC_EQC_CONF_SYNC_ESC2 | \
+         VC_EQC_CONF_SYNC_REDI)
+
+
+#endif /* PPC_PNV_XIVE_REGS_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b90d03711a..a7ec76dbd6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -705,7 +705,23 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, =
uint32_t core_id)
 static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
-    return;
+    Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
+    Error *local_err =3D NULL;
+    Object *obj;
+    PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
+
+    /*
+     * The core creates its interrupt presenter but the XIVE interrupt
+     * controller object is initialized afterwards. Hopefully, it's
+     * only used at runtime.
+     */
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), err=
p);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pnv_cpu->intc =3D obj;
 }
=20
 /* Allowed core identifiers on a POWER8 Processor Chip :
@@ -887,11 +903,19 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
=20
 static void pnv_chip_power9_instance_init(Object *obj)
 {
+    Pnv9Chip *chip9 =3D PNV9_CHIP(obj);
+
+    object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xiv=
e),
+                            TYPE_PNV_XIVE, &error_abort, NULL);
+    object_property_add_const_link(OBJECT(&chip9->xive), "chip", obj,
+                                   &error_abort);
 }
=20
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
+    Pnv9Chip *chip9 =3D PNV9_CHIP(dev);
+    PnvChip *chip =3D PNV_CHIP(dev);
     Error *local_err =3D NULL;
=20
     pcc->parent_realize(dev, &local_err);
@@ -899,6 +923,24 @@ static void pnv_chip_power9_realize(DeviceState *dev=
, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+    /* XIVE interrupt controller (POWER9) */
+    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_IC_BASE(chip=
),
+                            "ic-bar", &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_VC_BASE(chip=
),
+                            "vc-bar", &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_PC_BASE(chip=
),
+                            "pc-bar", &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_TM_BASE(chip=
),
+                            "tm-bar", &error_fatal);
+    object_property_set_bool(OBJECT(&chip9->xive), true, "realized",
+                             &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
+                            &chip9->xive.xscom_regs);
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 6b65397b7e..ebbb3d0e9a 100644
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
@@ -82,6 +83,7 @@ typedef struct Pnv9Chip {
     PnvChip      parent_obj;
=20
     /*< public >*/
+    PnvXive      xive;
 } Pnv9Chip;
=20
 typedef struct PnvChipClass {
@@ -215,4 +217,23 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
     (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
      PNV_PSIHB_FSP_SIZE)
=20
+/*
+ * POWER9 MMIO base addresses
+ */
+#define PNV9_CHIP_BASE(chip, base)   \
+    ((base) + ((uint64_t) (chip)->chip_id << 42))
+
+#define PNV9_XIVE_VC_SIZE            0x0000008000000000ull
+#define PNV9_XIVE_VC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000601000000=
0000ull)
+
+#define PNV9_XIVE_PC_SIZE            0x0000001000000000ull
+#define PNV9_XIVE_PC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000601800000=
0000ull)
+
+#define PNV9_XIVE_IC_SIZE            0x0000000000080000ull
+#define PNV9_XIVE_IC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000603020310=
0000ull)
+
+#define PNV9_XIVE_TM_SIZE            0x0000000000040000ull
+#define PNV9_XIVE_TM_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000603020318=
0000ull)
+
+
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
new file mode 100644
index 0000000000..4fdaa9247d
--- /dev/null
+++ b/include/hw/ppc/pnv_xive.h
@@ -0,0 +1,93 @@
+/*
+ * QEMU PowerPC XIVE interrupt controller model
+ *
+ * Copyright (c) 2017-2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_XIVE_H
+#define PPC_PNV_XIVE_H
+
+#include "hw/ppc/xive.h"
+
+struct PnvChip;
+
+#define TYPE_PNV_XIVE "pnv-xive"
+#define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
+
+#define XIVE_BLOCK_MAX      16
+
+#define XIVE_TABLE_BLK_MAX  16  /* Block Scope Table (0-15) */
+#define XIVE_TABLE_MIG_MAX  16  /* Migration Register Table (1-15) */
+#define XIVE_TABLE_VDT_MAX  16  /* VDT Domain Table (0-15) */
+#define XIVE_TABLE_EDT_MAX  64  /* EDT Domain Table (0-63) */
+
+typedef struct PnvXive {
+    XiveRouter    parent_obj;
+
+    /* Owning chip */
+    struct PnvChip *chip;
+
+    /* XSCOM addresses giving access to the controller registers */
+    MemoryRegion  xscom_regs;
+
+    /* Main MMIO regions that can be configured by FW */
+    MemoryRegion  ic_mmio;
+    MemoryRegion    ic_reg_mmio;
+    MemoryRegion    ic_notify_mmio;
+    MemoryRegion    ic_lsi_mmio;
+    MemoryRegion    tm_indirect_mmio;
+    MemoryRegion  vc_mmio;
+    MemoryRegion  pc_mmio;
+    MemoryRegion  tm_mmio;
+
+    /*
+     * IPI and END address spaces modeling the EDT segmentation in the
+     * VC region
+     */
+    AddressSpace  ipi_as;
+    MemoryRegion  ipi_mmio;
+    MemoryRegion    ipi_edt_mmio;
+
+    AddressSpace  end_as;
+    MemoryRegion  end_mmio;
+    MemoryRegion    end_edt_mmio;
+
+    /* Shortcut values for the Main MMIO regions */
+    hwaddr        ic_base;
+    uint32_t      ic_shift;
+    hwaddr        vc_base;
+    uint32_t      vc_shift;
+    hwaddr        pc_base;
+    uint32_t      pc_shift;
+    hwaddr        tm_base;
+    uint32_t      tm_shift;
+
+    /* Our XIVE source objects for IPIs and ENDs */
+    XiveSource    ipi_source;
+    XiveENDSource end_source;
+
+    /* Interrupt controller registers */
+    uint64_t      regs[0x300];
+
+    /* Can be configured by FW */
+    uint32_t      tctx_chipid;
+
+    /*
+     * Virtual Structure Descriptor tables : EAT, SBE, ENDT, NVTT, IRQ
+     * These are in a SRAM protected by ECC.
+     */
+    uint64_t      vsds[5][XIVE_BLOCK_MAX];
+
+    /* Translation tables */
+    uint64_t      blk[XIVE_TABLE_BLK_MAX];
+    uint64_t      mig[XIVE_TABLE_MIG_MAX];
+    uint64_t      vdt[XIVE_TABLE_VDT_MAX];
+    uint64_t      edt[XIVE_TABLE_EDT_MAX];
+} PnvXive;
+
+void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
+
+#endif /* PPC_PNV_XIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 255b26a5aa..6623ec54a7 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV9_XSCOM_XIVE_BASE      0x5013000
+#define PNV9_XSCOM_XIVE_SIZE      0x300
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
=20
--=20
2.20.1
