Received: from eggs.gnu.org ([2001:4830:134:3::10]:41963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYM-0003y9-Jx
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYH-0001g0-OH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYH-0001eu-Gd
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 831A04ACCB
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:53:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:40 -0300
Message-Id: <20171006215244.27104-4-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] target/i386: Use global variables to
 control KVM defaults
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

The compatibility rules for KVM defaults are implemented today
using x86_cpu_change_kvm_default(), and representing the
arguments to x86_cpu_change_kvm_default() inside compat_props
would be a challenge.

But the compat system doesn't need to be that complex.  From the
10 entries at kvm_default_props, only 3 of them need to be
affected by machine-type compat code.  It's much simpler and
obvious to just have 3 boolean properties that will control
compatibility mode, and handle them manually at the same place
where kvm_default_props is applied to the CPU object.

This introduces 3 global properties to control the KVM defaults
for x2apic, kvm-pv-eoi, and svm.  The global variables are just
an intermediate step to convert this to 3 X86CPU properties to be
controlled using MachineClass::compat_props.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 14 ++++++--------
 hw/i386/pc_piix.c |  6 +++---
 target/i386/cpu.c | 37 +++++++++++++++++--------------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..0184f98241 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1700,15 +1700,13 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
 
-/* Change the value of a KVM-specific default
- *
- * If value is NULL, no default will be set and the original
- * value from the CPU model table will be kept.
- *
- * It is valid to call this function only for properties that
- * are already present in the kvm_default_props table.
+/*
+ * Compat globals to control features automatically enabled/disabled by KVM.
+ * TODO: convert them to X86CPU fields set by MachineClass::compat_props
  */
-void x86_cpu_change_kvm_default(const char *prop, const char *value);
+extern bool kvm_auto_disable_svm;
+extern bool kvm_auto_enable_x2apic;
+extern bool kvm_auto_enable_pv_eoi;
 
 /* mpx_helper.c */
 void cpu_sync_bndcs_hflags(CPUX86State *env);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 31646e63c4..3e466b3896 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -328,7 +328,7 @@ static void pc_compat_2_2(MachineState *machine)
 static void pc_compat_2_1(MachineState *machine)
 {
     pc_compat_2_2(machine);
-    x86_cpu_change_kvm_default("svm", NULL);
+    kvm_auto_disable_svm = false;
 }
 
 static void pc_compat_2_0(MachineState *machine)
@@ -339,7 +339,7 @@ static void pc_compat_2_0(MachineState *machine)
 static void pc_compat_1_7(MachineState *machine)
 {
     pc_compat_2_0(machine);
-    x86_cpu_change_kvm_default("x2apic", NULL);
+    kvm_auto_enable_x2apic = false;
 }
 
 static void pc_compat_1_6(MachineState *machine)
@@ -367,7 +367,7 @@ static void pc_compat_1_3(MachineState *machine)
 static void pc_compat_1_2(MachineState *machine)
 {
     pc_compat_1_3(machine);
-    x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
+    kvm_auto_enable_pv_eoi = false;
 }
 
 /* PC compat function for pc-0.10 to pc-0.13 */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90c969363e..f8d317f1f9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1577,15 +1577,16 @@ static PropValue kvm_default_props[] = {
     { "kvm-nopiodelay", "on" },
     { "kvm-asyncpf", "on" },
     { "kvm-steal-time", "on" },
-    { "kvm-pv-eoi", "on" },
     { "kvmclock-stable-bit", "on" },
-    { "x2apic", "on" },
     { "acpi", "off" },
     { "monitor", "off" },
-    { "svm", "off" },
     { NULL, NULL },
 };
 
+bool kvm_auto_disable_svm = true;
+bool kvm_auto_enable_x2apic = true;
+bool kvm_auto_enable_pv_eoi = true;
+
 /* TCG-specific defaults that override all CPU models when using TCG
  */
 static PropValue tcg_default_props[] = {
@@ -1594,22 +1595,6 @@ static PropValue tcg_default_props[] = {
 };
 
 
-void x86_cpu_change_kvm_default(const char *prop, const char *value)
-{
-    PropValue *pv;
-    for (pv = kvm_default_props; pv->prop; pv++) {
-        if (!strcmp(pv->prop, prop)) {
-            pv->value = value;
-            break;
-        }
-    }
-
-    /* It is valid to call this function only for properties that
-     * are already present in the kvm_default_props table.
-     */
-    assert(pv->prop);
-}
-
 static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
@@ -2439,7 +2424,19 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
     /* Special cases not set in the X86CPUDefinition structs: */
     if (kvm_enabled()) {
         if (!kvm_irqchip_in_kernel()) {
-            x86_cpu_change_kvm_default("x2apic", "off");
+            object_property_set_bool(OBJECT(cpu), false, "x2apic",
+                                     &error_abort);
+        } else if (kvm_auto_enable_x2apic) {
+            object_property_set_bool(OBJECT(cpu), true, "x2apic",
+                                     &error_abort);
+        }
+        if (kvm_auto_disable_svm) {
+            object_property_set_bool(OBJECT(cpu), false, "svm",
+                                     &error_abort);
+        }
+        if (kvm_auto_enable_pv_eoi) {
+            object_property_set_bool(OBJECT(cpu), true, "kvm-pv-eoi",
+                                     &error_abort);
         }
 
         x86_cpu_apply_props(cpu, kvm_default_props);
-- 
2.13.6
