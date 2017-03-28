Received: from eggs.gnu.org ([2001:4830:134:3::10]:59236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cslct-0003GM-H4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cslcr-0007FK-7I
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:33:11 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:46553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cslcq-0007Ew-Uq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:33:09 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B5FA77885C
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 09:33:07 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 28 Mar 2017 09:32:29 +0200
Message-Id: <1490686352-24017-6-git-send-email-clg@kaod.org>
In-Reply-To: <1490686352-24017-1-git-send-email-clg@kaod.org>
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/8] ppc/pnv: create the ICP and ICS objects
 under the machine
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
the CPUState but the users will provide a core PIR number. The mapping
is done in the icp_get() handler of the machine and is transparent to
XICS.

The Interrupt Control Sources (ICS), Processor Service Interface and
PCI-E interface models, will be introduced in subsequent patches. For
now, we have none, so we just prepare ground with place holders.

Finally, to interface with the XICS layer which manipulates the ICP
and ICS objects, we extend the PowerNV machine with an XICSFabric
interface and its associated handlers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2:

 - removed the list of ICS. The handlers will iterate on the chips to
   use the available ICS.

 Changes since v1:

 - handled pir-to-cpu_index mapping under icp_get=20
 - removed ics_eio handler
 - changed ICP name indexing
 - removed sysbus parenting of the ICP object

 hw/ppc/pnv.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h |  3 ++
 2 files changed, 99 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa722af82e6..e441b8ac1cad 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -33,7 +33,10 @@
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
+#include "monitor/monitor.h"
+#include "hw/intc/intc.h"
=20
+#include "hw/ppc/xics.h"
 #include "hw/ppc/pnv_xscom.h"
=20
 #include "hw/isa/isa.h"
@@ -417,6 +420,23 @@ static void ppc_powernv_init(MachineState *machine)
         machine->cpu_model =3D "POWER8";
     }
=20
+    /* Create the Interrupt Control Presenters before the vCPUs */
+    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
+    pnv->icps =3D g_new0(PnvICPState, pnv->nr_servers);
+    for (i =3D 0; i < pnv->nr_servers; i++) {
+        PnvICPState *icp =3D &pnv->icps[i];
+        char name[32];
+
+        /* TODO: fix ICP object name to be in sync with the core name */
+        snprintf(name, sizeof(name), "icp[%d]", i);
+        object_initialize(icp, sizeof(*icp), TYPE_PNV_ICP);
+        object_property_add_child(OBJECT(pnv), name, OBJECT(icp),
+                                  &error_fatal);
+        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(pnv),
+                                       &error_fatal);
+        object_property_set_bool(OBJECT(icp), true, "realized", &error_f=
atal);
+    }
+
     /* Create the processor chips */
     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_=
model);
     if (!object_class_by_name(chip_typename)) {
@@ -737,6 +757,71 @@ static const TypeInfo pnv_chip_info =3D {
     .abstract      =3D true,
 };
=20
+static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        /* place holder */
+    }
+    return NULL;
+}
+
+static void pnv_ics_resend(XICSFabric *xi)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        /* place holder */
+    }
+}
+
+static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        CPUPPCState *env =3D &cpu->env;
+
+        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
+
+    if (!cpu) {
+        return NULL;
+    }
+
+    assert(cpu->parent_obj.cpu_index < pnv->nr_servers);
+    return ICP(&pnv->icps[cpu->parent_obj.cpu_index]);
+}
+
+static void pnv_pic_print_info(InterruptStatsProvider *obj,
+                               Monitor *mon)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    int i;
+
+    for (i =3D 0; i < pnv->nr_servers; i++) {
+        icp_pic_print_info(ICP(&pnv->icps[i]), mon);
+    }
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        /* place holder */
+    }
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -787,6 +872,8 @@ static void powernv_machine_class_props_init(ObjectCl=
ass *oc)
 static void powernv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -797,6 +884,10 @@ static void powernv_machine_class_init(ObjectClass *=
oc, void *data)
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
+    xic->icp_get =3D pnv_icp_get;
+    xic->ics_get =3D pnv_ics_get;
+    xic->ics_resend =3D pnv_ics_resend;
+    ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -807,6 +898,11 @@ static const TypeInfo powernv_machine_info =3D {
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
index df98a72006e4..1ca197d2ec83 100644
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
@@ -114,6 +115,8 @@ typedef struct PnvMachineState {
     PnvChip      **chips;
=20
     ISABus       *isa_bus;
+    PnvICPState  *icps;
+    uint32_t     nr_servers;
 } PnvMachineState;
=20
 #define PNV_FDT_ADDR          0x01000000
--=20
2.7.4
