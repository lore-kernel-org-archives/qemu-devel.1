Received: from eggs.gnu.org ([2001:4830:134:3::10]:43824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ilx-0003cQ-Do
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ilr-0006sa-Bj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ilr-0006ru-2v
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:30 +0200
Message-Id: <20171026140404.21948-6-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/39] lm32: cleanup cpu type name composition
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

introduce LM32_CPU_TYPE_NAME macro and consistently use it
to construct cpu type names. While at it replace dynamic
cpu type name composition with static data.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Michael Walle <michael@walle.cc>
Message-Id: <1507211474-188400-9-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/lm32/cpu.h |  3 +++
 target/lm32/cpu.c | 74 +++++++++++++++++--------------------------------=
------
 2 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index de265b50d1..2279594f40 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -257,6 +257,9 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_LM32_CPU, cpu_model)
=20
+#define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
+#define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
+
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
=20
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 7f3a292f2b..6f5c14767b 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -51,7 +51,7 @@ static void lm32_cpu_list_entry(gpointer data, gpointer=
 user_data)
     const char *typename =3D object_class_get_name(oc);
     char *name;
=20
-    name =3D g_strndup(typename, strlen(typename) - strlen("-" TYPE_LM32=
_CPU));
+    name =3D g_strndup(typename, strlen(typename) - strlen(LM32_CPU_TYPE=
_SUFFIX));
     (*s->cpu_fprintf)(s->file, "  %s\n", name);
     g_free(name);
 }
@@ -215,32 +215,12 @@ static void lm32_full_cpu_initfn(Object *obj)
                   | LM32_FEATURE_CYCLE_COUNT;
 }
=20
-typedef struct LM32CPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-} LM32CPUInfo;
-
-static const LM32CPUInfo lm32_cpus[] =3D {
-    {
-        .name =3D "lm32-basic",
-        .initfn =3D lm32_basic_cpu_initfn,
-    },
-    {
-        .name =3D "lm32-standard",
-        .initfn =3D lm32_standard_cpu_initfn,
-    },
-    {
-        .name =3D "lm32-full",
-        .initfn =3D lm32_full_cpu_initfn,
-    },
-};
-
 static ObjectClass *lm32_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_LM32_CPU, cpu_model);
+    typename =3D g_strdup_printf(LM32_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_LM32_CPU) |=
|
@@ -283,36 +263,26 @@ static void lm32_cpu_class_init(ObjectClass *oc, vo=
id *data)
     cc->tcg_initialize =3D lm32_translate_init;
 }
=20
-static void lm32_register_cpu_type(const LM32CPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_LM32_CPU,
-        .instance_init =3D info->initfn,
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_LM32_CPU, info->name);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
+#define DEFINE_LM32_CPU_TYPE(cpu_model, initfn) \
+    { \
+        .parent =3D TYPE_LM32_CPU, \
+        .name =3D LM32_CPU_TYPE_NAME(cpu_model), \
+        .instance_init =3D initfn, \
+    }
=20
-static const TypeInfo lm32_cpu_type_info =3D {
-    .name =3D TYPE_LM32_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(LM32CPU),
-    .instance_init =3D lm32_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(LM32CPUClass),
-    .class_init =3D lm32_cpu_class_init,
+static const TypeInfo lm32_cpus_type_infos[] =3D {
+    { /* base class should be registered first */
+         .name =3D TYPE_LM32_CPU,
+         .parent =3D TYPE_CPU,
+         .instance_size =3D sizeof(LM32CPU),
+         .instance_init =3D lm32_cpu_initfn,
+         .abstract =3D true,
+         .class_size =3D sizeof(LM32CPUClass),
+         .class_init =3D lm32_cpu_class_init,
+    },
+    DEFINE_LM32_CPU_TYPE("lm32-basic", lm32_basic_cpu_initfn),
+    DEFINE_LM32_CPU_TYPE("lm32-standard", lm32_standard_cpu_initfn),
+    DEFINE_LM32_CPU_TYPE("lm32-full", lm32_full_cpu_initfn),
 };
=20
-static void lm32_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&lm32_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(lm32_cpus); i++) {
-        lm32_register_cpu_type(&lm32_cpus[i]);
-    }
-}
-
-type_init(lm32_cpu_register_types)
+DEFINE_TYPES(lm32_cpus_type_infos)
--=20
2.13.6
