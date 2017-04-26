Received: from eggs.gnu.org ([2001:4830:134:3::10]:56729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwm-0005H3-Oq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwf-00080m-1o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:08 +1000
Message-Id: <20170426070034.10727-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/48] ppc/pnv: extend the machine with a
 XICSFabric interface
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

A XICSFabric QOM interface is used by the XICS layer to manipulate the
ICP and ICS objects. Let's define the associated handlers for the
PowerNV machine. All handlers should be defined even if there is no
ICS under the PowerNV machine yet.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index aad7917..0a0cfe3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -34,6 +34,7 @@
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
=20
+#include "hw/ppc/xics.h"
 #include "hw/ppc/pnv_xscom.h"
=20
 #include "hw/isa/isa.h"
@@ -738,6 +739,29 @@ static const TypeInfo pnv_chip_info =3D {
     .abstract      =3D true,
 };
=20
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
+    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
+
+    return cpu ? ICP(cpu->intc) : NULL;
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -788,6 +812,7 @@ static void powernv_machine_class_props_init(ObjectCl=
ass *oc)
 static void powernv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -798,6 +823,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
+    xic->icp_get =3D pnv_icp_get;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -808,6 +834,10 @@ static const TypeInfo powernv_machine_info =3D {
     .instance_size =3D sizeof(PnvMachineState),
     .instance_init =3D powernv_machine_initfn,
     .class_init    =3D powernv_machine_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_XICS_FABRIC },
+        { },
+    },
 };
=20
 static void powernv_machine_register_types(void)
--=20
2.9.3
