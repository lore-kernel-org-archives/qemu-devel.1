Received: from eggs.gnu.org ([2001:4830:134:3::10]:34173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Wg-0005Vx-B6
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Wd-0000dx-6B
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Wc-0000by-Tq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:42 +0200
Message-Id: <20171027142107.15542-15-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 14/39] openrisc: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

use new OPENRISC_CPU_TYPE_NAME to compose CPU type name and get
rid of intermediate OpenRISCCPUInfo/openrisc_cpu_register_types()
which is replaced by static TypeInfo array.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-18-git-send-email-imammedo@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/openrisc/cpu.h |  3 +++
 target/openrisc/cpu.c | 69 +++++++++++++++++----------------------------=
------
 2 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 892dc4210f..cc22dc8871 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -392,6 +392,9 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_mode=
l)
=20
+#define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
+#define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+
 #include "exec/cpu-all.h"
=20
 #define TB_FLAGS_DFLAG 1
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a8db869e50..e0394b8b06 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -101,7 +101,7 @@ static ObjectClass *openrisc_cpu_class_by_name(const =
char *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_OPENRISC_CPU, cpu_model);
+    typename =3D g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model=
);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CP=
U) ||
@@ -126,16 +126,6 @@ static void openrisc_any_initfn(Object *obj)
     cpu->env.cpucfgr =3D CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
 }
=20
-typedef struct OpenRISCCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-} OpenRISCCPUInfo;
-
-static const OpenRISCCPUInfo openrisc_cpus[] =3D {
-    { .name =3D "or1200",      .initfn =3D or1200_initfn },
-    { .name =3D "any",         .initfn =3D openrisc_any_initfn },
-};
-
 static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 {
     OpenRISCCPUClass *occ =3D OPENRISC_CPU_CLASS(oc);
@@ -166,40 +156,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc,=
 void *data)
     cc->tcg_initialize =3D openrisc_translate_init;
 }
=20
-static void cpu_register(const OpenRISCCPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_OPENRISC_CPU,
-        .instance_size =3D sizeof(OpenRISCCPU),
-        .instance_init =3D info->initfn,
-        .class_size =3D sizeof(OpenRISCCPUClass),
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_OPENRISC_CPU, info->na=
me);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo openrisc_cpu_type_info =3D {
-    .name =3D TYPE_OPENRISC_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(OpenRISCCPU),
-    .instance_init =3D openrisc_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(OpenRISCCPUClass),
-    .class_init =3D openrisc_cpu_class_init,
-};
-
-static void openrisc_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&openrisc_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(openrisc_cpus); i++) {
-        cpu_register(&openrisc_cpus[i]);
-    }
-}
-
 /* Sort alphabetically by type name, except for "any". */
 static gint openrisc_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
@@ -248,4 +204,25 @@ void cpu_openrisc_list(FILE *f, fprintf_function cpu=
_fprintf)
     g_slist_free(list);
 }
=20
-type_init(openrisc_cpu_register_types)
+#define DEFINE_OPENRISC_CPU_TYPE(cpu_model, initfn) \
+    {                                               \
+        .parent =3D TYPE_OPENRISC_CPU,                \
+        .instance_init =3D initfn,                    \
+        .name =3D OPENRISC_CPU_TYPE_NAME(cpu_model),  \
+    }
+
+static const TypeInfo openrisc_cpus_type_infos[] =3D {
+    { /* base class should be registered first */
+        .name =3D TYPE_OPENRISC_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(OpenRISCCPU),
+        .instance_init =3D openrisc_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(OpenRISCCPUClass),
+        .class_init =3D openrisc_cpu_class_init,
+    },
+    DEFINE_OPENRISC_CPU_TYPE("or1200", or1200_initfn),
+    DEFINE_OPENRISC_CPU_TYPE("any", openrisc_any_initfn),
+};
+
+DEFINE_TYPES(openrisc_cpus_type_infos)
--=20
2.13.6
