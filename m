Received: from eggs.gnu.org ([2001:4830:134:3::10]:46918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7y-0008HB-QM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7u-0000GW-Px
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:50 +1100
Message-Id: <20170301044405.1792-36-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/50] ppc/xics: register the reset handler of
 ICS objects
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

The reset of the ICS objects is currently handled by XICS but this can
be done for each individual ICS. This also reduces the use of the XICS
list of ICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 5 -----
 hw/ppc/spapr.c | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a71d385..97775c2 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -139,16 +139,11 @@ static void ics_simple_pic_print_info(InterruptStat=
sProvider *obj,
 static void xics_common_reset(DeviceState *d)
 {
     XICSState *xics =3D XICS_COMMON(d);
-    ICSState *ics;
     int i;
=20
     for (i =3D 0; i < xics->nr_servers; i++) {
         device_reset(DEVICE(&xics->ss[i]));
     }
-
-    QLIST_FOREACH(ics, &xics->ics, list) {
-        device_reset(DEVICE(ics));
-    }
 }
=20
 static void xics_common_initfn(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a4e4b86..a5e6072 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -114,6 +114,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     }
=20
     ics =3D ICS_SIMPLE(object_new(type_ics));
+    qdev_set_parent_bus(DEVICE(ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
     object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
     object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xics), NU=
LL);
--=20
2.9.3
