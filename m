Received: from eggs.gnu.org ([2001:4830:134:3::10]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gEdU9-0005Be-Ck
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gEdU5-0005Lq-S3
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gEdU5-0005KT-H2
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:55:17 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon, 22 Oct 2018 18:55:05 +0200
Message-Id: <20181022165506.30332-2-vkuznets@redhat.com>
In-Reply-To: <20181022165506.30332-1-vkuznets@redhat.com>
References: <20181022165506.30332-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] linux-headers: update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Update to kvm/next commit 1e58e5e59148 ("KVM: VMX: enable nested
 virtualization by default").

kvm_put_vcpu_events() needs to be fixed as 'pad' was renamed to
'pending' in 'struct kvm_vcpu_events'

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 linux-headers/asm-powerpc/kvm.h |  1 +
 linux-headers/asm-x86/kvm.h     |  8 ++++++--
 linux-headers/linux/kvm.h       | 16 ++++++++++++++--
 target/i386/kvm.c               |  2 +-
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1b32b56a03..8c876c166e 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -634,6 +634,7 @@ struct kvm_ppc_cpu_char {
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index fd23d5778e..dabfcf7c39 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -288,6 +288,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SIPI_VECTOR	0x00000002
 #define KVM_VCPUEVENT_VALID_SHADOW	0x00000004
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
+#define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
@@ -299,7 +300,7 @@ struct kvm_vcpu_events {
 		__u8 injected;
 		__u8 nr;
 		__u8 has_error_code;
-		__u8 pad;
+		__u8 pending;
 		__u32 error_code;
 	} exception;
 	struct {
@@ -322,7 +323,9 @@ struct kvm_vcpu_events {
 		__u8 smm_inside_nmi;
 		__u8 latched_init;
 	} smi;
-	__u32 reserved[9];
+	__u8 reserved[27];
+	__u8 exception_has_payload;
+	__u64 exception_payload;
 };
 
 /* for KVM_GET/SET_DEBUGREGS */
@@ -381,6 +384,7 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+#define KVM_STATE_NESTED_EVMCS		0x00000004
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 83ba4eb571..f11a7eb49c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -420,13 +420,19 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 	__u8  data[8];
 };
 
@@ -719,6 +725,7 @@ struct kvm_ppc_one_seg_page_size {
 
 #define KVM_PPC_PAGE_SIZES_REAL		0x00000001
 #define KVM_PPC_1T_SEGMENTS		0x00000002
+#define KVM_PPC_NO_HASH			0x00000004
 
 struct kvm_ppc_smmu_info {
 	__u64 flags;
@@ -953,6 +960,11 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_PPC_NESTED_HV 160
+#define KVM_CAP_HYPERV_SEND_IPI 161
+#define KVM_CAP_COALESCED_PIO 162
+#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
+#define KVM_CAP_EXCEPTION_PAYLOAD 164
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dc4047b02f..a46ad102d8 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2686,7 +2686,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.exception.nr = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
     events.exception.error_code = env->error_code;
-    events.exception.pad = 0;
+    events.exception.pending = 0;
 
     events.interrupt.injected = (env->interrupt_injected >= 0);
     events.interrupt.nr = env->interrupt_injected;
-- 
2.17.2
