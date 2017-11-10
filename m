Received: from eggs.gnu.org ([2001:4830:134:3::10]:47669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB78-0007gh-4C
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB76-0005rj-FF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:02 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:59345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eDB76-0005p6-5q
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:21:00 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1DF379C36A
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:20:59 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Nov 2017 15:20:10 +0000
Message-Id: <20171110152017.24324-5-clg@kaod.org>
In-Reply-To: <20171110152017.24324-1-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 04/11] spapr: move current IRQ
 allocation under the machine
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

Use the new XICSFabric operations to handle the IRQ number allocation
directly under the machine. These changes only move code and adapt it
to take into account the new API which uses IRQ numbers.

On PowerNV, only provide a basic irq_test() operation. For the moment,
there is no need for more.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/trace-events |  2 --
 hw/intc/xics.c       |  3 ++-
 hw/intc/xics_spapr.c | 57 +++++++++-------------------------------------=
------
 hw/ppc/pnv.c         | 18 +++++++++++++++++
 hw/ppc/spapr.c       | 56 ++++++++++++++++++++++++++++++++++++++++++++++=
++---
 hw/ppc/trace-events  |  2 ++
 6 files changed, 85 insertions(+), 53 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index b86f242b0fcf..e34ecf7a16e5 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -65,8 +65,6 @@ xics_ics_simple_reject(int nr, int srcno) "reject irq 0=
x%x [src %d]"
 xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
 xics_alloc(int irq) "irq %d"
 xics_alloc_block(int first, int num, bool lsi, int align) "first irq %d,=
 %d irqs, lsi=3D%d, alignnum %d"
-xics_ics_free(int src, int irq, int num) "Source#%d, first irq %d, %d ir=
qs"
-xics_ics_free_warn(int src, int irq) "Source#%d, irq %d is already free"
=20
 # hw/intc/s390_flic_kvm.c
 flic_create_device(int err) "flic: create device failed %d"
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index cc9816e7f204..2c4899f278e2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -53,6 +53,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
 {
     uint32_t i;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
=20
     monitor_printf(mon, "ICS %4x..%4x %p\n",
                    ics->offset, ics->offset + ics->nr_irqs - 1, ics);
@@ -64,7 +65,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
     for (i =3D 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq =3D ics->irqs + i;
=20
-        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
+        if (!xic->irq_test(ics->xics, i + ics->offset)) {
             continue;
         }
         monitor_printf(mon, "  %4x %s %02x %02x\n",
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index e8c0a1b3e903..de9e65d35247 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -245,50 +245,26 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
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
 int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)
 {
     int irq;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
=20
     if (!ics) {
         return -1;
     }
     if (irq_hint) {
-        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
+        if (xic->irq_test(ics->xics, irq_hint)) {
             error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
             return -1;
         }
         irq =3D irq_hint;
     } else {
-        irq =3D ics_find_free_block(ics, 1, 1);
+        irq =3D xic->irq_alloc_block(ics->xics, 1, 1);
         if (irq < 0) {
             error_setg(errp, "can't allocate IRQ: no IRQ left");
             return -1;
         }
-        irq +=3D ics->offset;
     }
=20
     ics_set_irq_type(ics, irq - ics->offset, lsi);
@@ -305,6 +281,7 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
                           bool align, Error **errp)
 {
     int i, first =3D -1;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
=20
     if (!ics) {
         return -1;
@@ -320,9 +297,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
     if (align) {
         assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
                (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D ics_find_free_block(ics, num, num);
+        first =3D xic->irq_alloc_block(ics->xics, num, num);
     } else {
-        first =3D ics_find_free_block(ics, num, 1);
+        first =3D xic->irq_alloc_block(ics->xics, num, 1);
     }
     if (first < 0) {
         error_setg(errp, "can't find a free %d-IRQ block", num);
@@ -330,33 +307,19 @@ int spapr_ics_alloc_block(ICSState *ics, int num, b=
ool lsi,
     }
=20
     for (i =3D first; i < first + num; ++i) {
-        ics_set_irq_type(ics, i, lsi);
+        ics_set_irq_type(ics, i - ics->offset, lsi);
     }
-    first +=3D ics->offset;
=20
     trace_xics_alloc_block(first, num, lsi, align);
=20
     return first;
 }
=20
-static void ics_free(ICSState *ics, int srcno, int num)
-{
-    int i;
-
-    for (i =3D srcno; i < srcno + num; ++i) {
-        if (ICS_IRQ_FREE(ics, i)) {
-            trace_xics_ics_free_warn(0, i + ics->offset);
-        }
-        memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
-    }
-}
-
 void spapr_ics_free(ICSState *ics, int irq, int num)
 {
-    if (ics_valid_irq(ics, irq)) {
-        trace_xics_ics_free(0, irq, num);
-        ics_free(ics, irq - ics->offset, num);
-    }
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
+
+    xic->irq_free_block(ics->xics, irq, num);
 }
=20
 void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c35c439d816b..8288940ef9d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1018,6 +1018,23 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int p=
ir)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+static bool pnv_irq_test(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    /* We don't have a IRQ allocator for the PowerNV machine yet, so
+     * just check that the IRQ number is valid for the PSI source
+     */
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
@@ -1102,6 +1119,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
     xic->icp_get =3D pnv_icp_get;
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
+    xic->irq_test =3D pnv_irq_test;
     ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 84d68f2fdbae..4bdceb45a14f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3536,19 +3536,69 @@ static ICPState *spapr_icp_get(XICSFabric *xi, in=
t vcpu_id)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+#define ICS_IRQ_FREE(ics, srcno)   \
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
 static bool spapr_irq_test(XICSFabric *xi, int irq)
 {
-    return false;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    ICSState *ics =3D spapr->ics;
+    int srcno =3D irq - ics->offset;
+
+    return !ICS_IRQ_FREE(ics, srcno);
 }
=20
 static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
 {
-    return -1;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    ICSState *ics =3D spapr->ics;
+    int srcno;
+
+    srcno =3D ics_find_free_block(ics, count, align);
+    if (srcno =3D=3D -1) {
+        return -1;
+    }
+
+    return srcno + ics->offset;
 }
=20
 static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
 {
-    ;
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    ICSState *ics =3D spapr->ics;
+    int srcno =3D irq - ics->offset;
+    int i;
+
+    if (ics_valid_irq(ics, irq)) {
+        trace_spapr_irq_free(0, irq, num);
+        for (i =3D srcno; i < srcno + num; ++i) {
+            if (ICS_IRQ_FREE(ics, i)) {
+                trace_spapr_irq_free_warn(0, i + ics->offset);
+            }
+            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
+        }
+    }
 }
=20
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 4a6a6490fa78..dc9ab4c4deb3 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -12,6 +12,8 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned req_=
num, unsigned max_irqs) "
 # hw/ppc/spapr.c
 spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld byte=
s"
 spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld byte=
s"
+spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d i=
rqs"
+spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free=
"
=20
 # hw/ppc/spapr_hcall.c
 spapr_cas_pvr_try(uint32_t pvr) "0x%x"
--=20
2.13.6
