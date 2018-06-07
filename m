Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBP-0001eP-4H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBK-0003Q4-CD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:39 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:46743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBK-0003OW-1C
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:34 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.88])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 79C30B59EE
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:38 +0200
Message-Id: <20180607155003.1580-4-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/28] spapr: introduce a new IRQ backend
 using fixed IRQ number ranges
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

The proposed layout of the IRQ number space is organized as follow :

   RANGES             DEVICES

   0x0000 - 0x0FFF    Reserved for future use (IPI =3D 2)

   0x1000 - 0x1000    1 EPOW
   0x1001 - 0x1001    1 HOTPLUG
   0x1002 - 0x10FF    unused
   0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
   0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
   0x1284 - 0x13FF    unused
   0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
   0x1800 - 0x1BFF    PCI MSI device 2
   0x1c00 - 0x1FFF    PCI MSI device 3

The MSI range is a bit more complex to handle as the IRQs are dynamically
allocated by the guest OS. We use a bitmap allocator under the sPAPR
IRQ backend for these.

The XICS IRQ number space is increased to 4K, which gives three MSI
ranges of 1K per PHB device. If more PHB devices are needed, the total
number of IRQs in the backend should be increased.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |   2 +
 include/hw/ppc/spapr_irq.h |  12 +++
 hw/ppc/spapr.c             |  22 ++++
 hw/ppc/spapr_irq.c         | 253 +++++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index aba1892f2bd0..bd256fbc9158 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -164,6 +164,8 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
=20
+    int32_t nr_irqs;
+    unsigned long *irq_map;
     const char *icp_type;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 67ec7ff162a6..dd9c4038d5b6 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -21,8 +21,16 @@
 #define SPAPR_IRQ_PCI_LSI    0x1200  /* 4 IRQs per device */
 #define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
                                       * a bitmap allocator */
+typedef struct sPAPRPIrqRange {
+    const char   *name;
+    uint32_t     offset;
+    uint32_t     width;
+    uint32_t     max_index;
+} sPAPRPIrqRange;
+
 typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
+    const sPAPRPIrqRange *ranges;
=20
     void (*init)(sPAPRMachineState *spapr, Error **errp);
     int (*assign)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq=
,
@@ -36,8 +44,12 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
 } sPAPRIrq;
=20
+extern sPAPRIrq spapr_irq_legacy;
 extern sPAPRIrq spapr_irq_xics;
=20
+const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
+                                          uint32_t offset);
+
 int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t =
irq,
                      Error **errp);
 int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fd37ca4803eb..c097a7093e62 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1850,6 +1850,24 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
     },
 };
=20
+static bool spapr_irq_map_needed(void *opaque)
+{
+    sPAPRMachineState *spapr =3D opaque;
+
+    return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->nr_irq=
s);
+}
+
+static const VMStateDescription vmstate_spapr_irq_map =3D {
+    .name =3D "spapr_irq_map",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D spapr_irq_map_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, nr_irqs),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr =3D {
     .name =3D "spapr",
     .version_id =3D 3,
@@ -1877,6 +1895,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
+        &vmstate_spapr_irq_map,
         NULL
     }
 };
@@ -3913,7 +3932,10 @@ static void spapr_machine_2_12_instance_options(Ma=
chineState *machine)
=20
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_3_0_class_options(mc);
+    smc->irq =3D &spapr_irq_legacy;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1efccf590899..6bd3dd7e01d7 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -237,7 +237,7 @@ static void spapr_irq_print_info_legacy(sPAPRMachineS=
tate *spapr,
     ics_pic_print_info(spapr->ics, mon);
 }
=20
-sPAPRIrq spapr_irq_xics =3D {
+sPAPRIrq spapr_irq_legacy =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
     .init        =3D spapr_irq_init_legacy,
     .assign      =3D spapr_irq_assign_legacy,
@@ -249,6 +249,257 @@ sPAPRIrq spapr_irq_xics =3D {
 };
=20
 /*
+ * IRQ range helpers for new IRQ backends
+ */
+const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
+                                          uint32_t range)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    const sPAPRPIrqRange *irq_range =3D smc->irq->ranges;
+
+    if (irq_range) {
+        /*
+         * The range identifier is also its offset in the IRQ number
+         * space. May be introduce a enum instead.
+         */
+        while (irq_range->name && irq_range->offset !=3D range) {
+            irq_range++;
+        }
+
+        if (!irq_range->name) {
+            return NULL;
+        }
+    }
+
+    return irq_range;
+}
+
+static int spapr_irq_range_base(sPAPRMachineState *spapr, uint32_t range=
,
+                                    uint32_t index, Error **errp)
+{
+    const sPAPRPIrqRange *irq_range =3D spapr_irq_get_range(spapr, range=
);
+
+    if (!irq_range) {
+        error_setg(errp, "Invalid IRQ range %x", range);
+        return -1;
+    }
+
+    if (index > irq_range->max_index) {
+        error_setg(errp, "Index %d too big for IRQ range %s", index,
+                   irq_range->name);
+        return -1;
+    }
+
+    return irq_range->offset + index * irq_range->width;
+}
+
+static int spapr_irq_range_alloc(sPAPRMachineState *spapr,
+                                 uint32_t range, uint32_t index, Error *=
*errp)
+{
+    return spapr_irq_range_base(spapr, range, index, errp);
+}
+
+static int spapr_irq_range_alloc_msi(sPAPRMachineState *spapr, uint32_t =
range,
+                                     uint32_t index, int num, bool align=
,
+                                     Error **errp)
+{
+    int msi_base;
+    int irq;
+
+    msi_base =3D spapr_irq_range_base(spapr, SPAPR_IRQ_PCI_MSI, index, e=
rrp);
+    if (msi_base =3D=3D -1) {
+        return -1;
+    }
+
+    /*
+     * The 'align_mask' parameter of bitmap_find_next_zero_area()
+     * should be one less than a power of 2; 0 means no
+     * alignment. Adapt the 'align' value of the former allocator
+     * to fit the requirements of bitmap_find_next_zero_area()
+     */
+    align -=3D 1;
+
+    irq =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_irqs,
+                                     msi_base, num, align);
+    if (irq =3D=3D spapr->nr_irqs) {
+        error_setg(errp, "can't find a free MSI %d-IRQ block", num);
+        return -1;
+    }
+
+    bitmap_set(spapr->irq_map, irq, num);
+    return irq;
+}
+
+static void spapr_irq_range_free_msi(sPAPRMachineState *spapr, int irq, =
int num)
+{
+    bitmap_clear(spapr->irq_map, irq, num);
+}
+
+/*
+ * New XICS IRQ backend
+ *
+ * using the IRQ ranges and device indexes
+ */
+static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+
+    spapr_irq_init_legacy(spapr, errp);
+
+    /*
+     * Initialize the MSI IRQ allocator. The full XICS IRQ number
+     * space is covered even though the bottow IRQ numbers below the
+     * XICS source number offset (4K) are unused and that only MSI IRQ
+     * numbers can be allocated. It does waste some bytes but it makes
+     * things easier. We will optimize later.
+     */
+    spapr->nr_irqs  =3D smc->irq->nr_irqs + spapr->ics->offset;
+    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+}
+
+/*
+ * The 'irq' assignment is only used by the sPAPR VIO devices and it
+ * has been deprecated in QEMU 3.0. This handler should be removed
+ * soon.
+ */
+static int spapr_irq_assign_xics(sPAPRMachineState *spapr, uint32_t rang=
e,
+                                 uint32_t irq, Error **errp)
+{
+    assert(range =3D=3D SPAPR_IRQ_VIO);
+
+    error_setg(errp, "IRQ assignment is not available on the new "
+               " XICS IRQ backend");
+    return -1;
+}
+
+static int spapr_irq_alloc_xics(sPAPRMachineState *spapr, uint32_t range=
,
+                                uint32_t index, Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int irq =3D spapr_irq_range_alloc(spapr, range, index, errp);
+
+    if (irq < 0) {
+        return irq;
+    }
+
+    /* Update the IRQState in the XICS source */
+    ics_set_irq_type(ics, irq - ics->offset, lsi);
+
+    return irq;
+}
+
+static int spapr_irq_alloc_block_xics(sPAPRMachineState *spapr, uint32_t=
 range,
+                                      uint32_t index, int num, bool alig=
n,
+                                      Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int irq;
+    int i;
+
+    if (range =3D=3D SPAPR_IRQ_PCI_MSI) {
+        irq =3D spapr_irq_range_alloc_msi(spapr, range, index, num, alig=
n, errp);
+    } else {
+        /* TODO: check IRQ range width vs. required block size */
+        irq =3D spapr_irq_range_alloc(spapr, range, index, errp);
+    }
+
+    if (irq < 0) {
+        return irq;
+    }
+
+    /* Update the IRQState in the XICS source */
+    for (i =3D irq; i < irq + num; ++i) {
+        ics_set_irq_type(ics, i - ics->offset, lsi);
+    }
+
+    return irq;
+}
+
+static void spapr_irq_free_xics(sPAPRMachineState *spapr, int irq, int n=
um,
+                                Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    int msi_base =3D spapr_irq_range_base(spapr, SPAPR_IRQ_PCI_MSI, 0, N=
ULL);
+    int i;
+
+    /* Any IRQ below MSI base should not be freed */
+    if (irq < msi_base) {
+        error_setg(errp, "IRQs %x-%x can not be freed", irq, irq + num);
+        return;
+    }
+
+    spapr_irq_range_free_msi(spapr, irq, num);
+
+    /* Clear out the IRQState from the XICS source */
+    for (i =3D irq; i < irq + num; ++i) {
+        if (ics_valid_irq(ics, i)) {
+            uint32_t srcno =3D i - ics->offset;
+            memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
+        }
+    }
+}
+
+static qemu_irq spapr_qirq_xics(sPAPRMachineState *spapr, int irq)
+{
+    return spapr_qirq_legacy(spapr, irq);
+}
+
+static void spapr_irq_print_info_xics(sPAPRMachineState *spapr,
+                                      Monitor *mon)
+{
+    spapr_irq_print_info_legacy(spapr, mon);
+}
+
+/*
+ * XICS IRQ number space
+ *
+ *   RANGES             DEVICES
+ *
+ *   0x0000 - 0x0FFF    Reserved for future use (IPI =3D 2)
+ *
+ *   0x1000 - 0x1000    1 EPOW
+ *   0x1001 - 0x1001    1 HOTPLUG
+ *   0x1002 - 0x10FF    unused
+ *   0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
+ *   0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
+ *   0x1284 - 0x13FF    unused
+ *   0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
+ *   0x1800 - 0x1BFF    PCI MSI device 2
+ *   0x1c00 - 0x1FFF    PCI MSI device 3
+ *
+ *   0x2000    ....     not allocated. Need to increase NR_IRQS
+ */
+static const sPAPRPIrqRange spapr_irq_ranges_xics[] =3D {
+    /* "IPI" Not used */
+    { "EPOW",       SPAPR_IRQ_EPOW,       1,               0      },
+    { "HOTPLUG",    SPAPR_IRQ_HOTPLUG,    1,               0      },
+    { "VIO",        SPAPR_IRQ_VIO,        1,               0xFF   },
+    { "PCI LSI",    SPAPR_IRQ_PCI_LSI,    PCI_NUM_PINS,    0x1F   },
+    { "PCI MSI",    SPAPR_IRQ_PCI_MSI,    0x400,           0x1F   },
+    { NULL,         0,                    0,               0      },
+};
+
+/*
+ * Increase the XICS IRQ number space to 4K. It gives us 3 possible
+ * MSI ranges for the PHBs.
+ */
+
+sPAPRIrq spapr_irq_xics =3D {
+    .nr_irqs     =3D 0x1000,
+    .init        =3D spapr_irq_init_xics,
+    .ranges      =3D spapr_irq_ranges_xics,
+    .assign      =3D spapr_irq_assign_xics,
+    .alloc       =3D spapr_irq_alloc_xics,
+    .alloc_block =3D spapr_irq_alloc_block_xics,
+    .free        =3D spapr_irq_free_xics,
+    .qirq        =3D spapr_qirq_xics,
+    .print_info  =3D spapr_irq_print_info_xics,
+};
+
+/*
  * sPAPR IRQ frontend routines for devices
  */
 int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t =
irq,
--=20
2.13.6
