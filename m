Received: from eggs.gnu.org ([2001:4830:134:3::10]:53259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixO-0003fb-1x
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0004hQ-Ce
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:24 +1100
Message-Id: <20171215055435.24204-14-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/24] ppc/xics: introduce an icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The sPAPR and the PowerNV core objects create the interrupt presenter
object of the CPUs in a very similar way. Let's provide a common
routine in which we use the presenter 'type' as a child identifier.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c          | 21 +++++++++++++++++++++
 hw/ppc/pnv_core.c       | 10 +---------
 hw/ppc/spapr_cpu_core.c | 13 ++-----------
 include/hw/ppc/xics.h   |  3 +++
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a1cc0e420c..bfc6b5bb23 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -384,6 +384,27 @@ static const TypeInfo icp_info =3D {
     .class_size =3D sizeof(ICPStateClass),
 };
=20
+Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error =
**errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(type);
+    object_property_add_child(cpu, type, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
+                                   &error_abort);
+    object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort)=
;
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        obj =3D NULL;
+    }
+
+    return obj;
+}
+
 /*
  * ICS: Source layer
  */
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 82ff440b33..8d966e0802 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -126,7 +126,6 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    Object *obj;
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -134,13 +133,7 @@ static void pnv_core_realize_child(Object *child, XI=
CSFabric *xi, Error **errp)
         return;
     }
=20
-    obj =3D object_new(TYPE_PNV_ICP);
-    object_property_add_child(child, "icp", obj, NULL);
-    object_unref(obj);
-    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
-                                   &error_abort);
-    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    icp_create(child, TYPE_PNV_ICP, xi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -148,7 +141,6 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
=20
     powernv_cpu_init(cpu, &local_err);
     if (local_err) {
-        object_unparent(obj);
         error_propagate(errp, local_err);
         return;
     }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1ea0e295dd..70e757f808 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -110,7 +110,6 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    Object *obj;
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -122,21 +121,13 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild,
         goto error;
     }
=20
-    obj =3D object_new(spapr->icp_type);
-    object_property_add_child(child, "icp", obj, &error_abort);
-    object_unref(obj);
-    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
-                                   &error_abort);
-    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abor=
t);
-    object_property_set_bool(obj, true, "realized", &local_err);
+    icp_create(child, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
     if (local_err) {
-        goto free_icp;
+        goto error;
     }
=20
     return;
=20
-free_icp:
-    object_unparent(obj);
 error:
     error_propagate(errp, local_err);
 }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 2df99be111..2ba8b12208 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -212,4 +212,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
+Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
+                   Error **errp);
+
 #endif /* XICS_H */
--=20
2.14.3
