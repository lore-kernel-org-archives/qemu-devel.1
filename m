Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIl-0002LR-8G
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIk-00051m-0g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:15 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSIj-00051I-Qj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:13 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D81CAAB1FE
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:15:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:34 +0200
Message-Id: <20170911171235.29331-21-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 20/21] ppc/xics: introduce a qirq_get()
 helper in the XICSFabric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will be used to choose the appropriate set of qirqs when XIVE is
activated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  7 +------
 hw/ppc/spapr.c        | 12 ++++++++++++
 include/hw/ppc/xics.h |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 927d4fec966a..7691492aa17b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -685,13 +685,8 @@ static const TypeInfo xics_fabric_info =3D {
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
 {
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
-    ICSState *ics =3D xic->ics_get(xi, irq);
=20
-    if (ics) {
-        return ics->qirqs[irq - ics->offset];
-    }
-
-    return NULL;
+    return xic->qirq_get(xi, irq);
 }
=20
 ICPState *xics_icp_get(XICSFabric *xi, int server)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c2011cb2dc72..d8b25be70cd8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3455,6 +3455,17 @@ static void spapr_phb_placement(sPAPRMachineState =
*spapr, uint32_t index,
     *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
 }
=20
+static qemu_irq spapr_qirq_get(XICSFabric *dev, int irq)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
+
+    if (!ics_valid_irq(spapr->ics, irq)) {
+        return NULL;
+    }
+
+    return spapr->ics->qirqs[irq - spapr->ics->offset];
+}
+
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
@@ -3539,6 +3550,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->unmap_hptes =3D spapr_unmap_hptes;
     vhc->store_hpte =3D spapr_store_hpte;
     vhc->get_patbe =3D spapr_get_patbe;
+    xic->qirq_get =3D spapr_qirq_get;
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c835997303c4..46d2fc1ef2c1 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -178,6 +178,7 @@ struct XICSFabric {
=20
 typedef struct XICSFabricClass {
     InterfaceClass parent;
+    qemu_irq (*qirq_get)(XICSFabric *xi, int irq);
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
     ICPState *(*icp_get)(XICSFabric *xi, int server);
--=20
2.13.5
