Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSo-0003Dn-Gm
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSn-000361-1d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1kSm-000349-QE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Oct 2017 23:39:54 -0300
Message-Id: <20171010024001.4526-2-ehabkost@redhat.com>
In-Reply-To: <20171010024001.4526-1-ehabkost@redhat.com>
References: <20171010024001.4526-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/8] qom/cpu: move cpu_model null check to
 cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and clean every implementation.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170917232842.14544-1-f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/cpu.c              | 7 ++++++-
 target/alpha/cpu.c     | 6 +-----
 target/arm/cpu.c       | 4 ----
 target/cris/cpu.c      | 4 ----
 target/lm32/cpu.c      | 4 ----
 target/m68k/cpu.c      | 4 ----
 target/mips/cpu.c      | 4 ----
 target/moxie/cpu.c     | 8 +-------
 target/openrisc/cpu.c  | 4 ----
 target/sh4/cpu.c       | 3 ---
 target/sparc/cpu.c     | 4 ----
 target/tricore/cpu.c   | 4 ----
 target/unicore32/cpu.c | 4 ----
 target/xtensa/cpu.c    | 4 ----
 14 files changed, 8 insertions(+), 56 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 94fa8fe005..54c9452b1c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -316,7 +316,12 @@ static bool cpu_common_has_work(CPUState *cs)
=20
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_mod=
el)
 {
-    CPUClass *cc =3D CPU_CLASS(object_class_by_name(typename));
+    CPUClass *cc;
+
+    if (!cpu_model) {
+        return NULL;
+    }
+    cc =3D CPU_CLASS(object_class_by_name(typename));
=20
     return cc->class_by_name(cpu_model);
 }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e6c6aabdf0..b8a21f4e01 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -127,14 +127,10 @@ static const AlphaCPUAlias alpha_cpu_aliases[] =3D =
{
=20
 static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc =3D NULL;
+    ObjectClass *oc;
     char *typename;
     int i;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     oc =3D object_class_by_name(cpu_model);
     if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) !=3D=
 NULL &&
         !object_class_is_abstract(oc)) {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f4f601f079..88578f360e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -939,10 +939,6 @@ static ObjectClass *arm_cpu_class_by_name(const char=
 *cpu_model)
     char *typename;
     char **cpuname;
=20
-    if (!cpu_model) {
-        return NULL;
-    }
-
     cpuname =3D g_strsplit(cpu_model, ",", 1);
     typename =3D g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
     oc =3D object_class_by_name(typename);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index ceebfed79b..88d93f2d11 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -69,10 +69,6 @@ static ObjectClass *cris_cpu_class_by_name(const char =
*cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
 #if defined(CONFIG_USER_ONLY)
     if (strcasecmp(cpu_model, "any") =3D=3D 0) {
         return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 2b8c36b6d0..bf081f56d2 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -246,10 +246,6 @@ static ObjectClass *lm32_cpu_class_by_name(const cha=
r *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_LM32_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 55bf24bae6..8c70e0805c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -87,10 +87,6 @@ static ObjectClass *m68k_cpu_class_by_name(const char =
*cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_M68K_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1a9a3ed94d..c15b894362 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -166,10 +166,6 @@ static ObjectClass *mips_cpu_class_by_name(const cha=
r *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D mips_cpu_type_name(cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 748d02f29e..30bd44fcad 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -89,13 +89,7 @@ static void moxie_cpu_initfn(Object *obj)
=20
 static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc;
-
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
-    oc =3D object_class_by_name(cpu_model);
+    ObjectClass *oc =3D object_class_by_name(cpu_model);
     if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) =
||
                        object_class_is_abstract(oc))) {
         return NULL;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a979f0bf8b..af9cdcc102 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -108,10 +108,6 @@ static ObjectClass *openrisc_cpu_class_by_name(const=
 char *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_OPENRISC_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 6ce7cba5a9..252440e019 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -133,9 +133,6 @@ static ObjectClass *superh_cpu_class_by_name(const ch=
ar *cpu_model)
     ObjectClass *oc;
     GSList *list, *item;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
     if (strcasecmp(cpu_model, "any") =3D=3D 0) {
         return object_class_by_name(TYPE_SH7750R_CPU);
     }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0806d699e6..beab90f3e6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -730,10 +730,6 @@ static ObjectClass *sparc_cpu_class_by_name(const ch=
ar *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D sparc_cpu_type_name(cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 5ab5b56454..871eb35453 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -120,10 +120,6 @@ static ObjectClass *tricore_cpu_class_by_name(const =
char *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (!cpu_model) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_TRICORE_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index c9b78ce68e..138acc9dd8 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -44,10 +44,6 @@ static ObjectClass *uc32_cpu_class_by_name(const char =
*cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_UNICORE32_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 85897df0a8..dcdc765a86 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -83,10 +83,6 @@ static ObjectClass *xtensa_cpu_class_by_name(const cha=
r *cpu_model)
     ObjectClass *oc;
     char *typename;
=20
-    if (cpu_model =3D=3D NULL) {
-        return NULL;
-    }
-
     typename =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
     oc =3D object_class_by_name(typename);
     g_free(typename);
--=20
2.13.6
