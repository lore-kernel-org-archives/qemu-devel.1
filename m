Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDW-0007ah-00
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDV-00037G-4M
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:14 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:57780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDU-00035G-UE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:13 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id BF9023BD53
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:53:05 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:45 +0100
Message-Id: <1488970371-8865-3-git-send-email-clg@kaod.org>
In-Reply-To: <1488970371-8865-1-git-send-email-clg@kaod.org>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 2/8] ppc/xics: add an ics_eoi()
 handler to XICSFabric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This handler will be required by PowerPC machines using multiple ICS
objects, like this is the case for PowerNV. Also update the sPAPR
machine to use the new handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  9 +++------
 hw/ppc/spapr.c        | 11 +++++++++++
 include/hw/ppc/xics.h |  2 ++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 209e1a75ecb9..e6fecd6e1a89 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -169,7 +169,7 @@ void ics_resend(ICSState *ics)
     }
 }
=20
-static void ics_eoi(ICSState *ics, int nr)
+void ics_eoi(ICSState *ics, int nr)
 {
     ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
=20
@@ -268,7 +268,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
 {
     XICSFabric *xi =3D icp->xics;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
-    ICSState *ics;
     uint32_t irq;
=20
     /* Send EOI -> ICS */
@@ -276,10 +275,8 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
     trace_xics_icp_eoi(icp->cs->cpu_index, xirr, icp->xirr);
     irq =3D xirr & XISR_MASK;
=20
-    ics =3D xic->ics_get(xi, irq);
-    if (ics) {
-        ics_eoi(ics, irq);
-    }
+    xic->ics_eoi(xi, irq);
+
     if (!XISR(icp)) {
         icp_resend(icp);
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c3bb99160545..043629cc5c54 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3024,6 +3024,16 @@ static void spapr_ics_resend(XICSFabric *dev)
     ics_resend(spapr->ics);
 }
=20
+static void spapr_ics_eoi(XICSFabric *xi, int irq)
+{
+    ICSState *ics;
+
+    ics =3D spapr_ics_get(xi, irq);
+    if (ics) {
+        ics_eoi(ics, irq);
+    }
+}
+
 static ICPState *spapr_icp_get(XICSFabric *xi, int server)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
@@ -3094,6 +3104,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->get_patbe =3D spapr_get_patbe;
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
+    xic->ics_eoi =3D spapr_ics_eoi;
     xic->icp_get =3D spapr_icp_get;
     ispc->print_info =3D spapr_pic_print_info;
 }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 42bd24e975cb..00b003b2392d 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -155,6 +155,7 @@ typedef struct XICSFabricClass {
     InterfaceClass parent;
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
+    void (*ics_eoi)(XICSFabric *xi, int irq);
     ICPState *(*icp_get)(XICSFabric *xi, int server);
 } XICSFabricClass;
=20
@@ -189,6 +190,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
=20
 void ics_resend(ICSState *ics);
+void ics_eoi(ICSState *ics, int irq);
 void icp_resend(ICPState *ss);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
--=20
2.7.4
