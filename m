Received: from eggs.gnu.org ([2001:4830:134:3::10]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpj-0001FH-JU
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpf-0002Bb-DD
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:35 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:35353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKnpf-0001zi-3y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:31 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 18FC1177D95
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 17:06:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  1 Dec 2017 17:06:00 +0100
Message-Id: <20171201160604.15265-2-clg@kaod.org>
In-Reply-To: <20171201160604.15265-1-clg@kaod.org>
References: <20171201160604.15265-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] ppc/xics: introduce an icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The sPAPR and the PowerNV core objects create the interrupt presenter
object of the CPUs in a very similar way. Let's provide a common
routine in which we use the presenter 'type' as a child identifier.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---

 Changes since initial XIVE patchset:

 - changed first CPUState parameter to be an Object

 hw/intc/xics.c          | 21 +++++++++++++++++++++
 hw/ppc/pnv_core.c       | 10 +---------
 hw/ppc/spapr_cpu_core.c | 13 ++-----------
 include/hw/ppc/xics.h   |  3 +++
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index a1cc0e420c98..bfc6b5bb2367 100644
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
index 82ff440b3334..8d966e080288 100644
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
index 1ea0e295dd74..70e757f808c7 100644
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
index 2df99be111ce..2ba8b12208d7 100644
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
2.13.6
