Received: from eggs.gnu.org ([209.51.188.92]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFu-00026t-Nf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFs-0007T2-6z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBFr-0007RO-Mj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:15:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHEQjN000714
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2tuuhj95-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:57 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:14:53 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:14:46 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774528595.1208625.15523908858345133758.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 03/19] xics: Disintricate allocation and
 type setting of interrupts
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

The current code assumes that an interrupt is allocated as soon as its
type is set to MSI or LSI. PHB hotplug will require to be able to set
the type of an interrupt before actually allocating it.

Disintricate type setting from allocation by using another flag bit for
the latter. Introduce a new ics_claim_irq() function for allocation. The
behavior of aborting if the same irq gets allocated twice is kept.

ics_set_irq_type() now only sets the type to MSI or LSI. It doesn't bring
anything to abort if the type was already set before. Drop the assert
and XICS_FLAGS_IRQ_MASK on the way.

Older QEMUs don't know about XICS_FLAGS_IRQ_CLAIMED. In order to safely
handle incoming migration, we must fix the irq flags. This is done at
post load thanks to a compat property. We don't need to do anything for
backward migration since older machines only care for the irq type.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/core/machine.c     |    4 ++++
 hw/intc/xics.c        |   28 +++++++++++++++++++++++++---
 hw/ppc/pnv_psi.c      |    1 +
 hw/ppc/spapr_irq.c    |    4 +---
 include/hw/ppc/xics.h |    8 ++++++--
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1a0a9ab1117a..536a34092367 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -25,6 +25,10 @@
 
 GlobalProperty hw_compat_3_1[] = {
     {
+        .driver   = "ics-base",
+        .property = "has-claimed-flag",
+        .value    = "off",
+    },{
         .driver   = "pcie-root-port",
         .property = "x-speed",
         .value    = "2_5",
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 16e8ffa2aaf7..82cf04548907 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -75,7 +75,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
     for (i = 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq = ics->irqs + i;
 
-        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
+        if (!(irq->flags & XICS_FLAGS_IRQ_CLAIMED)) {
             continue;
         }
         monitor_printf(mon, "  %4x %s %02x %02x\n",
@@ -662,6 +662,22 @@ static int ics_base_dispatch_post_load(void *opaque, int version_id)
     ICSState *ics = opaque;
     ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
 
+    if (!ics->has_claimed_flag) {
+        int i;
+
+        for (i = 0; i < ics->nr_irqs; i++) {
+            ICSIRQState *irq = ics->irqs + i;
+
+            /*
+             * For older machines, allocating the irq and setting its type is
+             * the same thing.
+             */
+            if (irq->flags & (XICS_FLAGS_IRQ_LSI| XICS_FLAGS_IRQ_MSI)) {
+                irq->flags |= XICS_FLAGS_IRQ_CLAIMED;
+            }
+        }
+    }
+
     if (info->post_load) {
         return info->post_load(ics, version_id);
     }
@@ -702,6 +718,7 @@ static const VMStateDescription vmstate_ics_base = {
 
 static Property ics_base_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
+    DEFINE_PROP_BOOL("has-claimed-flag", ICSState, has_claimed_flag, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -741,10 +758,15 @@ ICPState *xics_icp_get(XICSFabric *xi, int server)
     return xic->icp_get(xi, server);
 }
 
-void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
+void ics_claim_irq(ICSState *ics, int srcno)
 {
-    assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
+    assert(ICS_IRQ_FREE(ics, srcno));
+
+    ics->irqs[srcno].flags |= XICS_FLAGS_IRQ_CLAIMED;
+}
 
+void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
+{
     ics->irqs[srcno].flags |=
         lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
 }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 8ced09506321..ced34e1119dc 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -488,6 +488,7 @@ static void pnv_psi_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < ics->nr_irqs; i++) {
         ics_set_irq_type(ics, i, true);
+        ics_claim_irq(ics, i);
     }
 
     psi->qirqs = qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_irqs);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1da7a32348fc..86c712d15382 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -125,9 +125,6 @@ error:
     error_propagate(errp, local_err);
 }
 
-#define ICS_IRQ_FREE(ics, srcno)   \
-    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
-
 static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
                                 Error **errp)
 {
@@ -146,6 +143,7 @@ static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool lsi,
     }
 
     ics_set_irq_type(ics, irq - ics->offset, lsi);
+    ics_claim_irq(ics, irq - ics->offset);
     return 0;
 }
 
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index fad786e8b22d..e3be5cc663c5 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -131,6 +131,7 @@ struct ICSState {
     /*< public >*/
     uint32_t nr_irqs;
     uint32_t offset;
+    bool has_claimed_flag;
     ICSIRQState *irqs;
     XICSFabric *xics;
 };
@@ -153,13 +154,15 @@ struct ICSIRQState {
 #define XICS_STATUS_PRESENTED          0x10
 #define XICS_STATUS_QUEUED             0x20
     uint8_t status;
-/* (flags & XICS_FLAGS_IRQ_MASK) == 0 means the interrupt is not allocated */
 #define XICS_FLAGS_IRQ_LSI             0x1
 #define XICS_FLAGS_IRQ_MSI             0x2
-#define XICS_FLAGS_IRQ_MASK            0x3
+#define XICS_FLAGS_IRQ_CLAIMED         0x4
     uint8_t flags;
 };
 
+#define ICS_IRQ_FREE(ics, srcno)   \
+    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_CLAIMED)))
+
 struct XICSFabric {
     Object parent;
 };
@@ -193,6 +196,7 @@ void ics_simple_write_xive(ICSState *ics, int nr, int server,
 void ics_simple_set_irq(void *opaque, int srcno, int val);
 void ics_kvm_set_irq(void *opaque, int srcno, int val);
 
+void ics_claim_irq(ICSState *ics, int srcno);
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
