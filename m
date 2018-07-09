Received: from eggs.gnu.org ([2001:4830:134:3::10]:44109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq5-00052e-7X
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq4-0002AX-DM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:36 +1000
Message-Id: <20180709074350.27086-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/16] spapr/vio: quiet down the "irq" property
 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property")
introduced get/set accessors for the "irq" property to warn of its
usage, but the warning in the get pollutes the monitor 'info qtree'.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index daf85130b5..be9af71437 100644
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
2.17.1
