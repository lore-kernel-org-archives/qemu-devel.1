Received: from eggs.gnu.org ([2001:4830:134:3::10]:38584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBM-0001bi-Aj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBH-0003MC-7k
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:36 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:51231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBG-0003JS-MM
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:50:31 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.40])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 28891B5995
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:37 +0200
Message-Id: <20180607155003.1580-3-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/28] spapr: introduce a generic IRQ
 frontend to the machine
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

This proposal moves all the related IRQ routines of the sPAPR machine
behind a sPAPR IRQ backend interface 'spapr_irq' to prepare for future
changes in the sPAPR IRQ controller modeling. First of which is a
reorganization of the sPAPR IRQ number space layout and a second,
coming later, will be to integrate the support for the new POWER9 XIVE
IRQ controller.

The new interface defines a set of fixed IRQ number ranges, for each
IRQ type, in which devices allocate the IRQ numbers they need
depending on a unique device index. The layout is :

    SPAPR_IRQ_IPI        0x0        /*  1 IRQ per CPU      */
    SPAPR_IRQ_EPOW       0x1000     /*  1 IRQ per device   */
    SPAPR_IRQ_HOTPLUG    0x1001     /*  1 IRQ per device   */
    SPAPR_IRQ_VIO        0x1100     /*  1 IRQ per device   */
    SPAPR_IRQ_PCI_LSI    0x1200     /*  4 IRQs per device  */
    SPAPR_IRQ_PCI_MSI    0x1400     /* 1K IRQs per device  */

    The IPI range is reserved for future use when XIVE support
    comes in.

The 'spapr_irq' handlers encompass the previous needs and the new ones
and seem complex but the provided sPAPR IRQ backend for XICS should
implement what we have today without any functional changes.

Each device model is modified to take the new interface into account
using the IRQ range/type definitions and a device index. A part from
the VIO devices, lacking an id, the changes are relatively simple.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |  11 +-
 include/hw/ppc/spapr_irq.h |  50 ++++++++
 hw/ppc/spapr.c             | 196 +-----------------------------
 hw/ppc/spapr_events.c      |   8 +-
 hw/ppc/spapr_irq.c         | 291 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_pci.c         |  21 +++-
 hw/ppc/spapr_vio.c         |  17 ++-
 hw/ppc/Makefile.objs       |   2 +-
 8 files changed, 384 insertions(+), 212 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3388750fc795..aba1892f2bd0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -3,10 +3,10 @@
=20
 #include "sysemu/dma.h"
 #include "hw/boards.h"
-#include "hw/ppc/xics.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "hw/ppc/spapr_irq.h"
=20
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
@@ -104,6 +104,7 @@ struct sPAPRMachineClass {
                           unsigned n_dma, uint32_t *liobns, Error **errp=
);
     sPAPRResizeHPT resize_hpt_default;
     sPAPRCapabilities default_caps;
+    sPAPRIrq *irq;
 };
=20
 /**
@@ -772,14 +773,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
=20
-int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
-                    Error **errp);
-int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
-                          bool align, Error **errp);
-void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
-qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
-
-
 int spapr_caps_pre_load(void *opaque);
 int spapr_caps_pre_save(void *opaque);
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
new file mode 100644
index 000000000000..67ec7ff162a6
--- /dev/null
+++ b/include/hw/ppc/spapr_irq.h
@@ -0,0 +1,50 @@
+/*
+ * QEMU PowerPC sPAPR IRQ backend definitions
+ *
+ * Copyright (c) 2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#ifndef HW_SPAPR_IRQ_H
+#define HW_SPAPR_IRQ_H
+
+#include "hw/ppc/xics.h"
+
+/*
+ * IRQ ranges per type
+ */
+#define SPAPR_IRQ_IPI        0x0     /* 1 IRQ per CPU */
+#define SPAPR_IRQ_EPOW       0x1000  /* 1 IRQ per device */
+#define SPAPR_IRQ_HOTPLUG    0x1001  /* 1 IRQ per device */
+#define SPAPR_IRQ_VIO        0x1100  /* 1 IRQ per device */
+#define SPAPR_IRQ_PCI_LSI    0x1200  /* 4 IRQs per device */
+#define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
+                                      * a bitmap allocator */
+typedef struct sPAPRIrq {
+    uint32_t    nr_irqs;
+
+    void (*init)(sPAPRMachineState *spapr, Error **errp);
+    int (*assign)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq=
,
+                  Error **errp);
+    int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t inde=
x,
+                 Error **errp);
+    int (*alloc_block)(sPAPRMachineState *spapr, uint32_t range,
+                       uint32_t index, int num, bool align, Error **errp=
);
+    void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **err=
p);
+    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
+    void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
+} sPAPRIrq;
+
+extern sPAPRIrq spapr_irq_xics;
+
+int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t =
irq,
+                     Error **errp);
+int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
+                    Error **errp);
+int spapr_irq_alloc_block(sPAPRMachineState *spapr, uint32_t range,
+                          uint32_t index, int num, bool align, Error **e=
rrp);
+void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num, Error **=
errp);
+qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
+
+#endif /* HW_SPAPR_IRQ_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2375cbee1208..fd37ca4803eb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -116,33 +116,6 @@ static bool spapr_is_thread0_in_vcore(sPAPRMachineSt=
ate *spapr,
     return spapr_get_vcpu_id(cpu) % spapr->vsmt =3D=3D 0;
 }
=20
-static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
-                                  const char *type_ics,
-                                  int nr_irqs, Error **errp)
-{
-    Error *local_err =3D NULL;
-    Object *obj;
-
-    obj =3D object_new(type_ics);
-    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
-    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
-                                   &error_abort);
-    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
-    if (local_err) {
-        goto error;
-    }
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        goto error;
-    }
-
-    return ICS_SIMPLE(obj);
-
-error:
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
 static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
 {
     /* Dummy entries correspond to unused ICPState objects in older QEMU=
s,
@@ -183,32 +156,6 @@ static int xics_max_server_number(sPAPRMachineState =
*spapr)
     return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
 }
=20
-static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
-{
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
-
-    if (kvm_enabled()) {
-        if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, errp)) {
-            spapr->icp_type =3D TYPE_KVM_ICP;
-            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
-        }
-        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
-            return;
-        }
-    }
-
-    if (!spapr->ics) {
-        xics_spapr_init(spapr);
-        spapr->icp_type =3D TYPE_ICP;
-        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
-        if (!spapr->ics) {
-            return;
-        }
-    }
-}
-
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
                                   int smt_threads)
 {
@@ -2582,7 +2529,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
     /* Set up Interrupt Controller before we create the VCPUs */
-    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
+    smc->irq->init(spapr, &error_fatal);
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
@@ -3768,149 +3715,13 @@ static ICPState *spapr_icp_get(XICSFabric *xi, i=
nt vcpu_id)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
-#define ICS_IRQ_FREE(ics, srcno)   \
-    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
-
-static int ics_find_free_block(ICSState *ics, int num, int alignnum)
-{
-    int first, i;
-
-    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
-        if (num > (ics->nr_irqs - first)) {
-            return -1;
-        }
-        for (i =3D first; i < first + num; ++i) {
-            if (!ICS_IRQ_FREE(ics, i)) {
-                break;
-            }
-        }
-        if (i =3D=3D (first + num)) {
-            return first;
-        }
-    }
-
-    return -1;
-}
-
-/*
- * Allocate the IRQ number and set the IRQ type, LSI or MSI
- */
-static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
-{
-    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
-}
-
-int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
-                    Error **errp)
-{
-    ICSState *ics =3D spapr->ics;
-    int irq;
-
-    assert(ics);
-
-    if (irq_hint) {
-        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
-            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
-            return -1;
-        }
-        irq =3D irq_hint;
-    } else {
-        irq =3D ics_find_free_block(ics, 1, 1);
-        if (irq < 0) {
-            error_setg(errp, "can't allocate IRQ: no IRQ left");
-            return -1;
-        }
-        irq +=3D ics->offset;
-    }
-
-    spapr_irq_set_lsi(spapr, irq, lsi);
-    trace_spapr_irq_alloc(irq);
-
-    return irq;
-}
-
-/*
- * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
- * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
- */
-int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
-                          bool align, Error **errp)
-{
-    ICSState *ics =3D spapr->ics;
-    int i, first =3D -1;
-
-    assert(ics);
-
-    /*
-     * MSIMesage::data is used for storing VIRQ so
-     * it has to be aligned to num to support multiple
-     * MSI vectors. MSI-X is not affected by this.
-     * The hint is used for the first IRQ, the rest should
-     * be allocated continuously.
-     */
-    if (align) {
-        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
-               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D ics_find_free_block(ics, num, num);
-    } else {
-        first =3D ics_find_free_block(ics, num, 1);
-    }
-    if (first < 0) {
-        error_setg(errp, "can't find a free %d-IRQ block", num);
-        return -1;
-    }
-
-    first +=3D ics->offset;
-    for (i =3D first; i < first + num; ++i) {
-        spapr_irq_set_lsi(spapr, i, lsi);
-    }
-
-    trace_spapr_irq_alloc_block(first, num, lsi, align);
-
-    return first;
-}
-
-void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
-{
-    ICSState *ics =3D spapr->ics;
-    int srcno =3D irq - ics->offset;
-    int i;
-
-    if (ics_valid_irq(ics, irq)) {
-        trace_spapr_irq_free(0, irq, num);
-        for (i =3D srcno; i < srcno + num; ++i) {
-            if (ICS_IRQ_FREE(ics, i)) {
-                trace_spapr_irq_free_warn(0, i + ics->offset);
-            }
-            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
-        }
-    }
-}
-
-qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
-{
-    ICSState *ics =3D spapr->ics;
-
-    if (ics_valid_irq(ics, irq)) {
-        return ics->qirqs[irq - ics->offset];
-    }
-
-    return NULL;
-}
-
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-        icp_pic_print_info(ICP(cpu->intc), mon);
-    }
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
-    ics_pic_print_info(spapr->ics, mon);
+    smc->irq->print_info(spapr, mon);
 }
=20
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
@@ -4019,6 +3830,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
+    smc->irq =3D &spapr_irq_xics;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 86836f0626dc..f131b8c6fd1b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -712,8 +712,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
     spapr->event_sources =3D spapr_event_sources_new();
=20
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 spapr_irq_alloc(spapr, 0, false,
-                                                  &error_fatal));
+                                 spapr_irq_alloc(spapr, SPAPR_IRQ_EPOW,
+                                                 0, &error_fatal));
=20
     /* NOTE: if machine supports modern/dedicated hotplug event source,
      * we add it to the device-tree unconditionally. This means we may
@@ -725,8 +725,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
      */
     if (spapr->use_hotplug_event_source) {
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
-                                     spapr_irq_alloc(spapr, 0, false,
-                                                      &error_fatal));
+                                     spapr_irq_alloc(spapr, SPAPR_IRQ_HO=
TPLUG,
+                                                     0, &error_fatal));
     }
=20
     spapr->epow_notifier.notify =3D spapr_powerdown_req;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
new file mode 100644
index 000000000000..1efccf590899
--- /dev/null
+++ b/hw/ppc/spapr_irq.c
@@ -0,0 +1,291 @@
+/*
+ * QEMU PowerPC sPAPR IRQ interface
+ *
+ * Copyright (c) 2018, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/pci/pci.h"
+#include "hw/ppc/spapr.h"
+#include "sysemu/kvm.h"
+#include "trace.h"
+
+/*
+ * Legacy XICS IRQ backend.
+ *
+ * The device IRQ 'range' is used to identify LSIs, and the device
+ * 'index' is unused
+ */
+static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
+                                  const char *type_ics,
+                                  int nr_irqs, Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(type_ics);
+    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
+    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
+                                   &error_abort);
+    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
+    if (local_err) {
+        goto error;
+    }
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    return ICS_SIMPLE(obj);
+
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+static void spapr_irq_init_legacy(sPAPRMachineState *spapr, Error **errp=
)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    uint32_t nr_irqs =3D smc->irq->nr_irqs;
+
+    if (kvm_enabled()) {
+        if (machine_kernel_irqchip_allowed(machine) &&
+            !xics_kvm_init(spapr, errp)) {
+            spapr->icp_type =3D TYPE_KVM_ICP;
+            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
+        }
+        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
+            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
+            return;
+        }
+    }
+
+    if (!spapr->ics) {
+        xics_spapr_init(spapr);
+        spapr->icp_type =3D TYPE_ICP;
+        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
+        if (!spapr->ics) {
+            return;
+        }
+    }
+}
+
+#define ICS_IRQ_FREE(ics, srcno)                                \
+    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
+
+static int ics_find_free_block(ICSState *ics, int num, int alignnum)
+{
+    int first, i;
+
+    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
+        if (num > (ics->nr_irqs - first)) {
+            return -1;
+        }
+        for (i =3D first; i < first + num; ++i) {
+            if (!ICS_IRQ_FREE(ics, i)) {
+                break;
+            }
+        }
+        if (i =3D=3D (first + num)) {
+            return first;
+        }
+    }
+
+    return -1;
+}
+
+/*
+ * The 'irq' assignment is only used by the sPAPR VIO devices and it
+ * has been deprecated in QEMU 3.0. This handler should be removed
+ * soon.
+ */
+static int spapr_irq_assign_legacy(sPAPRMachineState *spapr, uint32_t ra=
nge,
+                                   uint32_t irq, Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+
+    assert(ics);
+    assert(range =3D=3D SPAPR_IRQ_VIO);
+
+    if (!ics_valid_irq(ics, irq)) {
+        error_setg(errp, "IRQ hint %d is invalid", irq);
+        return -1;
+    }
+
+    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
+        error_setg(errp, "can't allocate IRQ %d: already in use",
+                   irq);
+        return -1;
+    }
+
+    ics_set_irq_type(ics, irq - ics->offset, false);
+    trace_spapr_irq_alloc(irq);
+
+    return irq;
+}
+
+static int spapr_irq_alloc_legacy(sPAPRMachineState *spapr, uint32_t ran=
ge,
+                                  uint32_t index, Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int srcno;
+
+    assert(ics);
+
+    srcno =3D ics_find_free_block(ics, 1, 1);
+    if (srcno < 0) {
+        error_setg(errp, "can't allocate IRQ: no IRQ left");
+        return -1;
+    }
+
+    ics_set_irq_type(ics, srcno, lsi);
+    trace_spapr_irq_alloc(srcno);
+
+    return srcno + ics->offset;
+}
+
+/*
+ * Allocate block of consecutive IRQs, and return the number of the
+ * first IRQ in the block. If align=3D=3Dtrue, aligns the first IRQ numb=
er
+ * to num.
+ */
+static int spapr_irq_alloc_block_legacy(sPAPRMachineState *spapr,
+                                        uint32_t range, uint32_t index, =
int num,
+                                        bool align, Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
+    int i, srcno;
+
+    assert(ics);
+
+    /*
+     * MSIMessage::data is used for storing VIRQ so it has to be
+     * aligned to num to support multiple MSI vectors. MSI-X is not
+     * affected by this.
+     */
+    if (align) {
+        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
+               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
+        srcno =3D ics_find_free_block(ics, num, num);
+    } else {
+        srcno =3D ics_find_free_block(ics, num, 1);
+    }
+
+    if (srcno < 0) {
+        error_setg(errp, "can't find a free %d-IRQ block", num);
+        return -1;
+    }
+
+    for (i =3D srcno; i < srcno + num; ++i) {
+        ics_set_irq_type(ics, i, lsi);
+    }
+
+    trace_spapr_irq_alloc_block(srcno, num, lsi, align);
+
+    return ics->offset + srcno;
+}
+
+static void spapr_irq_free_legacy(sPAPRMachineState *spapr, int irq, int=
 num,
+                                Error **errp)
+{
+    ICSState *ics =3D spapr->ics;
+    uint32_t srcno =3D irq - ics->offset;
+    int i;
+
+    if (ics_valid_irq(ics, irq)) {
+        trace_spapr_irq_free(0, irq, num);
+        for (i =3D srcno; i < srcno + num; ++i) {
+            if (ICS_IRQ_FREE(ics, i)) {
+                trace_spapr_irq_free_warn(0, i);
+            }
+            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
+        }
+    }
+}
+
+static qemu_irq spapr_qirq_legacy(sPAPRMachineState *spapr, int irq)
+{
+    ICSState *ics =3D spapr->ics;
+    uint32_t srcno =3D irq - ics->offset;
+
+    if (ics_valid_irq(ics, irq)) {
+        return ics->qirqs[srcno];
+    }
+
+    return NULL;
+}
+
+static void spapr_irq_print_info_legacy(sPAPRMachineState *spapr,
+                                      Monitor *mon)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        icp_pic_print_info(ICP(cpu->intc), mon);
+    }
+
+    ics_pic_print_info(spapr->ics, mon);
+}
+
+sPAPRIrq spapr_irq_xics =3D {
+    .nr_irqs     =3D XICS_IRQS_SPAPR,
+    .init        =3D spapr_irq_init_legacy,
+    .assign      =3D spapr_irq_assign_legacy,
+    .alloc       =3D spapr_irq_alloc_legacy,
+    .alloc_block =3D spapr_irq_alloc_block_legacy,
+    .free        =3D spapr_irq_free_legacy,
+    .qirq        =3D spapr_qirq_legacy,
+    .print_info  =3D spapr_irq_print_info_legacy,
+};
+
+/*
+ * sPAPR IRQ frontend routines for devices
+ */
+int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t =
irq,
+                     Error **errp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    return smc->irq->assign(spapr, range, irq, errp);
+}
+
+int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
+                    Error **errp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    return smc->irq->alloc(spapr, range, index, errp);
+}
+
+int spapr_irq_alloc_block(sPAPRMachineState *spapr, uint32_t range,
+                          uint32_t index, int num, bool align, Error **e=
rrp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    return smc->irq->alloc_block(spapr, range, index, num, align, errp);
+}
+
+void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num,
+                    Error **errp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    smc->irq->free(spapr, irq, num, errp);
+}
+
+qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    return smc->irq->qirq(spapr, irq);
+}
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 4fd97ffe4c6e..cca4169fa10b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -333,7 +333,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
             return;
         }
=20
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
+        spapr_irq_free(spapr, msi->first_irq, msi->num, &err);
+        if (err) {
+            error_reportf_err(err, "Can't remove MSIs for device %x: ",
+                              config_addr);
+            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        }
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
         }
@@ -371,8 +376,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
-                           ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
+    irq =3D spapr_irq_alloc_block(spapr, SPAPR_IRQ_PCI_MSI, phb->index, =
req_num,
+                                ret_intr_type =3D=3D RTAS_TYPE_MSI, &err=
);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -382,7 +387,11 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
+        spapr_irq_free(spapr, msi->first_irq, msi->num, &err);
+        if (err) {
+            error_reportf_err(err, "Can't remove MSIs for device %x: ",
+                              config_addr);
+        }
         g_hash_table_remove(phb->msi, &config_addr);
     }
=20
@@ -1696,7 +1705,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
=20
     /* Initialize the LSI table */
-    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false, &loc=
al_err);
+    irq =3D spapr_irq_alloc_block(spapr, SPAPR_IRQ_PCI_LSI, sphb->index,
+                                PCI_NUM_PINS, false, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         error_prepend(errp, "can't allocate LSIs: ");
@@ -2112,6 +2122,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
+    /* TODO: fix the total count of allocatable MSIs per PHB */
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
=20
     /* Dynamic DMA window */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 28bb3b849b9b..d19b28142a13 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -433,6 +433,9 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
     }
 }
=20
+/* TODO : poor VIO device indexing ... */
+static uint32_t vio_index;
+
 static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
@@ -472,7 +475,19 @@ static void spapr_vio_busdev_realize(DeviceState *qd=
ev, Error **errp)
         dev->qdev.id =3D id;
     }
=20
-    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
+    /*
+     * The "irq" property has been deprecated. IRQ assignment is soon
+     * to be removed
+     */
+    if (dev->irq) {
+        spapr_irq_assign(spapr, SPAPR_IRQ_VIO, dev->irq, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    dev->irq =3D spapr_irq_alloc(spapr, SPAPR_IRQ_VIO, vio_index++,  &lo=
cal_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 86d82a6ec3ac..4fe3b7804d43 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
-obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
+obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
--=20
2.13.6
