Received: from eggs.gnu.org ([2001:4830:134:3::10]:58048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVd-0001cT-2q
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fnjVb-00020W-4L
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fnjVa-0001xT-Ol
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:53:39 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  9 Aug 2018 19:53:29 +0800
Message-Id: <1533815609-37245-4-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1533815609-37245-1-git-send-email-robert.hu@linux.intel.com>
References: <1533815609-37245-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 3/3] Change other funcitons referring to
 feature_word_info[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: robert.hu@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Add an util function feature_word_description(), which help construct the string
describing the feature word (both CPUID and MSR types).

report_unavailable_features(): add MSR_FEATURE_WORD type support.
x86_cpu_get_feature_words(): limit to CPUID_FEATURE_WORD only.
x86_cpu_get_supported_feature_word(): add MSR_FEATURE_WORD type support.
x86_cpu_adjust_feat_level(): assert the requested feature must be
CPUID_FEATURE_WORD type.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 76 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 77e1859..51989e5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3024,21 +3024,50 @@ static const TypeInfo host_x86_cpu_type_info = {
 
 #endif
 
+/*
+*caller should have input str no less than 64 byte length.
+*/
+#define FEATURE_WORD_DESCPTION_LEN 64
+static int feature_word_description(char str[], FeatureWordInfo *f,
+                                    uint32_t bit)
+{
+    int ret;
+
+    assert(f->type == CPUID_FEATURE_WORD ||
+        f->type == MSR_FEATURE_WORD);
+    switch (f->type) {
+    case CPUID_FEATURE_WORD:
+        {
+            const char *reg = get_register_name_32(f->cpuid.reg);
+            assert(reg);
+            ret = snprintf(str, FEATURE_WORD_DESCPTION_LEN,
+                    "CPUID.%02XH:%s%s%s [bit %d]",
+                    f->cpuid.eax, reg,
+                    f->feat_names[bit] ? "." : "",
+                    f->feat_names[bit] ? f->feat_names[bit] : "", bit);
+            break;
+        }
+    case MSR_FEATURE_WORD:
+        ret = snprintf(str, FEATURE_WORD_DESCPTION_LEN,
+            "MSR(%xH).%s [bit %d]",
+            f->msr.index,
+            f->feat_names[bit] ? f->feat_names[bit] : "", bit);
+        break;
+    }
+    return ret > 0;
+}
+
 static void report_unavailable_features(FeatureWord w, uint32_t mask)
 {
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
+    char feat_word_dscrp_str[FEATURE_WORD_DESCPTION_LEN];
 
     for (i = 0; i < 32; ++i) {
         if ((1UL << i) & mask) {
-            const char *reg = get_register_name_32(f->cpuid_reg);
-            assert(reg);
-            warn_report("%s doesn't support requested feature: "
-                        "CPUID.%02XH:%s%s%s [bit %d]",
+            feature_word_description(feat_word_dscrp_str, f, i);
+            warn_report("%s doesn't support requested feature: %s",
                         accel_uses_host_cpuid() ? "host" : "TCG",
-                        f->cpuid_eax, reg,
-                        f->feat_names[i] ? "." : "",
-                        f->feat_names[i] ? f->feat_names[i] : "", i);
+                        feat_word_dscrp_str);
         }
     }
 }
@@ -3276,17 +3305,17 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
 {
     uint32_t *array = (uint32_t *)opaque;
     FeatureWord w;
-    X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
-    X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
+    X86CPUFeatureWordInfo word_infos[FEATURE_WORDS_NUM_CPUID] = { };
+    X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS_NUM_CPUID] = { };
     X86CPUFeatureWordInfoList *list = NULL;
 
-    for (w = 0; w < FEATURE_WORDS; w++) {
+    for (w = 0; w < FEATURE_WORDS_NUM_CPUID; w++) {
         FeatureWordInfo *wi = &feature_word_info[w];
         X86CPUFeatureWordInfo *qwi = &word_infos[w];
-        qwi->cpuid_input_eax = wi->cpuid_eax;
-        qwi->has_cpuid_input_ecx = wi->cpuid_needs_ecx;
-        qwi->cpuid_input_ecx = wi->cpuid_ecx;
-        qwi->cpuid_register = x86_reg_info_32[wi->cpuid_reg].qapi_enum;
+        qwi->cpuid_input_eax = wi->cpuid.eax;
+        qwi->has_cpuid_input_ecx = wi->cpuid.needs_ecx;
+        qwi->cpuid_input_ecx = wi->cpuid.ecx;
+        qwi->cpuid_register = x86_reg_info_32[wi->cpuid.reg].qapi_enum;
         qwi->features = array[w];
 
         /* List will be in reverse order, but order shouldn't matter */
@@ -3659,12 +3688,20 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r;
+    uint32_t r = 0;
 
     if (kvm_enabled()) {
-        r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid_eax,
-                                                    wi->cpuid_ecx,
-                                                    wi->cpuid_reg);
+        switch (wi->type) {
+        case CPUID_FEATURE_WORD:
+            r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
+                                                wi->cpuid.ecx,
+                                                wi->cpuid.reg);
+            break;
+        case MSR_FEATURE_WORD:
+            r = kvm_arch_get_supported_msr_feature(kvm_state,
+                        wi->msr.index);
+            break;
+        }
     } else if (hvf_enabled()) {
         r = hvf_get_supported_cpuid(wi->cpuid_eax,
                                     wi->cpuid_ecx,
@@ -4732,9 +4769,10 @@ static void x86_cpu_adjust_feat_level(X86CPU *cpu, FeatureWord w)
 {
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *fi = &feature_word_info[w];
-    uint32_t eax = fi->cpuid_eax;
+    uint32_t eax = fi->cpuid.eax;
     uint32_t region = eax & 0xF0000000;
 
+    assert(feature_word_info[w].type == CPUID_FEATURE_WORD);
     if (!env->features[w]) {
         return;
     }
-- 
1.8.3.1
