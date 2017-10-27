Received: from eggs.gnu.org ([2001:4830:134:3::10]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Ve-0001zx-LN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Vd-00083m-BW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Vd-000836-26
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:29 +0200
Message-Id: <20171027142107.15542-2-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/39] alpha: cleanup cpu type name
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

Introduce ALPHA_CPU_TYPE_NAME macro to replace rather ununique
TYPE macro that alpha uses. With new macro it will follow
the same naming convention as other targets.

While at it put scattered TypeInfo into one array which places
type desriptions at one place and reduces code a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-5-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/alpha/cpu.h |   3 ++
 target/alpha/cpu.c | 107 +++++++++++++++++------------------------------=
------
 2 files changed, 37 insertions(+), 73 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 6ae240969b..0a9ad35f06 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -470,6 +470,9 @@ void alpha_translate_init(void);
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
=20
+#define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
+#define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
+
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index bc9520535b..7d6366bae9 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -108,21 +108,18 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_f=
printf)
 }
=20
 /* Models */
-
-#define TYPE(model) model "-" TYPE_ALPHA_CPU
-
 typedef struct AlphaCPUAlias {
     const char *alias;
     const char *typename;
 } AlphaCPUAlias;
=20
 static const AlphaCPUAlias alpha_cpu_aliases[] =3D {
-    { "21064",   TYPE("ev4") },
-    { "21164",   TYPE("ev5") },
-    { "21164a",  TYPE("ev56") },
-    { "21164pc", TYPE("pca56") },
-    { "21264",   TYPE("ev6") },
-    { "21264a",  TYPE("ev67") },
+    { "21064",   ALPHA_CPU_TYPE_NAME("ev4") },
+    { "21164",   ALPHA_CPU_TYPE_NAME("ev5") },
+    { "21164a",  ALPHA_CPU_TYPE_NAME("ev56") },
+    { "21164pc", ALPHA_CPU_TYPE_NAME("pca56") },
+    { "21264",   ALPHA_CPU_TYPE_NAME("ev6") },
+    { "21264a",  ALPHA_CPU_TYPE_NAME("ev67") },
 };
=20
 static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
@@ -145,7 +142,7 @@ static ObjectClass *alpha_cpu_class_by_name(const cha=
r *cpu_model)
         }
     }
=20
-    typename =3D g_strdup_printf("%s-" TYPE_ALPHA_CPU, cpu_model);
+    typename =3D g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && object_class_is_abstract(oc)) {
@@ -155,7 +152,7 @@ static ObjectClass *alpha_cpu_class_by_name(const cha=
r *cpu_model)
     /* TODO: remove match everything nonsense */
     /* Default to ev67; no reason not to emulate insns by default. */
     if (!oc) {
-        oc =3D object_class_by_name(TYPE("ev67"));
+        oc =3D object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
     }
=20
     return oc;
@@ -169,12 +166,6 @@ static void ev4_cpu_initfn(Object *obj)
     env->implver =3D IMPLVER_2106x;
 }
=20
-static const TypeInfo ev4_cpu_type_info =3D {
-    .name =3D TYPE("ev4"),
-    .parent =3D TYPE_ALPHA_CPU,
-    .instance_init =3D ev4_cpu_initfn,
-};
-
 static void ev5_cpu_initfn(Object *obj)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(obj);
@@ -183,12 +174,6 @@ static void ev5_cpu_initfn(Object *obj)
     env->implver =3D IMPLVER_21164;
 }
=20
-static const TypeInfo ev5_cpu_type_info =3D {
-    .name =3D TYPE("ev5"),
-    .parent =3D TYPE_ALPHA_CPU,
-    .instance_init =3D ev5_cpu_initfn,
-};
-
 static void ev56_cpu_initfn(Object *obj)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(obj);
@@ -197,12 +182,6 @@ static void ev56_cpu_initfn(Object *obj)
     env->amask |=3D AMASK_BWX;
 }
=20
-static const TypeInfo ev56_cpu_type_info =3D {
-    .name =3D TYPE("ev56"),
-    .parent =3D TYPE("ev5"),
-    .instance_init =3D ev56_cpu_initfn,
-};
-
 static void pca56_cpu_initfn(Object *obj)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(obj);
@@ -211,12 +190,6 @@ static void pca56_cpu_initfn(Object *obj)
     env->amask |=3D AMASK_MVI;
 }
=20
-static const TypeInfo pca56_cpu_type_info =3D {
-    .name =3D TYPE("pca56"),
-    .parent =3D TYPE("ev56"),
-    .instance_init =3D pca56_cpu_initfn,
-};
-
 static void ev6_cpu_initfn(Object *obj)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(obj);
@@ -226,12 +199,6 @@ static void ev6_cpu_initfn(Object *obj)
     env->amask =3D AMASK_BWX | AMASK_FIX | AMASK_MVI | AMASK_TRAP;
 }
=20
-static const TypeInfo ev6_cpu_type_info =3D {
-    .name =3D TYPE("ev6"),
-    .parent =3D TYPE_ALPHA_CPU,
-    .instance_init =3D ev6_cpu_initfn,
-};
-
 static void ev67_cpu_initfn(Object *obj)
 {
     AlphaCPU *cpu =3D ALPHA_CPU(obj);
@@ -240,17 +207,6 @@ static void ev67_cpu_initfn(Object *obj)
     env->amask |=3D AMASK_CIX | AMASK_PREFETCH;
 }
=20
-static const TypeInfo ev67_cpu_type_info =3D {
-    .name =3D TYPE("ev67"),
-    .parent =3D TYPE("ev6"),
-    .instance_init =3D ev67_cpu_initfn,
-};
-
-static const TypeInfo ev68_cpu_type_info =3D {
-    .name =3D TYPE("ev68"),
-    .parent =3D TYPE("ev67"),
-};
-
 static void alpha_cpu_initfn(Object *obj)
 {
     CPUState *cs =3D CPU(obj);
@@ -302,26 +258,31 @@ static void alpha_cpu_class_init(ObjectClass *oc, v=
oid *data)
     cc->gdb_num_core_regs =3D 67;
 }
=20
-static const TypeInfo alpha_cpu_type_info =3D {
-    .name =3D TYPE_ALPHA_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(AlphaCPU),
-    .instance_init =3D alpha_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(AlphaCPUClass),
-    .class_init =3D alpha_cpu_class_init,
+#define DEFINE_ALPHA_CPU_TYPE(base_type, cpu_model, initfn) \
+     {                                                      \
+         .parent =3D base_type,                               \
+         .instance_init =3D initfn,                           \
+         .name =3D ALPHA_CPU_TYPE_NAME(cpu_model),            \
+     }
+
+static const TypeInfo alpha_cpu_type_infos[] =3D {
+    {
+        .name =3D TYPE_ALPHA_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(AlphaCPU),
+        .instance_init =3D alpha_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(AlphaCPUClass),
+        .class_init =3D alpha_cpu_class_init,
+    },
+    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev4", ev4_cpu_initfn),
+    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev5", ev5_cpu_initfn),
+    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev5"), "ev56", ev56_cpu_i=
nitfn),
+    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev56"), "pca56",
+                          pca56_cpu_initfn),
+    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev6", ev6_cpu_initfn),
+    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev6"), "ev67", ev67_cpu_i=
nitfn),
+    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev67"), "ev68", NULL),
 };
=20
-static void alpha_cpu_register_types(void)
-{
-    type_register_static(&alpha_cpu_type_info);
-    type_register_static(&ev4_cpu_type_info);
-    type_register_static(&ev5_cpu_type_info);
-    type_register_static(&ev56_cpu_type_info);
-    type_register_static(&pca56_cpu_type_info);
-    type_register_static(&ev6_cpu_type_info);
-    type_register_static(&ev67_cpu_type_info);
-    type_register_static(&ev68_cpu_type_info);
-}
-
-type_init(alpha_cpu_register_types)
+DEFINE_TYPES(alpha_cpu_type_infos)
--=20
2.13.6
