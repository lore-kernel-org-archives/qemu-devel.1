Received: from eggs.gnu.org ([2001:4830:134:3::10]:60211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCxi-00059i-Ih
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCxe-0005wx-HJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:18:54 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:49434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCxe-0005t5-BJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:18:50 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6A557DCA18
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:18:47 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:00 +0100
Message-Id: <1487931503-10607-2-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/24] xics: XICS should not be a
 SysBusDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

From: David Gibson <david@gibson.dropbear.id.au>

Currently xics - the component of the IBM POWER interrupt controller
representing the overall interrupt fabric / architecture is
represented as a descendent of SysBusDevice.  However, this is not
really correct - the xics presents nothing in MMIO space so it should
be an "unattached" device in the current QOM model.

Since this device will always be created by the machine type, not created
specifically from the command line, and because it has no migrated state
it should be safe to move it around the device composition tree.

Therefore this patch changes it to a descendent of TYPE_DEVICE, and makes
it an unattached device.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c | 2 +-
 hw/ppc/spapr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 095c16a30082..372b8311fb8b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -260,7 +260,7 @@ static void xics_common_class_init(ObjectClass *oc, v=
oid *data)
=20
 static const TypeInfo xics_common_info =3D {
     .name          =3D TYPE_XICS_COMMON,
-    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XICSState),
     .class_size    =3D sizeof(XICSStateClass),
     .instance_init =3D xics_common_initfn,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5904e6498f49..8af54494f166 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -101,7 +101,7 @@ static XICSState *try_create_xics(const char *type, i=
nt nr_servers,
     Error *err =3D NULL;
     DeviceState *dev;
=20
-    dev =3D qdev_create(NULL, type);
+    dev =3D DEVICE(object_new(type));
     qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
     qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
--=20
2.7.4
