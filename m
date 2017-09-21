Received: from eggs.gnu.org ([2001:4830:134:3::10]:38511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0EY-0000qv-Et
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0EU-0007cV-GT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1dv0EU-0007cD-9t
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:30 -0400
Message-Id: <20170921120415.155548393@redhat.com>
Date: Thu, 21 Sep 2017 09:03:42 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
References: <20170921120341.590850215@redhat.com>
Content-Disposition: inline; filename=sync-linux-headers
Subject: [Qemu-devel] [patch 1/2] qemu: sync linux-headers with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: qemu-fifoprio/linux-headers/linux/kvm.h
===================================================================
--- qemu-fifoprio.orig/linux-headers/linux/kvm.h
+++ qemu-fifoprio/linux-headers/linux/kvm.h
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_VCPU_RT_PRIO_HC 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1355,6 +1356,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
+/* Available with KVM_CAP_VCPU_RT_PRIO_HC */
+#define KVM_SET_VCPU_RT_PRIO_HC	_IOW(KVMIO, 0xba, struct kvm_vcpu_rt_prio)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
Index: qemu-fifoprio/linux-headers/asm-x86/kvm.h
===================================================================
--- qemu-fifoprio.orig/linux-headers/asm-x86/kvm.h
+++ qemu-fifoprio/linux-headers/asm-x86/kvm.h
@@ -353,6 +353,11 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
+struct kvm_vcpu_rt_prio {
+	__u32 enabled;
+	__u32 sched_priority;
+};
+
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 };
Index: qemu-fifoprio/linux-headers/linux/kvm_para.h
===================================================================
--- qemu-fifoprio.orig/linux-headers/linux/kvm_para.h
+++ qemu-fifoprio/linux-headers/linux/kvm_para.h
@@ -15,6 +15,7 @@
 #define KVM_E2BIG		E2BIG
 #define KVM_EPERM		EPERM
 #define KVM_EOPNOTSUPP		95
+#define KVM_EINVAL		EINVAL
 
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
@@ -25,6 +26,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_RT_PRIO			10
 
 /*
  * hypercalls use architecture specific
