Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2Xa-0008IO-Cc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa2XZ-0006J2-0I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:23:06 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  2 Jul 2018 19:22:28 +0200
Message-Id: <1530552162-15533-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
References: <1530552162-15533-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 01/15] linux-headers: header update for
 KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

This is a header update against

git://linux-arm.org/linux-skp.git ipa52/v3

to get the KVM_ARM_GET_MAX_VM_PHYS_SHIFT ioctl. This allows to retrieve
the IPA address range KVM supports.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/linux/virtio_config.h | 16 ++++++++++++----
 linux-headers/asm-mips/unistd.h                | 18 ++++++++++++------
 linux-headers/asm-powerpc/kvm.h                |  1 +
 linux-headers/linux/kvm.h                      | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b777069..0b19436 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -45,11 +45,14 @@
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
-/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
- * transport being used (eg. virtio_ring), the rest are per-device feature
- * bits. */
+/*
+ * Virtio feature bits VIRTIO_TRANSPORT_F_START through
+ * VIRTIO_TRANSPORT_F_END are reserved for the transport
+ * being used (e.g. virtio_ring, virtio_pci etc.), the
+ * rest are per-device feature bits.
+ */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		38
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +74,9 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * Does the device support Single Root I/O Virtualization?
+ */
+#define VIRTIO_F_SR_IOV			37
 #endif /* _LINUX_VIRTIO_CONFIG_H */
diff --git a/linux-headers/asm-mips/unistd.h b/linux-headers/asm-mips/unistd.h
index 9bfef7f..d4a85ef 100644
--- a/linux-headers/asm-mips/unistd.h
+++ b/linux-headers/asm-mips/unistd.h
@@ -388,17 +388,19 @@
 #define __NR_pkey_alloc			(__NR_Linux + 364)
 #define __NR_pkey_free			(__NR_Linux + 365)
 #define __NR_statx			(__NR_Linux + 366)
+#define __NR_rseq			(__NR_Linux + 367)
+#define __NR_io_pgetevents		(__NR_Linux + 368)
 
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		366
+#define __NR_Linux_syscalls		368
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		366
+#define __NR_O32_Linux_syscalls		368
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -733,16 +735,18 @@
 #define __NR_pkey_alloc			(__NR_Linux + 324)
 #define __NR_pkey_free			(__NR_Linux + 325)
 #define __NR_statx			(__NR_Linux + 326)
+#define __NR_rseq			(__NR_Linux + 327)
+#define __NR_io_pgetevents		(__NR_Linux + 328)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		326
+#define __NR_Linux_syscalls		328
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		326
+#define __NR_64_Linux_syscalls		328
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1081,15 +1085,17 @@
 #define __NR_pkey_alloc			(__NR_Linux + 328)
 #define __NR_pkey_free			(__NR_Linux + 329)
 #define __NR_statx			(__NR_Linux + 330)
+#define __NR_rseq			(__NR_Linux + 331)
+#define __NR_io_pgetevents		(__NR_Linux + 332)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		330
+#define __NR_Linux_syscalls		332
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		330
+#define __NR_N32_Linux_syscalls		332
 
 #endif /* _ASM_UNISTD_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 833ed9a..1b32b56 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a..0a90115 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
+ * On arm/arm64, machine type can be used to request the physical
+ * address size for the VM. Bits [7-0] have been reserved for the
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, which is 40bits.
+ */
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK	0xff
+#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)		\
+	((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
+
+/*
  * ioctls for /dev/kvm fds:
  */
 #define KVM_GET_API_VERSION       _IO(KVMIO,   0x00)
@@ -775,6 +785,12 @@ struct kvm_ppc_resize_hpt {
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
 /*
+ * Get the maximum physical address size supported by the host.
+ * Returns log2(Max-Physical-Address-Size)
+ */
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT	_IO(KVMIO, 0x0b)
+
+/*
  * Extension capability list.
  */
 #define KVM_CAP_IRQCHIP	  0
-- 
2.5.5
