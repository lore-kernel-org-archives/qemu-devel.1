Received: from eggs.gnu.org ([2001:4830:134:3::10]:53495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3O-0006mU-ME
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ctE3N-0001Qe-RC
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:26 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:50959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ctE3N-0001QE-LI
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:54:25 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5DE9470C4D
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 15:54:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 29 Mar 2017 15:53:30 +0200
Message-Id: <1490795611-4762-9-git-send-email-clg@kaod.org>
In-Reply-To: <1490795611-4762-1-git-send-email-clg@kaod.org>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 8/9] ppc/pnv: extend the machine with a
 InterruptStatsProvider interface
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 57560b09e04e..15a908f4306a 100644
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
@@ -773,6 +775,18 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir=
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
@@ -824,6 +838,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D ppc_powernv_init;
@@ -837,6 +852,7 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
     xic->icp_get =3D pnv_icp_get;
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
+    ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
 }
@@ -849,6 +865,7 @@ static const TypeInfo powernv_machine_info =3D {
     .class_init    =3D powernv_machine_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_XICS_FABRIC },
+        { TYPE_INTERRUPT_STATS_PROVIDER },
         { },
     },
 };
--=20
2.7.4
