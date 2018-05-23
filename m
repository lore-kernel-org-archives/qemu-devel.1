Received: from eggs.gnu.org ([2001:4830:134:3::10]:48831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyk-0001fh-KV
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyj-0000m8-Ge
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyj-0000m2-As
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:01 -0400
Date: Wed, 23 May 2018 17:42:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-7-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/28] include/standard-headers: add
 asm-x86/kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Import asm-x86/kvm_para.h from linux where it can
be easily used on Linux and non-Linux platforms.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/asm-x86/kvm_para.h | 121 ++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 include/standard-headers/asm-x86/kvm_para.h

diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
new file mode 100644
index 0000000..53a85ae
--- /dev/null
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_KVM_PARA_H
+#define _ASM_X86_KVM_PARA_H
+
+#include "standard-headers/linux/types.h"
+
+/* This CPUID returns the signature 'KVMKVMKVM' in ebx, ecx, and edx.  It
+ * should be used to determine that a VM is running under KVM.
+ */
+#define KVM_CPUID_SIGNATURE	0x40000000
+
+/* This CPUID returns two feature bitmaps in eax, edx. Before enabling
+ * a particular paravirtualization, the appropriate feature bit should
+ * be checked in eax. The performance hint feature bit should be checked
+ * in edx.
+ */
+#define KVM_CPUID_FEATURES	0x40000001
+#define KVM_FEATURE_CLOCKSOURCE		0
+#define KVM_FEATURE_NOP_IO_DELAY	1
+#define KVM_FEATURE_MMU_OP		2
+/* This indicates that the new set of kvmclock msrs
+ * are available. The use of 0x11 and 0x12 is deprecated
+ */
+#define KVM_FEATURE_CLOCKSOURCE2        3
+#define KVM_FEATURE_ASYNC_PF		4
+#define KVM_FEATURE_STEAL_TIME		5
+#define KVM_FEATURE_PV_EOI		6
+#define KVM_FEATURE_PV_UNHALT		7
+#define KVM_FEATURE_PV_TLB_FLUSH	9
+#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
+
+#define KVM_HINTS_DEDICATED      0
+
+/* The last 8 bits are used to indicate how to interpret the flags field
+ * in pvclock structure. If no bits are set, all flags are ignored.
+ */
+#define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
+
+#define MSR_KVM_WALL_CLOCK  0x11
+#define MSR_KVM_SYSTEM_TIME 0x12
+
+#define KVM_MSR_ENABLED 1
+/* Custom MSRs falls in the range 0x4b564d00-0x4b564dff */
+#define MSR_KVM_WALL_CLOCK_NEW  0x4b564d00
+#define MSR_KVM_SYSTEM_TIME_NEW 0x4b564d01
+#define MSR_KVM_ASYNC_PF_EN 0x4b564d02
+#define MSR_KVM_STEAL_TIME  0x4b564d03
+#define MSR_KVM_PV_EOI_EN      0x4b564d04
+
+struct kvm_steal_time {
+	uint64_t steal;
+	uint32_t version;
+	uint32_t flags;
+	uint8_t  preempted;
+	uint8_t  uint8_t_pad[3];
+	uint32_t pad[11];
+};
+
+#define KVM_VCPU_PREEMPTED          (1 << 0)
+#define KVM_VCPU_FLUSH_TLB          (1 << 1)
+
+#define KVM_CLOCK_PAIRING_WALLCLOCK 0
+struct kvm_clock_pairing {
+	int64_t sec;
+	int64_t nsec;
+	uint64_t tsc;
+	uint32_t flags;
+	uint32_t pad[9];
+};
+
+#define KVM_STEAL_ALIGNMENT_BITS 5
+#define KVM_STEAL_VALID_BITS ((-1ULL << (KVM_STEAL_ALIGNMENT_BITS + 1)))
+#define KVM_STEAL_RESERVED_MASK (((1 << KVM_STEAL_ALIGNMENT_BITS) - 1 ) << 1)
+
+#define KVM_MAX_MMU_OP_BATCH           32
+
+#define KVM_ASYNC_PF_ENABLED			(1 << 0)
+#define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1)
+#define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT	(1 << 2)
+
+/* Operations for KVM_HC_MMU_OP */
+#define KVM_MMU_OP_WRITE_PTE            1
+#define KVM_MMU_OP_FLUSH_TLB	        2
+#define KVM_MMU_OP_RELEASE_PT	        3
+
+/* Payload for KVM_HC_MMU_OP */
+struct kvm_mmu_op_header {
+	uint32_t op;
+	uint32_t pad;
+};
+
+struct kvm_mmu_op_write_pte {
+	struct kvm_mmu_op_header header;
+	uint64_t pte_phys;
+	uint64_t pte_val;
+};
+
+struct kvm_mmu_op_flush_tlb {
+	struct kvm_mmu_op_header header;
+};
+
+struct kvm_mmu_op_release_pt {
+	struct kvm_mmu_op_header header;
+	uint64_t pt_phys;
+};
+
+#define KVM_PV_REASON_PAGE_NOT_PRESENT 1
+#define KVM_PV_REASON_PAGE_READY 2
+
+struct kvm_vcpu_pv_apf_data {
+	uint32_t reason;
+	uint8_t pad[60];
+	uint32_t enabled;
+};
+
+#define KVM_PV_EOI_BIT 0
+#define KVM_PV_EOI_MASK (0x1 << KVM_PV_EOI_BIT)
+#define KVM_PV_EOI_ENABLED KVM_PV_EOI_MASK
+#define KVM_PV_EOI_DISABLED 0x0
+
+#endif /* _ASM_X86_KVM_PARA_H */
-- 
MST
