Received: from eggs.gnu.org ([2001:4830:134:3::10]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0007JK-Ch
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyE-0006IY-87
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy9-00068P-1D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id 143-v6so1566591wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:26 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.32.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:32:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:34 +0200
Message-Id: <1539894735-14232-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/48] linux-headers: update to 4.20-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This brings in eVMCS and coalesced PIO support, as well as other features we do
not support yet.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-powerpc/kvm.h |  1 +
 linux-headers/asm-x86/kvm.h     |  8 ++++++--
 linux-headers/linux/kvm.h       | 16 ++++++++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1b32b56..8c876c1 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -634,6 +634,7 @@ struct kvm_ppc_cpu_char {
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
 #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index fd23d57..dabfcf7 100644
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
index 83ba4eb..f11a7eb 100644
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
 
-- 
1.8.3.1
