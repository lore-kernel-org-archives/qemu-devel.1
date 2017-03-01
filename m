Received: from eggs.gnu.org ([2001:4830:134:3::10]:46913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7y-0008H5-Ol
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7t-0000FH-NX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:44:03 +1100
Message-Id: <20170301044405.1792-49-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 48/50] ppc/xics: move InterruptStatsProvider to
 the sPAPR machine
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

It provides a better monitor output of the ICP and ICS objects, else
the objects are printed out of order.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 20 ++------------------
 hw/ppc/spapr.c        | 17 +++++++++++++++++
 include/hw/ppc/xics.h |  2 ++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ce6e8d7..5bcb955 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -93,10 +93,8 @@ void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
     }
 }
=20
-static void icp_pic_print_info(InterruptStatsProvider *obj,
-                           Monitor *mon)
+void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-    ICPState *icp =3D ICP(obj);
     int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
=20
     if (!icp->output) {
@@ -107,10 +105,8 @@ static void icp_pic_print_info(InterruptStatsProvide=
r *obj,
                    icp->pending_priority, icp->mfrr);
 }
=20
-static void ics_simple_pic_print_info(InterruptStatsProvider *obj,
-                                      Monitor *mon)
+void ics_pic_print_info(ICSState *ics, Monitor *mon)
 {
-    ICSState *ics =3D ICS_SIMPLE(obj);
     uint32_t i;
=20
     monitor_printf(mon, "ICS %4x..%4x %p\n",
@@ -369,12 +365,10 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
 static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
=20
     dc->reset =3D icp_reset;
     dc->vmsd =3D &vmstate_icp_server;
     dc->realize =3D icp_realize;
-    ic->print_info =3D icp_pic_print_info;
 }
=20
 static const TypeInfo icp_info =3D {
@@ -383,10 +377,6 @@ static const TypeInfo icp_info =3D {
     .instance_size =3D sizeof(ICPState),
     .class_init =3D icp_class_init,
     .class_size =3D sizeof(ICPStateClass),
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
-    },
 };
=20
 /*
@@ -632,7 +622,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
-    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
=20
     isc->realize =3D ics_simple_realize;
     dc->props =3D ics_simple_properties;
@@ -641,7 +630,6 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
     isc->reject =3D ics_simple_reject;
     isc->resend =3D ics_simple_resend;
     isc->eoi =3D ics_simple_eoi;
-    ic->print_info =3D ics_simple_pic_print_info;
 }
=20
 static const TypeInfo ics_simple_info =3D {
@@ -651,10 +639,6 @@ static const TypeInfo ics_simple_info =3D {
     .class_init =3D ics_simple_class_init,
     .class_size =3D sizeof(ICSStateClass),
     .instance_init =3D ics_simple_initfn,
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { }
-    },
 };
=20
 static void ics_base_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 76596a3..81c6c1c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -63,6 +63,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/nmi.h"
+#include "hw/intc/intc.h"
=20
 #include "hw/compat.h"
 #include "qemu/cutils.h"
@@ -2988,6 +2989,19 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 server)
     return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
 }
=20
+static void spapr_pic_print_info(InterruptStatsProvider *obj,
+                                 Monitor *mon)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    int i;
+
+    for (i =3D 0; i < spapr->nr_servers; i++) {
+        icp_pic_print_info(&spapr->icps[i], mon);
+    }
+
+    ics_pic_print_info(spapr->ics, mon);
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -2997,6 +3011,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
=20
@@ -3037,6 +3052,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
+    ispc->print_info =3D spapr_pic_print_info;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -3054,6 +3070,7 @@ static const TypeInfo spapr_machine_info =3D {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_XICS_FABRIC },
+        { TYPE_INTERRUPT_STATS_PROVIDER },
         { }
     },
 };
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 007ee2f..1945913 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -184,6 +184,8 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
                            uint8_t priority, uint8_t saved_priority);
=20
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
+void icp_pic_print_info(ICPState *icp, Monitor *mon);
+void ics_pic_print_info(ICSState *ics, Monitor *mon);
=20
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
--=20
2.9.3
