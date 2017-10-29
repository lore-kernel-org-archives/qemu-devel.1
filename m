Received: from eggs.gnu.org ([2001:4830:134:3::10]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s59-0004zB-Od
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s55-0005xF-AT
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:11 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:39622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s55-0005wx-1J
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:13:07 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0606B637C2
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:13:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:14 +0100
Message-Id: <20171029181217.9927-6-clg@kaod.org>
In-Reply-To: <20171029181217.9927-1-clg@kaod.org>
References: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/8] spapr: introduce an is_lsi() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Now that we can distinguish an LSI interrupt from an MSI using the IRQ
number, let's introduce a new XICSFabric operation for this purpose
and remove the use of XICS_FLAGS_IRQ_LSI flag.

The 'irq' parameter continues to refer to the global IRQ number space.

For compatibility with older machines, we use the machine class flag
'pre_2_11_has_no_bitmap'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 26 +++++++++++++++++---------
 hw/intc/xics_kvm.c    |  4 ++--
 hw/ppc/pnv.c          | 16 ++++++++++++++++
 hw/ppc/spapr.c        | 14 ++++++++++++++
 include/hw/ppc/xics.h |  2 ++
 5 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 2c4899f278e2..42880e736697 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/spapr.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
@@ -70,8 +71,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         }
         monitor_printf(mon, "  %4x %s %02x %02x\n",
                        ics->offset + i,
-                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
-                       "LSI" : "MSI",
+                       ics_is_lsi(ics, i) ? "LSI" : "MSI",
                        irq->priority, irq->status);
     }
 }
@@ -377,6 +377,14 @@ static const TypeInfo icp_info =3D {
 /*
  * ICS: Source layer
  */
+bool ics_is_lsi(ICSState *ics, int srcno)
+{
+    XICSFabric *xi =3D ics->xics;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
+
+    return xic->irq_is_lsi(xi, srcno + ics->offset);
+}
+
 static void ics_simple_resend_msi(ICSState *ics, int srcno)
 {
     ICSIRQState *irq =3D ics->irqs + srcno;
@@ -435,7 +443,7 @@ static void ics_simple_set_irq(void *opaque, int srcn=
o, int val)
 {
     ICSState *ics =3D (ICSState *)opaque;
=20
-    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
+    if (ics_is_lsi(ics, srcno)) {
         ics_simple_set_irq_lsi(ics, srcno, val);
     } else {
         ics_simple_set_irq_msi(ics, srcno, val);
@@ -472,7 +480,7 @@ void ics_simple_write_xive(ICSState *ics, int srcno, =
int server,
     trace_xics_ics_simple_write_xive(ics->offset + srcno, srcno, server,
                                      priority);
=20
-    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
+    if (ics_is_lsi(ics, srcno)) {
         ics_simple_write_xive_lsi(ics, srcno);
     } else {
         ics_simple_write_xive_msi(ics, srcno);
@@ -484,10 +492,10 @@ static void ics_simple_reject(ICSState *ics, uint32=
_t nr)
     ICSIRQState *irq =3D ics->irqs + nr - ics->offset;
=20
     trace_xics_ics_simple_reject(nr, nr - ics->offset);
-    if (irq->flags & XICS_FLAGS_IRQ_MSI) {
-        irq->status |=3D XICS_STATUS_REJECTED;
-    } else if (irq->flags & XICS_FLAGS_IRQ_LSI) {
+    if (ics_is_lsi(ics, nr - ics->offset)) {
         irq->status &=3D ~XICS_STATUS_SENT;
+    } else {
+        irq->status |=3D XICS_STATUS_REJECTED;
     }
 }
=20
@@ -497,7 +505,7 @@ static void ics_simple_resend(ICSState *ics)
=20
     for (i =3D 0; i < ics->nr_irqs; i++) {
         /* FIXME: filter by server#? */
-        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
+        if (ics_is_lsi(ics, i)) {
             ics_simple_resend_lsi(ics, i);
         } else {
             ics_simple_resend_msi(ics, i);
@@ -512,7 +520,7 @@ static void ics_simple_eoi(ICSState *ics, uint32_t nr=
)
=20
     trace_xics_ics_simple_eoi(nr);
=20
-    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
+    if (ics_is_lsi(ics, srcno)) {
         irq->status &=3D ~XICS_STATUS_SENT;
     }
 }
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 3091ad3ac2c8..2f10637c9f7c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -258,7 +258,7 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
             state |=3D KVM_XICS_MASKED;
         }
=20
-        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
+        if (ics_is_lsi(ics, i)) {
             state |=3D KVM_XICS_LEVEL_SENSITIVE;
             if (irq->status & XICS_STATUS_ASSERTED) {
                 state |=3D KVM_XICS_PENDING;
@@ -293,7 +293,7 @@ static void ics_kvm_set_irq(void *opaque, int srcno, =
int val)
     int rc;
=20
     args.irq =3D srcno + ics->offset;
-    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MSI) {
+    if (!ics_is_lsi(ics, srcno)) {
         if (!val) {
             return;
         }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8288940ef9d7..958223376b4c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1035,6 +1035,21 @@ static bool pnv_irq_test(XICSFabric *xi, int irq)
     return false;
 }
=20
+static bool pnv_irq_is_lsi(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    /* PowerNV machine only has PSI interrupts which are all LSIs */
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        ICSState *ics =3D &pnv->chips[i]->psi.ics;
+        if (ics_valid_irq(ics, irq)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
@@ -1120,6 +1135,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
     xic->irq_test =3D pnv_irq_test;
+    xic->irq_is_lsi =3D pnv_irq_is_lsi;
     ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5e42e3329ef4..d97f287118f0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3626,6 +3626,19 @@ static void spapr_irq_free_block(XICSFabric *xi, i=
nt irq, int num)
     bitmap_clear(spapr->irq_map, srcno, num);
 }
=20
+static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    int srcno =3D irq - spapr->irq_base;
+
+    if (smc->pre_2_11_has_no_bitmap) {
+        return spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI;
+    } else {
+        return (srcno >=3D 0) && (srcno < SPAPR_MAX_LSI);
+    }
+}
+
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
@@ -3723,6 +3736,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     xic->irq_test =3D spapr_irq_test;
     xic->irq_alloc_block =3D spapr_irq_alloc_block;
     xic->irq_free_block =3D spapr_irq_free_block;
+    xic->irq_is_lsi =3D spapr_irq_is_lsi;
=20
     ispc->print_info =3D spapr_pic_print_info;
     /* Force NUMA node memory size to be a multiple of
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c8e6637d16e4..292b929e88eb 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -179,6 +179,7 @@ typedef struct XICSFabricClass {
     bool (*irq_test)(XICSFabric *xi, int irq);
     int (*irq_alloc_block)(XICSFabric *xi, int count, int align, bool ls=
i);
     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
+    bool (*irq_is_lsi)(XICSFabric *xi, int irq);
 } XICSFabricClass;
=20
 #define XICS_IRQS_SPAPR               1024
@@ -205,6 +206,7 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
+bool ics_is_lsi(ICSState *ics, int srno);
=20
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
--=20
2.13.6
