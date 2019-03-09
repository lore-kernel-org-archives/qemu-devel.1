Received: from eggs.gnu.org ([209.51.188.92]:47275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0003t5-22
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wie-0000UU-4W
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wic-0000Pd-6G
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:31 -0500
Received: by mail-wm1-x32f.google.com with SMTP id x10so14099387wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:01 +0100
Message-Id: <1552117698-12355-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/25] i386: extended the cpuid_level when Intel
 PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luwei Kang <luwei.kang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Luwei Kang <luwei.kang@intel.com>

Intel Processor Trace required CPUID[0x14] but the cpuid_level
have no change when create a kvm guest with
e.g. "-cpu qemu64,+intel-pt".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Message-Id: <1548805979-12321-1-git-send-email-luwei.kang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 9 +++++++++
 target/i386/cpu.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9c8f833..c6d047b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -136,6 +136,7 @@ GlobalProperty pc_compat_3_1[] = {
     { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
+    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3aa6a8..d90c01a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5031,6 +5031,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
@@ -5824,6 +5831,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
     DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
                      false),
+    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
+                     true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 95112b9..83fb522 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1454,6 +1454,9 @@ struct X86CPU {
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
+    /* Enable auto level-increase for Intel Processor Trace leave */
+    bool intel_pt_auto_level;
+
     /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
     bool fill_mtrr_mask;
 
-- 
1.8.3.1
