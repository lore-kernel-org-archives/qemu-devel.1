Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WW-0005Qf-QY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WT-0000NC-LL
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85WT-0000Ls-Cf
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:22:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:40 +0200
Message-Id: <20171027142107.15542-13-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 12/39] moxie: cleanup cpu type name
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

introduce MOXIE_CPU_TYPE_NAME macro and consistently use it
to construct cpu type names. While at it replace dynamic
cpu type name composition with static data.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-16-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/moxie/cpu.h |  3 +++
 target/moxie/cpu.c | 56 +++++++++++++++++-------------------------------=
------
 2 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 75decaadd6..d37e6a5572 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -122,6 +122,9 @@ int cpu_moxie_signal_handler(int host_signum, void *p=
info,
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
=20
+#define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
+#define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_moxie_signal_handler
=20
 static inline int cpu_mmu_index(CPUMoxieState *env, bool ifetch)
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 44441b2cf2..f1389e5097 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -86,7 +86,7 @@ static ObjectClass *moxie_cpu_class_by_name(const char =
*cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    typename =3D g_strdup_printf("%s-" TYPE_MOXIE_CPU, cpu_model);
+    typename =3D g_strdup_printf(MOXIE_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) =
||
@@ -134,46 +134,24 @@ static void moxie_any_initfn(Object *obj)
     /* Set cpu feature flags */
 }
=20
-typedef struct MoxieCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-} MoxieCPUInfo;
-
-static const MoxieCPUInfo moxie_cpus[] =3D {
-    { .name =3D "MoxieLite",      .initfn =3D moxielite_initfn },
-    { .name =3D "any",            .initfn =3D moxie_any_initfn },
-};
+#define DEFINE_MOXIE_CPU_TYPE(cpu_model, initfn) \
+    {                                            \
+        .parent =3D TYPE_MOXIE_CPU,                \
+        .instance_init =3D initfn,                 \
+        .name =3D MOXIE_CPU_TYPE_NAME(cpu_model),  \
+    }
=20
-static void cpu_register(const MoxieCPUInfo *info)
-{
-    TypeInfo type_info =3D {
-        .parent =3D TYPE_MOXIE_CPU,
+static const TypeInfo moxie_cpus_type_infos[] =3D {
+    { /* base class should be registered first */
+        .name =3D TYPE_MOXIE_CPU,
+        .parent =3D TYPE_CPU,
         .instance_size =3D sizeof(MoxieCPU),
-        .instance_init =3D info->initfn,
+        .instance_init =3D moxie_cpu_initfn,
         .class_size =3D sizeof(MoxieCPUClass),
-    };
-
-    type_info.name =3D g_strdup_printf("%s-" TYPE_MOXIE_CPU, info->name)=
;
-    type_register(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo moxie_cpu_type_info =3D {
-    .name =3D TYPE_MOXIE_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(MoxieCPU),
-    .instance_init =3D moxie_cpu_initfn,
-    .class_size =3D sizeof(MoxieCPUClass),
-    .class_init =3D moxie_cpu_class_init,
+        .class_init =3D moxie_cpu_class_init,
+    },
+    DEFINE_MOXIE_CPU_TYPE("MoxieLite", moxielite_initfn),
+    DEFINE_MOXIE_CPU_TYPE("any", moxie_any_initfn),
 };
=20
-static void moxie_cpu_register_types(void)
-{
-    int i;
-    type_register_static(&moxie_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(moxie_cpus); i++) {
-        cpu_register(&moxie_cpus[i]);
-    }
-}
-
-type_init(moxie_cpu_register_types)
+DEFINE_TYPES(moxie_cpus_type_infos)
--=20
2.13.6
