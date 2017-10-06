Received: from eggs.gnu.org ([2001:4830:134:3::10]:41988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYP-00040M-C4
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYO-0001js-HK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYO-0001jT-8i
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BAB081F01
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:53:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:42 -0300
Message-Id: <20171006215244.27104-6-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] target/i386: Handle kvm_auto_* compat in
 x86_cpu_expand_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

x86_cpu_expand_features() is run after global properties are
applied, so we will be able to convert the kvm_auto_* global
variables to QOM properties controlled by
MachineClass::compat_props.

When doing that, we need to use x86_cpu_expand_feature() so we
don't override properties set explicitly by the user.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f8d317f1f9..83e234cef4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2423,22 +2423,6 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
 
     /* Special cases not set in the X86CPUDefinition structs: */
     if (kvm_enabled()) {
-        if (!kvm_irqchip_in_kernel()) {
-            object_property_set_bool(OBJECT(cpu), false, "x2apic",
-                                     &error_abort);
-        } else if (kvm_auto_enable_x2apic) {
-            object_property_set_bool(OBJECT(cpu), true, "x2apic",
-                                     &error_abort);
-        }
-        if (kvm_auto_disable_svm) {
-            object_property_set_bool(OBJECT(cpu), false, "svm",
-                                     &error_abort);
-        }
-        if (kvm_auto_enable_pv_eoi) {
-            object_property_set_bool(OBJECT(cpu), true, "kvm-pv-eoi",
-                                     &error_abort);
-        }
-
         x86_cpu_apply_props(cpu, kvm_default_props);
     } else if (tcg_enabled()) {
         x86_cpu_apply_props(cpu, tcg_default_props);
@@ -3511,6 +3495,31 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     FeatureWord w;
     GList *l;
     Error *local_err = NULL;
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
+
+    /*
+     * Note: "base" is a static CPU model and shouldn't auto-enable KVM
+     * defaults, so we check xcc->cpu_def here.
+     */
+    if (xcc->cpu_def && kvm_enabled()) {
+        /* KVM-specific defaults that depend on compatibility globals: */
+
+        if (!kvm_irqchip_in_kernel()) {
+            x86_cpu_expand_feature(cpu, FEAT_1_ECX, CPUID_EXT_X2APIC, 0);
+        } else if (kvm_auto_enable_x2apic) {
+            x86_cpu_expand_feature(cpu, FEAT_1_ECX, CPUID_EXT_X2APIC,
+                                   CPUID_EXT_X2APIC);
+        }
+
+        if (kvm_auto_disable_svm) {
+            x86_cpu_expand_feature(cpu, FEAT_8000_0001_ECX, CPUID_EXT3_SVM, 0);
+        }
+
+        if (kvm_auto_enable_pv_eoi) {
+            x86_cpu_expand_feature(cpu, FEAT_KVM, (1 << KVM_FEATURE_PV_EOI),
+                                   (1 << KVM_FEATURE_PV_EOI));
+        }
+    }
 
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
-- 
2.13.6
