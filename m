Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYR-00042L-FW
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYQ-0001kS-BY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYQ-0001k8-2L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1601E883B8
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:53:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:43 -0300
Message-Id: <20171006215244.27104-7-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] pc: Use compat_props to control KVM
 defaults compatibility
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

Replace the kvm_auto_* global variables with QOM properties
controlled by MachineClass::compat_props.

This will help us eliminate the pc_compat_*() function chain in
the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.h    | 17 +++++++++--------
 hw/i386/pc_piix.c    |  7 ++++---
 target/i386/cpu.c    | 18 ++++++++++--------
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 087d184ef5..d2742dd0bc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -753,6 +753,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver = "core2duo" "-" TYPE_X86_CPU,\
         .property = "vmx",\
         .value = "on",\
+    },{\
+        .driver = TYPE_X86_CPU,\
+        .property = "x-kvm-auto-disable-svm",\
+        .value = "off",\
     },
 
 #define PC_COMPAT_2_0 \
@@ -831,6 +835,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "hpet",\
         .property = HPET_INTCAP,\
         .value    = stringify(4),\
+    },{\
+        .driver = TYPE_X86_CPU,\
+        .property = "x-kvm-auto-enable-x2apic",\
+        .value = "off",\
     },
 
 #define PC_COMPAT_1_6 \
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0184f98241..7e5bf86921 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1267,6 +1267,15 @@ struct X86CPU {
     /* Stop SMI delivery for migration compatibility with old machines */
     bool kvm_no_smi_migration;
 
+    /* KVM automatically disables SVM if not explicitly enabled by user */
+    bool kvm_auto_disable_svm;
+
+    /* KVM automatically enables x2apic if not explicitly disabled by user */
+    bool kvm_auto_enable_x2apic;
+
+    /* KVM automatically enables kvm-pv-eoi if not explicitly disabled by user */
+    bool kvm_auto_enable_pv_eoi;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
@@ -1700,14 +1709,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
                                    TPRAccess access);
 
 
-/*
- * Compat globals to control features automatically enabled/disabled by KVM.
- * TODO: convert them to X86CPU fields set by MachineClass::compat_props
- */
-extern bool kvm_auto_disable_svm;
-extern bool kvm_auto_enable_x2apic;
-extern bool kvm_auto_enable_pv_eoi;
-
 /* mpx_helper.c */
 void cpu_sync_bndcs_hflags(CPUX86State *env);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3e466b3896..e0ce633876 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -328,7 +328,6 @@ static void pc_compat_2_2(MachineState *machine)
 static void pc_compat_2_1(MachineState *machine)
 {
     pc_compat_2_2(machine);
-    kvm_auto_disable_svm = false;
 }
 
 static void pc_compat_2_0(MachineState *machine)
@@ -339,7 +338,6 @@ static void pc_compat_2_0(MachineState *machine)
 static void pc_compat_1_7(MachineState *machine)
 {
     pc_compat_2_0(machine);
-    kvm_auto_enable_x2apic = false;
 }
 
 static void pc_compat_1_6(MachineState *machine)
@@ -367,7 +365,6 @@ static void pc_compat_1_3(MachineState *machine)
 static void pc_compat_1_2(MachineState *machine)
 {
     pc_compat_1_3(machine);
-    kvm_auto_enable_pv_eoi = false;
 }
 
 /* PC compat function for pc-0.10 to pc-0.13 */
@@ -705,6 +702,10 @@ DEFINE_I440FX_MACHINE(v1_3, "pc-1.3", pc_compat_1_3,
             .driver   = "VGA",\
             .property = "mmio",\
             .value    = "off",\
+        },{\
+            .driver = TYPE_X86_CPU,\
+            .property = "x-kvm-auto-enable-pv-eoi",\
+            .value = "off",\
         },
 
 static void pc_i440fx_1_2_machine_options(MachineClass *m)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 83e234cef4..2160738a37 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1583,10 +1583,6 @@ static PropValue kvm_default_props[] = {
     { NULL, NULL },
 };
 
-bool kvm_auto_disable_svm = true;
-bool kvm_auto_enable_x2apic = true;
-bool kvm_auto_enable_pv_eoi = true;
-
 /* TCG-specific defaults that override all CPU models when using TCG
  */
 static PropValue tcg_default_props[] = {
@@ -3502,20 +3498,20 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * defaults, so we check xcc->cpu_def here.
      */
     if (xcc->cpu_def && kvm_enabled()) {
-        /* KVM-specific defaults that depend on compatibility globals: */
+        /* KVM-specific defaults that depend on compatibility properties: */
 
         if (!kvm_irqchip_in_kernel()) {
             x86_cpu_expand_feature(cpu, FEAT_1_ECX, CPUID_EXT_X2APIC, 0);
-        } else if (kvm_auto_enable_x2apic) {
+        } else if (cpu->kvm_auto_enable_x2apic) {
             x86_cpu_expand_feature(cpu, FEAT_1_ECX, CPUID_EXT_X2APIC,
                                    CPUID_EXT_X2APIC);
         }
 
-        if (kvm_auto_disable_svm) {
+        if (cpu->kvm_auto_disable_svm) {
             x86_cpu_expand_feature(cpu, FEAT_8000_0001_ECX, CPUID_EXT3_SVM, 0);
         }
 
-        if (kvm_auto_enable_pv_eoi) {
+        if (cpu->kvm_auto_enable_pv_eoi) {
             x86_cpu_expand_feature(cpu, FEAT_KVM, (1 << KVM_FEATURE_PV_EOI),
                                    (1 << KVM_FEATURE_PV_EOI));
         }
@@ -4162,6 +4158,12 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
                      false),
+    DEFINE_PROP_BOOL("x-kvm-auto-disable-svm",
+                     X86CPU, kvm_auto_disable_svm, true),
+    DEFINE_PROP_BOOL("x-kvm-auto-enable-x2apic",
+                     X86CPU, kvm_auto_enable_x2apic, true),
+    DEFINE_PROP_BOOL("x-kvm-auto-enable-pv-eoi",
+                     X86CPU, kvm_auto_enable_pv_eoi, true),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
 
-- 
2.13.6
