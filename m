Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008MX-0g
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-00072Y-EJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:38 +1100
Message-Id: <20171017042152.29443-21-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/34] ppc: spapr: define core types statically
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

spapr core type definition doesn't have any fields that
require it to be defined at runtime. So replace code
that fills in TypeInfo at runtime with static TypeInfo
array that does the same at complie time.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c         | 87 +++++++++++++----------------------=
------
 include/hw/ppc/spapr_cpu_core.h |  2 +
 2 files changed, 30 insertions(+), 59 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b6610dd431..550d320b5b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -217,37 +217,6 @@ err:
     error_propagate(errp, local_err);
 }
=20
-static const char *spapr_core_models[] =3D {
-    /* 970 */
-    "970_v2.2",
-
-    /* 970MP variants */
-    "970mp_v1.0",
-    "970mp_v1.1",
-
-    /* POWER5+ */
-    "power5+_v2.1",
-
-    /* POWER7 */
-    "power7_v2.3",
-
-    /* POWER7+ */
-    "power7+_v2.1",
-
-    /* POWER8 */
-    "power8_v2.0",
-
-    /* POWER8E */
-    "power8e_v2.1",
-
-    /* POWER8NVL */
-    "power8nvl_v1.0",
-
-    /* POWER9 */
-    "power9_v1.0",
-    "power9_v2.0",
-};
-
 static Property spapr_cpu_core_properties[] =3D {
     DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
     DEFINE_PROP_END_OF_LIST()
@@ -265,33 +234,33 @@ void spapr_cpu_core_class_init(ObjectClass *oc, voi=
d *data)
     g_assert(scc->cpu_class);
 }
=20
-static const TypeInfo spapr_cpu_core_type_info =3D {
-    .name =3D TYPE_SPAPR_CPU_CORE,
-    .parent =3D TYPE_CPU_CORE,
-    .abstract =3D true,
-    .instance_size =3D sizeof(sPAPRCPUCore),
-    .class_size =3D sizeof(sPAPRCPUCoreClass),
-};
-
-static void spapr_cpu_core_register_types(void)
-{
-    int i;
-
-    type_register_static(&spapr_cpu_core_type_info);
-
-    for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
-        TypeInfo type_info =3D {
-            .parent =3D TYPE_SPAPR_CPU_CORE,
-            .instance_size =3D sizeof(sPAPRCPUCore),
-            .class_init =3D spapr_cpu_core_class_init,
-            .class_data =3D (void *) spapr_core_models[i],
-        };
-
-        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
-                                         spapr_core_models[i]);
-        type_register(&type_info);
-        g_free((void *)type_info.name);
+#define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
+    {                                                   \
+        .parent =3D TYPE_SPAPR_CPU_CORE,                  \
+        .class_data =3D (void *) cpu_model,               \
+        .class_init =3D spapr_cpu_core_class_init,        \
+        .name =3D SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
     }
-}
=20
-type_init(spapr_cpu_core_register_types)
+static const TypeInfo spapr_cpu_core_type_infos[] =3D {
+    {
+        .name =3D TYPE_SPAPR_CPU_CORE,
+        .parent =3D TYPE_CPU_CORE,
+        .abstract =3D true,
+        .instance_size =3D sizeof(sPAPRCPUCore),
+        .class_size =3D sizeof(sPAPRCPUCoreClass),
+    },
+    DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
+};
+
+DEFINE_TYPES(spapr_cpu_core_type_infos)
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 93051e9ecf..66dcf52587 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -21,6 +21,8 @@
 #define SPAPR_CPU_CORE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
=20
+#define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
+
 typedef struct sPAPRCPUCore {
     /*< private >*/
     CPUCore parent_obj;
--=20
2.13.6
