Received: from eggs.gnu.org ([2001:4830:134:3::10]:41566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmvm-0001p3-Mo
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmvg-0006LW-8x
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:42 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:51990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmvf-0006Ky-WF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:31:36 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8F1B19BC35
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:31:34 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:39 +0100
Message-Id: <20171109101439.390-13-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 12/12] spapr: use sPAPRMachineState
 in spapr_ics_ prototypes
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

The routines manipulating the IRQ numbers for the sPAPR machine do not
have any relation with the ICSState anymore. So use a sPAPRMachineState
parameter in their prototype and prefix them with spapr_irq_.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c  | 30 ++++++++++++------------------
 hw/ppc/spapr.c        |  5 +++--
 hw/ppc/spapr_events.c |  4 ++--
 hw/ppc/spapr_pci.c    |  8 ++++----
 hw/ppc/spapr_vio.c    |  2 +-
 include/hw/ppc/xics.h | 13 +++++++------
 6 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index f28e9136f2f6..b5c8b8fa0e89 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -245,22 +245,20 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
=20
-int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)
+int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
+                    Error **errp)
 {
     int irq;
-    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
=20
-    if (!ics) {
-        return -1;
-    }
     if (irq_hint) {
-        if (xic->irq_test(ics->xics, irq_hint)) {
+        if (xic->irq_test(XICS_FABRIC(spapr), irq_hint)) {
             error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
             return -1;
         }
         irq =3D irq_hint;
     } else {
-        irq =3D xic->irq_alloc_block(ics->xics, 1, 1, lsi);
+        irq =3D xic->irq_alloc_block(XICS_FABRIC(spapr), 1, 1, lsi);
         if (irq < 0) {
             error_setg(errp, "can't allocate IRQ: no IRQ left");
             return -1;
@@ -276,15 +274,11 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bo=
ol lsi, Error **errp)
  * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
  * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
  */
-int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi,
+int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
                           bool align, Error **errp)
 {
     int first =3D -1;
-    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
-
-    if (!ics) {
-        return -1;
-    }
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
=20
     /*
      * MSIMesage::data is used for storing VIRQ so
@@ -296,9 +290,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
     if (align) {
         assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
                (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
-        first =3D xic->irq_alloc_block(ics->xics, num, num, lsi);
+        first =3D xic->irq_alloc_block(XICS_FABRIC(spapr), num, num, lsi=
);
     } else {
-        first =3D xic->irq_alloc_block(ics->xics, num, 1, lsi);
+        first =3D xic->irq_alloc_block(XICS_FABRIC(spapr), num, 1, lsi);
     }
     if (first < 0) {
         error_setg(errp, "can't find a free %d-IRQ block", num);
@@ -310,11 +304,11 @@ int spapr_ics_alloc_block(ICSState *ics, int num, b=
ool lsi,
     return first;
 }
=20
-void spapr_ics_free(ICSState *ics, int irq, int num)
+void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
 {
-    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
=20
-    xic->irq_free_block(ics->xics, irq, num);
+    xic->irq_free_block(XICS_FABRIC(spapr), irq, num);
 }
=20
 void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0cf1e02fa2b7..dcde3f4da659 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3610,7 +3610,8 @@ static void ics_set_irq_type(ICSState *ics, int src=
no, bool lsi)
  * and then the MSIs. This allows us to keep the LSI IRQ numbers in a
  * well known range which is useful for PHB hotplug.
  */
-static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align, b=
ool lsi)
+static int spapr_irq_alloc_block_xi(XICSFabric *xi, int count, int align=
,
+                                    bool lsi)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
@@ -3776,7 +3777,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
     xic->irq_test =3D spapr_irq_test;
-    xic->irq_alloc_block =3D spapr_irq_alloc_block;
+    xic->irq_alloc_block =3D spapr_irq_alloc_block_xi;
     xic->irq_free_block =3D spapr_irq_free_block;
     xic->irq_is_lsi =3D spapr_irq_is_lsi;
=20
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index e377fc7ddea2..cead596f3e7a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -718,7 +718,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
     spapr->event_sources =3D spapr_event_sources_new();
=20
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 spapr_ics_alloc(spapr->ics, 0, false,
+                                 spapr_irq_alloc(spapr, 0, false,
                                                   &error_fatal));
=20
     /* NOTE: if machine supports modern/dedicated hotplug event source,
@@ -731,7 +731,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
      */
     if (spapr->use_hotplug_event_source) {
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
-                                     spapr_ics_alloc(spapr->ics, 0, fals=
e,
+                                     spapr_irq_alloc(spapr, 0, false,
                                                       &error_fatal));
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5a3122a9f9f9..e0ef77a480e5 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -314,7 +314,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
             return;
         }
=20
-        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
+        spapr_irq_free(spapr, msi->first_irq, msi->num);
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
         }
@@ -352,7 +352,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    irq =3D spapr_ics_alloc_block(spapr->ics, req_num, false,
+    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
                            ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
@@ -363,7 +363,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
=20
     /* Release previous MSIs */
     if (msi) {
-        spapr_ics_free(spapr->ics, msi->first_irq, msi->num);
+        spapr_irq_free(spapr, msi->first_irq, msi->num);
         g_hash_table_remove(phb->msi, &config_addr);
     }
=20
@@ -1675,7 +1675,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
         uint32_t irq;
         Error *local_err =3D NULL;
=20
-        irq =3D spapr_ics_alloc_block(spapr->ics, 1, true, false, &local=
_err);
+        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_err)=
;
         if (local_err) {
             error_propagate(errp, local_err);
             error_prepend(errp, "can't allocate LSIs: ");
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index ea3bc8bd9e21..bb7ed2c537b0 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -454,7 +454,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
         dev->qdev.id =3D id;
     }
=20
-    dev->irq =3D spapr_ics_alloc(spapr->ics, dev->irq, false, &local_err=
);
+    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 056cf37bc68f..dd3e2eacedb2 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -184,10 +184,13 @@ typedef struct XICSFabricClass {
=20
 #define XICS_IRQS_SPAPR               1024
=20
-int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)=
;
-int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
-                           Error **errp);
-void spapr_ics_free(ICSState *ics, int irq, int num);
+typedef struct sPAPRMachineState sPAPRMachineState;
+
+int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
+                    Error **errp);
+int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
+                          bool align, Error **errp);
+void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
=20
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
@@ -210,8 +213,6 @@ bool ics_is_lsi(ICSState *ics, int srno);
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
=20
-typedef struct sPAPRMachineState sPAPRMachineState;
-
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
--=20
2.13.6
