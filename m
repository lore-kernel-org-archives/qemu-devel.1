Received: from eggs.gnu.org ([2001:4830:134:3::10]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2l-00062P-6J
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy2i-0001iN-Hz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:19 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:44127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUy2i-0001gA-8o
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:34:16 -0400
Received: from player688.ha.ovh.net (unknown [10.109.122.64])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9F98D13C282
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 19:34:14 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 18 Jun 2018 19:34:00 +0200
Message-Id: <20180618173402.23405-2-clg@kaod.org>
In-Reply-To: <20180618173402.23405-1-clg@kaod.org>
References: <20180618173402.23405-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] spapr: split the IRQ allocation sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Today, when a device requests for IRQ number in a sPAPR machine, the
spapr_irq_alloc() routine first scans the ICSState status array to
find an empty slot and then performs the assignement of the selected
numbers. Split this sequence in two distinct routines : spapr_irq_find()
for lookups and spapr_irq_claim() for claiming the IRQ numbers.

This will ease the introduction of a static layout of IRQ numbers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h |  4 ++++
 hw/ppc/spapr.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_events.c  | 18 ++++++++++++++----
 hw/ppc/spapr_pci.c     | 23 ++++++++++++++++++++---
 hw/ppc/spapr_vio.c     | 10 +++++++++-
 5 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3388750fc795..15f771acc892 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -776,6 +776,10 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int ir=
q_hint, bool lsi,
                     Error **errp);
 int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
                           bool align, Error **errp);
+int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
+                   Error **errp);
+#define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, e=
rrp)
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db0fb385d4e0..1fa398111111 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3816,6 +3816,36 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
     return -1;
 }
=20
+int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error =
**errp)
+{
+    ICSState *ics =3D spapr->ics;
+    int first =3D -1;
+
+    assert(ics);
+
+    /*
+     * MSIMesage::data is used for storing VIRQ so
+     * it has to be aligned to num to support multiple
+     * MSI vectors. MSI-X is not affected by this.
+     * The hint is used for the first IRQ, the rest should
+     * be allocated continuously.
+     */
+    if (align) {
+        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
+               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
+        first =3D ics_find_free_block(ics, num, num);
+    } else {
+        first =3D ics_find_free_block(ics, num, 1);
+    }
+
+    if (first < 0) {
+        error_setg(errp, "can't find a free %d-IRQ block", num);
+        return -1;
+    }
+
+    return first + ics->offset;
+}
+
 /*
  * Allocate the IRQ number and set the IRQ type, LSI or MSI
  */
@@ -3894,6 +3924,26 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr=
, int num, bool lsi,
     return first;
 }
=20
+int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
+{
+    ICSState *ics =3D spapr->ics;
+
+    assert(ics);
+
+    if (!ics_valid_irq(ics, irq)) {
+        error_setg(errp, "IRQ %d is invalid", irq);
+        return -1;
+    }
+
+    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
+        error_setg(errp, "IRQ %d is not free", irq);
+        return -1;
+    }
+
+    spapr_irq_set_lsi(spapr, irq, lsi);
+    return 0;
+}
+
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
 {
     ICSState *ics =3D spapr->ics;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 86836f0626dc..e4f5946a2188 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -707,13 +707,18 @@ void spapr_clear_pending_events(sPAPRMachineState *=
spapr)
=20
 void spapr_events_init(sPAPRMachineState *spapr)
 {
+    int epow_irq;
+
+    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
+
+    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+
     QTAILQ_INIT(&spapr->pending_events);
=20
     spapr->event_sources =3D spapr_event_sources_new();
=20
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 spapr_irq_alloc(spapr, 0, false,
-                                                  &error_fatal));
+                                 epow_irq);
=20
     /* NOTE: if machine supports modern/dedicated hotplug event source,
      * we add it to the device-tree unconditionally. This means we may
@@ -724,9 +729,14 @@ void spapr_events_init(sPAPRMachineState *spapr)
      * checking that it's enabled.
      */
     if (spapr->use_hotplug_event_source) {
+        int hp_irq;
+
+        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
+
+        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
-                                     spapr_irq_alloc(spapr, 0, false,
-                                                      &error_fatal));
+                                     hp_irq);
     }
=20
     spapr->epow_notifier.notify =3D spapr_powerdown_req;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f936ce63effa..497b896c7d24 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -279,6 +279,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     spapr_pci_msi *msi;
     int *config_addr_key;
     Error *err =3D NULL;
+    int i;
=20
     /* Fins sPAPRPHBState */
     phb =3D spapr_pci_find_phb(spapr, buid);
@@ -371,8 +372,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     }
=20
     /* Allocate MSIs */
-    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
-                           ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
+    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_TYP=
E_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -380,6 +380,16 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
         return;
     }
=20
+    for (i =3D 0; i < req_num; i++) {
+        spapr_irq_claim(spapr, irq + i, false, &err);
+        if (err) {
+            error_reportf_err(err, "Can't allocate MSIs for device %x: "=
,
+                              config_addr);
+            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+            return;
+        }
+    }
+
     /* Release previous MSIs */
     if (msi) {
         spapr_irq_free(spapr, msi->first_irq, msi->num);
@@ -1698,7 +1708,14 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
         uint32_t irq;
         Error *local_err =3D NULL;
=20
-        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_err)=
;
+        irq =3D spapr_irq_findone(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_prepend(errp, "can't allocate LSIs: ");
+            return;
+        }
+
+        spapr_irq_claim(spapr, irq, true, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             error_prepend(errp, "can't allocate LSIs: ");
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 4555c648a8e2..daf85130b5ef 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -475,7 +475,15 @@ static void spapr_vio_busdev_realize(DeviceState *qd=
ev, Error **errp)
         dev->qdev.id =3D id;
     }
=20
-    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
+    if (!dev->irq) {
+        dev->irq =3D spapr_irq_findone(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    spapr_irq_claim(spapr, dev->irq, false, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
--=20
2.13.6
