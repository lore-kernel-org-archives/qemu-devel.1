Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f8LdK-0001BY-Hu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f8LdG-00066M-9w
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:06:34 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1f8LdG-00065F-1z
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:06:30 -0400
Received: by mail-pg0-x244.google.com with SMTP id r14so5048973pgq.4
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 01:06:29 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 17 Apr 2018 01:05:37 -0700
Message-Id: <1523952337-27449-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
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

This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspace with 
per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT/PAUSE 
in order that to improve latency in some workloads.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com> 
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * disable kvm-hint-dedicated if kvm-pv-unhalt is specified

 linux-headers/linux/kvm.h |  6 +++++-
 target/i386/cpu.h         |  2 ++
 target/i386/kvm.c         | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a167be8..857df15 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -925,7 +925,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_GS 140
 #define KVM_CAP_S390_AIS 141
 #define KVM_CAP_SPAPR_TCE_VFIO 142
-#define KVM_CAP_X86_GUEST_MWAIT 143
+#define KVM_CAP_X86_DISABLE_EXITS 143
 #define KVM_CAP_ARM_USER_IRQ 144
 #define KVM_CAP_S390_CMMA_MIGRATION 145
 #define KVM_CAP_PPC_FWNMI 146
@@ -1508,6 +1508,10 @@ struct kvm_assigned_msix_entry {
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+
 /* Available with KVM_CAP_ARM_USER_IRQ */
 
 /* Bits for run->s.regs.device_irq_level */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1b219fa..965de1b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -685,6 +685,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 
+#define KVM_PV_UNHALT (1U << 7)
+
 #define KVM_HINTS_DEDICATED (1U << 0)
 
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6c49954..9357caa 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1029,6 +1029,21 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
+        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
+
+        if (disable_exits) {
+            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
+                              KVM_X86_DISABLE_EXITS_HLT |
+                              KVM_X86_DISABLE_EXITS_PAUSE);
+            if (env->user_features[KVM] & KVM_PV_UNHALT)
+                disable_exits &= ~KVM_X86_DISABLE_EXITS_HLT;
+        }
+        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS, 0, disable_exits)) {
+            error_report("kvm: DISABLE EXITS not supported");
+        }
+    }
+
     qemu_add_vm_change_state_handler(cpu_update_state, env);
 
     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
-- 
2.7.4
