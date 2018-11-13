Received: from eggs.gnu.org ([2001:4830:134:3::10]:45036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMUGy-0002rc-5f
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMU6P-00058x-8c
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:31:20 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 13 Nov 2018 19:30:59 +1100
Message-Id: <20181113083104.2692-3-aik@ozlabs.ru>
In-Reply-To: <20181113083104.2692-1-aik@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu RFC 2/7] linux-header: Update for new
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>

This pulls new NVIDIA V100 and NPU VFIO region types.

The kernel changes are not in upstream yet so this does not have a tag.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/standard-headers/drm/drm_fourcc.h     | 48 ++++++++++++
 include/standard-headers/linux/ethtool.h      | 15 +---
 .../linux/input-event-codes.h                 | 18 +++++
 include/standard-headers/linux/pci_regs.h     |  1 +
 linux-headers/asm-arm/unistd-common.h         |  1 +
 linux-headers/asm-arm64/unistd.h              |  1 +
 linux-headers/asm-generic/unistd.h            |  2 +
 linux-headers/linux/kvm.h                     | 10 +++
 linux-headers/linux/vfio.h                    | 76 +++++++++++++++++++
 9 files changed, 160 insertions(+), 12 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index b53f8d7..bd0248a 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -29,11 +29,50 @@
 extern "C" {
 #endif
 
+/**
+ * DOC: overview
+ *
+ * In the DRM subsystem, framebuffer pixel formats are described using the
+ * fourcc codes defined in `include/uapi/drm/drm_fourcc.h`. In addition to the
+ * fourcc code, a Format Modifier may optionally be provided, in order to
+ * further describe the buffer's format - for example tiling or compression.
+ *
+ * Format Modifiers
+ * ----------------
+ *
+ * Format modifiers are used in conjunction with a fourcc code, forming a
+ * unique fourcc:modifier pair. This format:modifier pair must fully define the
+ * format and data layout of the buffer, and should be the only way to describe
+ * that particular buffer.
+ *
+ * Having multiple fourcc:modifier pairs which describe the same layout should
+ * be avoided, as such aliases run the risk of different drivers exposing
+ * different names for the same data format, forcing userspace to understand
+ * that they are aliases.
+ *
+ * Format modifiers may change any property of the buffer, including the number
+ * of planes and/or the required allocation size. Format modifiers are
+ * vendor-namespaced, and as such the relationship between a fourcc code and a
+ * modifier is specific to the modifer being used. For example, some modifiers
+ * may preserve meaning - such as number of planes - from the fourcc code,
+ * whereas others may not.
+ *
+ * Vendors should document their modifier usage in as much detail as
+ * possible, to ensure maximum compatibility across devices, drivers and
+ * applications.
+ *
+ * The authoritative list of format modifier codes is found in
+ * `include/uapi/drm/drm_fourcc.h`
+ */
+
 #define fourcc_code(a, b, c, d) ((uint32_t)(a) | ((uint32_t)(b) << 8) | \
 				 ((uint32_t)(c) << 16) | ((uint32_t)(d) << 24))
 
 #define DRM_FORMAT_BIG_ENDIAN (1<<31) /* format is big endian instead of little endian */
 
+/* Reserve 0 for the invalid format specifier */
+#define DRM_FORMAT_INVALID	0
+
 /* color index */
 #define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
 
@@ -298,6 +337,15 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
 
+/*
+ * Tiled, 16 (pixels) x 16 (lines) - sized macroblocks
+ *
+ * This is a simple tiled layout using tiles of 16x16 pixels in a row-major
+ * layout. For YCbCr formats Cb/Cr components are taken in such a way that
+ * they correspond to their 16x16 luma block.
+ */
+#define DRM_FORMAT_MOD_SAMSUNG_16_16_TILE	fourcc_mod_code(SAMSUNG, 2)
+
 /*
  * Qualcomm Compressed Format
  *
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 57ffcb5..6ec5aeb 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -91,10 +91,6 @@
  * %ETHTOOL_GSET to get the current values before making specific
  * changes and then applying them with %ETHTOOL_SSET.
  *
- * Drivers that implement set_settings() should validate all fields
- * other than @cmd that are not described as read-only or deprecated,
- * and must ignore all fields described as read-only.
- *
  * Deprecated fields should be ignored by both users and drivers.
  */
 struct ethtool_cmd {
@@ -1800,14 +1796,9 @@ enum ethtool_reset_flags {
  * rejected.
  *
  * Deprecated %ethtool_cmd fields transceiver, maxtxpkt and maxrxpkt
- * are not available in %ethtool_link_settings. Until all drivers are
- * converted to ignore them or to the new %ethtool_link_settings API,
- * for both queries and changes, users should always try
- * %ETHTOOL_GLINKSETTINGS first, and if it fails with -ENOTSUPP stick
- * only to %ETHTOOL_GSET and %ETHTOOL_SSET consistently. If it
- * succeeds, then users should stick to %ETHTOOL_GLINKSETTINGS and
- * %ETHTOOL_SLINKSETTINGS (which would support drivers implementing
- * either %ethtool_cmd or %ethtool_link_settings).
+ * are not available in %ethtool_link_settings. These fields will be
+ * always set to zero in %ETHTOOL_GSET reply and %ETHTOOL_SSET will
+ * fail if any of them is set to non-zero value.
  *
  * Users should assume that all fields not marked read-only are
  * writable and subject to validation by the driver.  They should use
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 9e6a8ba..792b8df 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -708,6 +708,15 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+/*
+ * 0x0a is reserved and should not be used in input drivers.
+ * It was used by HID as REL_MISC+1 and userspace needs to detect if
+ * the next REL_* event is correct or is just REL_MISC + n.
+ * We define here REL_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
@@ -744,6 +753,15 @@
 
 #define ABS_MISC		0x28
 
+/*
+ * 0x2e is reserved and should not be used in input drivers.
+ * It was used by HID as ABS_MISC+6 and userspace needs to detect if
+ * the next ABS_* event is correct or is just ABS_MISC + n.
+ * We define here ABS_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define ABS_RESERVED		0x2e
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index ee556cc..e1e9888 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -52,6 +52,7 @@
 #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
 
 #define PCI_STATUS		0x06	/* 16 bits */
+#define  PCI_STATUS_IMM_READY	0x01	/* Immediate Readiness */
 #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 60c2d93..8c84bcf 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -355,5 +355,6 @@
 #define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
 #define __NR_statx (__NR_SYSCALL_BASE + 397)
 #define __NR_rseq (__NR_SYSCALL_BASE + 398)
+#define __NR_io_pgetevents (__NR_SYSCALL_BASE + 399)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index 5072cbd..dae1584 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index df4bedb..538546e 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -242,10 +242,12 @@ __SYSCALL(__NR_tee, sys_tee)
 /* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
+#endif
 
 /* fs/sync.c */
 #define __NR_sync 81
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f11a7eb..95481af 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -757,6 +757,15 @@ struct kvm_ppc_resize_hpt {
 
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
+/*
+ * On arm64, machine type can be used to request the physical
+ * address size for the VM. Bits[7-0] are reserved for the guest
+ * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * value 0 implies the default IPA size, 40bits.
+ */
+#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
+#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
+	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -965,6 +974,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_COALESCED_PIO 162
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
+#define KVM_CAP_ARM_VM_IPA_SIZE 165
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453..fea9390 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -303,6 +303,70 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+#define VFIO_REGION_TYPE_GFX                    (1)
+#define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
+
+/**
+ * struct vfio_region_gfx_edid - EDID region layout.
+ *
+ * Set display link state and EDID blob.
+ *
+ * The EDID blob has monitor information such as brand, name, serial
+ * number, physical size, supported video modes and more.
+ *
+ * This special region allows userspace (typically qemu) set a virtual
+ * EDID for the virtual monitor, which allows a flexible display
+ * configuration.
+ *
+ * For the edid blob spec look here:
+ *    https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
+ *
+ * On linux systems you can find the EDID blob in sysfs:
+ *    /sys/class/drm/${card}/${connector}/edid
+ *
+ * You can use the edid-decode ulility (comes with xorg-x11-utils) to
+ * decode the EDID blob.
+ *
+ * @edid_offset: location of the edid blob, relative to the
+ *               start of the region (readonly).
+ * @edid_max_size: max size of the edid blob (readonly).
+ * @edid_size: actual edid size (read/write).
+ * @link_state: display link state (read/write).
+ * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
+ * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
+ * @max_xres: max display width (0 == no limitation, readonly).
+ * @max_yres: max display height (0 == no limitation, readonly).
+ *
+ * EDID update protocol:
+ *   (1) set link-state to down.
+ *   (2) update edid blob and size.
+ *   (3) set link-state to up.
+ */
+struct vfio_region_gfx_edid {
+	__u32 edid_offset;
+	__u32 edid_max_size;
+	__u32 edid_size;
+	__u32 max_xres;
+	__u32 max_yres;
+	__u32 link_state;
+#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
+#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
+};
+
+/* 10de vendor sub-type
+ *
+ * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
+ */
+#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
+
+/*
+ * 1014 vendor sub-type
+ *
+ * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
+ * to do TLB invalidation on a GPU.
+ */
+#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
@@ -313,6 +377,18 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
 
+/*
+ * Capability with compressed real address (aka SSA - small system address)
+ * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing.
+ */
+#define VFIO_REGION_INFO_CAP_NPU2		4
+
+struct vfio_region_info_cap_npu2 {
+	struct vfio_info_cap_header header;
+	__u64 tgt;
+	/* size is defined in VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM */
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.17.1
