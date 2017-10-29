Received: from eggs.gnu.org ([2001:4830:134:3::10]:35578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s4t-0004i6-89
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e8s4q-0005qJ-3X
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:55 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:55981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e8s4p-0005q8-TR
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 14:12:52 -0400
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id E33596379A
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 19:12:50 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun, 29 Oct 2017 19:12:12 +0100
Message-Id: <20171029181217.9927-4-clg@kaod.org>
In-Reply-To: <20171029181217.9927-1-clg@kaod.org>
References: <20171029181217.9927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/8] pnv: introduce an irq_test() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On PowerNV, there is no need for a bitmap for the moment. The only
interrupts handled are the ones from the PSI controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c35c439d816b..8288940ef9d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1018,6 +1018,23 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int p=
ir)
     return cpu ? ICP(cpu->intc) : NULL;
 }
=20
+static bool pnv_irq_test(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    /* We don't have a IRQ allocator for the PowerNV machine yet, so
+     * just check that the IRQ number is valid for the PSI source
+     */
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        ICSState *ics =3D &pnv->chips[i]->psi.ics;
+        if (ics_valid_irq(ics, irq)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
@@ -1102,6 +1119,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
     xic->icp_get =3D pnv_icp_get;
     xic->ics_get =3D pnv_ics_get;
     xic->ics_resend =3D pnv_ics_resend;
+    xic->irq_test =3D pnv_irq_test;
     ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
--=20
2.13.6
