Received: from eggs.gnu.org ([2001:4830:134:3::10]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faNAC-00033x-31
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faNA8-0004NU-4E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:24:20 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:60245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1faNA7-0004Mr-Sw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:24:16 -0400
Received: from player787.ha.ovh.net (unknown [10.109.105.46])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 53875D5BA6
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 17:24:14 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue,  3 Jul 2018 17:23:59 +0200
Message-Id: <20180703152359.16618-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.0] spapr/vio: quiet down the "irq"
 property accessors
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

commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property")
introduced get/set accessors for the "irq" property to warn of its
usage, but the warning in the get pollutes the monitor 'info qtree'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_vio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index daf85130b5ef..be9af71437cc 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -43,7 +43,16 @@
=20
 #include <libfdt.h>
=20
-static void spapr_vio_getset_irq(Object *obj, Visitor *v, const char *na=
me,
+static void spapr_vio_get_irq(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    Property *prop =3D opaque;
+    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
+
+    visit_type_uint32(v, name, ptr, errp);
+}
+
+static void spapr_vio_set_irq(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     Property *prop =3D opaque;
@@ -57,8 +66,8 @@ static void spapr_vio_getset_irq(Object *obj, Visitor *=
v, const char *name,
=20
 static const PropertyInfo spapr_vio_irq_propinfo =3D {
     .name =3D "irq",
-    .get =3D spapr_vio_getset_irq,
-    .set =3D spapr_vio_getset_irq,
+    .get =3D spapr_vio_get_irq,
+    .set =3D spapr_vio_set_irq,
 };
=20
 static Property spapr_vio_props[] =3D {
--=20
2.13.6
