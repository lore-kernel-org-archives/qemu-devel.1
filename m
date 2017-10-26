Received: from eggs.gnu.org ([2001:4830:134:3::10]:44265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7imz-0004XE-UJ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7imu-0008BE-6m
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7imt-0008Ac-TK
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:43 +0200
Message-Id: <20171026140404.21948-19-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/39] sh4: cleanup cpu type name composition
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

introduce SUPERH_CPU_TYPE_NAME macro and use it to construct
cpu type names. While at it move cpu type_infos into one
array and register it directly with type_init_from_array()
instead of custom superh_cpu_register_types()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-22-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sh4/cpu-qom.h |  6 ++---
 target/sh4/cpu.h     |  3 +++
 target/sh4/cpu.c     | 63 +++++++++++++++++++++-------------------------=
------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 01abb206e4..17deeb661b 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -24,9 +24,9 @@
=20
 #define TYPE_SUPERH_CPU "superh-cpu"
=20
-#define TYPE_SH7750R_CPU "sh7750r-" TYPE_SUPERH_CPU
-#define TYPE_SH7751R_CPU "sh7751r-" TYPE_SUPERH_CPU
-#define TYPE_SH7785_CPU "sh7785-" TYPE_SUPERH_CPU
+#define TYPE_SH7750R_CPU SUPERH_CPU_TYPE_NAME("sh7750r")
+#define TYPE_SH7751R_CPU SUPERH_CPU_TYPE_NAME("sh7751r")
+#define TYPE_SH7785_CPU  SUPERH_CPU_TYPE_NAME("sh7785")
=20
 #define SUPERH_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(SuperHCPUClass, (klass), TYPE_SUPERH_CPU)
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 123f34783a..960b46870d 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -274,6 +274,9 @@ void cpu_load_tlb(CPUSH4State * env);
=20
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_SUPERH_CPU, cpu_model)
=20
+#define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
+#define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
=20
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 89abce2472..ec6db61bdf 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -172,13 +172,6 @@ static void sh7750r_class_init(ObjectClass *oc, void=
 *data)
     scc->cvr =3D 0x00110000;
 }
=20
-static const TypeInfo sh7750r_type_info =3D {
-    .name =3D TYPE_SH7750R_CPU,
-    .parent =3D TYPE_SUPERH_CPU,
-    .class_init =3D sh7750r_class_init,
-    .instance_init =3D sh7750r_cpu_initfn,
-};
-
 static void sh7751r_cpu_initfn(Object *obj)
 {
     SuperHCPU *cpu =3D SUPERH_CPU(obj);
@@ -198,13 +191,6 @@ static void sh7751r_class_init(ObjectClass *oc, void=
 *data)
     scc->cvr =3D 0x00110000; /* Neutered caches, should be 0x20480000 */
 }
=20
-static const TypeInfo sh7751r_type_info =3D {
-    .name =3D TYPE_SH7751R_CPU,
-    .parent =3D TYPE_SUPERH_CPU,
-    .class_init =3D sh7751r_class_init,
-    .instance_init =3D sh7751r_cpu_initfn,
-};
-
 static void sh7785_cpu_initfn(Object *obj)
 {
     SuperHCPU *cpu =3D SUPERH_CPU(obj);
@@ -224,13 +210,6 @@ static void sh7785_class_init(ObjectClass *oc, void =
*data)
     scc->cvr =3D 0x71440211;
 }
=20
-static const TypeInfo sh7785_type_info =3D {
-    .name =3D TYPE_SH7785_CPU,
-    .parent =3D TYPE_SUPERH_CPU,
-    .class_init =3D sh7785_class_init,
-    .instance_init =3D sh7785_cpu_initfn,
-};
-
 static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
@@ -300,22 +279,30 @@ static void superh_cpu_class_init(ObjectClass *oc, =
void *data)
     dc->vmsd =3D &vmstate_sh_cpu;
 }
=20
-static const TypeInfo superh_cpu_type_info =3D {
-    .name =3D TYPE_SUPERH_CPU,
-    .parent =3D TYPE_CPU,
-    .instance_size =3D sizeof(SuperHCPU),
-    .instance_init =3D superh_cpu_initfn,
-    .abstract =3D true,
-    .class_size =3D sizeof(SuperHCPUClass),
-    .class_init =3D superh_cpu_class_init,
-};
+#define DEFINE_SUPERH_CPU_TYPE(type_name, cinit, initfn) \
+    {                                                    \
+        .name =3D type_name,                               \
+        .parent =3D TYPE_SUPERH_CPU,                       \
+        .class_init =3D cinit,                             \
+        .instance_init =3D initfn,                         \
+    }
+static const TypeInfo superh_cpu_type_infos[] =3D {
+    {
+        .name =3D TYPE_SUPERH_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(SuperHCPU),
+        .instance_init =3D superh_cpu_initfn,
+        .abstract =3D true,
+        .class_size =3D sizeof(SuperHCPUClass),
+        .class_init =3D superh_cpu_class_init,
+    },
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7750R_CPU, sh7750r_class_init,
+                           sh7750r_cpu_initfn),
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7751R_CPU, sh7751r_class_init,
+                           sh7751r_cpu_initfn),
+    DEFINE_SUPERH_CPU_TYPE(TYPE_SH7785_CPU, sh7785_class_init,
+                           sh7785_cpu_initfn),
=20
-static void superh_cpu_register_types(void)
-{
-    type_register_static(&superh_cpu_type_info);
-    type_register_static(&sh7750r_type_info);
-    type_register_static(&sh7751r_type_info);
-    type_register_static(&sh7785_type_info);
-}
+};
=20
-type_init(superh_cpu_register_types)
+DEFINE_TYPES(superh_cpu_type_infos)
--=20
2.13.6
