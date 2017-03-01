Received: from eggs.gnu.org ([2001:4830:134:3::10]:46923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7y-0008HD-Ri
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7u-0000GR-PC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:58 +1100
Message-Id: <20170301044405.1792-44-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/50] ppc/xics: register the reset handler of
 ICP objects
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

The reset of the ICP objects is currently handled by XICS but this can
be done for each individual ICP.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 18 ------------------
 hw/ppc/spapr.c |  1 +
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ddb0a6f..51e6c0c 100644
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
index 7ad932f..8b2d21c 100644
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
2.9.3
