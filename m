Received: from eggs.gnu.org ([2001:4830:134:3::10]:39809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwhE-0001zD-HP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwhD-00005c-EP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:40 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:34543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuwhD-0008WA-7z
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:39 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3181A7B120
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 09:46:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  3 Apr 2017 09:46:01 +0200
Message-Id: <1491205565-12831-6-git-send-email-clg@kaod.org>
In-Reply-To: <1491205565-12831-1-git-send-email-clg@kaod.org>
References: <1491205565-12831-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/9] ppc/pnv: extend the machine with a
 XICSFabric interface
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

A XICSFabric QOM interface is used by the XICS layer to manipulate the
ICP and ICS objects. Let's define the associated handlers for the
PowerNV machine. All handlers should be defined even if there is no
ICS under the PowerNV machine yet.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Changes since v4:

 - removed the empty ics_get() and ics_resend() handlers

 hw/ppc/pnv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3fa722af82e6..2d7aa5dcfbca 100644
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
@@ -737,6 +738,29 @@ static const TypeInfo pnv_chip_info =3D {
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
@@ -787,6 +811,7 @@ static void powernv_machine_class_props_init(ObjectCl=
ass *oc)
 static void powernv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -797,6 +822,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
+    xic->icp_get =3D pnv_icp_get;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -807,6 +833,10 @@ static const TypeInfo powernv_machine_info =3D {
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
2.7.4
