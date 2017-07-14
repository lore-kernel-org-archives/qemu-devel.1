Received: from eggs.gnu.org ([2001:4830:134:3::10]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11T-0001Nh-Q6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11S-0001DV-AL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11R-0001CI-W6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:52:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:51:55 +0200
Message-Id: <1500040339-119465-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC cpu
 subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

QOMfy cpu models handling introducing propper cpu types
for each cpu model.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
with this and conversion of features to properties,
it would be possible to replace cpu_sparc_init() with
cpu_generic_init() and reuse common -cpu handling
infrastructure.

CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu-qom.h |   2 +
 target/sparc/cpu.c     | 119 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 83 insertions(+), 38 deletions(-)

diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index f63af72..af6d57a 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -35,6 +35,7 @@
 #define SPARC_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(SPARCCPUClass, (obj), TYPE_SPARC_CPU)
 
+typedef struct sparc_def_t sparc_def_t;
 /**
  * SPARCCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -49,6 +50,7 @@ typedef struct SPARCCPUClass {
 
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
+    sparc_def_t *cpu_def;
 } SPARCCPUClass;
 
 typedef struct SPARCCPU SPARCCPU;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d606eb5..f8cf751 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -25,8 +25,6 @@
 
 //#define DEBUG_FEATURES
 
-static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char *cpu_model);
-
 /* CPUClass::reset() */
 static void sparc_cpu_reset(CPUState *s)
 {
@@ -111,17 +109,9 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
 {
     CPUSPARCState *env = &cpu->env;
     char *s = g_strdup(cpu_model);
-    char *featurestr, *name = strtok(s, ",");
-    sparc_def_t def1, *def = &def1;
+    char *featurestr = strtok(s, ",");
     Error *err = NULL;
 
-    if (cpu_sparc_find_by_name(def, name) < 0) {
-        g_free(s);
-        return -1;
-    }
-
-    env->def = g_memdup(def, sizeof(*def));
-
     featurestr = strtok(NULL, ",");
     sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
     g_free(s);
@@ -130,18 +120,18 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
         return -1;
     }
 
-    env->version = def->iu_version;
-    env->fsr = def->fpu_version;
-    env->nwindows = def->nwindows;
+    env->version = env->def->iu_version;
+    env->fsr = env->def->fpu_version;
+    env->nwindows = env->def->nwindows;
 #if !defined(TARGET_SPARC64)
-    env->mmuregs[0] |= def->mmu_version;
+    env->mmuregs[0] |= env->def->mmu_version;
     cpu_sparc_set_id(env, 0);
-    env->mxccregs[7] |= def->mxcc_version;
+    env->mxccregs[7] |= env->def->mxcc_version;
 #else
-    env->mmu_version = def->mmu_version;
-    env->maxtl = def->maxtl;
-    env->version |= def->maxtl << 8;
-    env->version |= def->nwindows - 1;
+    env->mmu_version = env->def->mmu_version;
+    env->maxtl = env->def->maxtl;
+    env->version |= env->def->maxtl << 8;
+    env->version |= env->def->nwindows - 1;
 #endif
     return 0;
 }
@@ -149,8 +139,19 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
 SPARCCPU *cpu_sparc_init(const char *cpu_model)
 {
     SPARCCPU *cpu;
+    ObjectClass *oc;
+    char *str, *name;
+
+    str = g_strdup(cpu_model);
+    name = strtok(str, ",");
+    oc = cpu_class_by_name(TYPE_SPARC_CPU, name);
+    if (oc == NULL) {
+        g_free(str);
+        return NULL;
+    }
+    g_free(str);
 
-    cpu = SPARC_CPU(object_new(TYPE_SPARC_CPU));
+    cpu = SPARC_CPU(object_new(object_class_get_name(oc)));
 
     if (cpu_sparc_register(cpu, cpu_model) < 0) {
         object_unref(OBJECT(cpu));
@@ -553,23 +554,6 @@ static void add_flagname_to_bitmaps(const char *flagname, uint32_t *features)
     error_report("CPU feature %s not found", flagname);
 }
 
-static int cpu_sparc_find_by_name(sparc_def_t *cpu_def, const char *name)
-{
-    unsigned int i;
-    const sparc_def_t *def = NULL;
-
-    for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
-        if (strcasecmp(name, sparc_defs[i].name) == 0) {
-            def = &sparc_defs[i];
-        }
-    }
-    if (!def) {
-        return -1;
-    }
-    memcpy(cpu_def, def, sizeof(*def));
-    return 0;
-}
-
 static void sparc_cpu_parse_features(CPUState *cs, char *features,
                                      Error **errp)
 {
@@ -796,6 +780,36 @@ static bool sparc_cpu_has_work(CPUState *cs)
            cpu_interrupts_enabled(env);
 }
 
+static char *sparc_cpu_type_name(const char *cpu_model)
+{
+    char *name = g_strdup_printf("%s-" TYPE_SPARC_CPU, cpu_model);
+    char *s = name;
+
+    /* SPARC cpu model names happen to have whitespaces,
+     * as type names shouldn't have spaces replace them with '-'
+     */
+    while ((s = strchr(s, ' '))) {
+        *s = '-';
+    }
+
+    return name;
+}
+
+static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+
+    if (cpu_model == NULL) {
+        return NULL;
+    }
+
+    typename = sparc_cpu_type_name(cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
+    return oc;
+}
+
 static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -825,6 +839,7 @@ static void sparc_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
     SPARCCPU *cpu = SPARC_CPU(obj);
+    SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
     CPUSPARCState *env = &cpu->env;
 
     cs->env_ptr = env;
@@ -832,6 +847,8 @@ static void sparc_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         gen_intermediate_code_init(env);
     }
+
+    env->def = g_memdup(scc->cpu_def, sizeof(*scc->cpu_def));
 }
 
 static void sparc_cpu_uninitfn(Object *obj)
@@ -854,6 +871,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     scc->parent_reset = cc->reset;
     cc->reset = sparc_cpu_reset;
 
+    cc->class_by_name = sparc_cpu_class_by_name;
     cc->has_work = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
@@ -893,9 +911,34 @@ static const TypeInfo sparc_cpu_type_info = {
     .class_init = sparc_cpu_class_init,
 };
 
+static void sparc_cpu_cpudef_class_init(ObjectClass *oc, void *data)
+{
+    SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
+    scc->cpu_def = data;
+}
+
+static void sparc_register_cpudef_type(const struct sparc_def_t *def)
+{
+    char *typename = sparc_cpu_type_name(def->name);
+    TypeInfo ti = {
+        .name = typename,
+        .parent = TYPE_SPARC_CPU,
+        .class_init = sparc_cpu_cpudef_class_init,
+        .class_data = (void *)def,
+    };
+
+    type_register(&ti);
+    g_free(typename);
+}
+
 static void sparc_cpu_register_types(void)
 {
+    int i;
+
     type_register_static(&sparc_cpu_type_info);
+    for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
+        sparc_register_cpudef_type(&sparc_defs[i]);
+    }
 }
 
 type_init(sparc_cpu_register_types)
-- 
2.7.4
