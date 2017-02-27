Received: from eggs.gnu.org ([2001:4830:134:3::10]:43721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6u-0007wE-O2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6s-0005Cs-Iv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6s-0005Cf-AF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:14 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:54 -0300
Message-Id: <20170227162501.29280-5-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/11] i386: Reorganize and document CPUID
 initialization steps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

CPU runnability checks and CPU model expansion have slightly
different requirements. Document the steps involved in loading a
CPU model and realizing a CPU, so their requirements and purpose
are clearly defined.

This patch doesn't change any implementation. It just add
comments, rename the x86_cpu_load_features() function for clarity
(so it won't be confused with x86_cpu_load_def()), and move
x86_cpu_filter_features() closer to it.

Message-Id: <20170116211124.29245-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 102 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 87affbfcd6..b614887a61 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2059,7 +2059,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static void x86_cpu_load_features(X86CPU *cpu, Error **errp);
+static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 static int x86_cpu_filter_features(X86CPU *cpu);
 
 /* Check for missing features that may prevent the CPU class from
@@ -2082,9 +2082,9 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
 
-    x86_cpu_load_features(xc, &err);
+    x86_cpu_expand_features(xc, &err);
     if (err) {
-        /* Errors at x86_cpu_load_features should never happen,
+        /* Errors at x86_cpu_expand_features should never happen,
          * but in case it does, just report the model as not
          * runnable at all using the "type" property.
          */
@@ -2245,31 +2245,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
     return r;
 }
 
-/*
- * Filters CPU feature words based on host availability of each feature.
- *
- * Returns: 0 if all flags are supported by the host, non-zero otherwise.
- */
-static int x86_cpu_filter_features(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    FeatureWord w;
-    int rv = 0;
-
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t host_feat =
-            x86_cpu_get_supported_feature_word(w, false);
-        uint32_t requested_features = env->features[w];
-        env->features[w] &= host_feat;
-        cpu->filtered_features[w] = requested_features & ~env->features[w];
-        if (cpu->filtered_features[w]) {
-            rv = 1;
-        }
-    }
-
-    return rv;
-}
-
 static void x86_cpu_report_filtered_features(X86CPU *cpu)
 {
     FeatureWord w;
@@ -3093,8 +3068,47 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
 }
 
-/* Load CPUID data based on configured features */
-static void x86_cpu_load_features(X86CPU *cpu, Error **errp)
+/***** Steps involved on loading and filtering CPUID data
+ *
+ * When initializing and realizing a CPU object, the steps
+ * involved in setting up CPUID data are:
+ *
+ * 1) Loading CPU model definition (X86CPUDefinition). This is
+ *    implemented by x86_cpu_load_def() and should be completely
+ *    transparent, as it is done automatically by instance_init.
+ *    No code should need to look at X86CPUDefinition structs
+ *    outside instance_init.
+ *
+ * 2) CPU expansion. This is done by realize before CPUID
+ *    filtering, and will make sure host/accelerator data is
+ *    loaded for CPU models that depend on host capabilities
+ *    (e.g. "host"). Done by x86_cpu_expand_features().
+ *
+ * 3) CPUID filtering. This initializes extra data related to
+ *    CPUID, and checks if the host supports all capabilities
+ *    required by the CPU. Runnability of a CPU model is
+ *    determined at this step. Done by x86_cpu_filter_features().
+ *
+ * Some operations don't require all steps to be performed.
+ * More precisely:
+ *
+ * - CPU instance creation (instance_init) will run only CPU
+ *   model loading. CPU expansion can't run at instance_init-time
+ *   because host/accelerator data may be not available yet.
+ * - CPU realization will perform both CPU model expansion and CPUID
+ *   filtering, and return an error in case one of them fails.
+ * - query-cpu-definitions needs to run all 3 steps. It needs
+ *   to run CPUID filtering, as the 'unavailable-features'
+ *   field is set based on the filtering results.
+ * - The query-cpu-model-expansion QMP command only needs to run
+ *   CPU model loading and CPU expansion. It should not filter
+ *   any CPUID data based on host capabilities.
+ */
+
+/* Expand CPU configuration data, based on configured features
+ * and host/accelerator capabilities when appropriate.
+ */
+static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
@@ -3171,6 +3185,32 @@ out:
     }
 }
 
+/*
+ * Finishes initialization of CPUID data, filters CPU feature
+ * words based on host availability of each feature.
+ *
+ * Returns: 0 if all flags are supported by the host, non-zero otherwise.
+ */
+static int x86_cpu_filter_features(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWord w;
+    int rv = 0;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        uint32_t host_feat =
+            x86_cpu_get_supported_feature_word(w, false);
+        uint32_t requested_features = env->features[w];
+        env->features[w] &= host_feat;
+        cpu->filtered_features[w] = requested_features & ~env->features[w];
+        if (cpu->filtered_features[w]) {
+            rv = 1;
+        }
+    }
+
+    return rv;
+}
+
 #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
                            (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
                            (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
@@ -3198,7 +3238,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    x86_cpu_load_features(cpu, &local_err);
+    x86_cpu_expand_features(cpu, &local_err);
     if (local_err) {
         goto out;
     }
-- 
2.11.0.259.g40922b1
