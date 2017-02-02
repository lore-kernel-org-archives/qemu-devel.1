Received: from eggs.gnu.org ([2001:4830:134:3::10]:58959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkk-0000Gp-CH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007QN-BA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007Px-2m
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:04:59 -0500
Message-Id: <20170202180359.981950362@redhat.com>
Date: Thu, 02 Feb 2017 15:53:33 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
References: <20170202175332.346975248@redhat.com>
Content-Disposition: inline; filename=sync-linux-headers
Subject: [Qemu-devel] [patch 1/2] kvm: sync linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Sync linux headers.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 linux-headers/asm-x86/kvm.h      |    5 +++++
 linux-headers/asm-x86/kvm_para.h |   13 ++++++++++++-
 linux-headers/linux/kvm.h        |    8 ++++++--
 linux-headers/linux/kvm_para.h   |    7 +++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

Index: qemu/linux-headers/asm-x86/kvm.h
===================================================================
--- qemu.orig/linux-headers/asm-x86/kvm.h	2016-12-29 15:45:22.415325241 -0200
+++ qemu/linux-headers/asm-x86/kvm.h	2017-01-31 09:47:45.740645314 -0200
@@ -357,4 +357,9 @@
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+struct kvm_vcpu_allow_freq {
+	__u16 enable;
+	__u16 pad[7];
+};
+
 #endif /* _ASM_X86_KVM_H */
Index: qemu/linux-headers/asm-x86/kvm_para.h
===================================================================
--- qemu.orig/linux-headers/asm-x86/kvm_para.h	2016-12-29 15:44:51.281263648 -0200
+++ qemu/linux-headers/asm-x86/kvm_para.h	2017-01-31 09:47:45.740645314 -0200
@@ -45,7 +45,18 @@
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u8  preempted;
+	__u8  u8_pad[3];
+	__u32 pad[11];
+};
+
+#define KVM_CLOCK_PAIRING_WALLCLOCK 0
+struct kvm_clock_pairing {
+	__s64 sec;
+	__s64 nsec;
+	__u64 tsc;
+	__u32 flags;
+	__u32 pad[9];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
Index: qemu/linux-headers/linux/kvm.h
===================================================================
--- qemu.orig/linux-headers/linux/kvm.h	2016-12-29 15:45:49.572379128 -0200
+++ qemu/linux-headers/linux/kvm.h	2017-01-31 09:47:45.740645314 -0200
@@ -651,6 +651,9 @@
 };
 
 /* for KVM_PPC_GET_PVINFO */
+
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
 struct kvm_ppc_pvinfo {
 	/* out */
 	__u32 flags;
@@ -682,8 +685,6 @@
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
-#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
-
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -870,6 +871,7 @@
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_ALLOW_FREQ_HC 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1280,6 +1282,8 @@
 #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
 /* Available with KVM_CAP_X86_SMM */
 #define KVM_SMI                   _IO(KVMIO,   0xb7)
+#define KVM_SET_VCPU_ALLOW_FREQ_HC   _IO(KVMIO,   0xb8)
+#define KVM_GET_VCPU_ALLOW_FREQ_HC   _IO(KVMIO,   0xb9)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
Index: qemu/linux-headers/linux/kvm_para.h
===================================================================
--- qemu.orig/linux-headers/linux/kvm_para.h	2016-12-29 15:45:22.416325243 -0200
+++ qemu/linux-headers/linux/kvm_para.h	2017-01-31 09:47:45.741645316 -0200
@@ -14,6 +14,7 @@
 #define KVM_EFAULT		EFAULT
 #define KVM_E2BIG		E2BIG
 #define KVM_EPERM		EPERM
+#define KVM_EOPNOTSUPP		95
 
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
@@ -23,6 +24,12 @@
 #define KVM_HC_MIPS_GET_CLOCK_FREQ	6
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
+#define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_FREQ_UP			10
+#define KVM_HC_FREQ_DOWN		11
+#define KVM_HC_FREQ_MAX			12
+#define KVM_HC_FREQ_MIN			13
+
 
 /*
  * hypercalls use architecture specific
