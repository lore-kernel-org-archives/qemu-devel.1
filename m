Received: from eggs.gnu.org ([2001:4830:134:3::10]:56320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIA-0001VI-MB
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI9-0003QC-Sz
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:03 +1000
Message-Id: <20170424015927.8933-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/47] ppc/pnv: extend the machine with a
 InterruptStatsProvider interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0a0cfe3..f3623ee 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -33,6 +33,8 @@
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
+#include "monitor/monitor.h"
+#include "hw/intc/intc.h"
=20
 #include "hw/ppc/xics.h"
 #include "hw/ppc/pnv_xscom.h"
@@ -762,6 +764,18 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir=
)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+static void pnv_pic_print_info(InterruptStatsProvider *obj,
+                               Monitor *mon)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        icp_pic_print_info(ICP(cpu->intc), mon);
+    }
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -813,6 +827,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -824,6 +839,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
     xic->icp_get =3D pnv_icp_get;
+    ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -836,6 +852,7 @@ static const TypeInfo powernv_machine_info =3D {
     .class_init    =3D powernv_machine_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_XICS_FABRIC },
+        { TYPE_INTERRUPT_STATS_PROVIDER },
         { },
     },
 };
--=20
2.9.3
