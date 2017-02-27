Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLp-0002vP-BN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLl-0008ER-CX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:33 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:56011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLl-0008EA-5z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:29 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id D90D2B319A
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:27 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:27 +0100
Message-Id: <1488205773-30436-21-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 20/26] ppc/xics: register the reset handler
 of ICP objects
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

The reset of the ICP objects is currently handled by XICS but this can
be done for each individual ICP.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c | 18 ------------------
 hw/ppc/spapr.c |  1 +
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ddb0a6f48b5c..51e6c0c85fca 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -137,29 +137,11 @@ static void ics_simple_pic_print_info(InterruptStat=
sProvider *obj,
 /*
  * XICS Common class - parent for emulated XICS and KVM-XICS
  */
-static void xics_common_reset(DeviceState *d)
-{
-    XICSState *xics =3D XICS_COMMON(d);
-    int i;
-
-    for (i =3D 0; i < xics->nr_servers; i++) {
-        device_reset(DEVICE(&xics->ss[i]));
-    }
-}
-
-static void xics_common_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(oc);
-
-    dc->reset =3D xics_common_reset;
-}
-
 static const TypeInfo xics_common_info =3D {
     .name          =3D TYPE_XICS_COMMON,
     .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XICSState),
     .class_size    =3D sizeof(XICSStateClass),
-    .class_init    =3D xics_common_class_init,
 };
=20
 /*
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index aa62292c8c90..88539557abd3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -131,6 +131,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
         ICPState *icp =3D &xics->ss[i];
=20
         object_initialize(icp, sizeof(*icp), type_icp);
+        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
         object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
         object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xi), =
NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
--=20
2.7.4
