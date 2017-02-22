Received: from eggs.gnu.org ([2001:4830:134:3::10]:58989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbp4-0007rd-HS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbp3-000775-Bj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbp3-00076v-3J
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46712804F1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:39:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 15:39:19 -0300
Message-Id: <20170222183919.11928-4-ehabkost@redhat.com>
In-Reply-To: <20170222183919.11928-1-ehabkost@redhat.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] i386: Don't set CPUClass::cpu_def on
 "max" model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Host CPUID info is used by the "max" CPU model only in KVM mode.
Move the initialization of CPUID data for "max" from class_init
to instance_init, and don't set CPUClass::cpu_def for "max".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu-qom.h |  4 +++-
 target/i386/cpu.c     | 45 +++++++++++++++++++++------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 14abd0a8c1..f6c704c3a9 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -60,7 +60,9 @@ typedef struct X86CPUClass {
     CPUClass parent_class;
     /*< public >*/
 
-    /* Should be eventually replaced by subclass-specific property defaults. */
+    /* CPU definition, automatically loaded by instance_init if not NULL.
+     * Should be eventually replaced by subclass-specific property defaults.
+     */
     X86CPUDefinition *cpu_def;
 
     bool kvm_required;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5164cd9ed5..df0783e39b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1531,47 +1531,27 @@ static int cpu_x86_fill_model_id(char *str)
     return 0;
 }
 
-static X86CPUDefinition host_cpudef;
-
 static Property max_x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-/* class_init for the "max" CPU model
- *
- * This function may be called before KVM is initialized.
- */
 static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
-    uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
     xcc->ordering = 9;
 
-    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
-    x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
-
-    host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
-    host_cpudef.family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
-    host_cpudef.model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
-    host_cpudef.stepping = eax & 0x0F;
-
-    cpu_x86_fill_model_id(host_cpudef.model_id);
-
-    xcc->cpu_def = &host_cpudef;
     xcc->model_description =
         "Enables all features supported by the accelerator in the current host";
 
-    /* level, xlevel, xlevel2, and the feature words are initialized on
-     * instance_init, because they require KVM to be initialized.
-     */
-
     dc->props = max_x86_cpu_properties;
 }
 
+static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp);
+
 static void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
@@ -1584,6 +1564,21 @@ static void max_x86_cpu_initfn(Object *obj)
     cpu->max_features = true;
 
     if (kvm_enabled()) {
+        X86CPUDefinition host_cpudef = { };
+        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
+
+        host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+        x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
+
+        host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
+        host_cpudef.family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
+        host_cpudef.model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
+        host_cpudef.stepping = eax & 0x0F;
+
+        cpu_x86_fill_model_id(host_cpudef.model_id);
+
+        x86_cpu_load_def(cpu, &host_cpudef, &error_abort);
+
         env->cpuid_min_level =
             kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
         env->cpuid_min_xlevel =
@@ -2186,7 +2181,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     CPUListState *s = user_data;
     char *name = x86_cpu_class_get_model_name(cc);
     const char *desc = cc->model_description;
-    if (!desc) {
+    if (!desc && cc->cpu_def) {
         desc = cc->cpu_def->model_id;
     }
 
@@ -3644,7 +3639,9 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_1", obj, "sse4.1", &error_abort);
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2", &error_abort);
 
-    x86_cpu_load_def(cpu, xcc->cpu_def, &error_abort);
+    if (xcc->cpu_def) {
+        x86_cpu_load_def(cpu, xcc->cpu_def, &error_abort);
+    }
 }
 
 static int64_t x86_cpu_get_arch_id(CPUState *cs)
-- 
2.11.0.259.g40922b1
