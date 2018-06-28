Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fYT3v-0005vm-3e
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fYT3u-0006GK-5K
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:17:59 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 29 Jun 2018 01:22:40 +0800
Message-ID: <1530206561-22348-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1530206561-22348-1-git-send-email-gengdongjiu@huawei.com>
References: <1530206561-22348-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 RFC 1/2] linux-headers: sync linux header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, james.morse@arm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, zhengxiang9@huawei.com, gengdongjiu@huawei.com, linuxarm@huawei.com

Import KVM_CAP_ARM_INJECT_SERROR_ESR and struct kvm_vcpu_events
for arm64, they are added manually in the kernel tree, so it will be
added after re-running scripts/update-linux-headers.sh. This linux
header sync is based on 4.17-rc7, linux kernel tree commit is
b04e217704b7f879c6b91222b066983a44a7a09f

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 linux-headers/asm-arm64/kvm.h | 13 +++++++++++++
 linux-headers/linux/kvm.h     |  1 +
 2 files changed, 14 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 17315ab..e240afc 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -39,6 +39,7 @@
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_EVENTS
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 
@@ -153,6 +154,18 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* for KVM_GET/SET_VCPU_EVENTS */
+struct kvm_vcpu_events {
+	struct {
+		__u8 serror_pending;
+		__u8 serror_has_esr;
+		/* Align it to 8 bytes */
+		__u8 pad[6];
+		__u64 serror_esr;
+	} exception;
+	__u32 reserved[12];
+};
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index cdb148e..cd8be47 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 155
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1
