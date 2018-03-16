Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ewqUQ-0001IR-7s
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ewqUM-0005ar-9c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:37:50 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:32825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ewqUM-0005aF-3T
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:37:46 -0400
Received: by mail-pg0-x244.google.com with SMTP id g12so4151419pgs.0
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:37:45 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 16 Mar 2018 07:36:42 -0700
Message-Id: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] i386/kvm: add support for
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
 linux-headers/linux/kvm.h |  6 +++++-
 target/i386/kvm.c         | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d23fff1..95ed9eb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -999,6 +999,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
+        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
+        if (disable_exits) {
+            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
+                              KVM_X86_DISABLE_EXITS_HLT |
+                              KVM_X86_DISABLE_EXITS_PAUSE);
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
