Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjh9-0007F2-0M
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjh6-00065M-Rz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:54:06 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Aug 2018 14:53:39 +0200
Message-Id: <20180820125341.5882-6-cohuck@redhat.com>
In-Reply-To: <20180820125341.5882-1-cohuck@redhat.com>
References: <20180820125341.5882-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] linux-headers: update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Update to Linux upstream commit 2ad0d5269970
("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/standard-headers/asm-x86/kvm_para.h    |   1 +
 include/standard-headers/drm/drm_fourcc.h      | 176 +++++++++++++++++++++++++
 include/standard-headers/linux/ethtool.h       |  11 +-
 include/standard-headers/linux/pci_regs.h      |   4 +-
 include/standard-headers/linux/virtio_config.h |  16 ++-
 linux-headers/asm-generic/unistd.h             |   4 +-
 linux-headers/asm-mips/unistd.h                |  18 ++-
 linux-headers/asm-powerpc/kvm.h                |   1 +
 linux-headers/asm-powerpc/unistd.h             |   1 +
 linux-headers/asm-s390/kvm.h                   |   5 +-
 linux-headers/asm-s390/unistd_32.h             |   2 +
 linux-headers/asm-s390/unistd_64.h             |   2 +
 linux-headers/asm-x86/kvm.h                    |  37 ++++++
 linux-headers/linux/kvm.h                      |   5 +
 linux-headers/linux/vhost.h                    |  18 +++
 15 files changed, 284 insertions(+), 17 deletions(-)

diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
index 1617c84b0d..35cd8d651f 100644
--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -28,6 +28,7 @@
 #define KVM_FEATURE_PV_UNHALT		7
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
+#define KVM_FEATURE_PV_SEND_IPI	11
 
 #define KVM_HINTS_REALTIME      0
 
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 11912fde24..b53f8d7c8c 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -182,6 +182,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
+#define DRM_FORMAT_MOD_VENDOR_ARM     0x08
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -297,6 +298,19 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
 
+/*
+ * Qualcomm Compressed Format
+ *
+ * Refers to a compressed variant of the base format that is compressed.
+ * Implementation may be platform and base-format specific.
+ *
+ * Each macrotile consists of m x n (mostly 4 x 4) tiles.
+ * Pixel data pitch/stride is aligned with macrotile width.
+ * Pixel data height is aligned with macrotile height.
+ * Entire pixel data buffer is aligned with 4k(bytes).
+ */
+#define DRM_FORMAT_MOD_QCOM_COMPRESSED	fourcc_mod_code(QCOM, 1)
+
 /* Vivante framebuffer modifiers */
 
 /*
@@ -383,6 +397,23 @@ extern "C" {
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_THIRTYTWO_GOB \
 	fourcc_mod_code(NVIDIA, 0x15)
 
+/*
+ * Some Broadcom modifiers take parameters, for example the number of
+ * vertical lines in the image. Reserve the lower 32 bits for modifier
+ * type, and the next 24 bits for parameters. Top 8 bits are the
+ * vendor code.
+ */
+#define __fourcc_mod_broadcom_param_shift 8
+#define __fourcc_mod_broadcom_param_bits 48
+#define fourcc_mod_broadcom_code(val, params) \
+	fourcc_mod_code(BROADCOM, ((((uint64_t)params) << __fourcc_mod_broadcom_param_shift) | val))
+#define fourcc_mod_broadcom_param(m) \
+	((int)(((m) >> __fourcc_mod_broadcom_param_shift) &	\
+	       ((1ULL << __fourcc_mod_broadcom_param_bits) - 1)))
+#define fourcc_mod_broadcom_mod(m) \
+	((m) & ~(((1ULL << __fourcc_mod_broadcom_param_bits) - 1) <<	\
+		 __fourcc_mod_broadcom_param_shift))
+
 /*
  * Broadcom VC4 "T" format
  *
@@ -404,6 +435,151 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED fourcc_mod_code(BROADCOM, 1)
 
+/*
+ * Broadcom SAND format
+ *
+ * This is the native format that the H.264 codec block uses.  For VC4
+ * HVS, it is only valid for H.264 (NV12/21) and RGBA modes.
+ *
+ * The image can be considered to be split into columns, and the
+ * columns are placed consecutively into memory.  The width of those
+ * columns can be either 32, 64, 128, or 256 pixels, but in practice
+ * only 128 pixel columns are used.
+ *
+ * The pitch between the start of each column is set to optimally
+ * switch between SDRAM banks. This is passed as the number of lines
+ * of column width in the modifier (we can't use the stride value due
+ * to various core checks that look at it , so you should set the
+ * stride to width*cpp).
+ *
+ * Note that the column height for this format modifier is the same
+ * for all of the planes, assuming that each column contains both Y
+ * and UV.  Some SAND-using hardware stores UV in a separate tiled
+ * image from Y to reduce the column height, which is not supported
+ * with these modifiers.
+ */
+
+#define DRM_FORMAT_MOD_BROADCOM_SAND32_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(2, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND64_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(3, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND128_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(4, v)
+#define DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(v) \
+	fourcc_mod_broadcom_code(5, v)
+
+#define DRM_FORMAT_MOD_BROADCOM_SAND32 \
+	DRM_FORMAT_MOD_BROADCOM_SAND32_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND64 \
+	DRM_FORMAT_MOD_BROADCOM_SAND64_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND128 \
+	DRM_FORMAT_MOD_BROADCOM_SAND128_COL_HEIGHT(0)
+#define DRM_FORMAT_MOD_BROADCOM_SAND256 \
+	DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(0)
+
+/* Broadcom UIF format
+ *
+ * This is the common format for the current Broadcom multimedia
+ * blocks, including V3D 3.x and newer, newer video codecs, and
+ * displays.
+ *
+ * The image consists of utiles (64b blocks), UIF blocks (2x2 utiles),
+ * and macroblocks (4x4 UIF blocks).  Those 4x4 UIF block groups are
+ * stored in columns, with padding between the columns to ensure that
+ * moving from one column to the next doesn't hit the same SDRAM page
+ * bank.
+ *
+ * To calculate the padding, it is assumed that each hardware block
+ * and the software driving it knows the platform's SDRAM page size,
+ * number of banks, and XOR address, and that it's identical between
+ * all blocks using the format.  This tiling modifier will use XOR as
+ * necessary to reduce the padding.  If a hardware block can't do XOR,
+ * the assumption is that a no-XOR tiling modifier will be created.
+ */
+#define DRM_FORMAT_MOD_BROADCOM_UIF fourcc_mod_code(BROADCOM, 6)
+
+/*
+ * Arm Framebuffer Compression (AFBC) modifiers
+ *
+ * AFBC is a proprietary lossless image compression protocol and format.
+ * It provides fine-grained random access and minimizes the amount of data
+ * transferred between IP blocks.
+ *
+ * AFBC has several features which may be supported and/or used, which are
+ * represented using bits in the modifier. Not all combinations are valid,
+ * and different devices or use-cases may support different combinations.
+ */
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
+
+/*
+ * AFBC superblock size
+ *
+ * Indicates the superblock size(s) used for the AFBC buffer. The buffer
+ * size (in pixels) must be aligned to a multiple of the superblock size.
+ * Four lowest significant bits(LSBs) are reserved for block size.
+ */
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+
+/*
+ * AFBC lossless colorspace transform
+ *
+ * Indicates that the buffer makes use of the AFBC lossless colorspace
+ * transform.
+ */
+#define AFBC_FORMAT_MOD_YTR     (1ULL <<  4)
+
+/*
+ * AFBC block-split
+ *
+ * Indicates that the payload of each superblock is split. The second
+ * half of the payload is positioned at a predefined offset from the start
+ * of the superblock payload.
+ */
+#define AFBC_FORMAT_MOD_SPLIT   (1ULL <<  5)
+
+/*
+ * AFBC sparse layout
+ *
+ * This flag indicates that the payload of each superblock must be stored at a
+ * predefined position relative to the other superblocks in the same AFBC
+ * buffer. This order is the same order used by the header buffer. In this mode
+ * each superblock is given the same amount of space as an uncompressed
+ * superblock of the particular format would require, rounding up to the next
+ * multiple of 128 bytes in size.
+ */
+#define AFBC_FORMAT_MOD_SPARSE  (1ULL <<  6)
+
+/*
+ * AFBC copy-block restrict
+ *
+ * Buffers with this flag must obey the copy-block restriction. The restriction
+ * is such that there are no copy-blocks referring across the border of 8x8
+ * blocks. For the subsampled data the 8x8 limitation is also subsampled.
+ */
+#define AFBC_FORMAT_MOD_CBR     (1ULL <<  7)
+
+/*
+ * AFBC tiled layout
+ *
+ * The tiled layout groups superblocks in 8x8 or 4x4 tiles, where all
+ * superblocks inside a tile are stored together in memory. 8x8 tiles are used
+ * for pixel formats up to and including 32 bpp while 4x4 tiles are used for
+ * larger bpp formats. The order between the tiles is scan line.
+ * When the tiled layout is used, the buffer size (in pixels) must be aligned
+ * to the tile size.
+ */
+#define AFBC_FORMAT_MOD_TILED   (1ULL <<  8)
+
+/*
+ * AFBC solid color blocks
+ *
+ * Indicates that the buffer makes use of solid-color blocks, whereby bandwidth
+ * can be reduced if a whole superblock is a single color.
+ */
+#define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index eb10c075e4..57ffcb5341 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -226,7 +226,7 @@ enum tunable_id {
 	ETHTOOL_TX_COPYBREAK,
 	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	/*
-	 * Add your fresh new tubale attribute above and remember to update
+	 * Add your fresh new tunable attribute above and remember to update
 	 * tunable_strings[] in net/core/ethtool.c
 	 */
 	__ETHTOOL_TUNABLE_COUNT,
@@ -870,7 +870,8 @@ struct ethtool_flow_ext {
  *	includes the %FLOW_EXT or %FLOW_MAC_EXT flag
  *	(see &struct ethtool_flow_ext description).
  * @ring_cookie: RX ring/queue index to deliver to, or %RX_CLS_FLOW_DISC
- *	if packets should be discarded
+ *	if packets should be discarded, or %RX_CLS_FLOW_WAKE if the
+ *	packets should be used for Wake-on-LAN with %WAKE_FILTER
  * @location: Location of rule in the table.  Locations must be
  *	numbered such that a flow matching multiple rules will be
  *	classified according to the first (lowest numbered) rule.
@@ -902,13 +903,13 @@ struct ethtool_rx_flow_spec {
 static inline uint64_t ethtool_get_flow_spec_ring(uint64_t ring_cookie)
 {
 	return ETHTOOL_RX_FLOW_SPEC_RING & ring_cookie;
-};
+}
 
 static inline uint64_t ethtool_get_flow_spec_ring_vf(uint64_t ring_cookie)
 {
 	return (ETHTOOL_RX_FLOW_SPEC_RING_VF & ring_cookie) >>
 				ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
-};
+}
 
 /**
  * struct ethtool_rxnfc - command to get or set RX flow classification rules
@@ -1634,6 +1635,7 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 #define WAKE_ARP		(1 << 4)
 #define WAKE_MAGIC		(1 << 5)
 #define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */
+#define WAKE_FILTER		(1 << 7)
 
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
@@ -1671,6 +1673,7 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
+#define RX_CLS_FLOW_WAKE	0xfffffffffffffffeULL
 
 /* Special RX classification rule insert location values */
 #define RX_CLS_LOC_SPECIAL	0x80000000	/* flag */
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 4da87e2ef8..ee556ccc93 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -636,6 +636,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
+#define PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
@@ -960,8 +961,9 @@
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-#define  PCI_REBAR_CTRL_NBAR_SHIFT	5  	    /* shift for # of BARs */
+#define  PCI_REBAR_CTRL_NBAR_SHIFT	5	    /* shift for # of BARs */
 #define  PCI_REBAR_CTRL_BAR_SIZE	0x00001F00  /* BAR size */
+#define  PCI_REBAR_CTRL_BAR_SHIFT	8	    /* shift for BAR size */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b777069699..0b194365a0 100644
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
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 42990676a5..df4bedb9b0 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_rseq 293
+__SYSCALL(__NR_rseq, sys_rseq)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd.h b/linux-headers/asm-mips/unistd.h
index 9bfef7f764..d4a85ef3eb 100644
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
index 833ed9a16a..1b32b56a03 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -633,6 +633,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
 #define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+#define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index 3629858142..ec3533b1d0 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 11def14301..1ab9901911 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -4,7 +4,7 @@
 /*
  * KVM s390 specific structures and definitions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -225,6 +225,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
+#define KVM_SYNC_ETOKEN (1UL << 11)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -258,6 +259,8 @@ struct kvm_sync_regs {
 		struct {
 			__u64 reserved1[2];
 			__u64 gscb[4];
+			__u64 etoken;
+			__u64 etoken_extension;
 		};
 	};
 };
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index d0f97cd0a4..514e302ba1 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -361,5 +361,7 @@
 #define __NR_statx 379
 #define __NR_s390_sthyi 380
 #define __NR_kexec_file_load 381
+#define __NR_io_pgetevents 382
+#define __NR_rseq 383
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 23ffb97746..d2b73de0ed 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -328,5 +328,7 @@
 #define __NR_statx 379
 #define __NR_s390_sthyi 380
 #define __NR_kexec_file_load 381
+#define __NR_io_pgetevents 382
+#define __NR_rseq 383
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c535c2fdea..86299efa80 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -378,4 +378,41 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 
+#define KVM_STATE_NESTED_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_RUN_PENDING	0x00000002
+
+#define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
+#define KVM_STATE_NESTED_SMM_VMXON	0x00000002
+
+struct kvm_vmx_nested_state {
+	__u64 vmxon_pa;
+	__u64 vmcs_pa;
+
+	struct {
+		__u16 flags;
+	} smm;
+};
+
+/* for KVM_CAP_NESTED_STATE */
+struct kvm_nested_state {
+	/* KVM_STATE_* flags */
+	__u16 flags;
+
+	/* 0 for VMX, 1 for SVM.  */
+	__u16 format;
+
+	/* 128 for SVM, 128 + VMCS size for VMX.  */
+	__u32 size;
+
+	union {
+		/* VMXON, VMCS */
+		struct kvm_vmx_nested_state vmx;
+
+		/* Pad the header to 128 bytes.  */
+		__u8 pad[120];
+	};
+
+	__u8 data[0];
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a5a3..66790724f1 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -949,6 +949,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE_1M 156
+#define KVM_CAP_NESTED_STATE 157
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1391,6 +1393,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
 
+/* Available with KVM_CAP_NESTED_STATE */
+#define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
+#define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index e336395d67..94726cb2c5 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -65,6 +65,7 @@ struct vhost_iotlb_msg {
 };
 
 #define VHOST_IOTLB_MSG 0x1
+#define VHOST_IOTLB_MSG_V2 0x2
 
 struct vhost_msg {
 	int type;
@@ -74,6 +75,15 @@ struct vhost_msg {
 	};
 };
 
+struct vhost_msg_v2 {
+	__u32 type;
+	__u32 reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
@@ -160,6 +170,14 @@ struct vhost_memory {
 #define VHOST_GET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x24,	\
 					 struct vhost_vring_state)
 
+/* Set or get vhost backend capability */
+
+/* Use message type V2 */
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+
+#define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x26, __u64)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.14.4
