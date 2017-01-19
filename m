Received: from eggs.gnu.org ([2001:4830:134:3::10]:35004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtM-0004nm-LG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtG-0001Mm-QA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJtG-0001LO-Hv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B843B81239
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:05:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:47 -0200
Message-Id: <20170119210449.11991-5-ehabkost@redhat.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] i386: Create "max" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename the existing "host" CPU model to "max, and set it to
kvm_enabled=false. The new "max" CPU model will be able to enable
all features supported by TCG out of the box, because its logic
is based on x86_cpu_get_supported_feature_word(), which already
works with TCG.

A new KVM-specific "host" class was added, that simply inherits
everything from "max" except the 'ordering' and 'description'
fields.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 006d0a8b70..6f3a62840f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1503,8 +1503,6 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value)
 static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
-#ifdef CONFIG_KVM
-
 static bool lmce_supported(void)
 {
     uint64_t mce_cap;
@@ -1533,23 +1531,22 @@ static int cpu_x86_fill_model_id(char *str)
 
 static X86CPUDefinition host_cpudef;
 
-static Property host_x86_cpu_properties[] = {
+static Property max_x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-/* class_init for the "host" CPU model
+/* class_init for the "max" CPU model
  *
  * This function may be called before KVM is initialized.
  */
-static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
+static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
-    xcc->kvm_required = true;
     xcc->ordering = 9;
 
     host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
@@ -1564,17 +1561,16 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
 
     xcc->cpu_def = &host_cpudef;
     xcc->model_description =
-        "KVM processor with all supported host features "
-        "(only available in KVM mode)";
+        "Enables all features supported by the accelerator in the current host";
 
     /* level, xlevel, xlevel2, and the feature words are initialized on
      * instance_init, because they require KVM to be initialized.
      */
 
-    dc->props = host_x86_cpu_properties;
+    dc->props = max_x86_cpu_properties;
 }
 
-static void host_x86_cpu_initfn(Object *obj)
+static void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
@@ -1585,7 +1581,6 @@ static void host_x86_cpu_initfn(Object *obj)
      */
     cpu->max_features = true;
 
-    /* If KVM is disabled, x86_cpu_realizefn() will report an error later */
     if (kvm_enabled()) {
         env->cpuid_min_level =
             kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
@@ -1602,10 +1597,30 @@ static void host_x86_cpu_initfn(Object *obj)
     object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
 }
 
+static const TypeInfo max_x86_cpu_type_info = {
+    .name = X86_CPU_TYPE_NAME("max"),
+    .parent = TYPE_X86_CPU,
+    .instance_init = max_x86_cpu_initfn,
+    .class_init = max_x86_cpu_class_init,
+};
+
+#ifdef CONFIG_KVM
+
+static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(oc);
+
+    xcc->kvm_required = true;
+    xcc->ordering = 8;
+
+    xcc->model_description =
+        "KVM processor with all supported host features "
+        "(only available in KVM mode)";
+}
+
 static const TypeInfo host_x86_cpu_type_info = {
     .name = X86_CPU_TYPE_NAME("host"),
-    .parent = TYPE_X86_CPU,
-    .instance_init = host_x86_cpu_initfn,
+    .parent = X86_CPU_TYPE_NAME("max"),
     .class_init = host_x86_cpu_class_init,
 };
 
@@ -3729,6 +3744,7 @@ static void x86_cpu_register_types(void)
     for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
         x86_register_cpudef_type(&builtin_x86_defs[i]);
     }
+    type_register_static(&max_x86_cpu_type_info);
 #ifdef CONFIG_KVM
     type_register_static(&host_x86_cpu_type_info);
 #endif
-- 
2.11.0.259.g40922b1
