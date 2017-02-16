Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQw-00023X-KN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQs-0005Vw-7M
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:18 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQs-0005UZ-1e
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:14 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id EF4772403D
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:12 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:33 +0100
Message-Id: <1487252865-12064-11-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/22] ppc/xics: register the reset handler
 of ICS objects
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

The reset of the ICS objects is currently handled by XICS but this can
be done for each individual ICS. This also reduces the use of the XICS
list of ICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c | 5 -----
 hw/ppc/spapr.c | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index bfd3a539561a..d679313cd49f 100644
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
index 85a973cce7ae..a2a64d7de41d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -112,6 +112,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     }
=20
     spapr->ics =3D ICS_SIMPLE(object_new(type_ics));
+    qdev_set_parent_bus(DEVICE(spapr->ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(spapr->ics), =
NULL);
     object_property_set_int(OBJECT(spapr->ics), nr_irqs, "nr-irqs", &err=
);
     object_property_add_const_link(OBJECT(spapr->ics), "xics", OBJECT(xi=
cs),
--=20
2.7.4
