Received: from eggs.gnu.org ([2001:4830:134:3::10]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7inj-0005Cu-VO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ind-0000nX-R6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ind-0000mD-H7
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:51 +0200
Message-Id: <20171026140404.21948-27-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/39] tricore: cleanup cpu type name composition
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

introduce TRICORE_CPU_TYPE_NAME macro and use it to construct
cpu type names. While at it move cpu type_infos into one
array and register it directly with type_init_from_array()
instead of custom tricore_cpu_register_types()/cpu_register()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-30-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/tricore/cpu.h |  2 ++
 target/tricore/cpu.c | 68 ++++++++++++++++------------------------------=
------
 2 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index bc53c40774..f41d2ceb69 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -413,6 +413,8 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreSta=
te *env, target_ulong *pc,
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_TRICORE_CPU, cpu_model=
)
=20
+#define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
+#define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
=20
 /* helpers.c */
 int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index cd93806d47..179c997aa4 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -116,7 +116,7 @@ static ObjectClass *tricore_cpu_class_by_name(const c=
har *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_TRICORE_CPU, cpu_model);
+    typename =3D g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model)=
;
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (!oc || !object_class_dynamic_cast(oc, TYPE_TRICORE_CPU) ||
@@ -147,19 +147,6 @@ static void tc27x_initfn(Object *obj)
     set_feature(&cpu->env, TRICORE_FEATURE_161);
 }
=20
-typedef struct TriCoreCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-} TriCoreCPUInfo;
-
-static const TriCoreCPUInfo tricore_cpus[] =3D {
-    { .name =3D "tc1796",      .initfn =3D tc1796_initfn },
-    { .name =3D "tc1797",      .initfn =3D tc1797_initfn },
-    { .name =3D "tc27x",       .initfn =3D tc27x_initfn },
-    { .name =3D NULL }
-};
-
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
 {
     TriCoreCPUClass *mcc =3D TRICORE_CPU_CLASS(c);
@@ -181,41 +168,26 @@ static void tricore_cpu_class_init(ObjectClass *c, =
void *data)
     cc->tcg_initialize =3D tricore_tcg_init;
 }
=20
-static void cpu_register(const TriCoreCPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_TRICORE_CPU,
+#define DEFINE_TRICORE_CPU_TYPE(cpu_model, initfn) \
+    {                                              \
+        .parent =3D TYPE_TRICORE_CPU,                \
+        .instance_init =3D initfn,                   \
+        .name =3D TRICORE_CPU_TYPE_NAME(cpu_model),  \
+    }
+
+static const TypeInfo tricore_cpu_type_infos[] =3D {
+    {
+        .name =3D TYPE_TRICORE_CPU,
+        .parent =3D TYPE_CPU,
         .instance_size =3D sizeof(TriCoreCPU),
-        .instance_init =3D info->initfn,
+        .instance_init =3D tricore_cpu_initfn,
+        .abstract =3D true,
         .class_size =3D sizeof(TriCoreCPUClass),
-        .class_init =3D info->class_init,
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_TRICORE_CPU, info->nam=
e);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo tricore_cpu_type_info =3D {
-    .name =3D TYPE_TRICORE_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(TriCoreCPU),
-    .instance_init =3D tricore_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(TriCoreCPUClass),
-    .class_init =3D tricore_cpu_class_init,
+        .class_init =3D tricore_cpu_class_init,
+    },
+    DEFINE_TRICORE_CPU_TYPE("tc1796", tc1796_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc1797", tc1797_initfn),
+    DEFINE_TRICORE_CPU_TYPE("tc27x", tc27x_initfn),
 };
=20
-static void tricore_cpu_register_types(void)
-{
-    const TriCoreCPUInfo *info =3D tricore_cpus;
-
-    type_register_static(&tricore_cpu_type_info);
-
-    while (info->name) {
-        cpu_register(info);
-        info++;
-    }
-}
-
-type_init(tricore_cpu_register_types)
+DEFINE_TYPES(tricore_cpu_type_infos)
--=20
2.13.6
