Received: from eggs.gnu.org ([2001:4830:134:3::10]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCY-0002dD-6m
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCT-00046o-EX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:50 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:33182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCT-000469-3w
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:45 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.5])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A19BD1BC63F
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:43 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:51 +0200
Message-Id: <20180607155003.1580-17-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/28] spapr: introdude a new machine IRQ
 backend for XIVE
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

The XIVE IRQ backend uses the same layout as the new XICS backend but
covers the full range of the IRQ number space. The IRQ numbers for the
CPU IPIs are allocated at the bottom of this space, below 4K, to
preserve compatibility with XICS which does not use that range.

This should be enough given that the maximum number of CPUs is 1024
for the sPAPR machine under QEMU. For the record, the biggest POWER8
or POWER9 system has a maximum of 1536 HW threads (16 sockets, 192
cores, SMT8).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |   2 +
 include/hw/ppc/spapr_irq.h |   3 +-
 hw/ppc/spapr.c             |   3 +-
 hw/ppc/spapr_irq.c         | 212 +++++++++++++++++++++++++++++++++++++++=
+++++-
 4 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd256fbc9158..fd0e32c4b32c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -14,6 +14,7 @@ struct sPAPRNVRAM;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
+typedef struct sPAPRXive sPAPRXive;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -167,6 +168,7 @@ struct sPAPRMachineState {
     int32_t nr_irqs;
     unsigned long *irq_map;
     const char *icp_type;
+    sPAPRXive  *xive;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index dd9c4038d5b6..aa41c487b705 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -32,7 +32,7 @@ typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
     const sPAPRPIrqRange *ranges;
=20
-    void (*init)(sPAPRMachineState *spapr, Error **errp);
+    void (*init)(sPAPRMachineState *spapr, uint32_t nr_servers, Error **=
errp);
     int (*assign)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq=
,
                   Error **errp);
     int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t inde=
x,
@@ -46,6 +46,7 @@ typedef struct sPAPRIrq {
=20
 extern sPAPRIrq spapr_irq_legacy;
 extern sPAPRIrq spapr_irq_xics;
+extern sPAPRIrq spapr_irq_xive;
=20
 const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
                                           uint32_t offset);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ae915a3b4803..156feff6e3fa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -55,6 +55,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/spapr_xive.h"
 #include "hw/pci/msi.h"
=20
 #include "hw/pci/pci.h"
@@ -2548,7 +2549,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
     /* Set up Interrupt Controller before we create the VCPUs */
-    smc->irq->init(spapr, &error_fatal);
+    smc->irq->init(spapr, xics_max_server_number(spapr), &error_fatal);
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 6bd3dd7e01d7..b5c3e7b197b6 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -9,9 +9,11 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_xive.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
=20
@@ -48,7 +50,8 @@ error:
     return NULL;
 }
=20
-static void spapr_irq_init_legacy(sPAPRMachineState *spapr, Error **errp=
)
+static void spapr_irq_init_legacy(sPAPRMachineState *spapr, uint32_t nr_=
servers,
+                                  Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
@@ -340,12 +343,13 @@ static void spapr_irq_range_free_msi(sPAPRMachineSt=
ate *spapr, int irq, int num)
  *
  * using the IRQ ranges and device indexes
  */
-static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_init_xics(sPAPRMachineState *spapr, uint32_t nr_se=
rvers,
+                                Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
=20
-    spapr_irq_init_legacy(spapr, errp);
+    spapr_irq_init_legacy(spapr, nr_servers, errp);
=20
     /*
      * Initialize the MSI IRQ allocator. The full XICS IRQ number
@@ -500,6 +504,208 @@ sPAPRIrq spapr_irq_xics =3D {
 };
=20
 /*
+ * XIVE IRQ backend.
+ */
+static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr,
+                                    const char *type_xive, int nr_irqs,
+                                    int nr_servers, Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+    uint32_t nr_eqs =3D nr_servers << 3; /* 8 priority EQs per CPU */
+
+    obj =3D object_new(type_xive);
+    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
+    if (local_err) {
+        goto error;
+    }
+    object_property_set_int(obj, nr_eqs, "nr-eqs", &local_err);
+    if (local_err) {
+        goto error;
+    }
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+    return SPAPR_XIVE(obj);
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+static void spapr_irq_init_xive(sPAPRMachineState *spapr, uint32_t nr_se=
rvers,
+                                Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    int i;
+
+    /* We don't have KVM support yet, so check for irqchip=3Don */
+    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+        error_report("kernel_irqchip requested. no XIVE support");
+        exit(1);
+    }
+
+    spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE, smc->irq->=
nr_irqs,
+                                    nr_servers, errp);
+    if (!spapr->xive) {
+        return;
+    }
+
+    /*
+     * Initialize the IRQ allocator.
+     */
+    spapr->nr_irqs  =3D smc->irq->nr_irqs;
+    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
+
+    /* Allocate the CPU IPIs */
+    for (i =3D 0; i < nr_servers; ++i) {
+        spapr_irq_alloc(spapr, SPAPR_IRQ_IPI, i, errp);
+    }
+}
+
+/*
+ * The 'irq' assignment is only used by the sPAPR VIO devices and it
+ * has been deprecated in QEMU 3.0. This handler should be removed
+ * soon.
+ */
+static int spapr_irq_assign_xive(sPAPRMachineState *spapr, uint32_t rang=
e,
+                                 uint32_t irq, Error **errp)
+{
+    assert(range =3D=3D SPAPR_IRQ_VIO);
+
+    error_setg(errp, "IRQ assignment is not available on the XIVE "
+               " IRQ backend");
+    return -1;
+}
+
+static int spapr_irq_alloc_xive(sPAPRMachineState *spapr, uint32_t range=
,
+                                uint32_t index, Error **errp)
+{
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int irq =3D spapr_irq_range_base(spapr, range, index, errp);
+
+    if (irq < 0) {
+        return irq;
+    }
+
+    /* Enable the IRQ at the XIVE level */
+    spapr_xive_irq_enable(spapr->xive, irq, lsi);
+    return irq;
+}
+
+static int spapr_irq_alloc_block_xive(sPAPRMachineState *spapr, uint32_t=
 range,
+                                      uint32_t index, int num, bool alig=
n,
+                                      Error **errp)
+{
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int irq;
+    int i;
+
+    if (range =3D=3D SPAPR_IRQ_PCI_MSI) {
+        irq =3D spapr_irq_range_alloc_msi(spapr, range, index, num, alig=
n, errp);
+    } else {
+        /* TODO: check range width vs. num */
+        irq =3D spapr_irq_range_alloc(spapr, range, index, errp);
+    }
+
+    if (irq < 0) {
+        return irq;
+    }
+
+    /* Enable the IRQ at the XIVE level */
+    for (i =3D irq; i < irq + num; ++i) {
+        spapr_xive_irq_enable(spapr->xive, i, lsi);
+    }
+
+    return irq;
+}
+
+static void spapr_irq_free_xive(sPAPRMachineState *spapr, int irq, int n=
um,
+                                Error **errp)
+{
+    int msi_base =3D spapr_irq_range_base(spapr, SPAPR_IRQ_PCI_MSI, 0, N=
ULL);
+
+    /* Any IRQ below MSI base should not be freed */
+    if (irq < msi_base) {
+        error_setg(errp, "IRQs %x-%x can not be freed", irq, irq + num);
+        return;
+    }
+
+    spapr_irq_range_free_msi(spapr, irq, num);
+    spapr_xive_irq_disable(spapr->xive, irq);
+}
+
+static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
+{
+    return spapr_xive_qirq(spapr->xive, irq);
+}
+
+static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,
+                                           Monitor *mon)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+       xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
+    }
+
+    spapr_xive_pic_print_info(spapr->xive, mon);
+}
+
+/*
+ * XIVE IRQ number space
+ *
+ * The bottom 4K IRQ numbers are now used to allocate the CPU IPIs in XI=
VE.
+ *
+ *   RANGES             DEVICES
+ *
+ *   0x0000 - 0x0FFF    4K IPIs (max vCPUs =3D 4096)
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
+static const sPAPRPIrqRange spapr_irq_ranges_xive[] =3D {
+    { "IPI",        SPAPR_IRQ_IPI ,       1,               0x1000 },
+    { "EPOW",       SPAPR_IRQ_EPOW,       1,               0      },
+    { "HOTPLUG",    SPAPR_IRQ_HOTPLUG,    1,               0      },
+    { "VIO",        SPAPR_IRQ_VIO,        1,               0xFF   },
+    { "PCI LSI",    SPAPR_IRQ_PCI_LSI,    PCI_NUM_PINS,    0x1F   },
+    { "PCI MSI",    SPAPR_IRQ_PCI_MSI,    0x400,           0x1F   },
+    { NULL,         0,                    0,               0      },
+ };
+
+/*
+ * XIVE uses the full IRQ number space. Set it to 8K to be compatible
+ * with XICS.
+ */
+
+sPAPRIrq spapr_irq_xive =3D {
+    .nr_irqs     =3D 0x2000,
+    .init        =3D spapr_irq_init_xive,
+    .ranges      =3D spapr_irq_ranges_xive,
+    .assign      =3D spapr_irq_assign_xive,
+    .alloc       =3D spapr_irq_alloc_xive,
+    .alloc_block =3D spapr_irq_alloc_block_xive,
+    .free        =3D spapr_irq_free_xive,
+    .qirq        =3D spapr_qirq_xive,
+    .print_info  =3D spapr_irq_print_info_xive,
+};
+
+/*
  * sPAPR IRQ frontend routines for devices
  */
 int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t =
irq,
--=20
2.13.6
