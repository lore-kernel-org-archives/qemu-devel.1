Received: from eggs.gnu.org ([2001:4830:134:3::10]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRa-0002eG-U4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRY-0005wN-H7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:58 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:60062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMRY-0005tg-5o
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:56 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id F2D3F241ED
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:54 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:39 +0100
Message-Id: <1487252865-12064-17-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/22] ppc/xics: register the reset handler
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
index dd41340d41a5..3ad7e8cf8ec4 100644
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
index 9c1772f93155..445d9a6ddad4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -130,6 +130,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
         ICPState *icp =3D &xics->ss[i];
=20
         object_initialize(icp, sizeof(*icp), type_icp);
+        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
         object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
         object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
--=20
2.7.4
