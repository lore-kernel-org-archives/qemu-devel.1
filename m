Received: from eggs.gnu.org ([2001:4830:134:3::10]:46983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRw-0003vX-IG
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRv-0006dG-EQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:44 +1000
Message-Id: <20170609052652.23200-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/20] pnv_core: drop reference on ICPState
 object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Similarly to what was done to spapr with commit 249127d0dfeb, this patch
ensures that we don't keep an extra reference on the ICPState object. Als=
o
since the object was just created and not reparented yet, the call to
object_property_add_child() should never fail: let's pass &error_abort to
make this clear.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1b7ec70..e8a9a94 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -119,7 +119,8 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
     Object *obj;
=20
     obj =3D object_new(TYPE_PNV_ICP);
-    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
+    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
+    object_unref(obj);
     object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort=
);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
--=20
2.9.4
