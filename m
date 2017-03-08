Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDZ-0007eR-UY
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDV-00037V-GZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:18 -0500
Received: from mo177.mail-out.ovh.net ([178.32.228.177]:49274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDV-00036t-6Z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:13 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id C43B732945
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:53:09 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:46 +0100
Message-Id: <1488970371-8865-4-git-send-email-clg@kaod.org>
In-Reply-To: <1488970371-8865-1-git-send-email-clg@kaod.org>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 3/8] ppc/pnv: create the ICP and ICS
 objects under the machine
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

Like this is done for the sPAPR machine, we use a simple array under
the PowerNV machine to store the Interrupt Control Presenters (ICP)
objects, one for each vCPU. This array is indexed by 'cpu_index' of
the CPUState.

We use a list to hold the different Interrupt Control Sources (ICS)
objects, as PowerNV needs to handle multiple sources: for PCI-E and
for the Processor Service Interface (PSI).

Finally, to interface with the XICS layer which manipulates the ICP
and ICS objects, we extend the PowerNV machine with an XICSFabric
interface and its associated handlers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c          | 89 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h  |  4 +++
 include/hw/ppc/xics.h |  1 +
 3 files changed, 94 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09f0d22defb8..461d3535e99c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -32,6 +32,8 @@
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
+#include "monitor/monitor.h"
+#include "hw/intc/intc.h"
=20
 #include "hw/ppc/pnv_xscom.h"
=20
@@ -416,6 +418,23 @@ static void ppc_powernv_init(MachineState *machine)
         machine->cpu_model =3D "POWER8";
     }
=20
+    /* Create the Interrupt Control Presenters before the vCPUs */
+    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
+    pnv->icps =3D g_new0(ICPState, pnv->nr_servers);
+    for (i =3D 0; i < pnv->nr_servers; i++) {
+        ICPState *icp =3D &pnv->icps[i];
+        object_initialize(icp, sizeof(*icp), TYPE_ICP);
+        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
+        object_property_add_child(OBJECT(pnv), "icp[*]", OBJECT(icp),
+                                  &error_fatal);
+        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(pnv),
+                                       &error_fatal);
+        object_property_set_bool(OBJECT(icp), true, "realized", &error_f=
atal);
+    }
+
+    /* and the list of Interrupt Control Sources */
+    QLIST_INIT(&pnv->ics);
+
     /* Create the processor chips */
     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_=
model);
     if (!object_class_by_name(chip_typename)) {
@@ -742,6 +761,48 @@ static void pnv_get_num_chips(Object *obj, Visitor *=
v, const char *name,
     visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp);
 }
=20
+static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    ICSState *ics;
+
+    QLIST_FOREACH(ics, &pnv->ics, list) {
+        if (ics_valid_irq(ics, irq)) {
+            return ics;
+        }
+    }
+    return NULL;
+}
+
+static void pnv_ics_resend(XICSFabric *xi)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    ICSState *ics;
+
+    QLIST_FOREACH(ics, &pnv->ics, list) {
+        ics_resend(ics);
+    }
+}
+
+static void pnv_ics_eoi(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    ICSState *ics;
+
+    QLIST_FOREACH(ics, &pnv->ics, list) {
+        if (ics_valid_irq(ics, irq)) {
+            ics_eoi(ics, irq);
+        }
+    }
+}
+
+static ICPState *pnv_icp_get(XICSFabric *xi, int server)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+
+    return (server < pnv->nr_servers) ? &pnv->icps[server] : NULL;
+}
+
 static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -783,9 +844,27 @@ static void powernv_machine_class_props_init(ObjectC=
lass *oc)
                               NULL);
 }
=20
+static void pnv_pic_print_info(InterruptStatsProvider *obj,
+                               Monitor *mon)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    ICSState *ics;
+    int i;
+
+    for (i =3D 0; i < pnv->nr_servers; i++) {
+        icp_pic_print_info(&pnv->icps[i], mon);
+    }
+
+    QLIST_FOREACH(ics, &pnv->ics, list) {
+        ics_pic_print_info(ics, mon);
+    }
+}
+
 static void powernv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -796,6 +875,11 @@ static void powernv_machine_class_init(ObjectClass *=
oc, void *data)
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
+    xic->icp_get =3D pnv_icp_get;
+    xic->ics_get =3D pnv_ics_get;
+    xic->ics_eoi =3D pnv_ics_eoi;
+    xic->ics_resend =3D pnv_ics_resend;
+    ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -806,6 +890,11 @@ static const TypeInfo powernv_machine_info =3D {
     .instance_size =3D sizeof(PnvMachineState),
     .instance_init =3D powernv_machine_initfn,
     .class_init    =3D powernv_machine_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_XICS_FABRIC },
+        { TYPE_INTERRUPT_STATS_PROVIDER },
+        { },
+    },
 };
=20
 static void powernv_machine_register_types(void)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index df98a72006e4..6a0b004cea93 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -22,6 +22,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/ppc/pnv_lpc.h"
+#include "hw/ppc/xics.h"
=20
 #define TYPE_PNV_CHIP "powernv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -114,6 +115,9 @@ typedef struct PnvMachineState {
     PnvChip      **chips;
=20
     ISABus       *isa_bus;
+    ICPState     *icps;
+    uint32_t     nr_servers;
+    QLIST_HEAD(, ICSState) ics;
 } PnvMachineState;
=20
 #define PNV_FDT_ADDR          0x01000000
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 00b003b2392d..c2032cac55f6 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -115,6 +115,7 @@ struct ICSState {
     qemu_irq *qirqs;
     ICSIRQState *irqs;
     XICSFabric *xics;
+    QLIST_ENTRY(ICSState) list;
 };
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
--=20
2.7.4
