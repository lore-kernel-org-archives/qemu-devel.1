Received: from eggs.gnu.org ([2001:4830:134:3::10]:56778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUo-0004sg-SF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUl-0008RO-NP
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:46 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:53270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fJiUl-0008PY-DK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:43 -0400
Received: from player774.ha.ovh.net (unknown [10.109.122.111])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8E4CCC3B71
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:44:39 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 18 May 2018 18:44:05 +0200
Message-Id: <20180518164405.11804-5-clg@kaod.org>
In-Reply-To: <20180518164405.11804-1-clg@kaod.org>
References: <20180518164405.11804-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] spapr: introduce a new IRQ backend using
 fixed IRQ number ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
   0x1800 - 0x1BFF    PCI MSI device 1
   0x1c00 - 0x1FFF    PCI MSI device 2

   0x2000    ....     not allocated. Need to increase NR_IRQS

The MSI range is a bit more complex to handle as the IRQS are dynamically
allocated by the guest OS. In consequence, we use a bitmap allocator
under the machine for these.

The XICS IRQ number space is increased to 4K, which gives three MSI
ranges of 1K for the PHBs. The XICS source IRQ numbers still have the
4K offset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |   2 +
 include/hw/ppc/spapr_irq.h |  12 +++
 hw/ppc/spapr.c             |  22 +++++
 hw/ppc/spapr_irq.c         | 220 +++++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4eb212b16a51..fcc1b1c1451d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -165,6 +165,8 @@ struct sPAPRMachineState {
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
=20
+    int32_t nr_irqs;
+    unsigned long *irq_map;
     const char *icp_type;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index caf4c33d4cec..d1af4c4d11ba 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -22,8 +22,16 @@
 #define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
                                       * a bitmap allocator */
=20
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
     int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t inde=
x,
@@ -35,6 +43,10 @@ typedef struct sPAPRIrq {
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_default;
+extern sPAPRIrq spapr_irq_2_12;
+
+const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
+                                          uint32_t offset);
=20
 int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
                     Error **errp);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 09f095d73eae..f2ebd6f20414 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1848,6 +1848,24 @@ static const VMStateDescription vmstate_spapr_patb=
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
@@ -1875,6 +1893,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
+        &vmstate_spapr_irq_map,
         NULL
     }
 };
@@ -3916,7 +3935,10 @@ static void spapr_machine_2_12_instance_options(Ma=
chineState *machine)
=20
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_13_class_options(mc);
+    smc->irq =3D &spapr_irq_2_12;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index ff6cb1aafd25..bfffb1467336 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -192,7 +192,7 @@ static qemu_irq spapr_qirq_2_12(sPAPRMachineState *sp=
apr, int irq)
     return NULL;
 }
=20
-sPAPRIrq spapr_irq_default =3D {
+sPAPRIrq spapr_irq_2_12 =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
     .init        =3D spapr_irq_init_2_12,
     .alloc       =3D spapr_irq_alloc_2_12,
@@ -201,6 +201,224 @@ sPAPRIrq spapr_irq_default =3D {
     .qirq        =3D spapr_qirq_2_12,
 };
=20
+/*
+ * IRQ range helpers for new IRQ backends
+ */
+const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
+                                          uint32_t offset)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    const sPAPRPIrqRange *range =3D smc->irq->ranges;
+
+    if (range) {
+        while (range->name && range->offset !=3D offset) {
+            range++;
+        }
+
+        if (!range->name) {
+            return NULL;
+        }
+    }
+
+    return range;
+}
+
+static int spapr_irq_get_base(sPAPRMachineState *spapr, uint32_t offset,
+                              uint32_t index, Error **errp)
+{
+    const sPAPRPIrqRange *range =3D spapr_irq_get_range(spapr, offset);
+
+    if (!range) {
+        error_setg(errp, "Invalid IRQ range %x", offset);
+        return -1;
+    }
+
+    if (index > range->max_index) {
+        error_setg(errp, "Index %d too big for IRQ range %s", index,
+                   range->name);
+        return -1;
+    }
+
+    return range->offset + index * range->width;
+}
+
+static int spapr_irq_range_alloc(sPAPRMachineState *spapr,
+                                 uint32_t range, uint32_t index, Error *=
*errp)
+{
+    return spapr_irq_get_base(spapr, range, index, errp);
+}
+
+static int spapr_irq_range_alloc_msi(sPAPRMachineState *spapr, uint32_t =
range,
+                                     uint32_t index, int num, bool align=
,
+                                     Error **errp)
+{
+    int msi_base =3D spapr_irq_get_base(spapr, SPAPR_IRQ_PCI_MSI, index,=
 errp);
+    int irq;
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
+static void spapr_irq_init_2_13(sPAPRMachineState *spapr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+
+    spapr_irq_init_2_12(spapr, errp);
+
+    /*
+     * Initialize the MSI IRQ allocator. The full XICS IRQ number
+     * space is covered even though the bottow IRQ numbers below the
+     * XICS source number offset (4K) are unused and that only MSI IRQ
+     * numbers can be allocated. We does waste some bytes but it makes
+     * things easier. We will optimize later.
+     */
+    spapr->nr_irqs  =3D smc->irq->nr_irqs + spapr->ics->offset;
+    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+}
+
+static int spapr_irq_alloc_2_13(sPAPRMachineState *spapr,
+                                uint32_t range, uint32_t index, Error **=
errp)
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
+static int spapr_irq_alloc_block_2_13(sPAPRMachineState *spapr, uint32_t=
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
+static void spapr_irq_free_2_13(sPAPRMachineState *spapr, int irq, int n=
um,
+                                Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    int msi_base =3D spapr_irq_get_base(spapr, SPAPR_IRQ_PCI_MSI, 0, NUL=
L);
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
+static qemu_irq spapr_qirq_2_13(sPAPRMachineState *spapr, int irq)
+{
+    return spapr_qirq_2_12(spapr, irq);
+}
+
+/*
+ *   RANGES             DEVICES
+ *
+ *   0x0000 - 0x0FFF    Reserved (IPI =3D 2)
+ *
+ *   0x1000 - 0x1000    1 EPOW
+ *   0x1001 - 0x1001    1 HOTPLUG
+ *   0x1002 - 0x10FF    unused
+ *   0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
+ *   0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
+ *   0x1284 - 0x13FF    unused
+ *   0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
+ *   0x1800 - 0x1BFF    PCI MSI device 1
+ *   0x1c00 - 0x1FFF    PCI MSI device 2
+ *   0x2000    ....     not allocated. Need to increase NR_IRQS
+ */
+static const sPAPRPIrqRange spapr_irq_ranges_2_13[] =3D {
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
+ * MSI ranges for the PHBs. The XICS Source IRQ numbers still have the
+ * 4K offset.
+ */
+#define SPAPR_NR_IRQS_2_13    0x1000
+
+sPAPRIrq spapr_irq_default =3D {
+    .nr_irqs     =3D SPAPR_NR_IRQS_2_13,
+    .init        =3D spapr_irq_init_2_13,
+    .ranges      =3D spapr_irq_ranges_2_13,
+    .alloc       =3D spapr_irq_alloc_2_13,
+    .alloc_block =3D spapr_irq_alloc_block_2_13,
+    .free        =3D spapr_irq_free_2_13,
+    .qirq        =3D spapr_qirq_2_13,
+};
+
 int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
                     Error **errp)
 {
--=20
2.13.6
