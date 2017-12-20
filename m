Received: from eggs.gnu.org ([2001:4830:134:3::10]:47571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij8-0004PQ-QJ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij1-0002Sy-1d
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRij0-0002SK-Ma
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:14 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:45 +0100
Message-Id: <20171220180358.29316-7-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/19] i386: refactor KVM cpuid code so that it
 applies to hvf as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch generalizes some code in cpu.c for hypervisor-based
accelerators, calling the new hvf_get_supported_cpuid where
KVM used kvm_get_supported_cpuid.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-12-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu-qom.h |  4 +--
 target/i386/cpu.c     | 77 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index c2205e6077..22f95eb3a4 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -47,7 +47,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
 /**
  * X86CPUClass:
  * @cpu_def: CPU model definition
- * @kvm_required: Whether CPU model requires KVM to be enabled.
+ * @host_cpuid_required: Whether CPU model requires cpuid from host.
  * @ordering: Ordering on the "-cpu help" CPU model list.
  * @migration_safe: See CpuDefinitionInfo::migration_safe
  * @static_model: See CpuDefinitionInfo::static
@@ -66,7 +66,7 @@ typedef struct X86CPUClass {
      */
     X86CPUDefinition *cpu_def;
 
-    bool kvm_required;
+    bool host_cpuid_required;
     int ordering;
     bool migration_safe;
     bool static_model;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 82603e3130..7b472962fc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hvf.h"
 #include "sysemu/cpus.h"
 #include "kvm_i386.h"
 
@@ -615,6 +616,11 @@ static uint32_t xsave_area_size(uint64_t mask)
     return ret;
 }
 
+static inline bool accel_uses_host_cpuid(void)
+{
+    return kvm_enabled() || hvf_enabled();
+}
+
 static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
 {
     return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
@@ -1686,10 +1692,15 @@ static void max_x86_cpu_initfn(Object *obj)
      */
     cpu->max_features = true;
 
-    if (kvm_enabled()) {
+    if (accel_uses_host_cpuid()) {
         char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
         char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
         int family, model, stepping;
+        X86CPUDefinition host_cpudef = { };
+        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
+
+        host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+        x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
 
         host_vendor_fms(vendor, &family, &model, &stepping);
 
@@ -1703,12 +1714,21 @@ static void max_x86_cpu_initfn(Object *obj)
         object_property_set_str(OBJECT(cpu), model_id, "model-id",
                                 &error_abort);
 
-        env->cpuid_min_level =
-            kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
-        env->cpuid_min_xlevel =
-            kvm_arch_get_supported_cpuid(s, 0x80000000, 0, R_EAX);
-        env->cpuid_min_xlevel2 =
-            kvm_arch_get_supported_cpuid(s, 0xC0000000, 0, R_EAX);
+        if (kvm_enabled()) {
+            env->cpuid_min_level =
+                kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
+            env->cpuid_min_xlevel =
+                kvm_arch_get_supported_cpuid(s, 0x80000000, 0, R_EAX);
+            env->cpuid_min_xlevel2 =
+                kvm_arch_get_supported_cpuid(s, 0xC0000000, 0, R_EAX);
+        } else {
+            env->cpuid_min_level =
+                hvf_get_supported_cpuid(0x0, 0, R_EAX);
+            env->cpuid_min_xlevel =
+                hvf_get_supported_cpuid(0x80000000, 0, R_EAX);
+            env->cpuid_min_xlevel2 =
+                hvf_get_supported_cpuid(0xC0000000, 0, R_EAX);
+        }
 
         if (lmce_supported()) {
             object_property_set_bool(OBJECT(cpu), true, "lmce", &error_abort);
@@ -1734,18 +1754,21 @@ static const TypeInfo max_x86_cpu_type_info = {
     .class_init = max_x86_cpu_class_init,
 };
 
-#ifdef CONFIG_KVM
-
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
 static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
-    xcc->kvm_required = true;
+    xcc->host_cpuid_required = true;
     xcc->ordering = 8;
 
-    xcc->model_description =
-        "KVM processor with all supported host features "
-        "(only available in KVM mode)";
+    if (kvm_enabled()) {
+        xcc->model_description =
+            "KVM processor with all supported host features ";
+    } else if (hvf_enabled()) {
+        xcc->model_description =
+            "HVF processor with all supported host features ";
+    }
 }
 
 static const TypeInfo host_x86_cpu_type_info = {
@@ -1767,7 +1790,7 @@ static void report_unavailable_features(FeatureWord w, uint32_t mask)
             assert(reg);
             warn_report("%s doesn't support requested feature: "
                         "CPUID.%02XH:%s%s%s [bit %d]",
-                        kvm_enabled() ? "host" : "TCG",
+                        accel_uses_host_cpuid() ? "host" : "TCG",
                         f->cpuid_eax, reg,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
@@ -2218,7 +2241,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
     Error *err = NULL;
     strList **next = missing_feats;
 
-    if (xcc->kvm_required && !kvm_enabled()) {
+    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         strList *new = g_new0(strList, 1);
         new->value = g_strdup("kvm");
         *missing_feats = new;
@@ -2380,6 +2403,10 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
         r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid_eax,
                                                     wi->cpuid_ecx,
                                                     wi->cpuid_reg);
+    } else if (hvf_enabled()) {
+        r = hvf_get_supported_cpuid(wi->cpuid_eax,
+                                    wi->cpuid_ecx,
+                                    wi->cpuid_reg);
     } else if (tcg_enabled()) {
         r = wi->tcg_features;
     } else {
@@ -2439,6 +2466,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
     }
 
     /* Special cases not set in the X86CPUDefinition structs: */
+    /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
         if (!kvm_irqchip_in_kernel()) {
             x86_cpu_change_kvm_default("x2apic", "off");
@@ -2459,7 +2487,7 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
      * when doing cross vendor migration
      */
     vendor = def->vendor;
-    if (kvm_enabled()) {
+    if (accel_uses_host_cpuid()) {
         uint32_t  ebx = 0, ecx = 0, edx = 0;
         host_cpuid(0, 0, NULL, &ebx, &ecx, &edx);
         x86_cpu_vendor_words2str(host_vendor, ebx, edx, ecx);
@@ -2910,6 +2938,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = kvm_arch_get_supported_cpuid(s, 0xA, count, R_EBX);
             *ecx = kvm_arch_get_supported_cpuid(s, 0xA, count, R_ECX);
             *edx = kvm_arch_get_supported_cpuid(s, 0xA, count, R_EDX);
+        } else if (hvf_enabled() && cpu->enable_pmu) {
+            *eax = hvf_get_supported_cpuid(0xA, count, R_EAX);
+            *ebx = hvf_get_supported_cpuid(0xA, count, R_EBX);
+            *ecx = hvf_get_supported_cpuid(0xA, count, R_ECX);
+            *edx = hvf_get_supported_cpuid(0xA, count, R_EDX);
         } else {
             *eax = 0;
             *ebx = 0;
@@ -3261,6 +3294,9 @@ static void x86_cpu_reset(CPUState *s)
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
     }
+    else if (hvf_enabled()) {
+        hvf_reset_vcpu(s);
+    }
 #endif
 }
 
@@ -3300,6 +3336,7 @@ APICCommonClass *apic_get_class(void)
 {
     const char *apic_type = "apic";
 
+    /* TODO: in-kernel irqchip for hvf */
     if (kvm_apic_in_kernel()) {
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
@@ -3613,7 +3650,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     static bool ht_warned;
 
-    if (xcc->kvm_required && !kvm_enabled()) {
+    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         char *name = x86_cpu_class_get_model_name(xcc);
         error_setg(&local_err, "CPU model '%s' requires KVM", name);
         g_free(name);
@@ -3635,7 +3672,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         x86_cpu_report_filtered_features(cpu);
         if (cpu->enforce_cpuid) {
             error_setg(&local_err,
-                       kvm_enabled() ?
+                       accel_uses_host_cpuid() ?
                            "Host doesn't support requested features" :
                            "TCG doesn't support requested features");
             goto out;
@@ -3658,7 +3695,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * consumer AMD devices but nothing else.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
-        if (kvm_enabled()) {
+        if (accel_uses_host_cpuid()) {
             uint32_t host_phys_bits = x86_host_phys_bits();
             static bool warned;
 
@@ -4278,7 +4315,7 @@ static void x86_cpu_register_types(void)
     }
     type_register_static(&max_x86_cpu_type_info);
     type_register_static(&x86_base_cpu_type_info);
-#ifdef CONFIG_KVM
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     type_register_static(&host_x86_cpu_type_info);
 #endif
 }
-- 
2.14.3
