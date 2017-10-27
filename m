Received: from eggs.gnu.org ([2001:4830:134:3::10]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85XN-00079I-Vi
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85XM-0001YG-RM
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85XM-0001Xm-Hm
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:52 +0200
Message-Id: <20171027142107.15542-25-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 24/39] unicore32: cleanup cpu type name
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

use new UNICORE32_CPU_TYPE_NAME to compose CPU type
name and get rid of intermediate
   UniCore32CPUInfo/uc32_cpu_register_types()
which is replaced by static TypeInfo array and
type_init_from_array()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-28-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/unicore32/cpu.h |  3 +++
 target/unicore32/cpu.c | 61 +++++++++++++++++---------------------------=
------
 2 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 7724108281..3dc6fbc6c7 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -167,6 +167,9 @@ static inline int cpu_mmu_index(CPUUniCore32State *en=
v, bool ifetch)
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_UNICORE32_CPU, cpu_mod=
el)
=20
+#define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
+#define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
+
 static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_u=
long *pc,
                                         target_ulong *cs_base, uint32_t =
*flags)
 {
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 526604ff78..17dc1504d7 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -44,7 +44,7 @@ static ObjectClass *uc32_cpu_class_by_name(const char *=
cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_UNICORE32_CPU, cpu_model);
+    typename =3D g_strdup_printf(UNICORE32_CPU_TYPE_NAME("%s"), cpu_mode=
l);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_UNICORE32_C=
PU) ||
@@ -54,11 +54,6 @@ static ObjectClass *uc32_cpu_class_by_name(const char =
*cpu_model)
     return oc;
 }
=20
-typedef struct UniCore32CPUInfo {
-    const char *name;
-    void (*instance_init)(Object *obj);
-} UniCore32CPUInfo;
-
 static void unicore_ii_cpu_initfn(Object *obj)
 {
     UniCore32CPU *cpu =3D UNICORE32_CPU(obj);
@@ -90,11 +85,6 @@ static void uc32_any_cpu_initfn(Object *obj)
     set_snan_bit_is_one(1, &env->ucf64.fp_status);
 }
=20
-static const UniCore32CPUInfo uc32_cpus[] =3D {
-    { .name =3D "UniCore-II", .instance_init =3D unicore_ii_cpu_initfn }=
,
-    { .name =3D "any",        .instance_init =3D uc32_any_cpu_initfn },
-};
-
 static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
@@ -160,36 +150,25 @@ static void uc32_cpu_class_init(ObjectClass *oc, vo=
id *data)
     dc->vmsd =3D &vmstate_uc32_cpu;
 }
=20
-static void uc32_register_cpu_type(const UniCore32CPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_UNICORE32_CPU,
-        .instance_init =3D info->instance_init,
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_UNICORE32_CPU, info->n=
ame);
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
+#define DEFINE_UNICORE32_CPU_TYPE(cpu_model, initfn) \
+    {                                                \
+        .parent =3D TYPE_UNICORE32_CPU,                \
+        .instance_init =3D initfn,                     \
+        .name =3D UNICORE32_CPU_TYPE_NAME(cpu_model),  \
+    }
=20
-static const TypeInfo uc32_cpu_type_info =3D {
-    .name =3D TYPE_UNICORE32_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(UniCore32CPU),
-    .instance_init =3D uc32_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(UniCore32CPUClass),
-    .class_init =3D uc32_cpu_class_init,
+static const TypeInfo uc32_cpu_type_infos[] =3D {
+    {
+        .name =3D TYPE_UNICORE32_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(UniCore32CPU),
+        .instance_init =3D uc32_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(UniCore32CPUClass),
+        .class_init =3D uc32_cpu_class_init,
+    },
+    DEFINE_UNICORE32_CPU_TYPE("UniCore-II", unicore_ii_cpu_initfn),
+    DEFINE_UNICORE32_CPU_TYPE("any", uc32_any_cpu_initfn),
 };
=20
-static void uc32_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&uc32_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(uc32_cpus); i++) {
-        uc32_register_cpu_type(&uc32_cpus[i]);
-    }
-}
-
-type_init(uc32_cpu_register_types)
+DEFINE_TYPES(uc32_cpu_type_infos)
--=20
2.13.6
