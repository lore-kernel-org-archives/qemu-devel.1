Received: from eggs.gnu.org ([2001:4830:134:3::10]:38246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKD-0001LA-H3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMK9-0007oB-Hh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:53 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:49095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMK9-0007nk-BL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:49 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9143AB3ABA
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:30:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:19 +0100
Message-Id: <1488205773-30436-13-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/26] ppc/xics: register the reset handler
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 5 -----
 hw/ppc/spapr.c | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a71d3858b13f..97775c2b61e5 100644
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
index 669a3a621b56..1706d52adec1 100644
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
2.7.4
