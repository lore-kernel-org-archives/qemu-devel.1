Received: from eggs.gnu.org ([2001:4830:134:3::10]:43755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ilm-0003Su-SY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ili-0006l3-N5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ili-0006kE-EH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:28 +0200
Message-Id: <20171026140404.21948-4-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/39] cris: cleanup cpu type name composition
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

replace ambiguous TYPE macro with a new CRIS_CPU_TYPE_NAME
and use it consistently in the code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1507211474-188400-7-git-send-email-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/cris/cpu.h |  3 +++
 target/cris/cpu.c | 81 +++++++++++++++++++------------------------------=
------
 2 files changed, 30 insertions(+), 54 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 5d822dee16..b64fa3542c 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -269,6 +269,9 @@ enum {
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
=20
+#define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
+#define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
+
 #define cpu_signal_handler cpu_cris_signal_handler
=20
 /* MMU modes definitions */
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 527a3448bf..949c7a6e25 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -71,11 +71,11 @@ static ObjectClass *cris_cpu_class_by_name(const char=
 *cpu_model)
=20
 #if defined(CONFIG_USER_ONLY)
     if (strcasecmp(cpu_model, "any") =3D=3D 0) {
-        return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
+        return object_class_by_name(CRIS_CPU_TYPE_NAME("crisv32"));
     }
 #endif
=20
-    typename =3D g_strdup_printf("%s-" TYPE_CRIS_CPU, cpu_model);
+    typename =3D g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU) |=
|
@@ -108,7 +108,7 @@ static void cris_cpu_list_entry(gpointer data, gpoint=
er user_data)
     const char *typename =3D object_class_get_name(oc);
     char *name;
=20
-    name =3D g_strndup(typename, strlen(typename) - strlen("-" TYPE_CRIS=
_CPU));
+    name =3D g_strndup(typename, strlen(typename) - strlen(CRIS_CPU_TYPE=
_SUFFIX));
     (*s->cpu_fprintf)(s->file, "  %s\n", name);
     g_free(name);
 }
@@ -254,38 +254,6 @@ static void crisv32_cpu_class_init(ObjectClass *oc, =
void *data)
     ccc->vr =3D 32;
 }
=20
-#define TYPE(model) model "-" TYPE_CRIS_CPU
-
-static const TypeInfo cris_cpu_model_type_infos[] =3D {
-    {
-        .name =3D TYPE("crisv8"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv8_cpu_class_init,
-    }, {
-        .name =3D TYPE("crisv9"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv9_cpu_class_init,
-    }, {
-        .name =3D TYPE("crisv10"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv10_cpu_class_init,
-    }, {
-        .name =3D TYPE("crisv11"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv11_cpu_class_init,
-    }, {
-        .name =3D TYPE("crisv17"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv17_cpu_class_init,
-    }, {
-        .name =3D TYPE("crisv32"),
-        .parent =3D TYPE_CRIS_CPU,
-        .class_init =3D crisv32_cpu_class_init,
-    }
-};
-
-#undef TYPE
-
 static void cris_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -320,24 +288,29 @@ static void cris_cpu_class_init(ObjectClass *oc, vo=
id *data)
     cc->tcg_initialize =3D cris_initialize_tcg;
 }
=20
-static const TypeInfo cris_cpu_type_info =3D {
-    .name =3D TYPE_CRIS_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(CRISCPU),
-    .instance_init =3D cris_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(CRISCPUClass),
-    .class_init =3D cris_cpu_class_init,
-};
+#define DEFINE_CRIS_CPU_TYPE(cpu_model, initfn) \
+     {                                          \
+         .parent =3D TYPE_CRIS_CPU,               \
+         .class_init =3D initfn,                  \
+         .name =3D CRIS_CPU_TYPE_NAME(cpu_model), \
+     }
=20
-static void cris_cpu_register_types(void)
-{
-    int i;
-
-    type_register_static(&cris_cpu_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(cris_cpu_model_type_infos); i++) {
-        type_register_static(&cris_cpu_model_type_infos[i]);
-    }
-}
+static const TypeInfo cris_cpu_model_type_infos[] =3D {
+    {
+        .name =3D TYPE_CRIS_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(CRISCPU),
+        .instance_init =3D cris_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(CRISCPUClass),
+        .class_init =3D cris_cpu_class_init,
+    },
+    DEFINE_CRIS_CPU_TYPE("crisv8", crisv8_cpu_class_init),
+    DEFINE_CRIS_CPU_TYPE("crisv9", crisv9_cpu_class_init),
+    DEFINE_CRIS_CPU_TYPE("crisv10", crisv10_cpu_class_init),
+    DEFINE_CRIS_CPU_TYPE("crisv11", crisv11_cpu_class_init),
+    DEFINE_CRIS_CPU_TYPE("crisv17", crisv17_cpu_class_init),
+    DEFINE_CRIS_CPU_TYPE("crisv32", crisv32_cpu_class_init),
+};
=20
-type_init(cris_cpu_register_types)
+DEFINE_TYPES(cris_cpu_model_type_infos)
--=20
2.13.6
