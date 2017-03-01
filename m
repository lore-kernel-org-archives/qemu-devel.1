Received: from eggs.gnu.org ([2001:4830:134:3::10]:46684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7t-0008A9-KH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7p-0000BN-Mc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:46 +1100
Message-Id: <20170301044405.1792-32-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/50] ppc/xics: use the QOM interface under the
 sPAPR machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Add 'ics_get' and 'ics_resend' handlers to the sPAPR machine. These
are relatively simple for a single ICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        |  2 +-
 hw/ppc/spapr.c        | 18 ++++++++++++++++++
 include/hw/ppc/xics.h |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 433869a..c6bfb61 100644
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
index 153aab4..c6cef04 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2969,6 +2969,20 @@ static void spapr_phb_placement(sPAPRMachineState =
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
@@ -2977,6 +2991,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     NMIClass *nc =3D NMI_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
=20
     mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
=20
@@ -3014,6 +3029,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->map_hptes =3D spapr_map_hptes;
     vhc->unmap_hptes =3D spapr_unmap_hptes;
     vhc->store_hpte =3D spapr_store_hpte;
+    xic->ics_get =3D spapr_ics_get;
+    xic->ics_resend =3D spapr_ics_resend;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -3030,6 +3047,7 @@ static const TypeInfo spapr_machine_info =3D {
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
+        { TYPE_XICS_FABRIC },
         { }
     },
 };
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1c43305..1161d54 100644
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
2.9.3
