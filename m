Received: from eggs.gnu.org ([209.51.188.92]:57194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goQwp-0001EQ-Uq
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1goQwp-0004U5-3f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:48:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:50611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1goQwo-0004SD-PL
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:48:55 -0500
From: Luwei Kang <luwei.kang@intel.com>
Date: Tue, 29 Jan 2019 18:48:22 -0500
Message-Id: <1548805702-12161-1-git-send-email-luwei.kang@intel.com>
Subject: [Qemu-devel] [PATCH V2] i386: extended the cpuid_level when Intel
 PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, Luwei Kang <luwei.kang@intel.com>

Intel Processor Trace required CPUID[0x14] but the cpuid_level
have no change when create a kvm guest with
e.g. "-cpu qemu64,+intel-pt".

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 9 +++++++++
 target/i386/cpu.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73d688f..72a0a70 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -122,6 +122,7 @@ GlobalProperty pc_compat_3_1[] = {
     { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
     { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
+    { TYPE_X86_CPU, "x-intel-pt-auto-leevl", "off" },
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f54125..6dddd99 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5023,6 +5023,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+
+        /* Intel Processor Trace requires CPUID[0x14] */
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
+             kvm_enabled() && cpu->intel_pt_auto_level) {
+            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
@@ -5816,6 +5823,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
     DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
                      false),
+    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
+                     true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59656a7..090baa4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1455,6 +1455,9 @@ struct X86CPU {
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
+    /* Enable auto level-increase for Intel Processor Trace leave */
+    bool intel_pt_auto_level;
+
     /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
     bool fill_mtrr_mask;
 
-- 
1.8.3.1
