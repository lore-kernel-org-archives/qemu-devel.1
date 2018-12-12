Received: from eggs.gnu.org ([2001:4830:134:3::10]:54339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPa-00041k-BX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPZ-0007CY-6r
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCPY-0007C3-VL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 593EE9D50B
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:51:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:49 +0400
Message-Id: <20181212214850.29953-28-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 27/28] arm: replace instance_post_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

Replace arm_cpu_post_init() instance callback by calling it from leaf
classes, to avoid potential ordering issue with other post_init callbacks=
.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
---
 target/arm/cpu-qom.h |  3 +++
 target/arm/cpu.h     |  2 ++
 target/arm/cpu.c     | 30 ++++++++++++++++++++++++------
 target/arm/cpu64.c   | 24 ++++++++++++++++++++----
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index d135ff8e06..2049fa9612 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -35,6 +35,8 @@ struct arm_boot_info;
=20
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
=20
+typedef struct ARMCPUInfo ARMCPUInfo;
+
 /**
  * ARMCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -47,6 +49,7 @@ typedef struct ARMCPUClass {
     CPUClass parent_class;
     /*< public >*/
=20
+    const ARMCPUInfo *info;
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
 } ARMCPUClass;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a73fed9a0..84fba2b24b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -884,6 +884,8 @@ static inline ARMCPU *arm_env_get_cpu(CPUARMState *en=
v)
     return container_of(env, ARMCPU, env);
 }
=20
+void arm_cpu_post_init(Object *obj);
+
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
=20
 #define ENV_GET_CPU(e) CPU(arm_env_get_cpu(e))
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..68f65c15ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -734,7 +734,7 @@ static Property arm_cpu_pmsav7_dregion_property =3D
 static Property arm_cpu_initsvtor_property =3D
             DEFINE_PROP_UINT32("init-svtor", ARMCPU, init_svtor, 0);
=20
-static void arm_cpu_post_init(Object *obj)
+void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
=20
@@ -1442,8 +1442,10 @@ static void cortex_m33_initfn(Object *obj)
=20
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
 {
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
     CPUClass *cc =3D CPU_CLASS(oc);
=20
+    acc->info =3D data;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
 #endif
@@ -1940,11 +1942,11 @@ static void arm_max_initfn(Object *obj)
=20
 #endif /* !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64) */
=20
-typedef struct ARMCPUInfo {
+struct ARMCPUInfo {
     const char *name;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, void *data);
-} ARMCPUInfo;
+};
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
@@ -2094,6 +2096,7 @@ static void arm_host_initfn(Object *obj)
     ARMCPU *cpu =3D ARM_CPU(obj);
=20
     kvm_arm_set_cpu_features_from_host(cpu);
+    arm_cpu_post_init(ARM_CPU(obj));
 }
=20
 static const TypeInfo host_arm_cpu_type_info =3D {
@@ -2108,14 +2111,30 @@ static const TypeInfo host_arm_cpu_type_info =3D =
{
=20
 #endif
=20
+static void arm_cpu_instance_init(Object *obj)
+{
+    ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(obj);
+
+    acc->info->initfn(obj);
+    arm_cpu_post_init(obj);
+}
+
+static void cpu_register_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
+
+    acc->info =3D data;
+}
+
 static void cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_ARM_CPU,
         .instance_size =3D sizeof(ARMCPU),
-        .instance_init =3D info->initfn,
+        .instance_init =3D arm_cpu_instance_init,
         .class_size =3D sizeof(ARMCPUClass),
-        .class_init =3D info->class_init,
+        .class_init =3D info->class_init ?: cpu_register_class_init,
+        .class_data =3D (void *)info,
     };
=20
     type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
@@ -2128,7 +2147,6 @@ static const TypeInfo arm_cpu_type_info =3D {
     .parent =3D TYPE_CPU,
     .instance_size =3D sizeof(ARMCPU),
     .instance_init =3D arm_cpu_initfn,
-    .instance_post_init =3D arm_cpu_post_init,
     .instance_finalize =3D arm_cpu_finalizefn,
     .abstract =3D true,
     .class_size =3D sizeof(ARMCPUClass),
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 873f059bf2..f09dc6b20d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -359,11 +359,11 @@ static void aarch64_max_initfn(Object *obj)
     }
 }
=20
-typedef struct ARMCPUInfo {
+struct ARMCPUInfo {
     const char *name;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, void *data);
-} ARMCPUInfo;
+};
=20
 static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
@@ -447,14 +447,30 @@ static void aarch64_cpu_class_init(ObjectClass *oc,=
 void *data)
     cc->gdb_arch_name =3D aarch64_gdb_arch_name;
 }
=20
+static void aarch64_cpu_instance_init(Object *obj)
+{
+    ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(obj);
+
+    acc->info->initfn(obj);
+    arm_cpu_post_init(obj);
+}
+
+static void cpu_register_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
+
+    acc->info =3D data;
+}
+
 static void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_AARCH64_CPU,
         .instance_size =3D sizeof(ARMCPU),
-        .instance_init =3D info->initfn,
+        .instance_init =3D aarch64_cpu_instance_init,
         .class_size =3D sizeof(ARMCPUClass),
-        .class_init =3D info->class_init,
+        .class_init =3D info->class_init ?: cpu_register_class_init,
+        .class_data =3D (void *)info,
     };
=20
     type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
--=20
2.20.0
