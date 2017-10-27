Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WC-0002cP-Ex
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85W9-0008U9-9y
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85W9-0008TU-08
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:36 +0200
Message-Id: <20171027142107.15542-9-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/39] m68k: cleanup cpu type name composition
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

use new M68K_CPU_TYPE_NAME to compose CPU type names
and get rid of intermediate M68kCPUInfo/register_cpu_type()
which is replaced by static TypeInfo array.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1507211474-188400-12-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/m68k/cpu.h |  3 +++
 target/m68k/cpu.c | 75 ++++++++++++++++++++-----------------------------=
------
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d9365476e5..afae5f68ac 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -323,6 +323,9 @@ void register_m68k_insns (CPUM68KState *env);
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_M68K_CPU, cpu_model)
=20
+#define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
+#define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_m68k_signal_handler
 #define cpu_list m68k_cpu_list
=20
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5da19e570b..0a3dd83548 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -87,7 +87,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char *=
cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_M68K_CPU, cpu_model);
+    typename =3D g_strdup_printf(M68K_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (object_class_dynamic_cast(oc, TYPE_M68K_CPU) =3D=
=3D NULL ||
@@ -202,23 +202,6 @@ static void any_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
 }
=20
-typedef struct M68kCPUInfo {
-    const char *name;
-    void (*instance_init)(Object *obj);
-} M68kCPUInfo;
-
-static const M68kCPUInfo m68k_cpus[] =3D {
-    { .name =3D "m68000", .instance_init =3D m68000_cpu_initfn },
-    { .name =3D "m68020", .instance_init =3D m68020_cpu_initfn },
-    { .name =3D "m68030", .instance_init =3D m68030_cpu_initfn },
-    { .name =3D "m68040", .instance_init =3D m68040_cpu_initfn },
-    { .name =3D "m68060", .instance_init =3D m68060_cpu_initfn },
-    { .name =3D "m5206", .instance_init =3D m5206_cpu_initfn },
-    { .name =3D "m5208", .instance_init =3D m5208_cpu_initfn },
-    { .name =3D "cfv4e", .instance_init =3D cfv4e_cpu_initfn },
-    { .name =3D "any",   .instance_init =3D any_cpu_initfn },
-};
-
 static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
@@ -290,36 +273,32 @@ static void m68k_cpu_class_init(ObjectClass *c, voi=
d *data)
     dc->vmsd =3D &vmstate_m68k_cpu;
 }
=20
-static void register_cpu_type(const M68kCPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_M68K_CPU,
-        .instance_init =3D info->instance_init,
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_M68K_CPU, info->name);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
+#define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
+    {                                           \
+        .name =3D M68K_CPU_TYPE_NAME(cpu_model),  \
+        .instance_init =3D initfn,                \
+        .parent =3D TYPE_M68K_CPU,                \
+    }
=20
-static const TypeInfo m68k_cpu_type_info =3D {
-    .name =3D TYPE_M68K_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(M68kCPU),
-    .instance_init =3D m68k_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(M68kCPUClass),
-    .class_init =3D m68k_cpu_class_init,
+static const TypeInfo m68k_cpus_type_infos[] =3D {
+    { /* base class should be registered first */
+        .name =3D TYPE_M68K_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(M68kCPU),
+        .instance_init =3D m68k_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(M68kCPUClass),
+        .class_init =3D m68k_cpu_class_init,
+    },
+    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),
 };
=20
-static void m68k_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&m68k_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(m68k_cpus); i++) {
-        register_cpu_type(&m68k_cpus[i]);
-    }
-}
-
-type_init(m68k_cpu_register_types)
+DEFINE_TYPES(m68k_cpus_type_infos)
--=20
2.13.6
