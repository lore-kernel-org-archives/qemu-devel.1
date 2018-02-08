Received: from eggs.gnu.org ([2001:4830:134:3::10]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ejikn-0003j5-2B
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ejikj-0002y2-Vd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:44:29 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ejikj-0002vy-Os
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 04:44:25 -0500
Received: by mail-pf0-x241.google.com with SMTP id k5so1541530pff.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 01:44:25 -0800 (PST)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu,  8 Feb 2018 17:44:20 +0800
Message-Id: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Wanpeng Li <wanpengli@tencent.com>

Add PV_DEDICATED hint cpuid feature bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/cpu.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d70954b..cf48931 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
         env->features[w] &= host_feat;
+        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
+            env->features[w] |= CPUID_PV_DEDICATED;
+        }
         cpu->filtered_features[w] = requested_features & ~env->features[w];
         if (cpu->filtered_features[w]) {
             rv = 1;
@@ -4682,6 +4685,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("pv-dedicated", X86CPU, pv_dedicated, false),
 
     /*
      * From "Requirements for Implementing the Microsoft
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f91e37d..8000da5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -672,6 +672,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
 
+#define CPUID_PV_DEDICATED     (1U << 8)
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
@@ -1276,6 +1278,7 @@ struct X86CPU {
     bool expose_kvm;
     bool expose_tcg;
     bool migratable;
+    bool pv_dedicated;
     bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
-- 
2.7.4
