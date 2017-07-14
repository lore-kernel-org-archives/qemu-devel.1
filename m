Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11w-0001lG-LL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11v-0001ag-6m
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11u-0001aJ-U5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:15 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:00 +0200
Message-Id: <1500040339-119465-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 09/28] sparc: replace custom cpu feature
 parsing with cpu_legacy_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

with features converted to properties we can reuse shared
with x86 cpu_legacy_parse_featurestr() for features parsing
and drop legacy parser that manipulated CPU directly.

With that in place and sparc_cpu_parse_features() providing
generic CPUClass::parse_features callback, the cpu_sparc_init()
will do the same job as cpu_generic_init() so replace content
of cpu_sparc_init() with it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 default-configs/sparc-bsd-user.mak         |   1 +
 default-configs/sparc-linux-user.mak       |   1 +
 default-configs/sparc-softmmu.mak          |   1 +
 default-configs/sparc32plus-linux-user.mak |   1 +
 default-configs/sparc64-bsd-user.mak       |   1 +
 default-configs/sparc64-linux-user.mak     |   1 +
 default-configs/sparc64-softmmu.mak        |   1 +
 target/sparc/cpu.c                         | 160 ++++-------------------------
 8 files changed, 27 insertions(+), 140 deletions(-)

diff --git a/default-configs/sparc-bsd-user.mak b/default-configs/sparc-bsd-user.mak
index 21e0950..caea9ea 100644
--- a/default-configs/sparc-bsd-user.mak
+++ b/default-configs/sparc-bsd-user.mak
@@ -1 +1,2 @@
 # Default configuration for sparc-bsd-user
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc-linux-user.mak b/default-configs/sparc-linux-user.mak
index 9c716d1..0f23504 100644
--- a/default-configs/sparc-linux-user.mak
+++ b/default-configs/sparc-linux-user.mak
@@ -1 +1,2 @@
 # Default configuration for sparc-linux-user
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index 004b0f4..d8fa9fd 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -18,3 +18,4 @@ CONFIG_GRLIB=y
 CONFIG_STP2000=y
 CONFIG_ECCMEMCTL=y
 CONFIG_SUN4M=y
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc32plus-linux-user.mak b/default-configs/sparc32plus-linux-user.mak
index 432e880..e3cc16b 100644
--- a/default-configs/sparc32plus-linux-user.mak
+++ b/default-configs/sparc32plus-linux-user.mak
@@ -1 +1,2 @@
 # Default configuration for sparc32plus-linux-user
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc64-bsd-user.mak b/default-configs/sparc64-bsd-user.mak
index b8b9eea..25bfa1f 100644
--- a/default-configs/sparc64-bsd-user.mak
+++ b/default-configs/sparc64-bsd-user.mak
@@ -1 +1,2 @@
 # Default configuration for sparc64-bsd-user
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc64-linux-user.mak b/default-configs/sparc64-linux-user.mak
index bf1bdd6..7c8a9f0 100644
--- a/default-configs/sparc64-linux-user.mak
+++ b/default-configs/sparc64-linux-user.mak
@@ -1 +1,2 @@
 # Default configuration for sparc64-linux-user
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index d07876a..658546a 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -16,3 +16,4 @@ CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_SUN4V_RTC=y
+CONFIG_LEGACY_CPU_FEATURES=y
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cb13540..1271b7f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -104,51 +104,23 @@ static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-static void sparc_cpu_parse_features(CPUState *cs, char *features,
-                                     Error **errp);
+/* Compatibily hack to maintain legacy +-feat semantic,
+ * where +-feat overwrites any feature set by
+ * feat=on|feat even if the later is parsed after +-feat
+ * (i.e. "-float,float=on" will result in "float" disabled)
+ */
+static GList *plus_features, *minus_features;
 
-static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
+static void sparc_cpu_parse_features(const char *typename, char *features,
+                                     Error **errp)
 {
-    char *s = g_strdup(cpu_model);
-    char *featurestr = strtok(s, ",");
-    Error *err = NULL;
-
-    featurestr = strtok(NULL, ",");
-    sparc_cpu_parse_features(CPU(cpu), featurestr, &err);
-    g_free(s);
-    if (err) {
-        error_report_err(err);
-        return -1;
-    }
-
-    return 0;
+    cpu_legacy_parse_featurestr(typename, features,
+        &plus_features, &minus_features, errp);
 }
 
 SPARCCPU *cpu_sparc_init(const char *cpu_model)
 {
-    SPARCCPU *cpu;
-    ObjectClass *oc;
-    char *str, *name;
-
-    str = g_strdup(cpu_model);
-    name = strtok(str, ",");
-    oc = cpu_class_by_name(TYPE_SPARC_CPU, name);
-    if (oc == NULL) {
-        g_free(str);
-        return NULL;
-    }
-    g_free(str);
-
-    cpu = SPARC_CPU(object_new(object_class_get_name(oc)));
-
-    if (cpu_sparc_register(cpu, cpu_model) < 0) {
-        object_unref(OBJECT(cpu));
-        return NULL;
-    }
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
 }
 
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
@@ -529,107 +501,6 @@ static void print_features(FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-static void add_flagname_to_bitmaps(const char *flagname, uint32_t *features)
-{
-    unsigned int i;
-
-    for (i = 0; i < ARRAY_SIZE(feature_name); i++) {
-        if (feature_name[i] && !strcmp(flagname, feature_name[i])) {
-            *features |= 1 << i;
-            return;
-        }
-    }
-    error_report("CPU feature %s not found", flagname);
-}
-
-static void sparc_cpu_parse_features(CPUState *cs, char *features,
-                                     Error **errp)
-{
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    sparc_def_t *cpu_def = &cpu->env.def;
-    char *featurestr;
-    uint32_t plus_features = 0;
-    uint32_t minus_features = 0;
-    uint64_t iu_version;
-    uint32_t fpu_version, mmu_version, nwindows;
-
-    featurestr = features ? strtok(features, ",") : NULL;
-    while (featurestr) {
-        char *val;
-
-        if (featurestr[0] == '+') {
-            add_flagname_to_bitmaps(featurestr + 1, &plus_features);
-        } else if (featurestr[0] == '-') {
-            add_flagname_to_bitmaps(featurestr + 1, &minus_features);
-        } else if ((val = strchr(featurestr, '='))) {
-            *val = 0; val++;
-            if (!strcmp(featurestr, "iu_version")) {
-                char *err;
-
-                iu_version = strtoll(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->iu_version = iu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "iu_version %" PRIx64 "\n", iu_version);
-#endif
-            } else if (!strcmp(featurestr, "fpu_version")) {
-                char *err;
-
-                fpu_version = strtol(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->fpu_version = fpu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "fpu_version %x\n", fpu_version);
-#endif
-            } else if (!strcmp(featurestr, "mmu_version")) {
-                char *err;
-
-                mmu_version = strtol(val, &err, 0);
-                if (!*val || *err) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->mmu_version = mmu_version;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "mmu_version %x\n", mmu_version);
-#endif
-            } else if (!strcmp(featurestr, "nwindows")) {
-                char *err;
-
-                nwindows = strtol(val, &err, 0);
-                if (!*val || *err || nwindows > MAX_NWINDOWS ||
-                    nwindows < MIN_NWINDOWS) {
-                    error_setg(errp, "bad numerical value %s", val);
-                    return;
-                }
-                cpu_def->nwindows = nwindows;
-#ifdef DEBUG_FEATURES
-                fprintf(stderr, "nwindows %d\n", nwindows);
-#endif
-            } else {
-                error_setg(errp, "unrecognized feature %s", featurestr);
-                return;
-            }
-        } else {
-            error_setg(errp, "feature string `%s' not in format "
-                             "(+feature|-feature|feature=xyz)", featurestr);
-            return;
-        }
-        featurestr = strtok(NULL, ",");
-    }
-    cpu_def->features |= plus_features;
-    cpu_def->features &= ~minus_features;
-#ifdef DEBUG_FEATURES
-    print_features(stderr, fprintf, cpu_def->features, NULL);
-#endif
-}
-
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
     unsigned int i;
@@ -806,6 +677,14 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
 
+    if (cpu_legacy_apply_features(OBJECT(cpu), plus_features, true, errp)) {
+        return;
+    }
+
+    if (cpu_legacy_apply_features(OBJECT(cpu), minus_features, false, errp)) {
+        return;
+    }
+
 #if defined(CONFIG_USER_ONLY)
     if ((env->def.features & CPU_FEATURE_FLOAT)) {
         env->def.features |= CPU_FEATURE_FLOAT128;
@@ -932,6 +811,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = sparc_cpu_reset;
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->parse_features = sparc_cpu_parse_features;
     cc->has_work = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
-- 
2.7.4
