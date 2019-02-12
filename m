Received: from eggs.gnu.org ([209.51.188.92]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjg-00014p-IL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcja-0003VL-Rb
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcja-0003BA-7S
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJlqP019040
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qm1rhcsyn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:23 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:20 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:24:13 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154999585315.690774.7586633403635165044.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v4 03/15] spapr_irq: Set LSIs at interrupt
 controller init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

The pseries machine only uses LSIs to support legacy PCI devices. Every
PHB claims 4 LSIs at realize time. When using in-kernel XICS (or upcoming
in-kernel XIVE), QEMU synchronizes the state of all irqs, including these
LSIs, later on at machine reset.

In order to support PHB hotplug, we need a way to tell KVM about the LSIs
that doesn't require a machine reset.

Since recent machine types allocate all these LSIs in a fixed range for
the machine lifetime, identify them when initializing the interrupt
controller, long before they get passed to KVM.

In order to do that, first disintricate interrupt typing and allocation.
Since the vast majority of interrupts are MSIs, make that the default
and have only the LSI users to explicitely set the type.

It is rather straight forward for XIVE. XICS needs some extra care
though: allocation state and type are mixed up in the same bits of the
flags field within the interrupt state. Setting the LSI bit there at
init time would mean the interrupt is de facto allocated, even if no
device asked for it. Introduce a bitmap to track LSIs at the ICS level.
In order to keep the patch minimal, the bitmap is only used when writing
the source state to KVM and when the interrupt is claimed, so that the
code that checks the interrupt type through the flags stays untouched.

With older pseries machine using the XICS legacy IRQ allocation scheme,
all interrupt numbers come from a common pool and there's no such thing
as a fixed range for LSIs. Introduce an helper so that these older
machine types can continue to set the type when allocating the LSI.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    7 +------
 hw/intc/xics.c              |   10 ++++++++--
 hw/intc/xics_kvm.c          |    2 +-
 hw/ppc/pnv_psi.c            |    3 ++-
 hw/ppc/spapr_events.c       |    4 ++--
 hw/ppc/spapr_irq.c          |   42 ++++++++++++++++++++++++++++++++----------
 hw/ppc/spapr_pci.c          |    6 ++++--
 hw/ppc/spapr_vio.c          |    2 +-
 include/hw/ppc/spapr_irq.h  |    5 +++--
 include/hw/ppc/spapr_xive.h |    2 +-
 include/hw/ppc/xics.h       |    4 +++-
 11 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 290a290e43a5..815263ca72ab 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -480,18 +480,13 @@ static void spapr_xive_register_types(void)
 
 type_init(spapr_xive_register_types)
 
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi)
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn)
 {
-    XiveSource *xsrc = &xive->source;
-
     if (lisn >= xive->nr_irqs) {
         return false;
     }
 
     xive->eat[lisn].w |= cpu_to_be64(EAS_VALID);
-    if (lsi) {
-        xive_source_irq_set_lsi(xsrc, lisn);
-    }
     return true;
 }
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 7cac138067e2..26e8940d7329 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -636,6 +636,7 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
         return;
     }
     ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+    ics->lsi_map = bitmap_new(ics->nr_irqs);
 }
 
 static int ics_base_dispatch_pre_save(void *opaque)
@@ -733,12 +734,17 @@ ICPState *xics_icp_get(XICSFabric *xi, int server)
     return xic->icp_get(xi, server);
 }
 
-void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
+void ics_set_lsi(ICSState *ics, int srcno)
+{
+    set_bit(srcno, ics->lsi_map);
+}
+
+void ics_claim_irq(ICSState *ics, int srcno)
 {
     assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
 
     ics->irqs[srcno].flags |=
-        lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
+        test_bit(srcno, ics->lsi_map) ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
 }
 
 static void xics_register_types(void)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index dff13300504c..e63979abc7fc 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -271,7 +271,7 @@ static int ics_set_kvm_state(ICSState *ics, int version_id)
             state |= KVM_XICS_MASKED;
         }
 
-        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
+        if (test_bit(i, ics->lsi_map)) {
             state |= KVM_XICS_LEVEL_SENSITIVE;
             if (irq->status & XICS_STATUS_ASSERTED) {
                 state |= KVM_XICS_PENDING;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 8ced09506321..e6089e1035c0 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -487,7 +487,8 @@ static void pnv_psi_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < ics->nr_irqs; i++) {
-        ics_set_irq_type(ics, i, true);
+        ics_set_lsi(ics, i);
+        ics_claim_irq(ics, i);
     }
 
     psi->qirqs = qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_irqs);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index b9c7ecb9e987..559026d0981c 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -713,7 +713,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
         epow_irq = spapr_irq_findone(spapr, &error_fatal);
     }
 
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, epow_irq, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
 
@@ -737,7 +737,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
             hp_irq = spapr_irq_findone(spapr, &error_fatal);
         }
 
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim(spapr, hp_irq, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
                                      hp_irq);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 8217e0215411..3fc34d7c8a43 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -16,10 +16,13 @@
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
+#include "hw/pci-host/spapr.h"
 #include "sysemu/kvm.h"
 
 #include "trace.h"
 
+#define SPAPR_IRQ_PCI_LSI_NR     (SPAPR_MAX_PHBS * PCI_NUM_PINS)
+
 void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis)
 {
     spapr->irq_map_nr = nr_msis;
@@ -102,6 +105,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
     MachineState *machine = MACHINE(spapr);
     int nr_irqs = spapr->irq->nr_irqs;
     Error *local_err = NULL;
+    int i;
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
@@ -128,6 +132,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
                                       &local_err);
     }
 
+    /* Identify the PCI LSIs */
+    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        for (i = 0; i < SPAPR_IRQ_PCI_LSI_NR; ++i) {
+            ics_set_lsi(spapr->ics,
+                        i + SPAPR_IRQ_PCI_LSI - spapr->irq->xics_offset);
+        }
+    }
+
 error:
     error_propagate(errp, local_err);
 }
@@ -135,7 +147,7 @@ error:
 #define ICS_IRQ_FREE(ics, srcno)   \
     (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
 
-static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
+static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq,
                                 Error **errp)
 {
     ICSState *ics = spapr->ics;
@@ -152,7 +164,7 @@ static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
         return -1;
     }
 
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
+    ics_claim_irq(ics, irq - ics->offset);
     return 0;
 }
 
@@ -296,16 +308,21 @@ static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
 
     /* Enable the CPU IPIs */
     for (i = 0; i < nr_servers; ++i) {
-        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
+        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i);
+    }
+
+    /* Identify the PCI LSIs */
+    for (i = 0; i < SPAPR_IRQ_PCI_LSI_NR; ++i) {
+        xive_source_irq_set_lsi(&spapr->xive->source, SPAPR_IRQ_PCI_LSI + i);
     }
 
     spapr_xive_hcall_init(spapr);
 }
 
-static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, bool lsi,
+static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq,
                                 Error **errp)
 {
-    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
+    if (!spapr_xive_irq_claim(spapr->xive, irq)) {
         error_setg(errp, "IRQ %d is invalid", irq);
         return -1;
     }
@@ -465,19 +482,19 @@ static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
-static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool lsi,
+static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq,
                                 Error **errp)
 {
     Error *local_err = NULL;
     int ret;
 
-    ret = spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
+    ret = spapr_irq_xics.claim(spapr, irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return ret;
     }
 
-    ret = spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
+    ret = spapr_irq_xive.claim(spapr, irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return ret;
@@ -630,9 +647,9 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
                                       spapr->irq->nr_irqs);
 }
 
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp)
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp)
 {
-    return spapr->irq->claim(spapr, irq, lsi, errp);
+    return spapr->irq->claim(spapr, irq, errp);
 }
 
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
@@ -712,6 +729,11 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error **errp)
     return first + ics->offset;
 }
 
+void spapr_irq_set_lsi_legacy(sPAPRMachineState *spapr, int irq)
+{
+    ics_set_lsi(spapr->ics, irq - spapr->irq->xics_offset);
+}
+
 #define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
 
 sPAPRIrq spapr_irq_xics_legacy = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c3fb0ac884b0..d68595531d5a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -391,7 +391,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     }
 
     for (i = 0; i < req_num; i++) {
-        spapr_irq_claim(spapr, irq + i, false, &err);
+        spapr_irq_claim(spapr, irq + i, &err);
         if (err) {
             if (i) {
                 spapr_irq_free(spapr, irq, i);
@@ -1742,9 +1742,11 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                         "can't allocate LSIs: ");
                 return;
             }
+
+            spapr_irq_set_lsi_legacy(spapr, irq);
         }
 
-        spapr_irq_claim(spapr, irq, true, &local_err);
+        spapr_irq_claim(spapr, irq, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
             return;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 2b7e7ecac57f..b1beefc24be5 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -512,7 +512,7 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    spapr_irq_claim(spapr, dev->irq, false, &local_err);
+    spapr_irq_claim(spapr, dev->irq, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5e30858dc22a..0e6c65d55430 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -37,7 +37,7 @@ typedef struct sPAPRIrq {
     uint32_t    xics_offset;
 
     void (*init)(sPAPRMachineState *spapr, Error **errp);
-    int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp);
+    int (*claim)(sPAPRMachineState *spapr, int irq, Error **errp);
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
@@ -56,7 +56,7 @@ extern sPAPRIrq spapr_irq_xive;
 extern sPAPRIrq spapr_irq_dual;
 
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error **errp);
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, Error **errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
@@ -67,5 +67,6 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
  */
 int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error **errp);
 #define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, errp)
+void spapr_irq_set_lsi_legacy(sPAPRMachineState *spapr, int irq);
 
 #endif
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 9bec9192e4a0..885ca169cb29 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -37,7 +37,7 @@ typedef struct sPAPRXive {
     MemoryRegion  tm_mmio;
 } sPAPRXive;
 
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
+bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index fad786e8b22d..18b083fe2aec 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -133,6 +133,7 @@ struct ICSState {
     uint32_t offset;
     ICSIRQState *irqs;
     XICSFabric *xics;
+    unsigned long *lsi_map;
 };
 
 #define ICS_PROP_XICS "xics"
@@ -193,7 +194,8 @@ void ics_simple_write_xive(ICSState *ics, int nr, int server,
 void ics_simple_set_irq(void *opaque, int srcno, int val);
 void ics_kvm_set_irq(void *opaque, int srcno, int val);
 
-void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
+void ics_set_lsi(ICSState *ics, int srcno);
+void ics_claim_irq(ICSState *ics, int srcno);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
 
