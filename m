Received: from eggs.gnu.org ([2001:4830:134:3::10]:49848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cFlP2-0000zS-Cr
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cFlOz-00038o-H2
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cFlOz-00038N-9a
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:37 -0500
Message-Id: <20161210172324.402794293@redhat.com>
Date: Sat, 10 Dec 2016 15:21:49 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
References: <20161210172148.361793326@redhat.com>
Content-Disposition: inline; filename=sync-linux-headers.patch
Subject: [Qemu-devel] [qemu patch V4 1/2] kvm: sync linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Import KVM_CLOCK_TSC_STABLE.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index 7361a16..b472b85 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -245,6 +245,7 @@ struct input_mask {
 #define BUS_SPI			0x1C
 #define BUS_RMI			0x1D
 #define BUS_CEC			0x1E
+#define BUS_INTEL_ISHTP		0x1F
 
 /*
  * MT_TOOL types
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 4040951..e5a2e68 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -612,6 +612,8 @@
  */
 #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
 #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
+#define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
+#define PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* Atomic 64-bit compare */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
@@ -619,6 +621,7 @@
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
+#define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
@@ -671,7 +674,8 @@
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DPC
+#define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -964,4 +968,13 @@
 
 #define PCI_EXP_DPC_SOURCE_ID		10	/* DPC Source Identifier */
 
+/* Precision Time Measurement */
+#define PCI_PTM_CAP			0x04	    /* PTM Capability */
+#define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
+#define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
+#define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
+#define PCI_PTM_CTRL			0x08	    /* PTM Control */
+#define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
+#define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
+
 #endif /* LINUX_PCI_REGS_H */
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 541268c..2fb7859 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -84,6 +84,13 @@ struct kvm_regs {
 #define KVM_VGIC_V2_DIST_SIZE		0x1000
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
+/* Supported VGICv3 address types  */
+#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
+
+#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
+#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
+
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
 
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index abeaf40..d45ea28 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -377,5 +377,8 @@
 #define __NR_copy_file_range 377
 #define __NR_preadv2 378
 #define __NR_pwritev2 379
+#define __NR_pkey_mprotect 380
+#define __NR_pkey_alloc 381
+#define __NR_pkey_free 382
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 73c3d1f..e22db91 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -330,5 +330,8 @@
 #define __NR_copy_file_range 326
 #define __NR_preadv2 327
 #define __NR_pwritev2 328
+#define __NR_pkey_mprotect 329
+#define __NR_pkey_alloc 330
+#define __NR_pkey_free 331
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index e5aea76..84e58b2 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -283,6 +283,9 @@
 #define __NR_membarrier (__X32_SYSCALL_BIT + 324)
 #define __NR_mlock2 (__X32_SYSCALL_BIT + 325)
 #define __NR_copy_file_range (__X32_SYSCALL_BIT + 326)
+#define __NR_pkey_mprotect (__X32_SYSCALL_BIT + 329)
+#define __NR_pkey_alloc (__X32_SYSCALL_BIT + 330)
+#define __NR_pkey_free (__X32_SYSCALL_BIT + 331)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4806e06..bb0ed71 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -972,12 +972,19 @@ struct kvm_irqfd {
 	__u8  pad[16];
 };
 
+/* For KVM_CAP_ADJUST_CLOCK */
+
+/* Do not use 1, KVM_CHECK_EXTENSION returned it before we had flags.  */
+#define KVM_CLOCK_TSC_STABLE		2
+
 struct kvm_clock_data {
 	__u64 clock;
 	__u32 flags;
 	__u32 pad[9];
 };
 
+/* For KVM_CAP_SW_TLB */
+
 #define KVM_MMU_FSL_BOOKE_NOHV		0
 #define KVM_MMU_FSL_BOOKE_HV		1
 
