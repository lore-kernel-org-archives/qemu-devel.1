Received: from eggs.gnu.org ([209.51.188.92]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsM-00039p-3b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzs8-00079Q-Hq
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzs7-00076M-UM
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so6331098wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:07 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:48 +0100
Message-Id: <20190125114155.32062-2-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 1/8] Update linux headers (5.0-rc2)
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

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/standard-headers/drm/drm_fourcc.h     |   63 +
 include/standard-headers/linux/ethtool.h      |   19 +-
 .../linux/input-event-codes.h                 |   19 +
 include/standard-headers/linux/pci_regs.h     |    1 +
 .../standard-headers/linux/virtio_balloon.h   |    8 +
 include/standard-headers/linux/virtio_blk.h   |   54 +
 .../standard-headers/linux/virtio_config.h    |    3 +
 include/standard-headers/linux/virtio_gpu.h   |   18 +
 include/standard-headers/linux/virtio_ring.h  |   52 +
 linux-headers/asm-arm/unistd-common.h         |    1 +
 linux-headers/asm-arm64/unistd.h              |    1 +
 linux-headers/asm-generic/unistd.h            |   10 +-
 linux-headers/asm-mips/sgidefs.h              |    8 -
 linux-headers/asm-mips/unistd.h               | 1074 +----------------
 linux-headers/asm-mips/unistd_n64.h           |  334 +++++
 linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
 linux-headers/asm-powerpc/unistd.h            |  389 +-----
 linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
 linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
 linux-headers/linux/kvm.h                     |   29 +
 linux-headers/linux/vfio.h                    |   92 ++
 linux-headers/linux/vhost.h                   |  113 +-
 linux-headers/linux/vhost_types.h             |  128 ++
 scripts/update-linux-headers.sh               |   10 +-
 24 files changed, 1963 insertions(+), 1590 deletions(-)
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index b53f8d7c8c..44490607f9 100644
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
 
@@ -111,6 +150,21 @@ extern "C" {
 #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian */
 
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_XYUV8888		fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
+
+/*
+ * packed YCbCr420 2x2 tiled formats
+ * first 64 bits will contain Y,Cb,Cr components for a 2x2 tile
+ */
+/* [63:0]   A3:A2:Y3:0:Cr0:0:Y2:0:A1:A0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian */
+#define DRM_FORMAT_Y0L0		fourcc_code('Y', '0', 'L', '0')
+/* [63:0]   X3:X2:Y3:0:Cr0:0:Y2:0:X1:X0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian */
+#define DRM_FORMAT_X0L0		fourcc_code('X', '0', 'L', '0')
+
+/* [63:0]   A3:A2:Y3:Cr0:Y2:A1:A0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
+#define DRM_FORMAT_Y0L2		fourcc_code('Y', '0', 'L', '2')
+/* [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
+#define DRM_FORMAT_X0L2		fourcc_code('X', '0', 'L', '2')
 
 /*
  * 2 plane RGB + A
@@ -298,6 +352,15 @@ extern "C" {
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
index 57ffcb5341..063c814278 100644
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
@@ -886,7 +882,7 @@ struct ethtool_rx_flow_spec {
 	uint32_t		location;
 };
 
-/* How rings are layed out when accessing virtual functions or
+/* How rings are laid out when accessing virtual functions or
  * offloaded queues is device specific. To allow users to do flow
  * steering and specify these queues the ring cookie is partitioned
  * into a 32bit queue index with an 8 bit virtual function id.
@@ -895,7 +891,7 @@ struct ethtool_rx_flow_spec {
  * devices start supporting PCIe w/ARI. However at the moment I
  * do not know of any devices that support this so I do not reserve
  * space for this at this time. If a future patch consumes the next
- * byte it should be aware of this possiblity.
+ * byte it should be aware of this possibility.
  */
 #define ETHTOOL_RX_FLOW_SPEC_RING	0x00000000FFFFFFFFLL
 #define ETHTOOL_RX_FLOW_SPEC_RING_VF	0x000000FF00000000LL
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
index 9e6a8ba4ce..ff2e1ebcc9 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -708,6 +708,16 @@
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
+#define REL_HWHEEL_HI_RES	0x0c
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
@@ -744,6 +754,15 @@
 
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
index ee556ccc93..e1e9888c85 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -52,6 +52,7 @@
 #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
 
 #define PCI_STATUS		0x06	/* 16 bits */
+#define  PCI_STATUS_IMM_READY	0x01	/* Immediate Readiness */
 #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 4dbb7dc6c0..9375ca2a70 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -34,15 +34,23 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
+#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+#define VIRTIO_BALLOON_CMD_ID_STOP	0
+#define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
 	uint32_t num_pages;
 	/* Number of pages we've actually got in balloon. */
 	uint32_t actual;
+	/* Free page report command id, readonly by guest */
+	uint32_t free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning is in use */
+	uint32_t poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
index ab16ec5fd2..0229b0fbe4 100644
--- a/include/standard-headers/linux/virtio_blk.h
+++ b/include/standard-headers/linux/virtio_blk.h
@@ -38,6 +38,8 @@
 #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
+#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
+#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -84,6 +86,39 @@ struct virtio_blk_config {
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
 	uint16_t num_queues;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
+	/*
+	 * The maximum discard sectors (in 512-byte sectors) for
+	 * one segment.
+	 */
+	uint32_t max_discard_sectors;
+	/*
+	 * The maximum number of discard segments in a
+	 * discard command.
+	 */
+	uint32_t max_discard_seg;
+	/* Discard commands must be aligned to this number of sectors. */
+	uint32_t discard_sector_alignment;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
+	/*
+	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
+	 * one segment.
+	 */
+	uint32_t max_write_zeroes_sectors;
+	/*
+	 * The maximum number of segments in a write zeroes
+	 * command.
+	 */
+	uint32_t max_write_zeroes_seg;
+	/*
+	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
+	 * deallocation of one or more of the sectors.
+	 */
+	uint8_t write_zeroes_may_unmap;
+
+	uint8_t unused1[3];
 } QEMU_PACKED;
 
 /*
@@ -112,6 +147,12 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Discard command */
+#define VIRTIO_BLK_T_DISCARD	11
+
+/* Write zeroes command */
+#define VIRTIO_BLK_T_WRITE_ZEROES	13
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -131,6 +172,19 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/* Unmap this range (only valid for write zeroes command) */
+#define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP	0x00000001
+
+/* Discard/write zeroes range for each request. */
+struct virtio_blk_discard_write_zeroes {
+	/* discard/write zeroes start sector */
+	uint64_t sector;
+	/* number of discard/write zeroes sectors */
+	uint32_t num_sectors;
+	/* flags for this range */
+	uint32_t flags;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index 0b194365a0..24e30af5ec 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -75,6 +75,9 @@
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
 
+/* This feature indicates support for the packed virtqueue layout. */
+#define VIRTIO_F_RING_PACKED		34
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 52a830dcf8..27bb5111f9 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -41,6 +41,7 @@
 #include "standard-headers/linux/types.h"
 
 #define VIRTIO_GPU_F_VIRGL 0
+#define VIRTIO_GPU_F_EDID  1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
+	VIRTIO_GPU_CMD_GET_EDID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
+	VIRTIO_GPU_RESP_OK_EDID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -291,6 +294,21 @@ struct virtio_gpu_resp_capset {
 	uint8_t capset_data[];
 };
 
+/* VIRTIO_GPU_CMD_GET_EDID */
+struct virtio_gpu_cmd_get_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint32_t scanout;
+	uint32_t padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_EDID */
+struct virtio_gpu_resp_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	uint32_t size;
+	uint32_t padding;
+	uint8_t edid[1024];
+};
+
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
index d26e72bc6b..e89931f634 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -42,6 +42,13 @@
 /* This means the buffer contains a list of buffer descriptors. */
 #define VRING_DESC_F_INDIRECT	4
 
+/*
+ * Mark a descriptor as available or used in packed ring.
+ * Notice: they are defined as shifts instead of shifted values.
+ */
+#define VRING_PACKED_DESC_F_AVAIL	7
+#define VRING_PACKED_DESC_F_USED	15
+
 /* The Host uses this in used->flags to advise the Guest: don't kick me when
  * you add a buffer.  It's unreliable, so it's simply an optimization.  Guest
  * will still kick if it's out of buffers. */
@@ -51,6 +58,23 @@
  * optimization.  */
 #define VRING_AVAIL_F_NO_INTERRUPT	1
 
+/* Enable events in packed ring. */
+#define VRING_PACKED_EVENT_FLAG_ENABLE	0x0
+/* Disable events in packed ring. */
+#define VRING_PACKED_EVENT_FLAG_DISABLE	0x1
+/*
+ * Enable events for a specific descriptor in packed ring.
+ * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ * Only valid if VIRTIO_RING_F_EVENT_IDX has been negotiated.
+ */
+#define VRING_PACKED_EVENT_FLAG_DESC	0x2
+
+/*
+ * Wrap counter bit shift in event suppression structure
+ * of packed ring.
+ */
+#define VRING_PACKED_EVENT_F_WRAP_CTR	15
+
 /* We support indirect buffer descriptors */
 #define VIRTIO_RING_F_INDIRECT_DESC	28
 
@@ -169,4 +193,32 @@ static inline int vring_need_event(uint16_t event_idx, uint16_t new_idx, uint16_
 	return (uint16_t)(new_idx - event_idx - 1) < (uint16_t)(new_idx - old);
 }
 
+struct vring_packed_desc_event {
+	/* Descriptor Ring Change Event Offset/Wrap Counter. */
+	uint16_t off_wrap;
+	/* Descriptor Ring Change Event Flags. */
+	uint16_t flags;
+};
+
+struct vring_packed_desc {
+	/* Buffer Address. */
+	uint64_t addr;
+	/* Buffer Length. */
+	uint32_t len;
+	/* Buffer ID. */
+	uint16_t id;
+	/* The flags depending on descriptor type. */
+	uint16_t flags;
+};
+
+struct vring_packed {
+	unsigned int num;
+
+	struct vring_packed_desc *desc;
+
+	struct vring_packed_desc_event *driver;
+
+	struct vring_packed_desc_event *device;
+};
+
 #endif /* _LINUX_VIRTIO_RING_H */
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 60c2d931d0..8c84bcf10f 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -355,5 +355,6 @@
 #define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
 #define __NR_statx (__NR_SYSCALL_BASE + 397)
 #define __NR_rseq (__NR_SYSCALL_BASE + 398)
+#define __NR_io_pgetevents (__NR_SYSCALL_BASE + 399)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index 5072cbd15c..dae1584cf0 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index df4bedb9b0..d90127298f 100644
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
@@ -736,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
@@ -758,8 +762,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate __NR3264_ftruncate
 #define __NR_lseek __NR3264_lseek
 #define __NR_sendfile __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_newfstatat __NR3264_fstatat
 #define __NR_fstat __NR3264_fstat
+#endif
 #define __NR_mmap __NR3264_mmap
 #define __NR_fadvise64 __NR3264_fadvise64
 #ifdef __NR3264_stat
@@ -774,8 +780,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_ftruncate64 __NR3264_ftruncate
 #define __NR_llseek __NR3264_lseek
 #define __NR_sendfile64 __NR3264_sendfile
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR_fstatat64 __NR3264_fstatat
 #define __NR_fstat64 __NR3264_fstat
+#endif
 #define __NR_mmap2 __NR3264_mmap
 #define __NR_fadvise64_64 __NR3264_fadvise64
 #ifdef __NR3264_stat
diff --git a/linux-headers/asm-mips/sgidefs.h b/linux-headers/asm-mips/sgidefs.h
index 26143e3b7c..69c3de90c5 100644
--- a/linux-headers/asm-mips/sgidefs.h
+++ b/linux-headers/asm-mips/sgidefs.h
@@ -11,14 +11,6 @@
 #ifndef __ASM_SGIDEFS_H
 #define __ASM_SGIDEFS_H
 
-/*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
 /*
  * Definitions for the ISA levels
  *
diff --git a/linux-headers/asm-mips/unistd.h b/linux-headers/asm-mips/unistd.h
index d4a85ef3eb..62b86b865c 100644
--- a/linux-headers/asm-mips/unistd.h
+++ b/linux-headers/asm-mips/unistd.h
@@ -17,1085 +17,23 @@
 
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
-/*
- * Linux o32 style syscalls are in the range from 4000 to 4999.
- */
-#define __NR_Linux			4000
-#define __NR_syscall			(__NR_Linux +	0)
-#define __NR_exit			(__NR_Linux +	1)
-#define __NR_fork			(__NR_Linux +	2)
-#define __NR_read			(__NR_Linux +	3)
-#define __NR_write			(__NR_Linux +	4)
-#define __NR_open			(__NR_Linux +	5)
-#define __NR_close			(__NR_Linux +	6)
-#define __NR_waitpid			(__NR_Linux +	7)
-#define __NR_creat			(__NR_Linux +	8)
-#define __NR_link			(__NR_Linux +	9)
-#define __NR_unlink			(__NR_Linux +  10)
-#define __NR_execve			(__NR_Linux +  11)
-#define __NR_chdir			(__NR_Linux +  12)
-#define __NR_time			(__NR_Linux +  13)
-#define __NR_mknod			(__NR_Linux +  14)
-#define __NR_chmod			(__NR_Linux +  15)
-#define __NR_lchown			(__NR_Linux +  16)
-#define __NR_break			(__NR_Linux +  17)
-#define __NR_unused18			(__NR_Linux +  18)
-#define __NR_lseek			(__NR_Linux +  19)
-#define __NR_getpid			(__NR_Linux +  20)
-#define __NR_mount			(__NR_Linux +  21)
-#define __NR_umount			(__NR_Linux +  22)
-#define __NR_setuid			(__NR_Linux +  23)
-#define __NR_getuid			(__NR_Linux +  24)
-#define __NR_stime			(__NR_Linux +  25)
-#define __NR_ptrace			(__NR_Linux +  26)
-#define __NR_alarm			(__NR_Linux +  27)
-#define __NR_unused28			(__NR_Linux +  28)
-#define __NR_pause			(__NR_Linux +  29)
-#define __NR_utime			(__NR_Linux +  30)
-#define __NR_stty			(__NR_Linux +  31)
-#define __NR_gtty			(__NR_Linux +  32)
-#define __NR_access			(__NR_Linux +  33)
-#define __NR_nice			(__NR_Linux +  34)
-#define __NR_ftime			(__NR_Linux +  35)
-#define __NR_sync			(__NR_Linux +  36)
-#define __NR_kill			(__NR_Linux +  37)
-#define __NR_rename			(__NR_Linux +  38)
-#define __NR_mkdir			(__NR_Linux +  39)
-#define __NR_rmdir			(__NR_Linux +  40)
-#define __NR_dup			(__NR_Linux +  41)
-#define __NR_pipe			(__NR_Linux +  42)
-#define __NR_times			(__NR_Linux +  43)
-#define __NR_prof			(__NR_Linux +  44)
-#define __NR_brk			(__NR_Linux +  45)
-#define __NR_setgid			(__NR_Linux +  46)
-#define __NR_getgid			(__NR_Linux +  47)
-#define __NR_signal			(__NR_Linux +  48)
-#define __NR_geteuid			(__NR_Linux +  49)
-#define __NR_getegid			(__NR_Linux +  50)
-#define __NR_acct			(__NR_Linux +  51)
-#define __NR_umount2			(__NR_Linux +  52)
-#define __NR_lock			(__NR_Linux +  53)
-#define __NR_ioctl			(__NR_Linux +  54)
-#define __NR_fcntl			(__NR_Linux +  55)
-#define __NR_mpx			(__NR_Linux +  56)
-#define __NR_setpgid			(__NR_Linux +  57)
-#define __NR_ulimit			(__NR_Linux +  58)
-#define __NR_unused59			(__NR_Linux +  59)
-#define __NR_umask			(__NR_Linux +  60)
-#define __NR_chroot			(__NR_Linux +  61)
-#define __NR_ustat			(__NR_Linux +  62)
-#define __NR_dup2			(__NR_Linux +  63)
-#define __NR_getppid			(__NR_Linux +  64)
-#define __NR_getpgrp			(__NR_Linux +  65)
-#define __NR_setsid			(__NR_Linux +  66)
-#define __NR_sigaction			(__NR_Linux +  67)
-#define __NR_sgetmask			(__NR_Linux +  68)
-#define __NR_ssetmask			(__NR_Linux +  69)
-#define __NR_setreuid			(__NR_Linux +  70)
-#define __NR_setregid			(__NR_Linux +  71)
-#define __NR_sigsuspend			(__NR_Linux +  72)
-#define __NR_sigpending			(__NR_Linux +  73)
-#define __NR_sethostname		(__NR_Linux +  74)
-#define __NR_setrlimit			(__NR_Linux +  75)
-#define __NR_getrlimit			(__NR_Linux +  76)
-#define __NR_getrusage			(__NR_Linux +  77)
-#define __NR_gettimeofday		(__NR_Linux +  78)
-#define __NR_settimeofday		(__NR_Linux +  79)
-#define __NR_getgroups			(__NR_Linux +  80)
-#define __NR_setgroups			(__NR_Linux +  81)
-#define __NR_reserved82			(__NR_Linux +  82)
-#define __NR_symlink			(__NR_Linux +  83)
-#define __NR_unused84			(__NR_Linux +  84)
-#define __NR_readlink			(__NR_Linux +  85)
-#define __NR_uselib			(__NR_Linux +  86)
-#define __NR_swapon			(__NR_Linux +  87)
-#define __NR_reboot			(__NR_Linux +  88)
-#define __NR_readdir			(__NR_Linux +  89)
-#define __NR_mmap			(__NR_Linux +  90)
-#define __NR_munmap			(__NR_Linux +  91)
-#define __NR_truncate			(__NR_Linux +  92)
-#define __NR_ftruncate			(__NR_Linux +  93)
-#define __NR_fchmod			(__NR_Linux +  94)
-#define __NR_fchown			(__NR_Linux +  95)
-#define __NR_getpriority		(__NR_Linux +  96)
-#define __NR_setpriority		(__NR_Linux +  97)
-#define __NR_profil			(__NR_Linux +  98)
-#define __NR_statfs			(__NR_Linux +  99)
-#define __NR_fstatfs			(__NR_Linux + 100)
-#define __NR_ioperm			(__NR_Linux + 101)
-#define __NR_socketcall			(__NR_Linux + 102)
-#define __NR_syslog			(__NR_Linux + 103)
-#define __NR_setitimer			(__NR_Linux + 104)
-#define __NR_getitimer			(__NR_Linux + 105)
-#define __NR_stat			(__NR_Linux + 106)
-#define __NR_lstat			(__NR_Linux + 107)
-#define __NR_fstat			(__NR_Linux + 108)
-#define __NR_unused109			(__NR_Linux + 109)
-#define __NR_iopl			(__NR_Linux + 110)
-#define __NR_vhangup			(__NR_Linux + 111)
-#define __NR_idle			(__NR_Linux + 112)
-#define __NR_vm86			(__NR_Linux + 113)
-#define __NR_wait4			(__NR_Linux + 114)
-#define __NR_swapoff			(__NR_Linux + 115)
-#define __NR_sysinfo			(__NR_Linux + 116)
-#define __NR_ipc			(__NR_Linux + 117)
-#define __NR_fsync			(__NR_Linux + 118)
-#define __NR_sigreturn			(__NR_Linux + 119)
-#define __NR_clone			(__NR_Linux + 120)
-#define __NR_setdomainname		(__NR_Linux + 121)
-#define __NR_uname			(__NR_Linux + 122)
-#define __NR_modify_ldt			(__NR_Linux + 123)
-#define __NR_adjtimex			(__NR_Linux + 124)
-#define __NR_mprotect			(__NR_Linux + 125)
-#define __NR_sigprocmask		(__NR_Linux + 126)
-#define __NR_create_module		(__NR_Linux + 127)
-#define __NR_init_module		(__NR_Linux + 128)
-#define __NR_delete_module		(__NR_Linux + 129)
-#define __NR_get_kernel_syms		(__NR_Linux + 130)
-#define __NR_quotactl			(__NR_Linux + 131)
-#define __NR_getpgid			(__NR_Linux + 132)
-#define __NR_fchdir			(__NR_Linux + 133)
-#define __NR_bdflush			(__NR_Linux + 134)
-#define __NR_sysfs			(__NR_Linux + 135)
-#define __NR_personality		(__NR_Linux + 136)
-#define __NR_afs_syscall		(__NR_Linux + 137) /* Syscall for Andrew File System */
-#define __NR_setfsuid			(__NR_Linux + 138)
-#define __NR_setfsgid			(__NR_Linux + 139)
-#define __NR__llseek			(__NR_Linux + 140)
-#define __NR_getdents			(__NR_Linux + 141)
-#define __NR__newselect			(__NR_Linux + 142)
-#define __NR_flock			(__NR_Linux + 143)
-#define __NR_msync			(__NR_Linux + 144)
-#define __NR_readv			(__NR_Linux + 145)
-#define __NR_writev			(__NR_Linux + 146)
-#define __NR_cacheflush			(__NR_Linux + 147)
-#define __NR_cachectl			(__NR_Linux + 148)
-#define __NR_sysmips			(__NR_Linux + 149)
-#define __NR_unused150			(__NR_Linux + 150)
-#define __NR_getsid			(__NR_Linux + 151)
-#define __NR_fdatasync			(__NR_Linux + 152)
-#define __NR__sysctl			(__NR_Linux + 153)
-#define __NR_mlock			(__NR_Linux + 154)
-#define __NR_munlock			(__NR_Linux + 155)
-#define __NR_mlockall			(__NR_Linux + 156)
-#define __NR_munlockall			(__NR_Linux + 157)
-#define __NR_sched_setparam		(__NR_Linux + 158)
-#define __NR_sched_getparam		(__NR_Linux + 159)
-#define __NR_sched_setscheduler		(__NR_Linux + 160)
-#define __NR_sched_getscheduler		(__NR_Linux + 161)
-#define __NR_sched_yield		(__NR_Linux + 162)
-#define __NR_sched_get_priority_max	(__NR_Linux + 163)
-#define __NR_sched_get_priority_min	(__NR_Linux + 164)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 165)
-#define __NR_nanosleep			(__NR_Linux + 166)
-#define __NR_mremap			(__NR_Linux + 167)
-#define __NR_accept			(__NR_Linux + 168)
-#define __NR_bind			(__NR_Linux + 169)
-#define __NR_connect			(__NR_Linux + 170)
-#define __NR_getpeername		(__NR_Linux + 171)
-#define __NR_getsockname		(__NR_Linux + 172)
-#define __NR_getsockopt			(__NR_Linux + 173)
-#define __NR_listen			(__NR_Linux + 174)
-#define __NR_recv			(__NR_Linux + 175)
-#define __NR_recvfrom			(__NR_Linux + 176)
-#define __NR_recvmsg			(__NR_Linux + 177)
-#define __NR_send			(__NR_Linux + 178)
-#define __NR_sendmsg			(__NR_Linux + 179)
-#define __NR_sendto			(__NR_Linux + 180)
-#define __NR_setsockopt			(__NR_Linux + 181)
-#define __NR_shutdown			(__NR_Linux + 182)
-#define __NR_socket			(__NR_Linux + 183)
-#define __NR_socketpair			(__NR_Linux + 184)
-#define __NR_setresuid			(__NR_Linux + 185)
-#define __NR_getresuid			(__NR_Linux + 186)
-#define __NR_query_module		(__NR_Linux + 187)
-#define __NR_poll			(__NR_Linux + 188)
-#define __NR_nfsservctl			(__NR_Linux + 189)
-#define __NR_setresgid			(__NR_Linux + 190)
-#define __NR_getresgid			(__NR_Linux + 191)
-#define __NR_prctl			(__NR_Linux + 192)
-#define __NR_rt_sigreturn		(__NR_Linux + 193)
-#define __NR_rt_sigaction		(__NR_Linux + 194)
-#define __NR_rt_sigprocmask		(__NR_Linux + 195)
-#define __NR_rt_sigpending		(__NR_Linux + 196)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 197)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 198)
-#define __NR_rt_sigsuspend		(__NR_Linux + 199)
-#define __NR_pread64			(__NR_Linux + 200)
-#define __NR_pwrite64			(__NR_Linux + 201)
-#define __NR_chown			(__NR_Linux + 202)
-#define __NR_getcwd			(__NR_Linux + 203)
-#define __NR_capget			(__NR_Linux + 204)
-#define __NR_capset			(__NR_Linux + 205)
-#define __NR_sigaltstack		(__NR_Linux + 206)
-#define __NR_sendfile			(__NR_Linux + 207)
-#define __NR_getpmsg			(__NR_Linux + 208)
-#define __NR_putpmsg			(__NR_Linux + 209)
-#define __NR_mmap2			(__NR_Linux + 210)
-#define __NR_truncate64			(__NR_Linux + 211)
-#define __NR_ftruncate64		(__NR_Linux + 212)
-#define __NR_stat64			(__NR_Linux + 213)
-#define __NR_lstat64			(__NR_Linux + 214)
-#define __NR_fstat64			(__NR_Linux + 215)
-#define __NR_pivot_root			(__NR_Linux + 216)
-#define __NR_mincore			(__NR_Linux + 217)
-#define __NR_madvise			(__NR_Linux + 218)
-#define __NR_getdents64			(__NR_Linux + 219)
-#define __NR_fcntl64			(__NR_Linux + 220)
-#define __NR_reserved221		(__NR_Linux + 221)
-#define __NR_gettid			(__NR_Linux + 222)
-#define __NR_readahead			(__NR_Linux + 223)
-#define __NR_setxattr			(__NR_Linux + 224)
-#define __NR_lsetxattr			(__NR_Linux + 225)
-#define __NR_fsetxattr			(__NR_Linux + 226)
-#define __NR_getxattr			(__NR_Linux + 227)
-#define __NR_lgetxattr			(__NR_Linux + 228)
-#define __NR_fgetxattr			(__NR_Linux + 229)
-#define __NR_listxattr			(__NR_Linux + 230)
-#define __NR_llistxattr			(__NR_Linux + 231)
-#define __NR_flistxattr			(__NR_Linux + 232)
-#define __NR_removexattr		(__NR_Linux + 233)
-#define __NR_lremovexattr		(__NR_Linux + 234)
-#define __NR_fremovexattr		(__NR_Linux + 235)
-#define __NR_tkill			(__NR_Linux + 236)
-#define __NR_sendfile64			(__NR_Linux + 237)
-#define __NR_futex			(__NR_Linux + 238)
-#define __NR_sched_setaffinity		(__NR_Linux + 239)
-#define __NR_sched_getaffinity		(__NR_Linux + 240)
-#define __NR_io_setup			(__NR_Linux + 241)
-#define __NR_io_destroy			(__NR_Linux + 242)
-#define __NR_io_getevents		(__NR_Linux + 243)
-#define __NR_io_submit			(__NR_Linux + 244)
-#define __NR_io_cancel			(__NR_Linux + 245)
-#define __NR_exit_group			(__NR_Linux + 246)
-#define __NR_lookup_dcookie		(__NR_Linux + 247)
-#define __NR_epoll_create		(__NR_Linux + 248)
-#define __NR_epoll_ctl			(__NR_Linux + 249)
-#define __NR_epoll_wait			(__NR_Linux + 250)
-#define __NR_remap_file_pages		(__NR_Linux + 251)
-#define __NR_set_tid_address		(__NR_Linux + 252)
-#define __NR_restart_syscall		(__NR_Linux + 253)
-#define __NR_fadvise64			(__NR_Linux + 254)
-#define __NR_statfs64			(__NR_Linux + 255)
-#define __NR_fstatfs64			(__NR_Linux + 256)
-#define __NR_timer_create		(__NR_Linux + 257)
-#define __NR_timer_settime		(__NR_Linux + 258)
-#define __NR_timer_gettime		(__NR_Linux + 259)
-#define __NR_timer_getoverrun		(__NR_Linux + 260)
-#define __NR_timer_delete		(__NR_Linux + 261)
-#define __NR_clock_settime		(__NR_Linux + 262)
-#define __NR_clock_gettime		(__NR_Linux + 263)
-#define __NR_clock_getres		(__NR_Linux + 264)
-#define __NR_clock_nanosleep		(__NR_Linux + 265)
-#define __NR_tgkill			(__NR_Linux + 266)
-#define __NR_utimes			(__NR_Linux + 267)
-#define __NR_mbind			(__NR_Linux + 268)
-#define __NR_get_mempolicy		(__NR_Linux + 269)
-#define __NR_set_mempolicy		(__NR_Linux + 270)
-#define __NR_mq_open			(__NR_Linux + 271)
-#define __NR_mq_unlink			(__NR_Linux + 272)
-#define __NR_mq_timedsend		(__NR_Linux + 273)
-#define __NR_mq_timedreceive		(__NR_Linux + 274)
-#define __NR_mq_notify			(__NR_Linux + 275)
-#define __NR_mq_getsetattr		(__NR_Linux + 276)
-#define __NR_vserver			(__NR_Linux + 277)
-#define __NR_waitid			(__NR_Linux + 278)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 279) */
-#define __NR_add_key			(__NR_Linux + 280)
-#define __NR_request_key		(__NR_Linux + 281)
-#define __NR_keyctl			(__NR_Linux + 282)
-#define __NR_set_thread_area		(__NR_Linux + 283)
-#define __NR_inotify_init		(__NR_Linux + 284)
-#define __NR_inotify_add_watch		(__NR_Linux + 285)
-#define __NR_inotify_rm_watch		(__NR_Linux + 286)
-#define __NR_migrate_pages		(__NR_Linux + 287)
-#define __NR_openat			(__NR_Linux + 288)
-#define __NR_mkdirat			(__NR_Linux + 289)
-#define __NR_mknodat			(__NR_Linux + 290)
-#define __NR_fchownat			(__NR_Linux + 291)
-#define __NR_futimesat			(__NR_Linux + 292)
-#define __NR_fstatat64			(__NR_Linux + 293)
-#define __NR_unlinkat			(__NR_Linux + 294)
-#define __NR_renameat			(__NR_Linux + 295)
-#define __NR_linkat			(__NR_Linux + 296)
-#define __NR_symlinkat			(__NR_Linux + 297)
-#define __NR_readlinkat			(__NR_Linux + 298)
-#define __NR_fchmodat			(__NR_Linux + 299)
-#define __NR_faccessat			(__NR_Linux + 300)
-#define __NR_pselect6			(__NR_Linux + 301)
-#define __NR_ppoll			(__NR_Linux + 302)
-#define __NR_unshare			(__NR_Linux + 303)
-#define __NR_splice			(__NR_Linux + 304)
-#define __NR_sync_file_range		(__NR_Linux + 305)
-#define __NR_tee			(__NR_Linux + 306)
-#define __NR_vmsplice			(__NR_Linux + 307)
-#define __NR_move_pages			(__NR_Linux + 308)
-#define __NR_set_robust_list		(__NR_Linux + 309)
-#define __NR_get_robust_list		(__NR_Linux + 310)
-#define __NR_kexec_load			(__NR_Linux + 311)
-#define __NR_getcpu			(__NR_Linux + 312)
-#define __NR_epoll_pwait		(__NR_Linux + 313)
-#define __NR_ioprio_set			(__NR_Linux + 314)
-#define __NR_ioprio_get			(__NR_Linux + 315)
-#define __NR_utimensat			(__NR_Linux + 316)
-#define __NR_signalfd			(__NR_Linux + 317)
-#define __NR_timerfd			(__NR_Linux + 318)
-#define __NR_eventfd			(__NR_Linux + 319)
-#define __NR_fallocate			(__NR_Linux + 320)
-#define __NR_timerfd_create		(__NR_Linux + 321)
-#define __NR_timerfd_gettime		(__NR_Linux + 322)
-#define __NR_timerfd_settime		(__NR_Linux + 323)
-#define __NR_signalfd4			(__NR_Linux + 324)
-#define __NR_eventfd2			(__NR_Linux + 325)
-#define __NR_epoll_create1		(__NR_Linux + 326)
-#define __NR_dup3			(__NR_Linux + 327)
-#define __NR_pipe2			(__NR_Linux + 328)
-#define __NR_inotify_init1		(__NR_Linux + 329)
-#define __NR_preadv			(__NR_Linux + 330)
-#define __NR_pwritev			(__NR_Linux + 331)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 332)
-#define __NR_perf_event_open		(__NR_Linux + 333)
-#define __NR_accept4			(__NR_Linux + 334)
-#define __NR_recvmmsg			(__NR_Linux + 335)
-#define __NR_fanotify_init		(__NR_Linux + 336)
-#define __NR_fanotify_mark		(__NR_Linux + 337)
-#define __NR_prlimit64			(__NR_Linux + 338)
-#define __NR_name_to_handle_at		(__NR_Linux + 339)
-#define __NR_open_by_handle_at		(__NR_Linux + 340)
-#define __NR_clock_adjtime		(__NR_Linux + 341)
-#define __NR_syncfs			(__NR_Linux + 342)
-#define __NR_sendmmsg			(__NR_Linux + 343)
-#define __NR_setns			(__NR_Linux + 344)
-#define __NR_process_vm_readv		(__NR_Linux + 345)
-#define __NR_process_vm_writev		(__NR_Linux + 346)
-#define __NR_kcmp			(__NR_Linux + 347)
-#define __NR_finit_module		(__NR_Linux + 348)
-#define __NR_sched_setattr		(__NR_Linux + 349)
-#define __NR_sched_getattr		(__NR_Linux + 350)
-#define __NR_renameat2			(__NR_Linux + 351)
-#define __NR_seccomp			(__NR_Linux + 352)
-#define __NR_getrandom			(__NR_Linux + 353)
-#define __NR_memfd_create		(__NR_Linux + 354)
-#define __NR_bpf			(__NR_Linux + 355)
-#define __NR_execveat			(__NR_Linux + 356)
-#define __NR_userfaultfd		(__NR_Linux + 357)
-#define __NR_membarrier			(__NR_Linux + 358)
-#define __NR_mlock2			(__NR_Linux + 359)
-#define __NR_copy_file_range		(__NR_Linux + 360)
-#define __NR_preadv2			(__NR_Linux + 361)
-#define __NR_pwritev2			(__NR_Linux + 362)
-#define __NR_pkey_mprotect		(__NR_Linux + 363)
-#define __NR_pkey_alloc			(__NR_Linux + 364)
-#define __NR_pkey_free			(__NR_Linux + 365)
-#define __NR_statx			(__NR_Linux + 366)
-#define __NR_rseq			(__NR_Linux + 367)
-#define __NR_io_pgetevents		(__NR_Linux + 368)
-
-
-/*
- * Offset of the last Linux o32 flavoured syscall
- */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux	4000
+#include <asm/unistd_o32.h>
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
-
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
-/*
- * Linux 64-bit syscalls are in the range from 5000 to 5999.
- */
-#define __NR_Linux			5000
-#define __NR_read			(__NR_Linux +	0)
-#define __NR_write			(__NR_Linux +	1)
-#define __NR_open			(__NR_Linux +	2)
-#define __NR_close			(__NR_Linux +	3)
-#define __NR_stat			(__NR_Linux +	4)
-#define __NR_fstat			(__NR_Linux +	5)
-#define __NR_lstat			(__NR_Linux +	6)
-#define __NR_poll			(__NR_Linux +	7)
-#define __NR_lseek			(__NR_Linux +	8)
-#define __NR_mmap			(__NR_Linux +	9)
-#define __NR_mprotect			(__NR_Linux +  10)
-#define __NR_munmap			(__NR_Linux +  11)
-#define __NR_brk			(__NR_Linux +  12)
-#define __NR_rt_sigaction		(__NR_Linux +  13)
-#define __NR_rt_sigprocmask		(__NR_Linux +  14)
-#define __NR_ioctl			(__NR_Linux +  15)
-#define __NR_pread64			(__NR_Linux +  16)
-#define __NR_pwrite64			(__NR_Linux +  17)
-#define __NR_readv			(__NR_Linux +  18)
-#define __NR_writev			(__NR_Linux +  19)
-#define __NR_access			(__NR_Linux +  20)
-#define __NR_pipe			(__NR_Linux +  21)
-#define __NR__newselect			(__NR_Linux +  22)
-#define __NR_sched_yield		(__NR_Linux +  23)
-#define __NR_mremap			(__NR_Linux +  24)
-#define __NR_msync			(__NR_Linux +  25)
-#define __NR_mincore			(__NR_Linux +  26)
-#define __NR_madvise			(__NR_Linux +  27)
-#define __NR_shmget			(__NR_Linux +  28)
-#define __NR_shmat			(__NR_Linux +  29)
-#define __NR_shmctl			(__NR_Linux +  30)
-#define __NR_dup			(__NR_Linux +  31)
-#define __NR_dup2			(__NR_Linux +  32)
-#define __NR_pause			(__NR_Linux +  33)
-#define __NR_nanosleep			(__NR_Linux +  34)
-#define __NR_getitimer			(__NR_Linux +  35)
-#define __NR_setitimer			(__NR_Linux +  36)
-#define __NR_alarm			(__NR_Linux +  37)
-#define __NR_getpid			(__NR_Linux +  38)
-#define __NR_sendfile			(__NR_Linux +  39)
-#define __NR_socket			(__NR_Linux +  40)
-#define __NR_connect			(__NR_Linux +  41)
-#define __NR_accept			(__NR_Linux +  42)
-#define __NR_sendto			(__NR_Linux +  43)
-#define __NR_recvfrom			(__NR_Linux +  44)
-#define __NR_sendmsg			(__NR_Linux +  45)
-#define __NR_recvmsg			(__NR_Linux +  46)
-#define __NR_shutdown			(__NR_Linux +  47)
-#define __NR_bind			(__NR_Linux +  48)
-#define __NR_listen			(__NR_Linux +  49)
-#define __NR_getsockname		(__NR_Linux +  50)
-#define __NR_getpeername		(__NR_Linux +  51)
-#define __NR_socketpair			(__NR_Linux +  52)
-#define __NR_setsockopt			(__NR_Linux +  53)
-#define __NR_getsockopt			(__NR_Linux +  54)
-#define __NR_clone			(__NR_Linux +  55)
-#define __NR_fork			(__NR_Linux +  56)
-#define __NR_execve			(__NR_Linux +  57)
-#define __NR_exit			(__NR_Linux +  58)
-#define __NR_wait4			(__NR_Linux +  59)
-#define __NR_kill			(__NR_Linux +  60)
-#define __NR_uname			(__NR_Linux +  61)
-#define __NR_semget			(__NR_Linux +  62)
-#define __NR_semop			(__NR_Linux +  63)
-#define __NR_semctl			(__NR_Linux +  64)
-#define __NR_shmdt			(__NR_Linux +  65)
-#define __NR_msgget			(__NR_Linux +  66)
-#define __NR_msgsnd			(__NR_Linux +  67)
-#define __NR_msgrcv			(__NR_Linux +  68)
-#define __NR_msgctl			(__NR_Linux +  69)
-#define __NR_fcntl			(__NR_Linux +  70)
-#define __NR_flock			(__NR_Linux +  71)
-#define __NR_fsync			(__NR_Linux +  72)
-#define __NR_fdatasync			(__NR_Linux +  73)
-#define __NR_truncate			(__NR_Linux +  74)
-#define __NR_ftruncate			(__NR_Linux +  75)
-#define __NR_getdents			(__NR_Linux +  76)
-#define __NR_getcwd			(__NR_Linux +  77)
-#define __NR_chdir			(__NR_Linux +  78)
-#define __NR_fchdir			(__NR_Linux +  79)
-#define __NR_rename			(__NR_Linux +  80)
-#define __NR_mkdir			(__NR_Linux +  81)
-#define __NR_rmdir			(__NR_Linux +  82)
-#define __NR_creat			(__NR_Linux +  83)
-#define __NR_link			(__NR_Linux +  84)
-#define __NR_unlink			(__NR_Linux +  85)
-#define __NR_symlink			(__NR_Linux +  86)
-#define __NR_readlink			(__NR_Linux +  87)
-#define __NR_chmod			(__NR_Linux +  88)
-#define __NR_fchmod			(__NR_Linux +  89)
-#define __NR_chown			(__NR_Linux +  90)
-#define __NR_fchown			(__NR_Linux +  91)
-#define __NR_lchown			(__NR_Linux +  92)
-#define __NR_umask			(__NR_Linux +  93)
-#define __NR_gettimeofday		(__NR_Linux +  94)
-#define __NR_getrlimit			(__NR_Linux +  95)
-#define __NR_getrusage			(__NR_Linux +  96)
-#define __NR_sysinfo			(__NR_Linux +  97)
-#define __NR_times			(__NR_Linux +  98)
-#define __NR_ptrace			(__NR_Linux +  99)
-#define __NR_getuid			(__NR_Linux + 100)
-#define __NR_syslog			(__NR_Linux + 101)
-#define __NR_getgid			(__NR_Linux + 102)
-#define __NR_setuid			(__NR_Linux + 103)
-#define __NR_setgid			(__NR_Linux + 104)
-#define __NR_geteuid			(__NR_Linux + 105)
-#define __NR_getegid			(__NR_Linux + 106)
-#define __NR_setpgid			(__NR_Linux + 107)
-#define __NR_getppid			(__NR_Linux + 108)
-#define __NR_getpgrp			(__NR_Linux + 109)
-#define __NR_setsid			(__NR_Linux + 110)
-#define __NR_setreuid			(__NR_Linux + 111)
-#define __NR_setregid			(__NR_Linux + 112)
-#define __NR_getgroups			(__NR_Linux + 113)
-#define __NR_setgroups			(__NR_Linux + 114)
-#define __NR_setresuid			(__NR_Linux + 115)
-#define __NR_getresuid			(__NR_Linux + 116)
-#define __NR_setresgid			(__NR_Linux + 117)
-#define __NR_getresgid			(__NR_Linux + 118)
-#define __NR_getpgid			(__NR_Linux + 119)
-#define __NR_setfsuid			(__NR_Linux + 120)
-#define __NR_setfsgid			(__NR_Linux + 121)
-#define __NR_getsid			(__NR_Linux + 122)
-#define __NR_capget			(__NR_Linux + 123)
-#define __NR_capset			(__NR_Linux + 124)
-#define __NR_rt_sigpending		(__NR_Linux + 125)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 126)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 127)
-#define __NR_rt_sigsuspend		(__NR_Linux + 128)
-#define __NR_sigaltstack		(__NR_Linux + 129)
-#define __NR_utime			(__NR_Linux + 130)
-#define __NR_mknod			(__NR_Linux + 131)
-#define __NR_personality		(__NR_Linux + 132)
-#define __NR_ustat			(__NR_Linux + 133)
-#define __NR_statfs			(__NR_Linux + 134)
-#define __NR_fstatfs			(__NR_Linux + 135)
-#define __NR_sysfs			(__NR_Linux + 136)
-#define __NR_getpriority		(__NR_Linux + 137)
-#define __NR_setpriority		(__NR_Linux + 138)
-#define __NR_sched_setparam		(__NR_Linux + 139)
-#define __NR_sched_getparam		(__NR_Linux + 140)
-#define __NR_sched_setscheduler		(__NR_Linux + 141)
-#define __NR_sched_getscheduler		(__NR_Linux + 142)
-#define __NR_sched_get_priority_max	(__NR_Linux + 143)
-#define __NR_sched_get_priority_min	(__NR_Linux + 144)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 145)
-#define __NR_mlock			(__NR_Linux + 146)
-#define __NR_munlock			(__NR_Linux + 147)
-#define __NR_mlockall			(__NR_Linux + 148)
-#define __NR_munlockall			(__NR_Linux + 149)
-#define __NR_vhangup			(__NR_Linux + 150)
-#define __NR_pivot_root			(__NR_Linux + 151)
-#define __NR__sysctl			(__NR_Linux + 152)
-#define __NR_prctl			(__NR_Linux + 153)
-#define __NR_adjtimex			(__NR_Linux + 154)
-#define __NR_setrlimit			(__NR_Linux + 155)
-#define __NR_chroot			(__NR_Linux + 156)
-#define __NR_sync			(__NR_Linux + 157)
-#define __NR_acct			(__NR_Linux + 158)
-#define __NR_settimeofday		(__NR_Linux + 159)
-#define __NR_mount			(__NR_Linux + 160)
-#define __NR_umount2			(__NR_Linux + 161)
-#define __NR_swapon			(__NR_Linux + 162)
-#define __NR_swapoff			(__NR_Linux + 163)
-#define __NR_reboot			(__NR_Linux + 164)
-#define __NR_sethostname		(__NR_Linux + 165)
-#define __NR_setdomainname		(__NR_Linux + 166)
-#define __NR_create_module		(__NR_Linux + 167)
-#define __NR_init_module		(__NR_Linux + 168)
-#define __NR_delete_module		(__NR_Linux + 169)
-#define __NR_get_kernel_syms		(__NR_Linux + 170)
-#define __NR_query_module		(__NR_Linux + 171)
-#define __NR_quotactl			(__NR_Linux + 172)
-#define __NR_nfsservctl			(__NR_Linux + 173)
-#define __NR_getpmsg			(__NR_Linux + 174)
-#define __NR_putpmsg			(__NR_Linux + 175)
-#define __NR_afs_syscall		(__NR_Linux + 176)
-#define __NR_reserved177		(__NR_Linux + 177)
-#define __NR_gettid			(__NR_Linux + 178)
-#define __NR_readahead			(__NR_Linux + 179)
-#define __NR_setxattr			(__NR_Linux + 180)
-#define __NR_lsetxattr			(__NR_Linux + 181)
-#define __NR_fsetxattr			(__NR_Linux + 182)
-#define __NR_getxattr			(__NR_Linux + 183)
-#define __NR_lgetxattr			(__NR_Linux + 184)
-#define __NR_fgetxattr			(__NR_Linux + 185)
-#define __NR_listxattr			(__NR_Linux + 186)
-#define __NR_llistxattr			(__NR_Linux + 187)
-#define __NR_flistxattr			(__NR_Linux + 188)
-#define __NR_removexattr		(__NR_Linux + 189)
-#define __NR_lremovexattr		(__NR_Linux + 190)
-#define __NR_fremovexattr		(__NR_Linux + 191)
-#define __NR_tkill			(__NR_Linux + 192)
-#define __NR_reserved193		(__NR_Linux + 193)
-#define __NR_futex			(__NR_Linux + 194)
-#define __NR_sched_setaffinity		(__NR_Linux + 195)
-#define __NR_sched_getaffinity		(__NR_Linux + 196)
-#define __NR_cacheflush			(__NR_Linux + 197)
-#define __NR_cachectl			(__NR_Linux + 198)
-#define __NR_sysmips			(__NR_Linux + 199)
-#define __NR_io_setup			(__NR_Linux + 200)
-#define __NR_io_destroy			(__NR_Linux + 201)
-#define __NR_io_getevents		(__NR_Linux + 202)
-#define __NR_io_submit			(__NR_Linux + 203)
-#define __NR_io_cancel			(__NR_Linux + 204)
-#define __NR_exit_group			(__NR_Linux + 205)
-#define __NR_lookup_dcookie		(__NR_Linux + 206)
-#define __NR_epoll_create		(__NR_Linux + 207)
-#define __NR_epoll_ctl			(__NR_Linux + 208)
-#define __NR_epoll_wait			(__NR_Linux + 209)
-#define __NR_remap_file_pages		(__NR_Linux + 210)
-#define __NR_rt_sigreturn		(__NR_Linux + 211)
-#define __NR_set_tid_address		(__NR_Linux + 212)
-#define __NR_restart_syscall		(__NR_Linux + 213)
-#define __NR_semtimedop			(__NR_Linux + 214)
-#define __NR_fadvise64			(__NR_Linux + 215)
-#define __NR_timer_create		(__NR_Linux + 216)
-#define __NR_timer_settime		(__NR_Linux + 217)
-#define __NR_timer_gettime		(__NR_Linux + 218)
-#define __NR_timer_getoverrun		(__NR_Linux + 219)
-#define __NR_timer_delete		(__NR_Linux + 220)
-#define __NR_clock_settime		(__NR_Linux + 221)
-#define __NR_clock_gettime		(__NR_Linux + 222)
-#define __NR_clock_getres		(__NR_Linux + 223)
-#define __NR_clock_nanosleep		(__NR_Linux + 224)
-#define __NR_tgkill			(__NR_Linux + 225)
-#define __NR_utimes			(__NR_Linux + 226)
-#define __NR_mbind			(__NR_Linux + 227)
-#define __NR_get_mempolicy		(__NR_Linux + 228)
-#define __NR_set_mempolicy		(__NR_Linux + 229)
-#define __NR_mq_open			(__NR_Linux + 230)
-#define __NR_mq_unlink			(__NR_Linux + 231)
-#define __NR_mq_timedsend		(__NR_Linux + 232)
-#define __NR_mq_timedreceive		(__NR_Linux + 233)
-#define __NR_mq_notify			(__NR_Linux + 234)
-#define __NR_mq_getsetattr		(__NR_Linux + 235)
-#define __NR_vserver			(__NR_Linux + 236)
-#define __NR_waitid			(__NR_Linux + 237)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 238) */
-#define __NR_add_key			(__NR_Linux + 239)
-#define __NR_request_key		(__NR_Linux + 240)
-#define __NR_keyctl			(__NR_Linux + 241)
-#define __NR_set_thread_area		(__NR_Linux + 242)
-#define __NR_inotify_init		(__NR_Linux + 243)
-#define __NR_inotify_add_watch		(__NR_Linux + 244)
-#define __NR_inotify_rm_watch		(__NR_Linux + 245)
-#define __NR_migrate_pages		(__NR_Linux + 246)
-#define __NR_openat			(__NR_Linux + 247)
-#define __NR_mkdirat			(__NR_Linux + 248)
-#define __NR_mknodat			(__NR_Linux + 249)
-#define __NR_fchownat			(__NR_Linux + 250)
-#define __NR_futimesat			(__NR_Linux + 251)
-#define __NR_newfstatat			(__NR_Linux + 252)
-#define __NR_unlinkat			(__NR_Linux + 253)
-#define __NR_renameat			(__NR_Linux + 254)
-#define __NR_linkat			(__NR_Linux + 255)
-#define __NR_symlinkat			(__NR_Linux + 256)
-#define __NR_readlinkat			(__NR_Linux + 257)
-#define __NR_fchmodat			(__NR_Linux + 258)
-#define __NR_faccessat			(__NR_Linux + 259)
-#define __NR_pselect6			(__NR_Linux + 260)
-#define __NR_ppoll			(__NR_Linux + 261)
-#define __NR_unshare			(__NR_Linux + 262)
-#define __NR_splice			(__NR_Linux + 263)
-#define __NR_sync_file_range		(__NR_Linux + 264)
-#define __NR_tee			(__NR_Linux + 265)
-#define __NR_vmsplice			(__NR_Linux + 266)
-#define __NR_move_pages			(__NR_Linux + 267)
-#define __NR_set_robust_list		(__NR_Linux + 268)
-#define __NR_get_robust_list		(__NR_Linux + 269)
-#define __NR_kexec_load			(__NR_Linux + 270)
-#define __NR_getcpu			(__NR_Linux + 271)
-#define __NR_epoll_pwait		(__NR_Linux + 272)
-#define __NR_ioprio_set			(__NR_Linux + 273)
-#define __NR_ioprio_get			(__NR_Linux + 274)
-#define __NR_utimensat			(__NR_Linux + 275)
-#define __NR_signalfd			(__NR_Linux + 276)
-#define __NR_timerfd			(__NR_Linux + 277)
-#define __NR_eventfd			(__NR_Linux + 278)
-#define __NR_fallocate			(__NR_Linux + 279)
-#define __NR_timerfd_create		(__NR_Linux + 280)
-#define __NR_timerfd_gettime		(__NR_Linux + 281)
-#define __NR_timerfd_settime		(__NR_Linux + 282)
-#define __NR_signalfd4			(__NR_Linux + 283)
-#define __NR_eventfd2			(__NR_Linux + 284)
-#define __NR_epoll_create1		(__NR_Linux + 285)
-#define __NR_dup3			(__NR_Linux + 286)
-#define __NR_pipe2			(__NR_Linux + 287)
-#define __NR_inotify_init1		(__NR_Linux + 288)
-#define __NR_preadv			(__NR_Linux + 289)
-#define __NR_pwritev			(__NR_Linux + 290)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 291)
-#define __NR_perf_event_open		(__NR_Linux + 292)
-#define __NR_accept4			(__NR_Linux + 293)
-#define __NR_recvmmsg			(__NR_Linux + 294)
-#define __NR_fanotify_init		(__NR_Linux + 295)
-#define __NR_fanotify_mark		(__NR_Linux + 296)
-#define __NR_prlimit64			(__NR_Linux + 297)
-#define __NR_name_to_handle_at		(__NR_Linux + 298)
-#define __NR_open_by_handle_at		(__NR_Linux + 299)
-#define __NR_clock_adjtime		(__NR_Linux + 300)
-#define __NR_syncfs			(__NR_Linux + 301)
-#define __NR_sendmmsg			(__NR_Linux + 302)
-#define __NR_setns			(__NR_Linux + 303)
-#define __NR_process_vm_readv		(__NR_Linux + 304)
-#define __NR_process_vm_writev		(__NR_Linux + 305)
-#define __NR_kcmp			(__NR_Linux + 306)
-#define __NR_finit_module		(__NR_Linux + 307)
-#define __NR_getdents64			(__NR_Linux + 308)
-#define __NR_sched_setattr		(__NR_Linux + 309)
-#define __NR_sched_getattr		(__NR_Linux + 310)
-#define __NR_renameat2			(__NR_Linux + 311)
-#define __NR_seccomp			(__NR_Linux + 312)
-#define __NR_getrandom			(__NR_Linux + 313)
-#define __NR_memfd_create		(__NR_Linux + 314)
-#define __NR_bpf			(__NR_Linux + 315)
-#define __NR_execveat			(__NR_Linux + 316)
-#define __NR_userfaultfd		(__NR_Linux + 317)
-#define __NR_membarrier			(__NR_Linux + 318)
-#define __NR_mlock2			(__NR_Linux + 319)
-#define __NR_copy_file_range		(__NR_Linux + 320)
-#define __NR_preadv2			(__NR_Linux + 321)
-#define __NR_pwritev2			(__NR_Linux + 322)
-#define __NR_pkey_mprotect		(__NR_Linux + 323)
-#define __NR_pkey_alloc			(__NR_Linux + 324)
-#define __NR_pkey_free			(__NR_Linux + 325)
-#define __NR_statx			(__NR_Linux + 326)
-#define __NR_rseq			(__NR_Linux + 327)
-#define __NR_io_pgetevents		(__NR_Linux + 328)
-
-/*
- * Offset of the last Linux 64-bit flavoured syscall
- */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux	5000
+#include <asm/unistd_n64.h>
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
-#define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
-
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
-/*
- * Linux N32 syscalls are in the range from 6000 to 6999.
- */
-#define __NR_Linux			6000
-#define __NR_read			(__NR_Linux +	0)
-#define __NR_write			(__NR_Linux +	1)
-#define __NR_open			(__NR_Linux +	2)
-#define __NR_close			(__NR_Linux +	3)
-#define __NR_stat			(__NR_Linux +	4)
-#define __NR_fstat			(__NR_Linux +	5)
-#define __NR_lstat			(__NR_Linux +	6)
-#define __NR_poll			(__NR_Linux +	7)
-#define __NR_lseek			(__NR_Linux +	8)
-#define __NR_mmap			(__NR_Linux +	9)
-#define __NR_mprotect			(__NR_Linux +  10)
-#define __NR_munmap			(__NR_Linux +  11)
-#define __NR_brk			(__NR_Linux +  12)
-#define __NR_rt_sigaction		(__NR_Linux +  13)
-#define __NR_rt_sigprocmask		(__NR_Linux +  14)
-#define __NR_ioctl			(__NR_Linux +  15)
-#define __NR_pread64			(__NR_Linux +  16)
-#define __NR_pwrite64			(__NR_Linux +  17)
-#define __NR_readv			(__NR_Linux +  18)
-#define __NR_writev			(__NR_Linux +  19)
-#define __NR_access			(__NR_Linux +  20)
-#define __NR_pipe			(__NR_Linux +  21)
-#define __NR__newselect			(__NR_Linux +  22)
-#define __NR_sched_yield		(__NR_Linux +  23)
-#define __NR_mremap			(__NR_Linux +  24)
-#define __NR_msync			(__NR_Linux +  25)
-#define __NR_mincore			(__NR_Linux +  26)
-#define __NR_madvise			(__NR_Linux +  27)
-#define __NR_shmget			(__NR_Linux +  28)
-#define __NR_shmat			(__NR_Linux +  29)
-#define __NR_shmctl			(__NR_Linux +  30)
-#define __NR_dup			(__NR_Linux +  31)
-#define __NR_dup2			(__NR_Linux +  32)
-#define __NR_pause			(__NR_Linux +  33)
-#define __NR_nanosleep			(__NR_Linux +  34)
-#define __NR_getitimer			(__NR_Linux +  35)
-#define __NR_setitimer			(__NR_Linux +  36)
-#define __NR_alarm			(__NR_Linux +  37)
-#define __NR_getpid			(__NR_Linux +  38)
-#define __NR_sendfile			(__NR_Linux +  39)
-#define __NR_socket			(__NR_Linux +  40)
-#define __NR_connect			(__NR_Linux +  41)
-#define __NR_accept			(__NR_Linux +  42)
-#define __NR_sendto			(__NR_Linux +  43)
-#define __NR_recvfrom			(__NR_Linux +  44)
-#define __NR_sendmsg			(__NR_Linux +  45)
-#define __NR_recvmsg			(__NR_Linux +  46)
-#define __NR_shutdown			(__NR_Linux +  47)
-#define __NR_bind			(__NR_Linux +  48)
-#define __NR_listen			(__NR_Linux +  49)
-#define __NR_getsockname		(__NR_Linux +  50)
-#define __NR_getpeername		(__NR_Linux +  51)
-#define __NR_socketpair			(__NR_Linux +  52)
-#define __NR_setsockopt			(__NR_Linux +  53)
-#define __NR_getsockopt			(__NR_Linux +  54)
-#define __NR_clone			(__NR_Linux +  55)
-#define __NR_fork			(__NR_Linux +  56)
-#define __NR_execve			(__NR_Linux +  57)
-#define __NR_exit			(__NR_Linux +  58)
-#define __NR_wait4			(__NR_Linux +  59)
-#define __NR_kill			(__NR_Linux +  60)
-#define __NR_uname			(__NR_Linux +  61)
-#define __NR_semget			(__NR_Linux +  62)
-#define __NR_semop			(__NR_Linux +  63)
-#define __NR_semctl			(__NR_Linux +  64)
-#define __NR_shmdt			(__NR_Linux +  65)
-#define __NR_msgget			(__NR_Linux +  66)
-#define __NR_msgsnd			(__NR_Linux +  67)
-#define __NR_msgrcv			(__NR_Linux +  68)
-#define __NR_msgctl			(__NR_Linux +  69)
-#define __NR_fcntl			(__NR_Linux +  70)
-#define __NR_flock			(__NR_Linux +  71)
-#define __NR_fsync			(__NR_Linux +  72)
-#define __NR_fdatasync			(__NR_Linux +  73)
-#define __NR_truncate			(__NR_Linux +  74)
-#define __NR_ftruncate			(__NR_Linux +  75)
-#define __NR_getdents			(__NR_Linux +  76)
-#define __NR_getcwd			(__NR_Linux +  77)
-#define __NR_chdir			(__NR_Linux +  78)
-#define __NR_fchdir			(__NR_Linux +  79)
-#define __NR_rename			(__NR_Linux +  80)
-#define __NR_mkdir			(__NR_Linux +  81)
-#define __NR_rmdir			(__NR_Linux +  82)
-#define __NR_creat			(__NR_Linux +  83)
-#define __NR_link			(__NR_Linux +  84)
-#define __NR_unlink			(__NR_Linux +  85)
-#define __NR_symlink			(__NR_Linux +  86)
-#define __NR_readlink			(__NR_Linux +  87)
-#define __NR_chmod			(__NR_Linux +  88)
-#define __NR_fchmod			(__NR_Linux +  89)
-#define __NR_chown			(__NR_Linux +  90)
-#define __NR_fchown			(__NR_Linux +  91)
-#define __NR_lchown			(__NR_Linux +  92)
-#define __NR_umask			(__NR_Linux +  93)
-#define __NR_gettimeofday		(__NR_Linux +  94)
-#define __NR_getrlimit			(__NR_Linux +  95)
-#define __NR_getrusage			(__NR_Linux +  96)
-#define __NR_sysinfo			(__NR_Linux +  97)
-#define __NR_times			(__NR_Linux +  98)
-#define __NR_ptrace			(__NR_Linux +  99)
-#define __NR_getuid			(__NR_Linux + 100)
-#define __NR_syslog			(__NR_Linux + 101)
-#define __NR_getgid			(__NR_Linux + 102)
-#define __NR_setuid			(__NR_Linux + 103)
-#define __NR_setgid			(__NR_Linux + 104)
-#define __NR_geteuid			(__NR_Linux + 105)
-#define __NR_getegid			(__NR_Linux + 106)
-#define __NR_setpgid			(__NR_Linux + 107)
-#define __NR_getppid			(__NR_Linux + 108)
-#define __NR_getpgrp			(__NR_Linux + 109)
-#define __NR_setsid			(__NR_Linux + 110)
-#define __NR_setreuid			(__NR_Linux + 111)
-#define __NR_setregid			(__NR_Linux + 112)
-#define __NR_getgroups			(__NR_Linux + 113)
-#define __NR_setgroups			(__NR_Linux + 114)
-#define __NR_setresuid			(__NR_Linux + 115)
-#define __NR_getresuid			(__NR_Linux + 116)
-#define __NR_setresgid			(__NR_Linux + 117)
-#define __NR_getresgid			(__NR_Linux + 118)
-#define __NR_getpgid			(__NR_Linux + 119)
-#define __NR_setfsuid			(__NR_Linux + 120)
-#define __NR_setfsgid			(__NR_Linux + 121)
-#define __NR_getsid			(__NR_Linux + 122)
-#define __NR_capget			(__NR_Linux + 123)
-#define __NR_capset			(__NR_Linux + 124)
-#define __NR_rt_sigpending		(__NR_Linux + 125)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 126)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 127)
-#define __NR_rt_sigsuspend		(__NR_Linux + 128)
-#define __NR_sigaltstack		(__NR_Linux + 129)
-#define __NR_utime			(__NR_Linux + 130)
-#define __NR_mknod			(__NR_Linux + 131)
-#define __NR_personality		(__NR_Linux + 132)
-#define __NR_ustat			(__NR_Linux + 133)
-#define __NR_statfs			(__NR_Linux + 134)
-#define __NR_fstatfs			(__NR_Linux + 135)
-#define __NR_sysfs			(__NR_Linux + 136)
-#define __NR_getpriority		(__NR_Linux + 137)
-#define __NR_setpriority		(__NR_Linux + 138)
-#define __NR_sched_setparam		(__NR_Linux + 139)
-#define __NR_sched_getparam		(__NR_Linux + 140)
-#define __NR_sched_setscheduler		(__NR_Linux + 141)
-#define __NR_sched_getscheduler		(__NR_Linux + 142)
-#define __NR_sched_get_priority_max	(__NR_Linux + 143)
-#define __NR_sched_get_priority_min	(__NR_Linux + 144)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 145)
-#define __NR_mlock			(__NR_Linux + 146)
-#define __NR_munlock			(__NR_Linux + 147)
-#define __NR_mlockall			(__NR_Linux + 148)
-#define __NR_munlockall			(__NR_Linux + 149)
-#define __NR_vhangup			(__NR_Linux + 150)
-#define __NR_pivot_root			(__NR_Linux + 151)
-#define __NR__sysctl			(__NR_Linux + 152)
-#define __NR_prctl			(__NR_Linux + 153)
-#define __NR_adjtimex			(__NR_Linux + 154)
-#define __NR_setrlimit			(__NR_Linux + 155)
-#define __NR_chroot			(__NR_Linux + 156)
-#define __NR_sync			(__NR_Linux + 157)
-#define __NR_acct			(__NR_Linux + 158)
-#define __NR_settimeofday		(__NR_Linux + 159)
-#define __NR_mount			(__NR_Linux + 160)
-#define __NR_umount2			(__NR_Linux + 161)
-#define __NR_swapon			(__NR_Linux + 162)
-#define __NR_swapoff			(__NR_Linux + 163)
-#define __NR_reboot			(__NR_Linux + 164)
-#define __NR_sethostname		(__NR_Linux + 165)
-#define __NR_setdomainname		(__NR_Linux + 166)
-#define __NR_create_module		(__NR_Linux + 167)
-#define __NR_init_module		(__NR_Linux + 168)
-#define __NR_delete_module		(__NR_Linux + 169)
-#define __NR_get_kernel_syms		(__NR_Linux + 170)
-#define __NR_query_module		(__NR_Linux + 171)
-#define __NR_quotactl			(__NR_Linux + 172)
-#define __NR_nfsservctl			(__NR_Linux + 173)
-#define __NR_getpmsg			(__NR_Linux + 174)
-#define __NR_putpmsg			(__NR_Linux + 175)
-#define __NR_afs_syscall		(__NR_Linux + 176)
-#define __NR_reserved177		(__NR_Linux + 177)
-#define __NR_gettid			(__NR_Linux + 178)
-#define __NR_readahead			(__NR_Linux + 179)
-#define __NR_setxattr			(__NR_Linux + 180)
-#define __NR_lsetxattr			(__NR_Linux + 181)
-#define __NR_fsetxattr			(__NR_Linux + 182)
-#define __NR_getxattr			(__NR_Linux + 183)
-#define __NR_lgetxattr			(__NR_Linux + 184)
-#define __NR_fgetxattr			(__NR_Linux + 185)
-#define __NR_listxattr			(__NR_Linux + 186)
-#define __NR_llistxattr			(__NR_Linux + 187)
-#define __NR_flistxattr			(__NR_Linux + 188)
-#define __NR_removexattr		(__NR_Linux + 189)
-#define __NR_lremovexattr		(__NR_Linux + 190)
-#define __NR_fremovexattr		(__NR_Linux + 191)
-#define __NR_tkill			(__NR_Linux + 192)
-#define __NR_reserved193		(__NR_Linux + 193)
-#define __NR_futex			(__NR_Linux + 194)
-#define __NR_sched_setaffinity		(__NR_Linux + 195)
-#define __NR_sched_getaffinity		(__NR_Linux + 196)
-#define __NR_cacheflush			(__NR_Linux + 197)
-#define __NR_cachectl			(__NR_Linux + 198)
-#define __NR_sysmips			(__NR_Linux + 199)
-#define __NR_io_setup			(__NR_Linux + 200)
-#define __NR_io_destroy			(__NR_Linux + 201)
-#define __NR_io_getevents		(__NR_Linux + 202)
-#define __NR_io_submit			(__NR_Linux + 203)
-#define __NR_io_cancel			(__NR_Linux + 204)
-#define __NR_exit_group			(__NR_Linux + 205)
-#define __NR_lookup_dcookie		(__NR_Linux + 206)
-#define __NR_epoll_create		(__NR_Linux + 207)
-#define __NR_epoll_ctl			(__NR_Linux + 208)
-#define __NR_epoll_wait			(__NR_Linux + 209)
-#define __NR_remap_file_pages		(__NR_Linux + 210)
-#define __NR_rt_sigreturn		(__NR_Linux + 211)
-#define __NR_fcntl64			(__NR_Linux + 212)
-#define __NR_set_tid_address		(__NR_Linux + 213)
-#define __NR_restart_syscall		(__NR_Linux + 214)
-#define __NR_semtimedop			(__NR_Linux + 215)
-#define __NR_fadvise64			(__NR_Linux + 216)
-#define __NR_statfs64			(__NR_Linux + 217)
-#define __NR_fstatfs64			(__NR_Linux + 218)
-#define __NR_sendfile64			(__NR_Linux + 219)
-#define __NR_timer_create		(__NR_Linux + 220)
-#define __NR_timer_settime		(__NR_Linux + 221)
-#define __NR_timer_gettime		(__NR_Linux + 222)
-#define __NR_timer_getoverrun		(__NR_Linux + 223)
-#define __NR_timer_delete		(__NR_Linux + 224)
-#define __NR_clock_settime		(__NR_Linux + 225)
-#define __NR_clock_gettime		(__NR_Linux + 226)
-#define __NR_clock_getres		(__NR_Linux + 227)
-#define __NR_clock_nanosleep		(__NR_Linux + 228)
-#define __NR_tgkill			(__NR_Linux + 229)
-#define __NR_utimes			(__NR_Linux + 230)
-#define __NR_mbind			(__NR_Linux + 231)
-#define __NR_get_mempolicy		(__NR_Linux + 232)
-#define __NR_set_mempolicy		(__NR_Linux + 233)
-#define __NR_mq_open			(__NR_Linux + 234)
-#define __NR_mq_unlink			(__NR_Linux + 235)
-#define __NR_mq_timedsend		(__NR_Linux + 236)
-#define __NR_mq_timedreceive		(__NR_Linux + 237)
-#define __NR_mq_notify			(__NR_Linux + 238)
-#define __NR_mq_getsetattr		(__NR_Linux + 239)
-#define __NR_vserver			(__NR_Linux + 240)
-#define __NR_waitid			(__NR_Linux + 241)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 242) */
-#define __NR_add_key			(__NR_Linux + 243)
-#define __NR_request_key		(__NR_Linux + 244)
-#define __NR_keyctl			(__NR_Linux + 245)
-#define __NR_set_thread_area		(__NR_Linux + 246)
-#define __NR_inotify_init		(__NR_Linux + 247)
-#define __NR_inotify_add_watch		(__NR_Linux + 248)
-#define __NR_inotify_rm_watch		(__NR_Linux + 249)
-#define __NR_migrate_pages		(__NR_Linux + 250)
-#define __NR_openat			(__NR_Linux + 251)
-#define __NR_mkdirat			(__NR_Linux + 252)
-#define __NR_mknodat			(__NR_Linux + 253)
-#define __NR_fchownat			(__NR_Linux + 254)
-#define __NR_futimesat			(__NR_Linux + 255)
-#define __NR_newfstatat			(__NR_Linux + 256)
-#define __NR_unlinkat			(__NR_Linux + 257)
-#define __NR_renameat			(__NR_Linux + 258)
-#define __NR_linkat			(__NR_Linux + 259)
-#define __NR_symlinkat			(__NR_Linux + 260)
-#define __NR_readlinkat			(__NR_Linux + 261)
-#define __NR_fchmodat			(__NR_Linux + 262)
-#define __NR_faccessat			(__NR_Linux + 263)
-#define __NR_pselect6			(__NR_Linux + 264)
-#define __NR_ppoll			(__NR_Linux + 265)
-#define __NR_unshare			(__NR_Linux + 266)
-#define __NR_splice			(__NR_Linux + 267)
-#define __NR_sync_file_range		(__NR_Linux + 268)
-#define __NR_tee			(__NR_Linux + 269)
-#define __NR_vmsplice			(__NR_Linux + 270)
-#define __NR_move_pages			(__NR_Linux + 271)
-#define __NR_set_robust_list		(__NR_Linux + 272)
-#define __NR_get_robust_list		(__NR_Linux + 273)
-#define __NR_kexec_load			(__NR_Linux + 274)
-#define __NR_getcpu			(__NR_Linux + 275)
-#define __NR_epoll_pwait		(__NR_Linux + 276)
-#define __NR_ioprio_set			(__NR_Linux + 277)
-#define __NR_ioprio_get			(__NR_Linux + 278)
-#define __NR_utimensat			(__NR_Linux + 279)
-#define __NR_signalfd			(__NR_Linux + 280)
-#define __NR_timerfd			(__NR_Linux + 281)
-#define __NR_eventfd			(__NR_Linux + 282)
-#define __NR_fallocate			(__NR_Linux + 283)
-#define __NR_timerfd_create		(__NR_Linux + 284)
-#define __NR_timerfd_gettime		(__NR_Linux + 285)
-#define __NR_timerfd_settime		(__NR_Linux + 286)
-#define __NR_signalfd4			(__NR_Linux + 287)
-#define __NR_eventfd2			(__NR_Linux + 288)
-#define __NR_epoll_create1		(__NR_Linux + 289)
-#define __NR_dup3			(__NR_Linux + 290)
-#define __NR_pipe2			(__NR_Linux + 291)
-#define __NR_inotify_init1		(__NR_Linux + 292)
-#define __NR_preadv			(__NR_Linux + 293)
-#define __NR_pwritev			(__NR_Linux + 294)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 295)
-#define __NR_perf_event_open		(__NR_Linux + 296)
-#define __NR_accept4			(__NR_Linux + 297)
-#define __NR_recvmmsg			(__NR_Linux + 298)
-#define __NR_getdents64			(__NR_Linux + 299)
-#define __NR_fanotify_init		(__NR_Linux + 300)
-#define __NR_fanotify_mark		(__NR_Linux + 301)
-#define __NR_prlimit64			(__NR_Linux + 302)
-#define __NR_name_to_handle_at		(__NR_Linux + 303)
-#define __NR_open_by_handle_at		(__NR_Linux + 304)
-#define __NR_clock_adjtime		(__NR_Linux + 305)
-#define __NR_syncfs			(__NR_Linux + 306)
-#define __NR_sendmmsg			(__NR_Linux + 307)
-#define __NR_setns			(__NR_Linux + 308)
-#define __NR_process_vm_readv		(__NR_Linux + 309)
-#define __NR_process_vm_writev		(__NR_Linux + 310)
-#define __NR_kcmp			(__NR_Linux + 311)
-#define __NR_finit_module		(__NR_Linux + 312)
-#define __NR_sched_setattr		(__NR_Linux + 313)
-#define __NR_sched_getattr		(__NR_Linux + 314)
-#define __NR_renameat2			(__NR_Linux + 315)
-#define __NR_seccomp			(__NR_Linux + 316)
-#define __NR_getrandom			(__NR_Linux + 317)
-#define __NR_memfd_create		(__NR_Linux + 318)
-#define __NR_bpf			(__NR_Linux + 319)
-#define __NR_execveat			(__NR_Linux + 320)
-#define __NR_userfaultfd		(__NR_Linux + 321)
-#define __NR_membarrier			(__NR_Linux + 322)
-#define __NR_mlock2			(__NR_Linux + 323)
-#define __NR_copy_file_range		(__NR_Linux + 324)
-#define __NR_preadv2			(__NR_Linux + 325)
-#define __NR_pwritev2			(__NR_Linux + 326)
-#define __NR_pkey_mprotect		(__NR_Linux + 327)
-#define __NR_pkey_alloc			(__NR_Linux + 328)
-#define __NR_pkey_free			(__NR_Linux + 329)
-#define __NR_statx			(__NR_Linux + 330)
-#define __NR_rseq			(__NR_Linux + 331)
-#define __NR_io_pgetevents		(__NR_Linux + 332)
-
-/*
- * Offset of the last N32 flavoured syscall
- */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux	6000
+#include <asm/unistd_n32.h>
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
-#define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
-
 #endif /* _ASM_UNISTD_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
new file mode 100644
index 0000000000..8083de1f25
--- /dev/null
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -0,0 +1,334 @@
+#ifndef _ASM_MIPS_UNISTD_N64_H
+#define _ASM_MIPS_UNISTD_N64_H
+
+#define __NR_read	(__NR_Linux + 0)
+#define __NR_write	(__NR_Linux + 1)
+#define __NR_open	(__NR_Linux + 2)
+#define __NR_close	(__NR_Linux + 3)
+#define __NR_stat	(__NR_Linux + 4)
+#define __NR_fstat	(__NR_Linux + 5)
+#define __NR_lstat	(__NR_Linux + 6)
+#define __NR_poll	(__NR_Linux + 7)
+#define __NR_lseek	(__NR_Linux + 8)
+#define __NR_mmap	(__NR_Linux + 9)
+#define __NR_mprotect	(__NR_Linux + 10)
+#define __NR_munmap	(__NR_Linux + 11)
+#define __NR_brk	(__NR_Linux + 12)
+#define __NR_rt_sigaction	(__NR_Linux + 13)
+#define __NR_rt_sigprocmask	(__NR_Linux + 14)
+#define __NR_ioctl	(__NR_Linux + 15)
+#define __NR_pread64	(__NR_Linux + 16)
+#define __NR_pwrite64	(__NR_Linux + 17)
+#define __NR_readv	(__NR_Linux + 18)
+#define __NR_writev	(__NR_Linux + 19)
+#define __NR_access	(__NR_Linux + 20)
+#define __NR_pipe	(__NR_Linux + 21)
+#define __NR__newselect	(__NR_Linux + 22)
+#define __NR_sched_yield	(__NR_Linux + 23)
+#define __NR_mremap	(__NR_Linux + 24)
+#define __NR_msync	(__NR_Linux + 25)
+#define __NR_mincore	(__NR_Linux + 26)
+#define __NR_madvise	(__NR_Linux + 27)
+#define __NR_shmget	(__NR_Linux + 28)
+#define __NR_shmat	(__NR_Linux + 29)
+#define __NR_shmctl	(__NR_Linux + 30)
+#define __NR_dup	(__NR_Linux + 31)
+#define __NR_dup2	(__NR_Linux + 32)
+#define __NR_pause	(__NR_Linux + 33)
+#define __NR_nanosleep	(__NR_Linux + 34)
+#define __NR_getitimer	(__NR_Linux + 35)
+#define __NR_setitimer	(__NR_Linux + 36)
+#define __NR_alarm	(__NR_Linux + 37)
+#define __NR_getpid	(__NR_Linux + 38)
+#define __NR_sendfile	(__NR_Linux + 39)
+#define __NR_socket	(__NR_Linux + 40)
+#define __NR_connect	(__NR_Linux + 41)
+#define __NR_accept	(__NR_Linux + 42)
+#define __NR_sendto	(__NR_Linux + 43)
+#define __NR_recvfrom	(__NR_Linux + 44)
+#define __NR_sendmsg	(__NR_Linux + 45)
+#define __NR_recvmsg	(__NR_Linux + 46)
+#define __NR_shutdown	(__NR_Linux + 47)
+#define __NR_bind	(__NR_Linux + 48)
+#define __NR_listen	(__NR_Linux + 49)
+#define __NR_getsockname	(__NR_Linux + 50)
+#define __NR_getpeername	(__NR_Linux + 51)
+#define __NR_socketpair	(__NR_Linux + 52)
+#define __NR_setsockopt	(__NR_Linux + 53)
+#define __NR_getsockopt	(__NR_Linux + 54)
+#define __NR_clone	(__NR_Linux + 55)
+#define __NR_fork	(__NR_Linux + 56)
+#define __NR_execve	(__NR_Linux + 57)
+#define __NR_exit	(__NR_Linux + 58)
+#define __NR_wait4	(__NR_Linux + 59)
+#define __NR_kill	(__NR_Linux + 60)
+#define __NR_uname	(__NR_Linux + 61)
+#define __NR_semget	(__NR_Linux + 62)
+#define __NR_semop	(__NR_Linux + 63)
+#define __NR_semctl	(__NR_Linux + 64)
+#define __NR_shmdt	(__NR_Linux + 65)
+#define __NR_msgget	(__NR_Linux + 66)
+#define __NR_msgsnd	(__NR_Linux + 67)
+#define __NR_msgrcv	(__NR_Linux + 68)
+#define __NR_msgctl	(__NR_Linux + 69)
+#define __NR_fcntl	(__NR_Linux + 70)
+#define __NR_flock	(__NR_Linux + 71)
+#define __NR_fsync	(__NR_Linux + 72)
+#define __NR_fdatasync	(__NR_Linux + 73)
+#define __NR_truncate	(__NR_Linux + 74)
+#define __NR_ftruncate	(__NR_Linux + 75)
+#define __NR_getdents	(__NR_Linux + 76)
+#define __NR_getcwd	(__NR_Linux + 77)
+#define __NR_chdir	(__NR_Linux + 78)
+#define __NR_fchdir	(__NR_Linux + 79)
+#define __NR_rename	(__NR_Linux + 80)
+#define __NR_mkdir	(__NR_Linux + 81)
+#define __NR_rmdir	(__NR_Linux + 82)
+#define __NR_creat	(__NR_Linux + 83)
+#define __NR_link	(__NR_Linux + 84)
+#define __NR_unlink	(__NR_Linux + 85)
+#define __NR_symlink	(__NR_Linux + 86)
+#define __NR_readlink	(__NR_Linux + 87)
+#define __NR_chmod	(__NR_Linux + 88)
+#define __NR_fchmod	(__NR_Linux + 89)
+#define __NR_chown	(__NR_Linux + 90)
+#define __NR_fchown	(__NR_Linux + 91)
+#define __NR_lchown	(__NR_Linux + 92)
+#define __NR_umask	(__NR_Linux + 93)
+#define __NR_gettimeofday	(__NR_Linux + 94)
+#define __NR_getrlimit	(__NR_Linux + 95)
+#define __NR_getrusage	(__NR_Linux + 96)
+#define __NR_sysinfo	(__NR_Linux + 97)
+#define __NR_times	(__NR_Linux + 98)
+#define __NR_ptrace	(__NR_Linux + 99)
+#define __NR_getuid	(__NR_Linux + 100)
+#define __NR_syslog	(__NR_Linux + 101)
+#define __NR_getgid	(__NR_Linux + 102)
+#define __NR_setuid	(__NR_Linux + 103)
+#define __NR_setgid	(__NR_Linux + 104)
+#define __NR_geteuid	(__NR_Linux + 105)
+#define __NR_getegid	(__NR_Linux + 106)
+#define __NR_setpgid	(__NR_Linux + 107)
+#define __NR_getppid	(__NR_Linux + 108)
+#define __NR_getpgrp	(__NR_Linux + 109)
+#define __NR_setsid	(__NR_Linux + 110)
+#define __NR_setreuid	(__NR_Linux + 111)
+#define __NR_setregid	(__NR_Linux + 112)
+#define __NR_getgroups	(__NR_Linux + 113)
+#define __NR_setgroups	(__NR_Linux + 114)
+#define __NR_setresuid	(__NR_Linux + 115)
+#define __NR_getresuid	(__NR_Linux + 116)
+#define __NR_setresgid	(__NR_Linux + 117)
+#define __NR_getresgid	(__NR_Linux + 118)
+#define __NR_getpgid	(__NR_Linux + 119)
+#define __NR_setfsuid	(__NR_Linux + 120)
+#define __NR_setfsgid	(__NR_Linux + 121)
+#define __NR_getsid	(__NR_Linux + 122)
+#define __NR_capget	(__NR_Linux + 123)
+#define __NR_capset	(__NR_Linux + 124)
+#define __NR_rt_sigpending	(__NR_Linux + 125)
+#define __NR_rt_sigtimedwait	(__NR_Linux + 126)
+#define __NR_rt_sigqueueinfo	(__NR_Linux + 127)
+#define __NR_rt_sigsuspend	(__NR_Linux + 128)
+#define __NR_sigaltstack	(__NR_Linux + 129)
+#define __NR_utime	(__NR_Linux + 130)
+#define __NR_mknod	(__NR_Linux + 131)
+#define __NR_personality	(__NR_Linux + 132)
+#define __NR_ustat	(__NR_Linux + 133)
+#define __NR_statfs	(__NR_Linux + 134)
+#define __NR_fstatfs	(__NR_Linux + 135)
+#define __NR_sysfs	(__NR_Linux + 136)
+#define __NR_getpriority	(__NR_Linux + 137)
+#define __NR_setpriority	(__NR_Linux + 138)
+#define __NR_sched_setparam	(__NR_Linux + 139)
+#define __NR_sched_getparam	(__NR_Linux + 140)
+#define __NR_sched_setscheduler	(__NR_Linux + 141)
+#define __NR_sched_getscheduler	(__NR_Linux + 142)
+#define __NR_sched_get_priority_max	(__NR_Linux + 143)
+#define __NR_sched_get_priority_min	(__NR_Linux + 144)
+#define __NR_sched_rr_get_interval	(__NR_Linux + 145)
+#define __NR_mlock	(__NR_Linux + 146)
+#define __NR_munlock	(__NR_Linux + 147)
+#define __NR_mlockall	(__NR_Linux + 148)
+#define __NR_munlockall	(__NR_Linux + 149)
+#define __NR_vhangup	(__NR_Linux + 150)
+#define __NR_pivot_root	(__NR_Linux + 151)
+#define __NR__sysctl	(__NR_Linux + 152)
+#define __NR_prctl	(__NR_Linux + 153)
+#define __NR_adjtimex	(__NR_Linux + 154)
+#define __NR_setrlimit	(__NR_Linux + 155)
+#define __NR_chroot	(__NR_Linux + 156)
+#define __NR_sync	(__NR_Linux + 157)
+#define __NR_acct	(__NR_Linux + 158)
+#define __NR_settimeofday	(__NR_Linux + 159)
+#define __NR_mount	(__NR_Linux + 160)
+#define __NR_umount2	(__NR_Linux + 161)
+#define __NR_swapon	(__NR_Linux + 162)
+#define __NR_swapoff	(__NR_Linux + 163)
+#define __NR_reboot	(__NR_Linux + 164)
+#define __NR_sethostname	(__NR_Linux + 165)
+#define __NR_setdomainname	(__NR_Linux + 166)
+#define __NR_create_module	(__NR_Linux + 167)
+#define __NR_init_module	(__NR_Linux + 168)
+#define __NR_delete_module	(__NR_Linux + 169)
+#define __NR_get_kernel_syms	(__NR_Linux + 170)
+#define __NR_query_module	(__NR_Linux + 171)
+#define __NR_quotactl	(__NR_Linux + 172)
+#define __NR_nfsservctl	(__NR_Linux + 173)
+#define __NR_getpmsg	(__NR_Linux + 174)
+#define __NR_putpmsg	(__NR_Linux + 175)
+#define __NR_afs_syscall	(__NR_Linux + 176)
+#define __NR_reserved177	(__NR_Linux + 177)
+#define __NR_gettid	(__NR_Linux + 178)
+#define __NR_readahead	(__NR_Linux + 179)
+#define __NR_setxattr	(__NR_Linux + 180)
+#define __NR_lsetxattr	(__NR_Linux + 181)
+#define __NR_fsetxattr	(__NR_Linux + 182)
+#define __NR_getxattr	(__NR_Linux + 183)
+#define __NR_lgetxattr	(__NR_Linux + 184)
+#define __NR_fgetxattr	(__NR_Linux + 185)
+#define __NR_listxattr	(__NR_Linux + 186)
+#define __NR_llistxattr	(__NR_Linux + 187)
+#define __NR_flistxattr	(__NR_Linux + 188)
+#define __NR_removexattr	(__NR_Linux + 189)
+#define __NR_lremovexattr	(__NR_Linux + 190)
+#define __NR_fremovexattr	(__NR_Linux + 191)
+#define __NR_tkill	(__NR_Linux + 192)
+#define __NR_reserved193	(__NR_Linux + 193)
+#define __NR_futex	(__NR_Linux + 194)
+#define __NR_sched_setaffinity	(__NR_Linux + 195)
+#define __NR_sched_getaffinity	(__NR_Linux + 196)
+#define __NR_cacheflush	(__NR_Linux + 197)
+#define __NR_cachectl	(__NR_Linux + 198)
+#define __NR_sysmips	(__NR_Linux + 199)
+#define __NR_io_setup	(__NR_Linux + 200)
+#define __NR_io_destroy	(__NR_Linux + 201)
+#define __NR_io_getevents	(__NR_Linux + 202)
+#define __NR_io_submit	(__NR_Linux + 203)
+#define __NR_io_cancel	(__NR_Linux + 204)
+#define __NR_exit_group	(__NR_Linux + 205)
+#define __NR_lookup_dcookie	(__NR_Linux + 206)
+#define __NR_epoll_create	(__NR_Linux + 207)
+#define __NR_epoll_ctl	(__NR_Linux + 208)
+#define __NR_epoll_wait	(__NR_Linux + 209)
+#define __NR_remap_file_pages	(__NR_Linux + 210)
+#define __NR_rt_sigreturn	(__NR_Linux + 211)
+#define __NR_set_tid_address	(__NR_Linux + 212)
+#define __NR_restart_syscall	(__NR_Linux + 213)
+#define __NR_semtimedop	(__NR_Linux + 214)
+#define __NR_fadvise64	(__NR_Linux + 215)
+#define __NR_timer_create	(__NR_Linux + 216)
+#define __NR_timer_settime	(__NR_Linux + 217)
+#define __NR_timer_gettime	(__NR_Linux + 218)
+#define __NR_timer_getoverrun	(__NR_Linux + 219)
+#define __NR_timer_delete	(__NR_Linux + 220)
+#define __NR_clock_settime	(__NR_Linux + 221)
+#define __NR_clock_gettime	(__NR_Linux + 222)
+#define __NR_clock_getres	(__NR_Linux + 223)
+#define __NR_clock_nanosleep	(__NR_Linux + 224)
+#define __NR_tgkill	(__NR_Linux + 225)
+#define __NR_utimes	(__NR_Linux + 226)
+#define __NR_mbind	(__NR_Linux + 227)
+#define __NR_get_mempolicy	(__NR_Linux + 228)
+#define __NR_set_mempolicy	(__NR_Linux + 229)
+#define __NR_mq_open	(__NR_Linux + 230)
+#define __NR_mq_unlink	(__NR_Linux + 231)
+#define __NR_mq_timedsend	(__NR_Linux + 232)
+#define __NR_mq_timedreceive	(__NR_Linux + 233)
+#define __NR_mq_notify	(__NR_Linux + 234)
+#define __NR_mq_getsetattr	(__NR_Linux + 235)
+#define __NR_vserver	(__NR_Linux + 236)
+#define __NR_waitid	(__NR_Linux + 237)
+#define __NR_add_key	(__NR_Linux + 239)
+#define __NR_request_key	(__NR_Linux + 240)
+#define __NR_keyctl	(__NR_Linux + 241)
+#define __NR_set_thread_area	(__NR_Linux + 242)
+#define __NR_inotify_init	(__NR_Linux + 243)
+#define __NR_inotify_add_watch	(__NR_Linux + 244)
+#define __NR_inotify_rm_watch	(__NR_Linux + 245)
+#define __NR_migrate_pages	(__NR_Linux + 246)
+#define __NR_openat	(__NR_Linux + 247)
+#define __NR_mkdirat	(__NR_Linux + 248)
+#define __NR_mknodat	(__NR_Linux + 249)
+#define __NR_fchownat	(__NR_Linux + 250)
+#define __NR_futimesat	(__NR_Linux + 251)
+#define __NR_newfstatat	(__NR_Linux + 252)
+#define __NR_unlinkat	(__NR_Linux + 253)
+#define __NR_renameat	(__NR_Linux + 254)
+#define __NR_linkat	(__NR_Linux + 255)
+#define __NR_symlinkat	(__NR_Linux + 256)
+#define __NR_readlinkat	(__NR_Linux + 257)
+#define __NR_fchmodat	(__NR_Linux + 258)
+#define __NR_faccessat	(__NR_Linux + 259)
+#define __NR_pselect6	(__NR_Linux + 260)
+#define __NR_ppoll	(__NR_Linux + 261)
+#define __NR_unshare	(__NR_Linux + 262)
+#define __NR_splice	(__NR_Linux + 263)
+#define __NR_sync_file_range	(__NR_Linux + 264)
+#define __NR_tee	(__NR_Linux + 265)
+#define __NR_vmsplice	(__NR_Linux + 266)
+#define __NR_move_pages	(__NR_Linux + 267)
+#define __NR_set_robust_list	(__NR_Linux + 268)
+#define __NR_get_robust_list	(__NR_Linux + 269)
+#define __NR_kexec_load	(__NR_Linux + 270)
+#define __NR_getcpu	(__NR_Linux + 271)
+#define __NR_epoll_pwait	(__NR_Linux + 272)
+#define __NR_ioprio_set	(__NR_Linux + 273)
+#define __NR_ioprio_get	(__NR_Linux + 274)
+#define __NR_utimensat	(__NR_Linux + 275)
+#define __NR_signalfd	(__NR_Linux + 276)
+#define __NR_timerfd	(__NR_Linux + 277)
+#define __NR_eventfd	(__NR_Linux + 278)
+#define __NR_fallocate	(__NR_Linux + 279)
+#define __NR_timerfd_create	(__NR_Linux + 280)
+#define __NR_timerfd_gettime	(__NR_Linux + 281)
+#define __NR_timerfd_settime	(__NR_Linux + 282)
+#define __NR_signalfd4	(__NR_Linux + 283)
+#define __NR_eventfd2	(__NR_Linux + 284)
+#define __NR_epoll_create1	(__NR_Linux + 285)
+#define __NR_dup3	(__NR_Linux + 286)
+#define __NR_pipe2	(__NR_Linux + 287)
+#define __NR_inotify_init1	(__NR_Linux + 288)
+#define __NR_preadv	(__NR_Linux + 289)
+#define __NR_pwritev	(__NR_Linux + 290)
+#define __NR_rt_tgsigqueueinfo	(__NR_Linux + 291)
+#define __NR_perf_event_open	(__NR_Linux + 292)
+#define __NR_accept4	(__NR_Linux + 293)
+#define __NR_recvmmsg	(__NR_Linux + 294)
+#define __NR_fanotify_init	(__NR_Linux + 295)
+#define __NR_fanotify_mark	(__NR_Linux + 296)
+#define __NR_prlimit64	(__NR_Linux + 297)
+#define __NR_name_to_handle_at	(__NR_Linux + 298)
+#define __NR_open_by_handle_at	(__NR_Linux + 299)
+#define __NR_clock_adjtime	(__NR_Linux + 300)
+#define __NR_syncfs	(__NR_Linux + 301)
+#define __NR_sendmmsg	(__NR_Linux + 302)
+#define __NR_setns	(__NR_Linux + 303)
+#define __NR_process_vm_readv	(__NR_Linux + 304)
+#define __NR_process_vm_writev	(__NR_Linux + 305)
+#define __NR_kcmp	(__NR_Linux + 306)
+#define __NR_finit_module	(__NR_Linux + 307)
+#define __NR_getdents64	(__NR_Linux + 308)
+#define __NR_sched_setattr	(__NR_Linux + 309)
+#define __NR_sched_getattr	(__NR_Linux + 310)
+#define __NR_renameat2	(__NR_Linux + 311)
+#define __NR_seccomp	(__NR_Linux + 312)
+#define __NR_getrandom	(__NR_Linux + 313)
+#define __NR_memfd_create	(__NR_Linux + 314)
+#define __NR_bpf	(__NR_Linux + 315)
+#define __NR_execveat	(__NR_Linux + 316)
+#define __NR_userfaultfd	(__NR_Linux + 317)
+#define __NR_membarrier	(__NR_Linux + 318)
+#define __NR_mlock2	(__NR_Linux + 319)
+#define __NR_copy_file_range	(__NR_Linux + 320)
+#define __NR_preadv2	(__NR_Linux + 321)
+#define __NR_pwritev2	(__NR_Linux + 322)
+#define __NR_pkey_mprotect	(__NR_Linux + 323)
+#define __NR_pkey_alloc	(__NR_Linux + 324)
+#define __NR_pkey_free	(__NR_Linux + 325)
+#define __NR_statx	(__NR_Linux + 326)
+#define __NR_rseq	(__NR_Linux + 327)
+#define __NR_io_pgetevents	(__NR_Linux + 328)
+
+
+#endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
new file mode 100644
index 0000000000..b03835b286
--- /dev/null
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -0,0 +1,374 @@
+#ifndef _ASM_MIPS_UNISTD_O32_H
+#define _ASM_MIPS_UNISTD_O32_H
+
+#define __NR_syscall	(__NR_Linux + 0)
+#define __NR_exit	(__NR_Linux + 1)
+#define __NR_fork	(__NR_Linux + 2)
+#define __NR_read	(__NR_Linux + 3)
+#define __NR_write	(__NR_Linux + 4)
+#define __NR_open	(__NR_Linux + 5)
+#define __NR_close	(__NR_Linux + 6)
+#define __NR_waitpid	(__NR_Linux + 7)
+#define __NR_creat	(__NR_Linux + 8)
+#define __NR_link	(__NR_Linux + 9)
+#define __NR_unlink	(__NR_Linux + 10)
+#define __NR_execve	(__NR_Linux + 11)
+#define __NR_chdir	(__NR_Linux + 12)
+#define __NR_time	(__NR_Linux + 13)
+#define __NR_mknod	(__NR_Linux + 14)
+#define __NR_chmod	(__NR_Linux + 15)
+#define __NR_lchown	(__NR_Linux + 16)
+#define __NR_break	(__NR_Linux + 17)
+#define __NR_unused18	(__NR_Linux + 18)
+#define __NR_lseek	(__NR_Linux + 19)
+#define __NR_getpid	(__NR_Linux + 20)
+#define __NR_mount	(__NR_Linux + 21)
+#define __NR_umount	(__NR_Linux + 22)
+#define __NR_setuid	(__NR_Linux + 23)
+#define __NR_getuid	(__NR_Linux + 24)
+#define __NR_stime	(__NR_Linux + 25)
+#define __NR_ptrace	(__NR_Linux + 26)
+#define __NR_alarm	(__NR_Linux + 27)
+#define __NR_unused28	(__NR_Linux + 28)
+#define __NR_pause	(__NR_Linux + 29)
+#define __NR_utime	(__NR_Linux + 30)
+#define __NR_stty	(__NR_Linux + 31)
+#define __NR_gtty	(__NR_Linux + 32)
+#define __NR_access	(__NR_Linux + 33)
+#define __NR_nice	(__NR_Linux + 34)
+#define __NR_ftime	(__NR_Linux + 35)
+#define __NR_sync	(__NR_Linux + 36)
+#define __NR_kill	(__NR_Linux + 37)
+#define __NR_rename	(__NR_Linux + 38)
+#define __NR_mkdir	(__NR_Linux + 39)
+#define __NR_rmdir	(__NR_Linux + 40)
+#define __NR_dup	(__NR_Linux + 41)
+#define __NR_pipe	(__NR_Linux + 42)
+#define __NR_times	(__NR_Linux + 43)
+#define __NR_prof	(__NR_Linux + 44)
+#define __NR_brk	(__NR_Linux + 45)
+#define __NR_setgid	(__NR_Linux + 46)
+#define __NR_getgid	(__NR_Linux + 47)
+#define __NR_signal	(__NR_Linux + 48)
+#define __NR_geteuid	(__NR_Linux + 49)
+#define __NR_getegid	(__NR_Linux + 50)
+#define __NR_acct	(__NR_Linux + 51)
+#define __NR_umount2	(__NR_Linux + 52)
+#define __NR_lock	(__NR_Linux + 53)
+#define __NR_ioctl	(__NR_Linux + 54)
+#define __NR_fcntl	(__NR_Linux + 55)
+#define __NR_mpx	(__NR_Linux + 56)
+#define __NR_setpgid	(__NR_Linux + 57)
+#define __NR_ulimit	(__NR_Linux + 58)
+#define __NR_unused59	(__NR_Linux + 59)
+#define __NR_umask	(__NR_Linux + 60)
+#define __NR_chroot	(__NR_Linux + 61)
+#define __NR_ustat	(__NR_Linux + 62)
+#define __NR_dup2	(__NR_Linux + 63)
+#define __NR_getppid	(__NR_Linux + 64)
+#define __NR_getpgrp	(__NR_Linux + 65)
+#define __NR_setsid	(__NR_Linux + 66)
+#define __NR_sigaction	(__NR_Linux + 67)
+#define __NR_sgetmask	(__NR_Linux + 68)
+#define __NR_ssetmask	(__NR_Linux + 69)
+#define __NR_setreuid	(__NR_Linux + 70)
+#define __NR_setregid	(__NR_Linux + 71)
+#define __NR_sigsuspend	(__NR_Linux + 72)
+#define __NR_sigpending	(__NR_Linux + 73)
+#define __NR_sethostname	(__NR_Linux + 74)
+#define __NR_setrlimit	(__NR_Linux + 75)
+#define __NR_getrlimit	(__NR_Linux + 76)
+#define __NR_getrusage	(__NR_Linux + 77)
+#define __NR_gettimeofday	(__NR_Linux + 78)
+#define __NR_settimeofday	(__NR_Linux + 79)
+#define __NR_getgroups	(__NR_Linux + 80)
+#define __NR_setgroups	(__NR_Linux + 81)
+#define __NR_reserved82	(__NR_Linux + 82)
+#define __NR_symlink	(__NR_Linux + 83)
+#define __NR_unused84	(__NR_Linux + 84)
+#define __NR_readlink	(__NR_Linux + 85)
+#define __NR_uselib	(__NR_Linux + 86)
+#define __NR_swapon	(__NR_Linux + 87)
+#define __NR_reboot	(__NR_Linux + 88)
+#define __NR_readdir	(__NR_Linux + 89)
+#define __NR_mmap	(__NR_Linux + 90)
+#define __NR_munmap	(__NR_Linux + 91)
+#define __NR_truncate	(__NR_Linux + 92)
+#define __NR_ftruncate	(__NR_Linux + 93)
+#define __NR_fchmod	(__NR_Linux + 94)
+#define __NR_fchown	(__NR_Linux + 95)
+#define __NR_getpriority	(__NR_Linux + 96)
+#define __NR_setpriority	(__NR_Linux + 97)
+#define __NR_profil	(__NR_Linux + 98)
+#define __NR_statfs	(__NR_Linux + 99)
+#define __NR_fstatfs	(__NR_Linux + 100)
+#define __NR_ioperm	(__NR_Linux + 101)
+#define __NR_socketcall	(__NR_Linux + 102)
+#define __NR_syslog	(__NR_Linux + 103)
+#define __NR_setitimer	(__NR_Linux + 104)
+#define __NR_getitimer	(__NR_Linux + 105)
+#define __NR_stat	(__NR_Linux + 106)
+#define __NR_lstat	(__NR_Linux + 107)
+#define __NR_fstat	(__NR_Linux + 108)
+#define __NR_unused109	(__NR_Linux + 109)
+#define __NR_iopl	(__NR_Linux + 110)
+#define __NR_vhangup	(__NR_Linux + 111)
+#define __NR_idle	(__NR_Linux + 112)
+#define __NR_vm86	(__NR_Linux + 113)
+#define __NR_wait4	(__NR_Linux + 114)
+#define __NR_swapoff	(__NR_Linux + 115)
+#define __NR_sysinfo	(__NR_Linux + 116)
+#define __NR_ipc	(__NR_Linux + 117)
+#define __NR_fsync	(__NR_Linux + 118)
+#define __NR_sigreturn	(__NR_Linux + 119)
+#define __NR_clone	(__NR_Linux + 120)
+#define __NR_setdomainname	(__NR_Linux + 121)
+#define __NR_uname	(__NR_Linux + 122)
+#define __NR_modify_ldt	(__NR_Linux + 123)
+#define __NR_adjtimex	(__NR_Linux + 124)
+#define __NR_mprotect	(__NR_Linux + 125)
+#define __NR_sigprocmask	(__NR_Linux + 126)
+#define __NR_create_module	(__NR_Linux + 127)
+#define __NR_init_module	(__NR_Linux + 128)
+#define __NR_delete_module	(__NR_Linux + 129)
+#define __NR_get_kernel_syms	(__NR_Linux + 130)
+#define __NR_quotactl	(__NR_Linux + 131)
+#define __NR_getpgid	(__NR_Linux + 132)
+#define __NR_fchdir	(__NR_Linux + 133)
+#define __NR_bdflush	(__NR_Linux + 134)
+#define __NR_sysfs	(__NR_Linux + 135)
+#define __NR_personality	(__NR_Linux + 136)
+#define __NR_afs_syscall	(__NR_Linux + 137)
+#define __NR_setfsuid	(__NR_Linux + 138)
+#define __NR_setfsgid	(__NR_Linux + 139)
+#define __NR__llseek	(__NR_Linux + 140)
+#define __NR_getdents	(__NR_Linux + 141)
+#define __NR__newselect	(__NR_Linux + 142)
+#define __NR_flock	(__NR_Linux + 143)
+#define __NR_msync	(__NR_Linux + 144)
+#define __NR_readv	(__NR_Linux + 145)
+#define __NR_writev	(__NR_Linux + 146)
+#define __NR_cacheflush	(__NR_Linux + 147)
+#define __NR_cachectl	(__NR_Linux + 148)
+#define __NR_sysmips	(__NR_Linux + 149)
+#define __NR_unused150	(__NR_Linux + 150)
+#define __NR_getsid	(__NR_Linux + 151)
+#define __NR_fdatasync	(__NR_Linux + 152)
+#define __NR__sysctl	(__NR_Linux + 153)
+#define __NR_mlock	(__NR_Linux + 154)
+#define __NR_munlock	(__NR_Linux + 155)
+#define __NR_mlockall	(__NR_Linux + 156)
+#define __NR_munlockall	(__NR_Linux + 157)
+#define __NR_sched_setparam	(__NR_Linux + 158)
+#define __NR_sched_getparam	(__NR_Linux + 159)
+#define __NR_sched_setscheduler	(__NR_Linux + 160)
+#define __NR_sched_getscheduler	(__NR_Linux + 161)
+#define __NR_sched_yield	(__NR_Linux + 162)
+#define __NR_sched_get_priority_max	(__NR_Linux + 163)
+#define __NR_sched_get_priority_min	(__NR_Linux + 164)
+#define __NR_sched_rr_get_interval	(__NR_Linux + 165)
+#define __NR_nanosleep	(__NR_Linux + 166)
+#define __NR_mremap	(__NR_Linux + 167)
+#define __NR_accept	(__NR_Linux + 168)
+#define __NR_bind	(__NR_Linux + 169)
+#define __NR_connect	(__NR_Linux + 170)
+#define __NR_getpeername	(__NR_Linux + 171)
+#define __NR_getsockname	(__NR_Linux + 172)
+#define __NR_getsockopt	(__NR_Linux + 173)
+#define __NR_listen	(__NR_Linux + 174)
+#define __NR_recv	(__NR_Linux + 175)
+#define __NR_recvfrom	(__NR_Linux + 176)
+#define __NR_recvmsg	(__NR_Linux + 177)
+#define __NR_send	(__NR_Linux + 178)
+#define __NR_sendmsg	(__NR_Linux + 179)
+#define __NR_sendto	(__NR_Linux + 180)
+#define __NR_setsockopt	(__NR_Linux + 181)
+#define __NR_shutdown	(__NR_Linux + 182)
+#define __NR_socket	(__NR_Linux + 183)
+#define __NR_socketpair	(__NR_Linux + 184)
+#define __NR_setresuid	(__NR_Linux + 185)
+#define __NR_getresuid	(__NR_Linux + 186)
+#define __NR_query_module	(__NR_Linux + 187)
+#define __NR_poll	(__NR_Linux + 188)
+#define __NR_nfsservctl	(__NR_Linux + 189)
+#define __NR_setresgid	(__NR_Linux + 190)
+#define __NR_getresgid	(__NR_Linux + 191)
+#define __NR_prctl	(__NR_Linux + 192)
+#define __NR_rt_sigreturn	(__NR_Linux + 193)
+#define __NR_rt_sigaction	(__NR_Linux + 194)
+#define __NR_rt_sigprocmask	(__NR_Linux + 195)
+#define __NR_rt_sigpending	(__NR_Linux + 196)
+#define __NR_rt_sigtimedwait	(__NR_Linux + 197)
+#define __NR_rt_sigqueueinfo	(__NR_Linux + 198)
+#define __NR_rt_sigsuspend	(__NR_Linux + 199)
+#define __NR_pread64	(__NR_Linux + 200)
+#define __NR_pwrite64	(__NR_Linux + 201)
+#define __NR_chown	(__NR_Linux + 202)
+#define __NR_getcwd	(__NR_Linux + 203)
+#define __NR_capget	(__NR_Linux + 204)
+#define __NR_capset	(__NR_Linux + 205)
+#define __NR_sigaltstack	(__NR_Linux + 206)
+#define __NR_sendfile	(__NR_Linux + 207)
+#define __NR_getpmsg	(__NR_Linux + 208)
+#define __NR_putpmsg	(__NR_Linux + 209)
+#define __NR_mmap2	(__NR_Linux + 210)
+#define __NR_truncate64	(__NR_Linux + 211)
+#define __NR_ftruncate64	(__NR_Linux + 212)
+#define __NR_stat64	(__NR_Linux + 213)
+#define __NR_lstat64	(__NR_Linux + 214)
+#define __NR_fstat64	(__NR_Linux + 215)
+#define __NR_pivot_root	(__NR_Linux + 216)
+#define __NR_mincore	(__NR_Linux + 217)
+#define __NR_madvise	(__NR_Linux + 218)
+#define __NR_getdents64	(__NR_Linux + 219)
+#define __NR_fcntl64	(__NR_Linux + 220)
+#define __NR_reserved221	(__NR_Linux + 221)
+#define __NR_gettid	(__NR_Linux + 222)
+#define __NR_readahead	(__NR_Linux + 223)
+#define __NR_setxattr	(__NR_Linux + 224)
+#define __NR_lsetxattr	(__NR_Linux + 225)
+#define __NR_fsetxattr	(__NR_Linux + 226)
+#define __NR_getxattr	(__NR_Linux + 227)
+#define __NR_lgetxattr	(__NR_Linux + 228)
+#define __NR_fgetxattr	(__NR_Linux + 229)
+#define __NR_listxattr	(__NR_Linux + 230)
+#define __NR_llistxattr	(__NR_Linux + 231)
+#define __NR_flistxattr	(__NR_Linux + 232)
+#define __NR_removexattr	(__NR_Linux + 233)
+#define __NR_lremovexattr	(__NR_Linux + 234)
+#define __NR_fremovexattr	(__NR_Linux + 235)
+#define __NR_tkill	(__NR_Linux + 236)
+#define __NR_sendfile64	(__NR_Linux + 237)
+#define __NR_futex	(__NR_Linux + 238)
+#define __NR_sched_setaffinity	(__NR_Linux + 239)
+#define __NR_sched_getaffinity	(__NR_Linux + 240)
+#define __NR_io_setup	(__NR_Linux + 241)
+#define __NR_io_destroy	(__NR_Linux + 242)
+#define __NR_io_getevents	(__NR_Linux + 243)
+#define __NR_io_submit	(__NR_Linux + 244)
+#define __NR_io_cancel	(__NR_Linux + 245)
+#define __NR_exit_group	(__NR_Linux + 246)
+#define __NR_lookup_dcookie	(__NR_Linux + 247)
+#define __NR_epoll_create	(__NR_Linux + 248)
+#define __NR_epoll_ctl	(__NR_Linux + 249)
+#define __NR_epoll_wait	(__NR_Linux + 250)
+#define __NR_remap_file_pages	(__NR_Linux + 251)
+#define __NR_set_tid_address	(__NR_Linux + 252)
+#define __NR_restart_syscall	(__NR_Linux + 253)
+#define __NR_fadvise64	(__NR_Linux + 254)
+#define __NR_statfs64	(__NR_Linux + 255)
+#define __NR_fstatfs64	(__NR_Linux + 256)
+#define __NR_timer_create	(__NR_Linux + 257)
+#define __NR_timer_settime	(__NR_Linux + 258)
+#define __NR_timer_gettime	(__NR_Linux + 259)
+#define __NR_timer_getoverrun	(__NR_Linux + 260)
+#define __NR_timer_delete	(__NR_Linux + 261)
+#define __NR_clock_settime	(__NR_Linux + 262)
+#define __NR_clock_gettime	(__NR_Linux + 263)
+#define __NR_clock_getres	(__NR_Linux + 264)
+#define __NR_clock_nanosleep	(__NR_Linux + 265)
+#define __NR_tgkill	(__NR_Linux + 266)
+#define __NR_utimes	(__NR_Linux + 267)
+#define __NR_mbind	(__NR_Linux + 268)
+#define __NR_get_mempolicy	(__NR_Linux + 269)
+#define __NR_set_mempolicy	(__NR_Linux + 270)
+#define __NR_mq_open	(__NR_Linux + 271)
+#define __NR_mq_unlink	(__NR_Linux + 272)
+#define __NR_mq_timedsend	(__NR_Linux + 273)
+#define __NR_mq_timedreceive	(__NR_Linux + 274)
+#define __NR_mq_notify	(__NR_Linux + 275)
+#define __NR_mq_getsetattr	(__NR_Linux + 276)
+#define __NR_vserver	(__NR_Linux + 277)
+#define __NR_waitid	(__NR_Linux + 278)
+#define __NR_add_key	(__NR_Linux + 280)
+#define __NR_request_key	(__NR_Linux + 281)
+#define __NR_keyctl	(__NR_Linux + 282)
+#define __NR_set_thread_area	(__NR_Linux + 283)
+#define __NR_inotify_init	(__NR_Linux + 284)
+#define __NR_inotify_add_watch	(__NR_Linux + 285)
+#define __NR_inotify_rm_watch	(__NR_Linux + 286)
+#define __NR_migrate_pages	(__NR_Linux + 287)
+#define __NR_openat	(__NR_Linux + 288)
+#define __NR_mkdirat	(__NR_Linux + 289)
+#define __NR_mknodat	(__NR_Linux + 290)
+#define __NR_fchownat	(__NR_Linux + 291)
+#define __NR_futimesat	(__NR_Linux + 292)
+#define __NR_fstatat64	(__NR_Linux + 293)
+#define __NR_unlinkat	(__NR_Linux + 294)
+#define __NR_renameat	(__NR_Linux + 295)
+#define __NR_linkat	(__NR_Linux + 296)
+#define __NR_symlinkat	(__NR_Linux + 297)
+#define __NR_readlinkat	(__NR_Linux + 298)
+#define __NR_fchmodat	(__NR_Linux + 299)
+#define __NR_faccessat	(__NR_Linux + 300)
+#define __NR_pselect6	(__NR_Linux + 301)
+#define __NR_ppoll	(__NR_Linux + 302)
+#define __NR_unshare	(__NR_Linux + 303)
+#define __NR_splice	(__NR_Linux + 304)
+#define __NR_sync_file_range	(__NR_Linux + 305)
+#define __NR_tee	(__NR_Linux + 306)
+#define __NR_vmsplice	(__NR_Linux + 307)
+#define __NR_move_pages	(__NR_Linux + 308)
+#define __NR_set_robust_list	(__NR_Linux + 309)
+#define __NR_get_robust_list	(__NR_Linux + 310)
+#define __NR_kexec_load	(__NR_Linux + 311)
+#define __NR_getcpu	(__NR_Linux + 312)
+#define __NR_epoll_pwait	(__NR_Linux + 313)
+#define __NR_ioprio_set	(__NR_Linux + 314)
+#define __NR_ioprio_get	(__NR_Linux + 315)
+#define __NR_utimensat	(__NR_Linux + 316)
+#define __NR_signalfd	(__NR_Linux + 317)
+#define __NR_timerfd	(__NR_Linux + 318)
+#define __NR_eventfd	(__NR_Linux + 319)
+#define __NR_fallocate	(__NR_Linux + 320)
+#define __NR_timerfd_create	(__NR_Linux + 321)
+#define __NR_timerfd_gettime	(__NR_Linux + 322)
+#define __NR_timerfd_settime	(__NR_Linux + 323)
+#define __NR_signalfd4	(__NR_Linux + 324)
+#define __NR_eventfd2	(__NR_Linux + 325)
+#define __NR_epoll_create1	(__NR_Linux + 326)
+#define __NR_dup3	(__NR_Linux + 327)
+#define __NR_pipe2	(__NR_Linux + 328)
+#define __NR_inotify_init1	(__NR_Linux + 329)
+#define __NR_preadv	(__NR_Linux + 330)
+#define __NR_pwritev	(__NR_Linux + 331)
+#define __NR_rt_tgsigqueueinfo	(__NR_Linux + 332)
+#define __NR_perf_event_open	(__NR_Linux + 333)
+#define __NR_accept4	(__NR_Linux + 334)
+#define __NR_recvmmsg	(__NR_Linux + 335)
+#define __NR_fanotify_init	(__NR_Linux + 336)
+#define __NR_fanotify_mark	(__NR_Linux + 337)
+#define __NR_prlimit64	(__NR_Linux + 338)
+#define __NR_name_to_handle_at	(__NR_Linux + 339)
+#define __NR_open_by_handle_at	(__NR_Linux + 340)
+#define __NR_clock_adjtime	(__NR_Linux + 341)
+#define __NR_syncfs	(__NR_Linux + 342)
+#define __NR_sendmmsg	(__NR_Linux + 343)
+#define __NR_setns	(__NR_Linux + 344)
+#define __NR_process_vm_readv	(__NR_Linux + 345)
+#define __NR_process_vm_writev	(__NR_Linux + 346)
+#define __NR_kcmp	(__NR_Linux + 347)
+#define __NR_finit_module	(__NR_Linux + 348)
+#define __NR_sched_setattr	(__NR_Linux + 349)
+#define __NR_sched_getattr	(__NR_Linux + 350)
+#define __NR_renameat2	(__NR_Linux + 351)
+#define __NR_seccomp	(__NR_Linux + 352)
+#define __NR_getrandom	(__NR_Linux + 353)
+#define __NR_memfd_create	(__NR_Linux + 354)
+#define __NR_bpf	(__NR_Linux + 355)
+#define __NR_execveat	(__NR_Linux + 356)
+#define __NR_userfaultfd	(__NR_Linux + 357)
+#define __NR_membarrier	(__NR_Linux + 358)
+#define __NR_mlock2	(__NR_Linux + 359)
+#define __NR_copy_file_range	(__NR_Linux + 360)
+#define __NR_preadv2	(__NR_Linux + 361)
+#define __NR_pwritev2	(__NR_Linux + 362)
+#define __NR_pkey_mprotect	(__NR_Linux + 363)
+#define __NR_pkey_alloc	(__NR_Linux + 364)
+#define __NR_pkey_free	(__NR_Linux + 365)
+#define __NR_statx	(__NR_Linux + 366)
+#define __NR_rseq	(__NR_Linux + 367)
+#define __NR_io_pgetevents	(__NR_Linux + 368)
+
+
+#endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index ec3533b1d0..2b29bd8096 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -10,395 +10,10 @@
 #ifndef _ASM_POWERPC_UNISTD_H_
 #define _ASM_POWERPC_UNISTD_H_
 
-
-#define __NR_restart_syscall	  0
-#define __NR_exit		  1
-#define __NR_fork		  2
-#define __NR_read		  3
-#define __NR_write		  4
-#define __NR_open		  5
-#define __NR_close		  6
-#define __NR_waitpid		  7
-#define __NR_creat		  8
-#define __NR_link		  9
-#define __NR_unlink		 10
-#define __NR_execve		 11
-#define __NR_chdir		 12
-#define __NR_time		 13
-#define __NR_mknod		 14
-#define __NR_chmod		 15
-#define __NR_lchown		 16
-#define __NR_break		 17
-#define __NR_oldstat		 18
-#define __NR_lseek		 19
-#define __NR_getpid		 20
-#define __NR_mount		 21
-#define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
-#define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
-#define __NR_access		 33
-#define __NR_nice		 34
-#define __NR_ftime		 35
-#define __NR_sync		 36
-#define __NR_kill		 37
-#define __NR_rename		 38
-#define __NR_mkdir		 39
-#define __NR_rmdir		 40
-#define __NR_dup		 41
-#define __NR_pipe		 42
-#define __NR_times		 43
-#define __NR_prof		 44
-#define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_acct		 51
-#define __NR_umount2		 52
-#define __NR_lock		 53
-#define __NR_ioctl		 54
-#define __NR_fcntl		 55
-#define __NR_mpx		 56
-#define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
-#define __NR_umask		 60
-#define __NR_chroot		 61
-#define __NR_ustat		 62
-#define __NR_dup2		 63
-#define __NR_getppid		 64
-#define __NR_getpgrp		 65
-#define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
-#define __NR_sethostname	 74
-#define __NR_setrlimit		 75
-#define __NR_getrlimit		 76
-#define __NR_getrusage		 77
-#define __NR_gettimeofday	 78
-#define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-#define __NR_select		 82
-#define __NR_symlink		 83
-#define __NR_oldlstat		 84
-#define __NR_readlink		 85
-#define __NR_uselib		 86
-#define __NR_swapon		 87
-#define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
-#define __NR_munmap		 91
-#define __NR_truncate		 92
-#define __NR_ftruncate		 93
-#define __NR_fchmod		 94
-#define __NR_fchown		 95
-#define __NR_getpriority	 96
-#define __NR_setpriority	 97
-#define __NR_profil		 98
-#define __NR_statfs		 99
-#define __NR_fstatfs		100
-#define __NR_ioperm		101
-#define __NR_socketcall		102
-#define __NR_syslog		103
-#define __NR_setitimer		104
-#define __NR_getitimer		105
-#define __NR_stat		106
-#define __NR_lstat		107
-#define __NR_fstat		108
-#define __NR_olduname		109
-#define __NR_iopl		110
-#define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86		113
-#define __NR_wait4		114
-#define __NR_swapoff		115
-#define __NR_sysinfo		116
-#define __NR_ipc		117
-#define __NR_fsync		118
-#define __NR_sigreturn		119
-#define __NR_clone		120
-#define __NR_setdomainname	121
-#define __NR_uname		122
-#define __NR_modify_ldt		123
-#define __NR_adjtimex		124
-#define __NR_mprotect		125
-#define __NR_sigprocmask	126
-#define __NR_create_module	127
-#define __NR_init_module	128
-#define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
-#define __NR_quotactl		131
-#define __NR_getpgid		132
-#define __NR_fchdir		133
-#define __NR_bdflush		134
-#define __NR_sysfs		135
-#define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR_getdents		141
-#define __NR__newselect		142
-#define __NR_flock		143
-#define __NR_msync		144
-#define __NR_readv		145
-#define __NR_writev		146
-#define __NR_getsid		147
-#define __NR_fdatasync		148
-#define __NR__sysctl		149
-#define __NR_mlock		150
-#define __NR_munlock		151
-#define __NR_mlockall		152
-#define __NR_munlockall		153
-#define __NR_sched_setparam		154
-#define __NR_sched_getparam		155
-#define __NR_sched_setscheduler		156
-#define __NR_sched_getscheduler		157
-#define __NR_sched_yield		158
-#define __NR_sched_get_priority_max	159
-#define __NR_sched_get_priority_min	160
-#define __NR_sched_rr_get_interval	161
-#define __NR_nanosleep		162
-#define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-#define __NR_query_module	166
-#define __NR_poll		167
-#define __NR_nfsservctl		168
-#define __NR_setresgid		169
-#define __NR_getresgid		170
-#define __NR_prctl		171
-#define __NR_rt_sigreturn	172
-#define __NR_rt_sigaction	173
-#define __NR_rt_sigprocmask	174
-#define __NR_rt_sigpending	175
-#define __NR_rt_sigtimedwait	176
-#define __NR_rt_sigqueueinfo	177
-#define __NR_rt_sigsuspend	178
-#define __NR_pread64		179
-#define __NR_pwrite64		180
-#define __NR_chown		181
-#define __NR_getcwd		182
-#define __NR_capget		183
-#define __NR_capset		184
-#define __NR_sigaltstack	185
-#define __NR_sendfile		186
-#define __NR_getpmsg		187	/* some people actually want streams */
-#define __NR_putpmsg		188	/* some people actually want streams */
-#define __NR_vfork		189
-#define __NR_ugetrlimit		190	/* SuS compliant getrlimit */
-#define __NR_readahead		191
-#ifndef __powerpc64__			/* these are 32-bit only */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#endif
-#define __NR_pciconfig_read	198
-#define __NR_pciconfig_write	199
-#define __NR_pciconfig_iobase	200
-#define __NR_multiplexer	201
-#define __NR_getdents64		202
-#define __NR_pivot_root		203
-#ifndef __powerpc64__
-#define __NR_fcntl64		204
-#endif
-#define __NR_madvise		205
-#define __NR_mincore		206
-#define __NR_gettid		207
-#define __NR_tkill		208
-#define __NR_setxattr		209
-#define __NR_lsetxattr		210
-#define __NR_fsetxattr		211
-#define __NR_getxattr		212
-#define __NR_lgetxattr		213
-#define __NR_fgetxattr		214
-#define __NR_listxattr		215
-#define __NR_llistxattr		216
-#define __NR_flistxattr		217
-#define __NR_removexattr	218
-#define __NR_lremovexattr	219
-#define __NR_fremovexattr	220
-#define __NR_futex		221
-#define __NR_sched_setaffinity	222
-#define __NR_sched_getaffinity	223
-/* 224 currently unused */
-#define __NR_tuxcall		225
 #ifndef __powerpc64__
-#define __NR_sendfile64		226
-#endif
-#define __NR_io_setup		227
-#define __NR_io_destroy		228
-#define __NR_io_getevents	229
-#define __NR_io_submit		230
-#define __NR_io_cancel		231
-#define __NR_set_tid_address	232
-#define __NR_fadvise64		233
-#define __NR_exit_group		234
-#define __NR_lookup_dcookie	235
-#define __NR_epoll_create	236
-#define __NR_epoll_ctl		237
-#define __NR_epoll_wait		238
-#define __NR_remap_file_pages	239
-#define __NR_timer_create	240
-#define __NR_timer_settime	241
-#define __NR_timer_gettime	242
-#define __NR_timer_getoverrun	243
-#define __NR_timer_delete	244
-#define __NR_clock_settime	245
-#define __NR_clock_gettime	246
-#define __NR_clock_getres	247
-#define __NR_clock_nanosleep	248
-#define __NR_swapcontext	249
-#define __NR_tgkill		250
-#define __NR_utimes		251
-#define __NR_statfs64		252
-#define __NR_fstatfs64		253
-#ifndef __powerpc64__
-#define __NR_fadvise64_64	254
-#endif
-#define __NR_rtas		255
-#define __NR_sys_debug_setcontext 256
-/* Number 257 is reserved for vserver */
-#define __NR_migrate_pages	258
-#define __NR_mbind		259
-#define __NR_get_mempolicy	260
-#define __NR_set_mempolicy	261
-#define __NR_mq_open		262
-#define __NR_mq_unlink		263
-#define __NR_mq_timedsend	264
-#define __NR_mq_timedreceive	265
-#define __NR_mq_notify		266
-#define __NR_mq_getsetattr	267
-#define __NR_kexec_load		268
-#define __NR_add_key		269
-#define __NR_request_key	270
-#define __NR_keyctl		271
-#define __NR_waitid		272
-#define __NR_ioprio_set		273
-#define __NR_ioprio_get		274
-#define __NR_inotify_init	275
-#define __NR_inotify_add_watch	276
-#define __NR_inotify_rm_watch	277
-#define __NR_spu_run		278
-#define __NR_spu_create		279
-#define __NR_pselect6		280
-#define __NR_ppoll		281
-#define __NR_unshare		282
-#define __NR_splice		283
-#define __NR_tee		284
-#define __NR_vmsplice		285
-#define __NR_openat		286
-#define __NR_mkdirat		287
-#define __NR_mknodat		288
-#define __NR_fchownat		289
-#define __NR_futimesat		290
-#ifdef __powerpc64__
-#define __NR_newfstatat		291
+#include <asm/unistd_32.h>
 #else
-#define __NR_fstatat64		291
+#include <asm/unistd_64.h>
 #endif
-#define __NR_unlinkat		292
-#define __NR_renameat		293
-#define __NR_linkat		294
-#define __NR_symlinkat		295
-#define __NR_readlinkat		296
-#define __NR_fchmodat		297
-#define __NR_faccessat		298
-#define __NR_get_robust_list	299
-#define __NR_set_robust_list	300
-#define __NR_move_pages		301
-#define __NR_getcpu		302
-#define __NR_epoll_pwait	303
-#define __NR_utimensat		304
-#define __NR_signalfd		305
-#define __NR_timerfd_create	306
-#define __NR_eventfd		307
-#define __NR_sync_file_range2	308
-#define __NR_fallocate		309
-#define __NR_subpage_prot	310
-#define __NR_timerfd_settime	311
-#define __NR_timerfd_gettime	312
-#define __NR_signalfd4		313
-#define __NR_eventfd2		314
-#define __NR_epoll_create1	315
-#define __NR_dup3		316
-#define __NR_pipe2		317
-#define __NR_inotify_init1	318
-#define __NR_perf_event_open	319
-#define __NR_preadv		320
-#define __NR_pwritev		321
-#define __NR_rt_tgsigqueueinfo	322
-#define __NR_fanotify_init	323
-#define __NR_fanotify_mark	324
-#define __NR_prlimit64		325
-#define __NR_socket		326
-#define __NR_bind		327
-#define __NR_connect		328
-#define __NR_listen		329
-#define __NR_accept		330
-#define __NR_getsockname	331
-#define __NR_getpeername	332
-#define __NR_socketpair		333
-#define __NR_send		334
-#define __NR_sendto		335
-#define __NR_recv		336
-#define __NR_recvfrom		337
-#define __NR_shutdown		338
-#define __NR_setsockopt		339
-#define __NR_getsockopt		340
-#define __NR_sendmsg		341
-#define __NR_recvmsg		342
-#define __NR_recvmmsg		343
-#define __NR_accept4		344
-#define __NR_name_to_handle_at	345
-#define __NR_open_by_handle_at	346
-#define __NR_clock_adjtime	347
-#define __NR_syncfs		348
-#define __NR_sendmmsg		349
-#define __NR_setns		350
-#define __NR_process_vm_readv	351
-#define __NR_process_vm_writev	352
-#define __NR_finit_module	353
-#define __NR_kcmp		354
-#define __NR_sched_setattr	355
-#define __NR_sched_getattr	356
-#define __NR_renameat2		357
-#define __NR_seccomp		358
-#define __NR_getrandom		359
-#define __NR_memfd_create	360
-#define __NR_bpf		361
-#define __NR_execveat		362
-#define __NR_switch_endian	363
-#define __NR_userfaultfd	364
-#define __NR_membarrier		365
-#define __NR_mlock2		378
-#define __NR_copy_file_range	379
-#define __NR_preadv2		380
-#define __NR_pwritev2		381
-#define __NR_kexec_file_load	382
-#define __NR_statx		383
-#define __NR_pkey_alloc		384
-#define __NR_pkey_free		385
-#define __NR_pkey_mprotect	386
-#define __NR_rseq		387
-#define __NR_io_pgetevents	388
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
new file mode 100644
index 0000000000..b8403d700d
--- /dev/null
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -0,0 +1,381 @@
+#ifndef _ASM_POWERPC_UNISTD_32_H
+#define _ASM_POWERPC_UNISTD_32_H
+
+#define __NR_restart_syscall	0
+#define __NR_exit	1
+#define __NR_fork	2
+#define __NR_read	3
+#define __NR_write	4
+#define __NR_open	5
+#define __NR_close	6
+#define __NR_waitpid	7
+#define __NR_creat	8
+#define __NR_link	9
+#define __NR_unlink	10
+#define __NR_execve	11
+#define __NR_chdir	12
+#define __NR_time	13
+#define __NR_mknod	14
+#define __NR_chmod	15
+#define __NR_lchown	16
+#define __NR_break	17
+#define __NR_oldstat	18
+#define __NR_lseek	19
+#define __NR_getpid	20
+#define __NR_mount	21
+#define __NR_umount	22
+#define __NR_setuid	23
+#define __NR_getuid	24
+#define __NR_stime	25
+#define __NR_ptrace	26
+#define __NR_alarm	27
+#define __NR_oldfstat	28
+#define __NR_pause	29
+#define __NR_utime	30
+#define __NR_stty	31
+#define __NR_gtty	32
+#define __NR_access	33
+#define __NR_nice	34
+#define __NR_ftime	35
+#define __NR_sync	36
+#define __NR_kill	37
+#define __NR_rename	38
+#define __NR_mkdir	39
+#define __NR_rmdir	40
+#define __NR_dup	41
+#define __NR_pipe	42
+#define __NR_times	43
+#define __NR_prof	44
+#define __NR_brk	45
+#define __NR_setgid	46
+#define __NR_getgid	47
+#define __NR_signal	48
+#define __NR_geteuid	49
+#define __NR_getegid	50
+#define __NR_acct	51
+#define __NR_umount2	52
+#define __NR_lock	53
+#define __NR_ioctl	54
+#define __NR_fcntl	55
+#define __NR_mpx	56
+#define __NR_setpgid	57
+#define __NR_ulimit	58
+#define __NR_oldolduname	59
+#define __NR_umask	60
+#define __NR_chroot	61
+#define __NR_ustat	62
+#define __NR_dup2	63
+#define __NR_getppid	64
+#define __NR_getpgrp	65
+#define __NR_setsid	66
+#define __NR_sigaction	67
+#define __NR_sgetmask	68
+#define __NR_ssetmask	69
+#define __NR_setreuid	70
+#define __NR_setregid	71
+#define __NR_sigsuspend	72
+#define __NR_sigpending	73
+#define __NR_sethostname	74
+#define __NR_setrlimit	75
+#define __NR_getrlimit	76
+#define __NR_getrusage	77
+#define __NR_gettimeofday	78
+#define __NR_settimeofday	79
+#define __NR_getgroups	80
+#define __NR_setgroups	81
+#define __NR_select	82
+#define __NR_symlink	83
+#define __NR_oldlstat	84
+#define __NR_readlink	85
+#define __NR_uselib	86
+#define __NR_swapon	87
+#define __NR_reboot	88
+#define __NR_readdir	89
+#define __NR_mmap	90
+#define __NR_munmap	91
+#define __NR_truncate	92
+#define __NR_ftruncate	93
+#define __NR_fchmod	94
+#define __NR_fchown	95
+#define __NR_getpriority	96
+#define __NR_setpriority	97
+#define __NR_profil	98
+#define __NR_statfs	99
+#define __NR_fstatfs	100
+#define __NR_ioperm	101
+#define __NR_socketcall	102
+#define __NR_syslog	103
+#define __NR_setitimer	104
+#define __NR_getitimer	105
+#define __NR_stat	106
+#define __NR_lstat	107
+#define __NR_fstat	108
+#define __NR_olduname	109
+#define __NR_iopl	110
+#define __NR_vhangup	111
+#define __NR_idle	112
+#define __NR_vm86	113
+#define __NR_wait4	114
+#define __NR_swapoff	115
+#define __NR_sysinfo	116
+#define __NR_ipc	117
+#define __NR_fsync	118
+#define __NR_sigreturn	119
+#define __NR_clone	120
+#define __NR_setdomainname	121
+#define __NR_uname	122
+#define __NR_modify_ldt	123
+#define __NR_adjtimex	124
+#define __NR_mprotect	125
+#define __NR_sigprocmask	126
+#define __NR_create_module	127
+#define __NR_init_module	128
+#define __NR_delete_module	129
+#define __NR_get_kernel_syms	130
+#define __NR_quotactl	131
+#define __NR_getpgid	132
+#define __NR_fchdir	133
+#define __NR_bdflush	134
+#define __NR_sysfs	135
+#define __NR_personality	136
+#define __NR_afs_syscall	137
+#define __NR_setfsuid	138
+#define __NR_setfsgid	139
+#define __NR__llseek	140
+#define __NR_getdents	141
+#define __NR__newselect	142
+#define __NR_flock	143
+#define __NR_msync	144
+#define __NR_readv	145
+#define __NR_writev	146
+#define __NR_getsid	147
+#define __NR_fdatasync	148
+#define __NR__sysctl	149
+#define __NR_mlock	150
+#define __NR_munlock	151
+#define __NR_mlockall	152
+#define __NR_munlockall	153
+#define __NR_sched_setparam	154
+#define __NR_sched_getparam	155
+#define __NR_sched_setscheduler	156
+#define __NR_sched_getscheduler	157
+#define __NR_sched_yield	158
+#define __NR_sched_get_priority_max	159
+#define __NR_sched_get_priority_min	160
+#define __NR_sched_rr_get_interval	161
+#define __NR_nanosleep	162
+#define __NR_mremap	163
+#define __NR_setresuid	164
+#define __NR_getresuid	165
+#define __NR_query_module	166
+#define __NR_poll	167
+#define __NR_nfsservctl	168
+#define __NR_setresgid	169
+#define __NR_getresgid	170
+#define __NR_prctl	171
+#define __NR_rt_sigreturn	172
+#define __NR_rt_sigaction	173
+#define __NR_rt_sigprocmask	174
+#define __NR_rt_sigpending	175
+#define __NR_rt_sigtimedwait	176
+#define __NR_rt_sigqueueinfo	177
+#define __NR_rt_sigsuspend	178
+#define __NR_pread64	179
+#define __NR_pwrite64	180
+#define __NR_chown	181
+#define __NR_getcwd	182
+#define __NR_capget	183
+#define __NR_capset	184
+#define __NR_sigaltstack	185
+#define __NR_sendfile	186
+#define __NR_getpmsg	187
+#define __NR_putpmsg	188
+#define __NR_vfork	189
+#define __NR_ugetrlimit	190
+#define __NR_readahead	191
+#define __NR_mmap2	192
+#define __NR_truncate64	193
+#define __NR_ftruncate64	194
+#define __NR_stat64	195
+#define __NR_lstat64	196
+#define __NR_fstat64	197
+#define __NR_pciconfig_read	198
+#define __NR_pciconfig_write	199
+#define __NR_pciconfig_iobase	200
+#define __NR_multiplexer	201
+#define __NR_getdents64	202
+#define __NR_pivot_root	203
+#define __NR_fcntl64	204
+#define __NR_madvise	205
+#define __NR_mincore	206
+#define __NR_gettid	207
+#define __NR_tkill	208
+#define __NR_setxattr	209
+#define __NR_lsetxattr	210
+#define __NR_fsetxattr	211
+#define __NR_getxattr	212
+#define __NR_lgetxattr	213
+#define __NR_fgetxattr	214
+#define __NR_listxattr	215
+#define __NR_llistxattr	216
+#define __NR_flistxattr	217
+#define __NR_removexattr	218
+#define __NR_lremovexattr	219
+#define __NR_fremovexattr	220
+#define __NR_futex	221
+#define __NR_sched_setaffinity	222
+#define __NR_sched_getaffinity	223
+#define __NR_tuxcall	225
+#define __NR_sendfile64	226
+#define __NR_io_setup	227
+#define __NR_io_destroy	228
+#define __NR_io_getevents	229
+#define __NR_io_submit	230
+#define __NR_io_cancel	231
+#define __NR_set_tid_address	232
+#define __NR_fadvise64	233
+#define __NR_exit_group	234
+#define __NR_lookup_dcookie	235
+#define __NR_epoll_create	236
+#define __NR_epoll_ctl	237
+#define __NR_epoll_wait	238
+#define __NR_remap_file_pages	239
+#define __NR_timer_create	240
+#define __NR_timer_settime	241
+#define __NR_timer_gettime	242
+#define __NR_timer_getoverrun	243
+#define __NR_timer_delete	244
+#define __NR_clock_settime	245
+#define __NR_clock_gettime	246
+#define __NR_clock_getres	247
+#define __NR_clock_nanosleep	248
+#define __NR_swapcontext	249
+#define __NR_tgkill	250
+#define __NR_utimes	251
+#define __NR_statfs64	252
+#define __NR_fstatfs64	253
+#define __NR_fadvise64_64	254
+#define __NR_rtas	255
+#define __NR_sys_debug_setcontext	256
+#define __NR_migrate_pages	258
+#define __NR_mbind	259
+#define __NR_get_mempolicy	260
+#define __NR_set_mempolicy	261
+#define __NR_mq_open	262
+#define __NR_mq_unlink	263
+#define __NR_mq_timedsend	264
+#define __NR_mq_timedreceive	265
+#define __NR_mq_notify	266
+#define __NR_mq_getsetattr	267
+#define __NR_kexec_load	268
+#define __NR_add_key	269
+#define __NR_request_key	270
+#define __NR_keyctl	271
+#define __NR_waitid	272
+#define __NR_ioprio_set	273
+#define __NR_ioprio_get	274
+#define __NR_inotify_init	275
+#define __NR_inotify_add_watch	276
+#define __NR_inotify_rm_watch	277
+#define __NR_spu_run	278
+#define __NR_spu_create	279
+#define __NR_pselect6	280
+#define __NR_ppoll	281
+#define __NR_unshare	282
+#define __NR_splice	283
+#define __NR_tee	284
+#define __NR_vmsplice	285
+#define __NR_openat	286
+#define __NR_mkdirat	287
+#define __NR_mknodat	288
+#define __NR_fchownat	289
+#define __NR_futimesat	290
+#define __NR_fstatat64	291
+#define __NR_unlinkat	292
+#define __NR_renameat	293
+#define __NR_linkat	294
+#define __NR_symlinkat	295
+#define __NR_readlinkat	296
+#define __NR_fchmodat	297
+#define __NR_faccessat	298
+#define __NR_get_robust_list	299
+#define __NR_set_robust_list	300
+#define __NR_move_pages	301
+#define __NR_getcpu	302
+#define __NR_epoll_pwait	303
+#define __NR_utimensat	304
+#define __NR_signalfd	305
+#define __NR_timerfd_create	306
+#define __NR_eventfd	307
+#define __NR_sync_file_range2	308
+#define __NR_fallocate	309
+#define __NR_subpage_prot	310
+#define __NR_timerfd_settime	311
+#define __NR_timerfd_gettime	312
+#define __NR_signalfd4	313
+#define __NR_eventfd2	314
+#define __NR_epoll_create1	315
+#define __NR_dup3	316
+#define __NR_pipe2	317
+#define __NR_inotify_init1	318
+#define __NR_perf_event_open	319
+#define __NR_preadv	320
+#define __NR_pwritev	321
+#define __NR_rt_tgsigqueueinfo	322
+#define __NR_fanotify_init	323
+#define __NR_fanotify_mark	324
+#define __NR_prlimit64	325
+#define __NR_socket	326
+#define __NR_bind	327
+#define __NR_connect	328
+#define __NR_listen	329
+#define __NR_accept	330
+#define __NR_getsockname	331
+#define __NR_getpeername	332
+#define __NR_socketpair	333
+#define __NR_send	334
+#define __NR_sendto	335
+#define __NR_recv	336
+#define __NR_recvfrom	337
+#define __NR_shutdown	338
+#define __NR_setsockopt	339
+#define __NR_getsockopt	340
+#define __NR_sendmsg	341
+#define __NR_recvmsg	342
+#define __NR_recvmmsg	343
+#define __NR_accept4	344
+#define __NR_name_to_handle_at	345
+#define __NR_open_by_handle_at	346
+#define __NR_clock_adjtime	347
+#define __NR_syncfs	348
+#define __NR_sendmmsg	349
+#define __NR_setns	350
+#define __NR_process_vm_readv	351
+#define __NR_process_vm_writev	352
+#define __NR_finit_module	353
+#define __NR_kcmp	354
+#define __NR_sched_setattr	355
+#define __NR_sched_getattr	356
+#define __NR_renameat2	357
+#define __NR_seccomp	358
+#define __NR_getrandom	359
+#define __NR_memfd_create	360
+#define __NR_bpf	361
+#define __NR_execveat	362
+#define __NR_switch_endian	363
+#define __NR_userfaultfd	364
+#define __NR_membarrier	365
+#define __NR_mlock2	378
+#define __NR_copy_file_range	379
+#define __NR_preadv2	380
+#define __NR_pwritev2	381
+#define __NR_kexec_file_load	382
+#define __NR_statx	383
+#define __NR_pkey_alloc	384
+#define __NR_pkey_free	385
+#define __NR_pkey_mprotect	386
+#define __NR_rseq	387
+#define __NR_io_pgetevents	388
+
+
+#endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
new file mode 100644
index 0000000000..f6a25fbbdd
--- /dev/null
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -0,0 +1,372 @@
+#ifndef _ASM_POWERPC_UNISTD_64_H
+#define _ASM_POWERPC_UNISTD_64_H
+
+#define __NR_restart_syscall	0
+#define __NR_exit	1
+#define __NR_fork	2
+#define __NR_read	3
+#define __NR_write	4
+#define __NR_open	5
+#define __NR_close	6
+#define __NR_waitpid	7
+#define __NR_creat	8
+#define __NR_link	9
+#define __NR_unlink	10
+#define __NR_execve	11
+#define __NR_chdir	12
+#define __NR_time	13
+#define __NR_mknod	14
+#define __NR_chmod	15
+#define __NR_lchown	16
+#define __NR_break	17
+#define __NR_oldstat	18
+#define __NR_lseek	19
+#define __NR_getpid	20
+#define __NR_mount	21
+#define __NR_umount	22
+#define __NR_setuid	23
+#define __NR_getuid	24
+#define __NR_stime	25
+#define __NR_ptrace	26
+#define __NR_alarm	27
+#define __NR_oldfstat	28
+#define __NR_pause	29
+#define __NR_utime	30
+#define __NR_stty	31
+#define __NR_gtty	32
+#define __NR_access	33
+#define __NR_nice	34
+#define __NR_ftime	35
+#define __NR_sync	36
+#define __NR_kill	37
+#define __NR_rename	38
+#define __NR_mkdir	39
+#define __NR_rmdir	40
+#define __NR_dup	41
+#define __NR_pipe	42
+#define __NR_times	43
+#define __NR_prof	44
+#define __NR_brk	45
+#define __NR_setgid	46
+#define __NR_getgid	47
+#define __NR_signal	48
+#define __NR_geteuid	49
+#define __NR_getegid	50
+#define __NR_acct	51
+#define __NR_umount2	52
+#define __NR_lock	53
+#define __NR_ioctl	54
+#define __NR_fcntl	55
+#define __NR_mpx	56
+#define __NR_setpgid	57
+#define __NR_ulimit	58
+#define __NR_oldolduname	59
+#define __NR_umask	60
+#define __NR_chroot	61
+#define __NR_ustat	62
+#define __NR_dup2	63
+#define __NR_getppid	64
+#define __NR_getpgrp	65
+#define __NR_setsid	66
+#define __NR_sigaction	67
+#define __NR_sgetmask	68
+#define __NR_ssetmask	69
+#define __NR_setreuid	70
+#define __NR_setregid	71
+#define __NR_sigsuspend	72
+#define __NR_sigpending	73
+#define __NR_sethostname	74
+#define __NR_setrlimit	75
+#define __NR_getrlimit	76
+#define __NR_getrusage	77
+#define __NR_gettimeofday	78
+#define __NR_settimeofday	79
+#define __NR_getgroups	80
+#define __NR_setgroups	81
+#define __NR_select	82
+#define __NR_symlink	83
+#define __NR_oldlstat	84
+#define __NR_readlink	85
+#define __NR_uselib	86
+#define __NR_swapon	87
+#define __NR_reboot	88
+#define __NR_readdir	89
+#define __NR_mmap	90
+#define __NR_munmap	91
+#define __NR_truncate	92
+#define __NR_ftruncate	93
+#define __NR_fchmod	94
+#define __NR_fchown	95
+#define __NR_getpriority	96
+#define __NR_setpriority	97
+#define __NR_profil	98
+#define __NR_statfs	99
+#define __NR_fstatfs	100
+#define __NR_ioperm	101
+#define __NR_socketcall	102
+#define __NR_syslog	103
+#define __NR_setitimer	104
+#define __NR_getitimer	105
+#define __NR_stat	106
+#define __NR_lstat	107
+#define __NR_fstat	108
+#define __NR_olduname	109
+#define __NR_iopl	110
+#define __NR_vhangup	111
+#define __NR_idle	112
+#define __NR_vm86	113
+#define __NR_wait4	114
+#define __NR_swapoff	115
+#define __NR_sysinfo	116
+#define __NR_ipc	117
+#define __NR_fsync	118
+#define __NR_sigreturn	119
+#define __NR_clone	120
+#define __NR_setdomainname	121
+#define __NR_uname	122
+#define __NR_modify_ldt	123
+#define __NR_adjtimex	124
+#define __NR_mprotect	125
+#define __NR_sigprocmask	126
+#define __NR_create_module	127
+#define __NR_init_module	128
+#define __NR_delete_module	129
+#define __NR_get_kernel_syms	130
+#define __NR_quotactl	131
+#define __NR_getpgid	132
+#define __NR_fchdir	133
+#define __NR_bdflush	134
+#define __NR_sysfs	135
+#define __NR_personality	136
+#define __NR_afs_syscall	137
+#define __NR_setfsuid	138
+#define __NR_setfsgid	139
+#define __NR__llseek	140
+#define __NR_getdents	141
+#define __NR__newselect	142
+#define __NR_flock	143
+#define __NR_msync	144
+#define __NR_readv	145
+#define __NR_writev	146
+#define __NR_getsid	147
+#define __NR_fdatasync	148
+#define __NR__sysctl	149
+#define __NR_mlock	150
+#define __NR_munlock	151
+#define __NR_mlockall	152
+#define __NR_munlockall	153
+#define __NR_sched_setparam	154
+#define __NR_sched_getparam	155
+#define __NR_sched_setscheduler	156
+#define __NR_sched_getscheduler	157
+#define __NR_sched_yield	158
+#define __NR_sched_get_priority_max	159
+#define __NR_sched_get_priority_min	160
+#define __NR_sched_rr_get_interval	161
+#define __NR_nanosleep	162
+#define __NR_mremap	163
+#define __NR_setresuid	164
+#define __NR_getresuid	165
+#define __NR_query_module	166
+#define __NR_poll	167
+#define __NR_nfsservctl	168
+#define __NR_setresgid	169
+#define __NR_getresgid	170
+#define __NR_prctl	171
+#define __NR_rt_sigreturn	172
+#define __NR_rt_sigaction	173
+#define __NR_rt_sigprocmask	174
+#define __NR_rt_sigpending	175
+#define __NR_rt_sigtimedwait	176
+#define __NR_rt_sigqueueinfo	177
+#define __NR_rt_sigsuspend	178
+#define __NR_pread64	179
+#define __NR_pwrite64	180
+#define __NR_chown	181
+#define __NR_getcwd	182
+#define __NR_capget	183
+#define __NR_capset	184
+#define __NR_sigaltstack	185
+#define __NR_sendfile	186
+#define __NR_getpmsg	187
+#define __NR_putpmsg	188
+#define __NR_vfork	189
+#define __NR_ugetrlimit	190
+#define __NR_readahead	191
+#define __NR_pciconfig_read	198
+#define __NR_pciconfig_write	199
+#define __NR_pciconfig_iobase	200
+#define __NR_multiplexer	201
+#define __NR_getdents64	202
+#define __NR_pivot_root	203
+#define __NR_madvise	205
+#define __NR_mincore	206
+#define __NR_gettid	207
+#define __NR_tkill	208
+#define __NR_setxattr	209
+#define __NR_lsetxattr	210
+#define __NR_fsetxattr	211
+#define __NR_getxattr	212
+#define __NR_lgetxattr	213
+#define __NR_fgetxattr	214
+#define __NR_listxattr	215
+#define __NR_llistxattr	216
+#define __NR_flistxattr	217
+#define __NR_removexattr	218
+#define __NR_lremovexattr	219
+#define __NR_fremovexattr	220
+#define __NR_futex	221
+#define __NR_sched_setaffinity	222
+#define __NR_sched_getaffinity	223
+#define __NR_tuxcall	225
+#define __NR_io_setup	227
+#define __NR_io_destroy	228
+#define __NR_io_getevents	229
+#define __NR_io_submit	230
+#define __NR_io_cancel	231
+#define __NR_set_tid_address	232
+#define __NR_fadvise64	233
+#define __NR_exit_group	234
+#define __NR_lookup_dcookie	235
+#define __NR_epoll_create	236
+#define __NR_epoll_ctl	237
+#define __NR_epoll_wait	238
+#define __NR_remap_file_pages	239
+#define __NR_timer_create	240
+#define __NR_timer_settime	241
+#define __NR_timer_gettime	242
+#define __NR_timer_getoverrun	243
+#define __NR_timer_delete	244
+#define __NR_clock_settime	245
+#define __NR_clock_gettime	246
+#define __NR_clock_getres	247
+#define __NR_clock_nanosleep	248
+#define __NR_swapcontext	249
+#define __NR_tgkill	250
+#define __NR_utimes	251
+#define __NR_statfs64	252
+#define __NR_fstatfs64	253
+#define __NR_rtas	255
+#define __NR_sys_debug_setcontext	256
+#define __NR_migrate_pages	258
+#define __NR_mbind	259
+#define __NR_get_mempolicy	260
+#define __NR_set_mempolicy	261
+#define __NR_mq_open	262
+#define __NR_mq_unlink	263
+#define __NR_mq_timedsend	264
+#define __NR_mq_timedreceive	265
+#define __NR_mq_notify	266
+#define __NR_mq_getsetattr	267
+#define __NR_kexec_load	268
+#define __NR_add_key	269
+#define __NR_request_key	270
+#define __NR_keyctl	271
+#define __NR_waitid	272
+#define __NR_ioprio_set	273
+#define __NR_ioprio_get	274
+#define __NR_inotify_init	275
+#define __NR_inotify_add_watch	276
+#define __NR_inotify_rm_watch	277
+#define __NR_spu_run	278
+#define __NR_spu_create	279
+#define __NR_pselect6	280
+#define __NR_ppoll	281
+#define __NR_unshare	282
+#define __NR_splice	283
+#define __NR_tee	284
+#define __NR_vmsplice	285
+#define __NR_openat	286
+#define __NR_mkdirat	287
+#define __NR_mknodat	288
+#define __NR_fchownat	289
+#define __NR_futimesat	290
+#define __NR_newfstatat	291
+#define __NR_unlinkat	292
+#define __NR_renameat	293
+#define __NR_linkat	294
+#define __NR_symlinkat	295
+#define __NR_readlinkat	296
+#define __NR_fchmodat	297
+#define __NR_faccessat	298
+#define __NR_get_robust_list	299
+#define __NR_set_robust_list	300
+#define __NR_move_pages	301
+#define __NR_getcpu	302
+#define __NR_epoll_pwait	303
+#define __NR_utimensat	304
+#define __NR_signalfd	305
+#define __NR_timerfd_create	306
+#define __NR_eventfd	307
+#define __NR_sync_file_range2	308
+#define __NR_fallocate	309
+#define __NR_subpage_prot	310
+#define __NR_timerfd_settime	311
+#define __NR_timerfd_gettime	312
+#define __NR_signalfd4	313
+#define __NR_eventfd2	314
+#define __NR_epoll_create1	315
+#define __NR_dup3	316
+#define __NR_pipe2	317
+#define __NR_inotify_init1	318
+#define __NR_perf_event_open	319
+#define __NR_preadv	320
+#define __NR_pwritev	321
+#define __NR_rt_tgsigqueueinfo	322
+#define __NR_fanotify_init	323
+#define __NR_fanotify_mark	324
+#define __NR_prlimit64	325
+#define __NR_socket	326
+#define __NR_bind	327
+#define __NR_connect	328
+#define __NR_listen	329
+#define __NR_accept	330
+#define __NR_getsockname	331
+#define __NR_getpeername	332
+#define __NR_socketpair	333
+#define __NR_send	334
+#define __NR_sendto	335
+#define __NR_recv	336
+#define __NR_recvfrom	337
+#define __NR_shutdown	338
+#define __NR_setsockopt	339
+#define __NR_getsockopt	340
+#define __NR_sendmsg	341
+#define __NR_recvmsg	342
+#define __NR_recvmmsg	343
+#define __NR_accept4	344
+#define __NR_name_to_handle_at	345
+#define __NR_open_by_handle_at	346
+#define __NR_clock_adjtime	347
+#define __NR_syncfs	348
+#define __NR_sendmmsg	349
+#define __NR_setns	350
+#define __NR_process_vm_readv	351
+#define __NR_process_vm_writev	352
+#define __NR_finit_module	353
+#define __NR_kcmp	354
+#define __NR_sched_setattr	355
+#define __NR_sched_getattr	356
+#define __NR_renameat2	357
+#define __NR_seccomp	358
+#define __NR_getrandom	359
+#define __NR_memfd_create	360
+#define __NR_bpf	361
+#define __NR_execveat	362
+#define __NR_switch_endian	363
+#define __NR_userfaultfd	364
+#define __NR_membarrier	365
+#define __NR_mlock2	378
+#define __NR_copy_file_range	379
+#define __NR_preadv2	380
+#define __NR_pwritev2	381
+#define __NR_kexec_file_load	382
+#define __NR_statx	383
+#define __NR_pkey_alloc	384
+#define __NR_pkey_free	385
+#define __NR_pkey_mprotect	386
+#define __NR_rseq	387
+#define __NR_io_pgetevents	388
+
+
+#endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f11a7eb49c..b53ee59748 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -492,6 +492,17 @@ struct kvm_dirty_log {
 	};
 };
 
+/* for KVM_CLEAR_DIRTY_LOG */
+struct kvm_clear_dirty_log {
+	__u32 slot;
+	__u32 num_pages;
+	__u64 first_page;
+	union {
+		void *dirty_bitmap; /* one bit per page */
+		__u64 padding2;
+	};
+};
+
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
@@ -757,6 +768,15 @@ struct kvm_ppc_resize_hpt {
 
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
@@ -965,6 +985,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_COALESCED_PIO 162
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
+#define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_HYPERV_CPUID 167
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1411,6 +1434,12 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+#define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
+
+/* Available with KVM_CAP_HYPERV_CPUID */
+#define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453394..12a7b1dc53 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -303,6 +303,71 @@ struct vfio_region_info_cap_type {
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
+/*
+ * 10de vendor sub-type
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
@@ -313,6 +378,33 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
 
+/*
+ * Capability with compressed real address (aka SSA - small system address)
+ * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing
+ * and by the userspace to associate a NVLink bridge with a GPU.
+ */
+#define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT	4
+
+struct vfio_region_info_cap_nvlink2_ssatgt {
+	struct vfio_info_cap_header header;
+	__u64 tgt;
+};
+
+/*
+ * Capability with an NVLink link speed. The value is read by
+ * the NVlink2 bridge driver from the bridge's "ibm,nvlink-speed"
+ * property in the device tree. The value is fixed in the hardware
+ * and failing to provide the correct value results in the link
+ * not working with no indication from the driver why.
+ */
+#define VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD	5
+
+struct vfio_region_info_cap_nvlink2_lnkspd {
+	struct vfio_info_cap_header header;
+	__u32 link_speed;
+	__u32 __pad;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index c8a8fbeb81..40d028eed6 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -11,94 +11,9 @@
  * device configuration.
  */
 
+#include <linux/vhost_types.h>
 #include <linux/types.h>
-
 #include <linux/ioctl.h>
-#include <linux/virtio_config.h>
-#include <linux/virtio_ring.h>
-
-struct vhost_vring_state {
-	unsigned int index;
-	unsigned int num;
-};
-
-struct vhost_vring_file {
-	unsigned int index;
-	int fd; /* Pass -1 to unbind from file. */
-
-};
-
-struct vhost_vring_addr {
-	unsigned int index;
-	/* Option flags. */
-	unsigned int flags;
-	/* Flag values: */
-	/* Whether log address is valid. If set enables logging. */
-#define VHOST_VRING_F_LOG 0
-
-	/* Start of array of descriptors (virtually contiguous) */
-	__u64 desc_user_addr;
-	/* Used structure address. Must be 32 bit aligned */
-	__u64 used_user_addr;
-	/* Available structure address. Must be 16 bit aligned */
-	__u64 avail_user_addr;
-	/* Logging support. */
-	/* Log writes to used structure, at offset calculated from specified
-	 * address. Address must be 32 bit aligned. */
-	__u64 log_guest_addr;
-};
-
-/* no alignment requirement */
-struct vhost_iotlb_msg {
-	__u64 iova;
-	__u64 size;
-	__u64 uaddr;
-#define VHOST_ACCESS_RO      0x1
-#define VHOST_ACCESS_WO      0x2
-#define VHOST_ACCESS_RW      0x3
-	__u8 perm;
-#define VHOST_IOTLB_MISS           1
-#define VHOST_IOTLB_UPDATE         2
-#define VHOST_IOTLB_INVALIDATE     3
-#define VHOST_IOTLB_ACCESS_FAIL    4
-	__u8 type;
-};
-
-#define VHOST_IOTLB_MSG 0x1
-#define VHOST_IOTLB_MSG_V2 0x2
-
-struct vhost_msg {
-	int type;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_msg_v2 {
-	__u32 type;
-	__u32 reserved;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_memory_region {
-	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-	__u64 userspace_addr;
-	__u64 flags_padding; /* No flags are currently specified. */
-};
-
-/* All region addresses and sizes must be 4K aligned. */
-#define VHOST_PAGE_SIZE 0x1000
-
-struct vhost_memory {
-	__u32 nregions;
-	__u32 padding;
-	struct vhost_memory_region regions[0];
-};
 
 /* ioctls */
 
@@ -186,31 +101,7 @@ struct vhost_memory {
  * device.  This can be used to stop the ring (e.g. for migration). */
 #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
 
-/* Feature bits */
-/* Log all write descriptors. Can be changed while device is active. */
-#define VHOST_F_LOG_ALL 26
-/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
-#define VHOST_NET_F_VIRTIO_NET_HDR 27
-
-/* VHOST_SCSI specific definitions */
-
-/*
- * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
- *
- * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
- *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
- * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
- *            All the targets under vhost_wwpn can be seen and used by guset.
- */
-
-#define VHOST_SCSI_ABI_VERSION	1
-
-struct vhost_scsi_target {
-	int abi_version;
-	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
-	unsigned short vhost_tpgt;
-	unsigned short reserved;
-};
+/* VHOST_SCSI specific defines */
 
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
 #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
diff --git a/linux-headers/linux/vhost_types.h b/linux-headers/linux/vhost_types.h
new file mode 100644
index 0000000000..93c17ae58a
--- /dev/null
+++ b/linux-headers/linux/vhost_types.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_VHOST_TYPES_H
+#define _LINUX_VHOST_TYPES_H
+/* Userspace interface for in-kernel virtio accelerators. */
+
+/* vhost is used to reduce the number of system calls involved in virtio.
+ *
+ * Existing virtio net code is used in the guest without modification.
+ *
+ * This header includes interface used by userspace hypervisor for
+ * device configuration.
+ */
+
+#include <linux/types.h>
+
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+
+struct vhost_vring_state {
+	unsigned int index;
+	unsigned int num;
+};
+
+struct vhost_vring_file {
+	unsigned int index;
+	int fd; /* Pass -1 to unbind from file. */
+
+};
+
+struct vhost_vring_addr {
+	unsigned int index;
+	/* Option flags. */
+	unsigned int flags;
+	/* Flag values: */
+	/* Whether log address is valid. If set enables logging. */
+#define VHOST_VRING_F_LOG 0
+
+	/* Start of array of descriptors (virtually contiguous) */
+	__u64 desc_user_addr;
+	/* Used structure address. Must be 32 bit aligned */
+	__u64 used_user_addr;
+	/* Available structure address. Must be 16 bit aligned */
+	__u64 avail_user_addr;
+	/* Logging support. */
+	/* Log writes to used structure, at offset calculated from specified
+	 * address. Address must be 32 bit aligned. */
+	__u64 log_guest_addr;
+};
+
+/* no alignment requirement */
+struct vhost_iotlb_msg {
+	__u64 iova;
+	__u64 size;
+	__u64 uaddr;
+#define VHOST_ACCESS_RO      0x1
+#define VHOST_ACCESS_WO      0x2
+#define VHOST_ACCESS_RW      0x3
+	__u8 perm;
+#define VHOST_IOTLB_MISS           1
+#define VHOST_IOTLB_UPDATE         2
+#define VHOST_IOTLB_INVALIDATE     3
+#define VHOST_IOTLB_ACCESS_FAIL    4
+	__u8 type;
+};
+
+#define VHOST_IOTLB_MSG 0x1
+#define VHOST_IOTLB_MSG_V2 0x2
+
+struct vhost_msg {
+	int type;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
+struct vhost_msg_v2 {
+	__u32 type;
+	__u32 reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
+struct vhost_memory_region {
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+	__u64 userspace_addr;
+	__u64 flags_padding; /* No flags are currently specified. */
+};
+
+/* All region addresses and sizes must be 4K aligned. */
+#define VHOST_PAGE_SIZE 0x1000
+
+struct vhost_memory {
+	__u32 nregions;
+	__u32 padding;
+	struct vhost_memory_region regions[0];
+};
+
+/* VHOST_SCSI specific definitions */
+
+/*
+ * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
+ *
+ * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
+ *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
+ * ABI Rev 1: January 2013. Ignore vhost_tpgt field in struct vhost_scsi_target.
+ *            All the targets under vhost_wwpn can be seen and used by guset.
+ */
+
+#define VHOST_SCSI_ABI_VERSION	1
+
+struct vhost_scsi_target {
+	int abi_version;
+	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
+	unsigned short vhost_tpgt;
+	unsigned short reserved;
+};
+
+/* Feature bits */
+/* Log all write descriptors. Can be changed while device is active. */
+#define VHOST_F_LOG_ALL 26
+/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
+#define VHOST_NET_F_VIRTIO_NET_HDR 27
+
+#endif
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe240..58b25d4a39 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -121,11 +121,19 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
         cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
     fi
+    if [ $arch = mips ]; then
+        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
+	cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
+    fi
+    if [ $arch = powerpc ]; then
+        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
+	cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
+    fi
 done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h vfio.h vfio_ccw.h vhost.h \
+for header in kvm.h vfio.h vfio_ccw.h vhost.h vhost_types.h \
               psci.h psp-sev.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-- 
2.20.1
