Received: from eggs.gnu.org ([2001:4830:134:3::10]:50767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOc-0008Rj-Te
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOY-00077J-Lm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:46 +1100
Message-Id: <20171017042152.29443-29-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/34] ppc: pnv: drop PnvCoreClass::cpu_oc field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

deduce cpu type directly from core type instead of
maintaining type mapping in PnvCoreClass::cpu_oc and doing
extra cpu_model parsing in pnv_core_class_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c         | 18 ++++++++++++------
 include/hw/ppc/pnv_core.h |  1 -
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 85b39a5b5e..135d3fa29f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -27,6 +27,16 @@
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/xics.h"
=20
+static const char *pnv_core_cpu_typename(PnvCore *pc)
+{
+    const char *core_type =3D object_class_get_name(object_get_class(OBJ=
ECT(pc)));
+    int len =3D strlen(core_type) - strlen(PNV_CORE_TYPE_SUFFIX);
+    char *s =3D g_strdup_printf(POWERPC_CPU_TYPE_NAME("%.*s"), len, core=
_type);
+    const char *cpu_type =3D object_class_get_name(object_class_by_name(=
s));
+    g_free(s);
+    return cpu_type;
+}
+
 static void powernv_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
@@ -148,8 +158,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
 {
     PnvCore *pc =3D PNV_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
-    PnvCoreClass *pcc =3D PNV_CORE_GET_CLASS(OBJECT(dev));
-    const char *typename =3D object_class_get_name(pcc->cpu_oc);
+    const char *typename =3D pnv_core_cpu_typename(pc);
     size_t size =3D object_type_get_instance_size(typename);
     Error *local_err =3D NULL;
     void *obj;
@@ -211,11 +220,9 @@ static Property pnv_core_properties[] =3D {
 static void pnv_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    PnvCoreClass *pcc =3D PNV_CORE_CLASS(oc);
=20
     dc->realize =3D pnv_core_realize;
     dc->props =3D pnv_core_properties;
-    pcc->cpu_oc =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
 }
=20
 static const TypeInfo pnv_core_info =3D {
@@ -223,6 +230,7 @@ static const TypeInfo pnv_core_info =3D {
     .parent         =3D TYPE_CPU_CORE,
     .instance_size  =3D sizeof(PnvCore),
     .class_size     =3D sizeof(PnvCoreClass),
+    .class_init =3D pnv_core_class_init,
     .abstract       =3D true,
 };
=20
@@ -239,8 +247,6 @@ static void pnv_core_register_types(void)
         TypeInfo ti =3D {
             .parent =3D TYPE_PNV_CORE,
             .instance_size =3D sizeof(PnvCore),
-            .class_init =3D pnv_core_class_init,
-            .class_data =3D (void *) pnv_core_models[i],
         };
         ti.name =3D pnv_core_typename(pnv_core_models[i]);
         type_register(&ti);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3360c4b12d..a336a1f18a 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -42,7 +42,6 @@ typedef struct PnvCore {
=20
 typedef struct PnvCoreClass {
     DeviceClass parent_class;
-    ObjectClass *cpu_oc;
 } PnvCoreClass;
=20
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
--=20
2.13.6
