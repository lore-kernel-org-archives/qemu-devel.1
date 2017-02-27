Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJw-00015h-K0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJq-0007YX-TN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:36 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:57153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJq-0007Wo-Mw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:30 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5680DB3AD6
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:30:24 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:15 +0100
Message-Id: <1488205773-30436-9-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/26] ppc/xics: use the QOM interface under
 the sPAPR machine
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

Add 'ics_get' and 'ics_resend' handlers to the sPAPR machine. These
are relatively simple for a single ICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  2 +-
 hw/ppc/spapr.c        | 18 ++++++++++++++++++
 include/hw/ppc/xics.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 433869a696c4..c6bfb610fd32 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -193,7 +193,7 @@ static void ics_reject(ICSState *ics, uint32_t nr)
     }
 }
=20
-static void ics_resend(ICSState *ics)
+void ics_resend(ICSState *ics)
 {
     ICSStateClass *k =3D ICS_BASE_GET_CLASS(ics);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 130bfdc0055c..ad41aba44b49 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2913,6 +2913,20 @@ static void spapr_phb_placement(sPAPRMachineState =
*spapr, uint32_t index,
     *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
 }
=20
+static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
+
+    return ics_valid_irq(spapr->ics, irq) ? spapr->ics : NULL;
+}
+
+static void spapr_ics_resend(XICSFabric *dev)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
+
+    ics_resend(spapr->ics);
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -2921,6 +2935,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     NMIClass *nc =3D NMI_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
=20
     mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
=20
@@ -2954,6 +2969,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     nc->nmi_monitor_handler =3D spapr_nmi;
     smc->phb_placement =3D spapr_phb_placement;
     vhc->hypercall =3D emulate_spapr_hypercall;
+    xic->ics_get =3D spapr_ics_get;
+    xic->ics_resend =3D spapr_ics_resend;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -2970,6 +2987,7 @@ static const TypeInfo spapr_machine_info =3D {
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
+        { TYPE_XICS_FABRIC },
         { }
     },
 };
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1c43305a0456..1161d5487b4f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -223,5 +223,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
=20
 ICSState *xics_find_source(XICSState *icp, int irq);
+void ics_resend(ICSState *ics);
=20
 #endif /* XICS_H */
--=20
2.7.4
