Received: from eggs.gnu.org ([2001:4830:134:3::10]:50011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSF-0004ke-Qm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSE-00055B-GI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5eSE-00053e-7E
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  2 May 2017 17:31:15 -0300
Message-Id: <20170502203115.22233-5-ehabkost@redhat.com>
In-Reply-To: <20170502203115.22233-1-ehabkost@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] x86: Support feature=force on the
 command-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Introduce a new CPUFeatureSetting QAPI data type, and use it to support
feature=force on -cpu.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json              | 32 +++++++++++++++++++++++++
 target/i386/cpu.h             |  2 ++
 target/i386/cpu.c             | 55 +++++++++++++++++++++++++++++++++----------
 tests/test-x86-cpuid-compat.c | 14 ++++++++++-
 4 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 01b087fa16..d716409114 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4250,6 +4250,38 @@
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
 ##
+# @CPUFeatureSettingEnum:
+#
+# Additional valid values for a CPUFeatureSetting property.
+#
+# @force: Force feature to be enabled, even if the accelerator
+#         reports the feature as unavailable. Should be used only
+#         for testing or debugging purposes.
+#
+# Since: 2.10
+##
+{ 'enum': 'CPUFeatureSettingEnum',
+  'data': ['force'] }
+
+##
+# @CPUFeatureSetting:
+#
+# Values for a CPU feature property.
+#
+# @bool: If false, the feature is forcibly disabled.
+#        If true, QEMU will try to enable the feature. QEMU will
+#        refuse to start if the feature is unavailable and
+#        'enforce' mode is enabled in the CPU.
+#
+# @enum: See @CPUFeatureSettingEnum.
+#
+# Since: 2.10
+##
+{ 'alternate': 'CPUFeatureSetting',
+  'data': { 'bool': 'bool',
+            'enum': 'CPUFeatureSettingEnum' } }
+
+##
 # @CpuDefinitionInfo:
 #
 # Virtual CPU definition.
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4602ca80d..7a34998e0a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1149,6 +1149,8 @@ typedef struct CPUX86State {
     FeatureWordArray features;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
+    /* Features set to 'force' */
+    FeatureWordArray forced_features;
     uint32_t cpuid_model[12];
 
     /* MTRRs */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985f11..6c24b92cee 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3463,7 +3463,7 @@ static int x86_cpu_filter_features(X86CPU *cpu)
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        env->features[w] &= host_feat;
+        env->features[w] &= host_feat | env->forced_features[w];
         cpu->filtered_features[w] = requested_features & ~env->features[w];
         if (cpu->filtered_features[w]) {
             rv = 1;
@@ -3705,9 +3705,19 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 {
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    uint32_t f = cpu->env.features[fp->w];
-    bool value = (f & fp->mask) == fp->mask;
-    visit_type_bool(v, name, &value, errp);
+    bool bvalue = (cpu->env.features[fp->w] & fp->mask) == fp->mask;
+    bool forced = (cpu->env.forced_features[fp->w] & fp->mask) == fp->mask;
+    CPUFeatureSetting *value = g_new0(CPUFeatureSetting, 1);
+
+    if (!forced) {
+        value->type = QTYPE_QBOOL;
+        value->u.q_bool = bvalue;
+    } else {
+        value->type = QTYPE_QSTRING;
+        value->u.q_enum = CPU_FEATURE_SETTING_ENUM_FORCE;
+    }
+    visit_type_CPUFeatureSetting(v, name, &value, errp);
+    qapi_free_CPUFeatureSetting(value);
 }
 
 static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -3717,25 +3727,46 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
     Error *local_err = NULL;
-    bool value;
+    CPUFeatureSetting *value = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
+    visit_type_CPUFeatureSetting(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    if (value) {
-        cpu->env.features[fp->w] |= fp->mask;
-    } else {
-        cpu->env.features[fp->w] &= ~fp->mask;
+    switch (value->type) {
+    case QTYPE_QBOOL:
+        if (value->u.q_bool) {
+            cpu->env.features[fp->w] |= fp->mask;
+        } else {
+            cpu->env.features[fp->w] &= ~fp->mask;
+        }
+        cpu->env.forced_features[fp->w] &= ~fp->mask;
+        cpu->env.user_features[fp->w] |= fp->mask;
+    break;
+    case QTYPE_QSTRING:
+        switch (value->u.q_enum) {
+        case CPU_FEATURE_SETTING_ENUM_FORCE:
+            cpu->env.features[fp->w] |= fp->mask;
+            cpu->env.forced_features[fp->w] |= fp->mask;
+        break;
+        default:
+            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
+                       "CPUFeatureSetting");
+        }
+    break;
+    default:
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name,
+                   "CPUFeatureSetting");
     }
-    cpu->env.user_features[fp->w] |= fp->mask;
+
+    qapi_free_CPUFeatureSetting(value);
 }
 
 static void x86_cpu_release_bit_prop(Object *obj, const char *name,
@@ -3769,7 +3800,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
         fp = g_new0(BitProperty, 1);
         fp->w = w;
         fp->mask = mask;
-        object_property_add(OBJECT(cpu), prop_name, "bool",
+        object_property_add(OBJECT(cpu), prop_name, "CPUFeatureSetting",
                             x86_cpu_get_bit_prop,
                             x86_cpu_set_bit_prop,
                             x86_cpu_release_bit_prop, fp, &error_abort);
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 00ee8a264f..9940f4de1c 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -98,6 +98,8 @@ typedef struct FeatureTestArgs {
     int bitnr;
     /* The expected value for the bit in (X86CPUFeatureWordInfo.features) */
     bool expected_value;
+    /* Don't look at filtered-features when checking feature value */
+    bool ignore_filtered_features;
 } FeatureTestArgs;
 
 /* Get the value for a feature word in a X86CPUFeatureWordInfo list */
@@ -129,7 +131,9 @@ static void test_feature_flag(const void *data)
     present = qobject_to_qlist(qom_get(path, "feature-words"));
     filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
     value = get_feature_word(present, args->input_eax, args->input_ecx, args->reg);
-    value |= get_feature_word(filtered, args->input_eax, args->input_ecx, args->reg);
+    if (!args->ignore_filtered_features) {
+        value |= get_feature_word(filtered, args->input_eax, args->input_ecx, args->reg);
+    }
     qtest_end();
 
     g_assert(!!(value & (1U << args->bitnr)) == args->expected_value);
@@ -336,5 +340,13 @@ int main(int argc, char **argv)
                      "-machine accel=kvm:tcg -cpu max,mmx=off",
                      1, 0, "EDX", 23, false);
 
+    {
+    FeatureTestArgs *a;
+    a = add_feature_test("x86/cpuid/features/monitor-force",
+                         "-machine accel=kvm:tcg -cpu 486,monitor=force",
+                         1, 0, "ECX",  3, true);
+    a->ignore_filtered_features = true;
+    }
+
     return g_test_run();
 }
-- 
2.11.0.259.g40922b1
