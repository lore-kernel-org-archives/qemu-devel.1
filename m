Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClM-0006OG-1c
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClG-0000sc-FI
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:08 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fMClF-0000p1-Qm
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:27:54 +0100
Message-Id: <20180525132755.21839-6-peter.maydell@linaro.org>
In-Reply-To: <20180525132755.21839-1-peter.maydell@linaro.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] Update Linux headers to 4.17-rc6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Update our copy of the Linux headers to upstream 4.17-rc6
(kernel commit 771c577c23bac90597c68).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/standard-headers/asm-x86/hyperv.h     |   1 -
 include/standard-headers/asm-x86/kvm_para.h   |   2 +-
 include/standard-headers/linux/ethtool.h      |  36 +-
 include/standard-headers/linux/input.h        |   4 +-
 include/standard-headers/linux/pci_regs.h     |   7 +-
 .../standard-headers/linux/virtio_balloon.h   |  15 +
 include/standard-headers/linux/virtio_gpu.h   |   1 -
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  49 +--
 linux-headers/asm-arm/kvm.h                   |  15 +
 linux-headers/asm-arm64/kvm.h                 |   6 +
 linux-headers/asm-x86/hyperv.h                |   1 -
 linux-headers/asm-x86/kvm.h                   |  19 +-
 linux-headers/linux/kvm.h                     |  30 +-
 linux-headers/linux/vfio.h                    |  27 ++
 linux-headers/COPYING                         | 358 +-----------------
 .../LICENSES/exceptions/Linux-syscall-note    |  25 ++
 linux-headers/LICENSES/preferred/BSD-2-Clause |  32 ++
 linux-headers/LICENSES/preferred/BSD-3-Clause |  36 ++
 .../{COPYING => LICENSES/preferred/GPL-2.0}   |  27 +-
 19 files changed, 287 insertions(+), 404 deletions(-)
 delete mode 100644 include/standard-headers/asm-x86/hyperv.h
 delete mode 100644 linux-headers/asm-x86/hyperv.h
 create mode 100644 linux-headers/LICENSES/exceptions/Linux-syscall-note
 create mode 100644 linux-headers/LICENSES/preferred/BSD-2-Clause
 create mode 100644 linux-headers/LICENSES/preferred/BSD-3-Clause
 copy linux-headers/{COPYING => LICENSES/preferred/GPL-2.0} (96%)

diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
deleted file mode 100644
index ce87d0c344..0000000000
--- a/include/standard-headers/asm-x86/hyperv.h
+++ /dev/null
@@ -1 +0,0 @@
-        /* this is a temporary placeholder until kvm_para.h stops including it */
diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
index 53a85ae3ed..1617c84b0d 100644
--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -29,7 +29,7 @@
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 
-#define KVM_HINTS_DEDICATED      0
+#define KVM_HINTS_REALTIME      0
 
 /* The last 8 bits are used to indicate how to interpret the flags field
  * in pvclock structure. If no bits are set, all flags are ignored.
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 94aacb7adf..eb10c075e4 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -217,10 +217,14 @@ struct ethtool_value {
 	uint32_t	data;
 };
 
+#define PFC_STORM_PREVENTION_AUTO	0xffff
+#define PFC_STORM_PREVENTION_DISABLE	0
+
 enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
+	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	/*
 	 * Add your fresh new tubale attribute above and remember to update
 	 * tunable_strings[] in net/core/ethtool.c
@@ -914,12 +918,15 @@ static inline uint64_t ethtool_get_flow_spec_ring_vf(uint64_t ring_cookie)
  * @flow_type: Type of flow to be affected, e.g. %TCP_V4_FLOW
  * @data: Command-dependent value
  * @fs: Flow classification rule
+ * @rss_context: RSS context to be affected
  * @rule_cnt: Number of rules to be affected
  * @rule_locs: Array of used rule locations
  *
  * For %ETHTOOL_GRXFH and %ETHTOOL_SRXFH, @data is a bitmask indicating
  * the fields included in the flow hash, e.g. %RXH_IP_SRC.  The following
- * structure fields must not be used.
+ * structure fields must not be used, except that if @flow_type includes
+ * the %FLOW_RSS flag, then @rss_context determines which RSS context to
+ * act on.
  *
  * For %ETHTOOL_GRXRINGS, @data is set to the number of RX rings/queues
  * on return.
@@ -931,7 +938,9 @@ static inline uint64_t ethtool_get_flow_spec_ring_vf(uint64_t ring_cookie)
  * set in @data then special location values should not be used.
  *
  * For %ETHTOOL_GRXCLSRULE, @fs.@location specifies the location of an
- * existing rule on entry and @fs contains the rule on return.
+ * existing rule on entry and @fs contains the rule on return; if
+ * @fs.@flow_type includes the %FLOW_RSS flag, then @rss_context is
+ * filled with the RSS context ID associated with the rule.
  *
  * For %ETHTOOL_GRXCLSRLALL, @rule_cnt specifies the array size of the
  * user buffer for @rule_locs on entry.  On return, @data is the size
@@ -942,7 +951,11 @@ static inline uint64_t ethtool_get_flow_spec_ring_vf(uint64_t ring_cookie)
  * For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
  * @fs.@location either specifies the location to use or is a special
  * location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
- * @fs.@location is the actual rule location.
+ * @fs.@location is the actual rule location.  If @fs.@flow_type
+ * includes the %FLOW_RSS flag, @rss_context is the RSS context ID to
+ * use for flow spreading traffic which matches this rule.  The value
+ * from the rxfh indirection table will be added to @fs.@ring_cookie
+ * to choose which ring to deliver to.
  *
  * For %ETHTOOL_SRXCLSRLDEL, @fs.@location specifies the location of an
  * existing rule on entry.
@@ -963,7 +976,10 @@ struct ethtool_rxnfc {
 	uint32_t				flow_type;
 	uint64_t				data;
 	struct ethtool_rx_flow_spec	fs;
-	uint32_t				rule_cnt;
+	union {
+		uint32_t			rule_cnt;
+		uint32_t			rss_context;
+	};
 	uint32_t				rule_locs[0];
 };
 
@@ -990,7 +1006,11 @@ struct ethtool_rxfh_indir {
 /**
  * struct ethtool_rxfh - command to get/set RX flow hash indir or/and hash key.
  * @cmd: Specific command number - %ETHTOOL_GRSSH or %ETHTOOL_SRSSH
- * @rss_context: RSS context identifier.
+ * @rss_context: RSS context identifier.  Context 0 is the default for normal
+ *	traffic; other contexts can be referenced as the destination for RX flow
+ *	classification rules.  %ETH_RXFH_CONTEXT_ALLOC is used with command
+ *	%ETHTOOL_SRSSH to allocate a new RSS context; on return this field will
+ *	contain the ID of the newly allocated context.
  * @indir_size: On entry, the array size of the user buffer for the
  *	indirection table, which may be zero, or (for %ETHTOOL_SRSSH),
  *	%ETH_RXFH_INDIR_NO_CHANGE.  On return from %ETHTOOL_GRSSH,
@@ -1009,7 +1029,8 @@ struct ethtool_rxfh_indir {
  * size should be returned.  For %ETHTOOL_SRSSH, an @indir_size of
  * %ETH_RXFH_INDIR_NO_CHANGE means that indir table setting is not requested
  * and a @indir_size of zero means the indir table should be reset to default
- * values. An hfunc of zero means that hash function setting is not requested.
+ * values (if @rss_context == 0) or that the RSS context should be deleted.
+ * An hfunc of zero means that hash function setting is not requested.
  */
 struct ethtool_rxfh {
 	uint32_t   cmd;
@@ -1021,6 +1042,7 @@ struct ethtool_rxfh {
 	uint32_t	rsvd32;
 	uint32_t   rss_config[0];
 };
+#define ETH_RXFH_CONTEXT_ALLOC		0xffffffff
 #define ETH_RXFH_INDIR_NO_CHANGE	0xffffffff
 
 /**
@@ -1635,6 +1657,8 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
+/* Flag to enable RSS spreading of traffic matching rule (nfc only) */
+#define	FLOW_RSS	0x20000000
 
 /* L3-L4 network traffic flow hash options */
 #define	RXH_L2DA	(1 << 1)
diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index 939b62775c..6d6128c081 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -28,8 +28,8 @@ struct input_event {
 #define input_event_sec time.tv_sec
 #define input_event_usec time.tv_usec
 #else
-	__kernel_ulong_t __sec;
-	__kernel_ulong_t __usec;
+	unsigned long __sec;
+	unsigned long __usec;
 #define input_event_sec  __sec
 #define input_event_usec __usec
 #endif
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 0c79eac5e9..103ba797a8 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -520,6 +520,7 @@
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
+#define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -547,6 +548,7 @@
 #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -648,8 +650,9 @@
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
 #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5.0GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8.0GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index e446805ae9..4dbb7dc6c0 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -57,6 +57,21 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_NR       10
 
+#define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
+	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
+	VIRTIO_BALLOON_S_NAMES_prefix "swap-out", \
+	VIRTIO_BALLOON_S_NAMES_prefix "major-faults", \
+	VIRTIO_BALLOON_S_NAMES_prefix "minor-faults", \
+	VIRTIO_BALLOON_S_NAMES_prefix "free-memory", \
+	VIRTIO_BALLOON_S_NAMES_prefix "total-memory", \
+	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
+	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
+}
+
+#define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
+
 /*
  * Memory statistics structure.
  * Driver fills an array of these structures and passes to device.
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 52a830dcf8..c1c8f0751d 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -260,7 +260,6 @@ struct virtio_gpu_cmd_submit {
 };
 
 #define VIRTIO_GPU_CAPSET_VIRGL 1
-#define VIRTIO_GPU_CAPSET_VIRGL2 2
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/standard-headers/rdma/vmw_pvrdma-abi.h
index 07a820d337..6c2bc46116 100644
--- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
+++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
@@ -143,7 +143,7 @@ struct pvrdma_alloc_pd_resp {
 };
 
 struct pvrdma_create_cq {
-	uint64_t buf_addr;
+	uint64_t __attribute__((aligned(8))) buf_addr;
 	uint32_t buf_size;
 	uint32_t reserved;
 };
@@ -154,13 +154,13 @@ struct pvrdma_create_cq_resp {
 };
 
 struct pvrdma_resize_cq {
-	uint64_t buf_addr;
+	uint64_t __attribute__((aligned(8))) buf_addr;
 	uint32_t buf_size;
 	uint32_t reserved;
 };
 
 struct pvrdma_create_srq {
-	uint64_t buf_addr;
+	uint64_t __attribute__((aligned(8))) buf_addr;
 	uint32_t buf_size;
 	uint32_t reserved;
 };
@@ -171,25 +171,25 @@ struct pvrdma_create_srq_resp {
 };
 
 struct pvrdma_create_qp {
-	uint64_t rbuf_addr;
-	uint64_t sbuf_addr;
+	uint64_t __attribute__((aligned(8))) rbuf_addr;
+	uint64_t __attribute__((aligned(8))) sbuf_addr;
 	uint32_t rbuf_size;
 	uint32_t sbuf_size;
-	uint64_t qp_addr;
+	uint64_t __attribute__((aligned(8))) qp_addr;
 };
 
 /* PVRDMA masked atomic compare and swap */
 struct pvrdma_ex_cmp_swap {
-	uint64_t swap_val;
-	uint64_t compare_val;
-	uint64_t swap_mask;
-	uint64_t compare_mask;
+	uint64_t __attribute__((aligned(8))) swap_val;
+	uint64_t __attribute__((aligned(8))) compare_val;
+	uint64_t __attribute__((aligned(8))) swap_mask;
+	uint64_t __attribute__((aligned(8))) compare_mask;
 };
 
 /* PVRDMA masked atomic fetch and add */
 struct pvrdma_ex_fetch_add {
-	uint64_t add_val;
-	uint64_t field_boundary;
+	uint64_t __attribute__((aligned(8))) add_val;
+	uint64_t __attribute__((aligned(8))) field_boundary;
 };
 
 /* PVRDMA address vector. */
@@ -207,14 +207,14 @@ struct pvrdma_av {
 
 /* PVRDMA scatter/gather entry */
 struct pvrdma_sge {
-	uint64_t   addr;
+	uint64_t __attribute__((aligned(8))) addr;
 	uint32_t   length;
 	uint32_t   lkey;
 };
 
 /* PVRDMA receive queue work request */
 struct pvrdma_rq_wqe_hdr {
-	uint64_t wr_id;		/* wr id */
+	uint64_t __attribute__((aligned(8))) wr_id;		/* wr id */
 	uint32_t num_sge;		/* size of s/g array */
 	uint32_t total_len;	/* reserved */
 };
@@ -222,7 +222,7 @@ struct pvrdma_rq_wqe_hdr {
 
 /* PVRDMA send queue work request */
 struct pvrdma_sq_wqe_hdr {
-	uint64_t wr_id;		/* wr id */
+	uint64_t __attribute__((aligned(8))) wr_id;		/* wr id */
 	uint32_t num_sge;		/* size of s/g array */
 	uint32_t total_len;	/* reserved */
 	uint32_t opcode;		/* operation type */
@@ -234,19 +234,19 @@ struct pvrdma_sq_wqe_hdr {
 	uint32_t reserved;
 	union {
 		struct {
-			uint64_t remote_addr;
+			uint64_t __attribute__((aligned(8))) remote_addr;
 			uint32_t rkey;
 			uint8_t reserved[4];
 		} rdma;
 		struct {
-			uint64_t remote_addr;
-			uint64_t compare_add;
-			uint64_t swap;
+			uint64_t __attribute__((aligned(8))) remote_addr;
+			uint64_t __attribute__((aligned(8))) compare_add;
+			uint64_t __attribute__((aligned(8))) swap;
 			uint32_t rkey;
 			uint32_t reserved;
 		} atomic;
 		struct {
-			uint64_t remote_addr;
+			uint64_t __attribute__((aligned(8))) remote_addr;
 			uint32_t log_arg_sz;
 			uint32_t rkey;
 			union {
@@ -255,13 +255,14 @@ struct pvrdma_sq_wqe_hdr {
 			} wr_data;
 		} masked_atomics;
 		struct {
-			uint64_t iova_start;
-			uint64_t pl_pdir_dma;
+			uint64_t __attribute__((aligned(8))) iova_start;
+			uint64_t __attribute__((aligned(8))) pl_pdir_dma;
 			uint32_t page_shift;
 			uint32_t page_list_len;
 			uint32_t length;
 			uint32_t access_flags;
 			uint32_t rkey;
+			uint32_t reserved;
 		} fast_reg;
 		struct {
 			uint32_t remote_qpn;
@@ -274,8 +275,8 @@ struct pvrdma_sq_wqe_hdr {
 
 /* Completion queue element. */
 struct pvrdma_cqe {
-	uint64_t wr_id;
-	uint64_t qp;
+	uint64_t __attribute__((aligned(8))) wr_id;
+	uint64_t __attribute__((aligned(8))) qp;
 	uint32_t opcode;
 	uint32_t status;
 	uint32_t byte_len;
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 4392955081..670b43c9e9 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -135,6 +135,15 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_CRM_SHIFT		7
 #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
 #define KVM_REG_ARM_32_CRN_SHIFT	11
+/*
+ * For KVM currently all guest registers are nonsecure, but we reserve a bit
+ * in the encoding to distinguish secure from nonsecure for AArch32 system
+ * registers that are banked by security. This is 1 for the secure banked
+ * register, and 0 for the nonsecure banked register or if the register is
+ * not banked by security.
+ */
+#define KVM_REG_ARM_SECURE_MASK	0x0000000010000000
+#define KVM_REG_ARM_SECURE_SHIFT	28
 
 #define ARM_CP15_REG_SHIFT_MASK(x,n) \
 	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
@@ -186,6 +195,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_VFP_FPINST		0x1009
 #define KVM_REG_ARM_VFP_FPINST2		0x100A
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 4e80651efe..17315aba6a 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -206,6 +206,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/asm-x86/hyperv.h b/linux-headers/asm-x86/hyperv.h
deleted file mode 100644
index 01af4d8593..0000000000
--- a/linux-headers/asm-x86/hyperv.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "standard-headers/asm-x86/hyperv.h"
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index f3a960488e..c535c2fdea 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -354,8 +354,25 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
-/* definition of registers in kvm_run */
+#define KVM_SYNC_X86_REGS      (1UL << 0)
+#define KVM_SYNC_X86_SREGS     (1UL << 1)
+#define KVM_SYNC_X86_EVENTS    (1UL << 2)
+
+#define KVM_SYNC_X86_VALID_FIELDS \
+	(KVM_SYNC_X86_REGS| \
+	 KVM_SYNC_X86_SREGS| \
+	 KVM_SYNC_X86_EVENTS)
+
+/* kvm_sync_regs struct included by kvm_run struct */
 struct kvm_sync_regs {
+	/* Members of this structure are potentially malicious.
+	 * Care must be taken by code reading, esp. interpreting,
+	 * data fields from them inside KVM to prevent TOCTOU and
+	 * double-fetch types of vulnerabilities.
+	 */
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_vcpu_events events;
 };
 
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a167be89d1..cdb148e959 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -396,6 +396,10 @@ struct kvm_run {
 		char padding[256];
 	};
 
+	/* 2048 is the size of the char array used to bound/pad the size
+	 * of the union that holds sync regs.
+	 */
+	#define SYNC_REGS_SIZE_BYTES 2048
 	/*
 	 * shared registers between kvm and userspace.
 	 * kvm_valid_regs specifies the register classes set by the host
@@ -407,7 +411,7 @@ struct kvm_run {
 	__u64 kvm_dirty_regs;
 	union {
 		struct kvm_sync_regs regs;
-		char padding[2048];
+		char padding[SYNC_REGS_SIZE_BYTES];
 	} s;
 };
 
@@ -672,6 +676,13 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
+
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
 	/* in */
@@ -925,7 +936,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_GS 140
 #define KVM_CAP_S390_AIS 141
 #define KVM_CAP_SPAPR_TCE_VFIO 142
-#define KVM_CAP_X86_GUEST_MWAIT 143
+#define KVM_CAP_X86_DISABLE_EXITS 143
 #define KVM_CAP_ARM_USER_IRQ 144
 #define KVM_CAP_S390_CMMA_MIGRATION 145
 #define KVM_CAP_PPC_FWNMI 146
@@ -936,6 +947,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
+#define KVM_CAP_HYPERV_EVENTFD 154
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1375,6 +1387,10 @@ struct kvm_enc_region {
 #define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
 #define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
 
+/* Available with KVM_CAP_HYPERV_EVENTFD */
+#define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
+
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1515,4 +1531,14 @@ struct kvm_assigned_msix_entry {
 #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
 #define KVM_ARM_DEV_PMU			(1 << 2)
 
+struct kvm_hyperv_eventfd {
+	__u32 conn_id;
+	__s32 fd;
+	__u32 flags;
+	__u32 padding[3];
+};
+
+#define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
+#define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3a0a305c8c..3615a269d3 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -575,6 +575,33 @@ struct vfio_device_gfx_plane_info {
 
 #define VFIO_DEVICE_GET_GFX_DMABUF _IO(VFIO_TYPE, VFIO_BASE + 15)
 
+/**
+ * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 16,
+ *                              struct vfio_device_ioeventfd)
+ *
+ * Perform a write to the device at the specified device fd offset, with
+ * the specified data and width when the provided eventfd is triggered.
+ * vfio bus drivers may not support this for all regions, for all widths,
+ * or at all.  vfio-pci currently only enables support for BAR regions,
+ * excluding the MSI-X vector table.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_ioeventfd {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
+#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
+#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
+#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
+#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
+	__u64	offset;			/* device fd offset of write */
+	__u64	data;			/* data to be written */
+	__s32	fd;			/* -1 for de-assignment */
+};
+
+#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/linux-headers/COPYING b/linux-headers/COPYING
index ca442d313d..da4cb28feb 100644
--- a/linux-headers/COPYING
+++ b/linux-headers/COPYING
@@ -1,356 +1,18 @@
+The Linux Kernel is provided under:
 
-   NOTE! This copyright does *not* cover user programs that use kernel
- services by normal system calls - this is merely considered normal use
- of the kernel, and does *not* fall under the heading of "derived work".
- Also note that the GPL below is copyrighted by the Free Software
- Foundation, but the instance of code that it refers to (the Linux
- kernel) is copyrighted by me and others who actually wrote it.
+	SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 
- Also note that the only valid version of the GPL as far as the kernel
- is concerned is _this_ particular version of the license (ie v2, not
- v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+Being under the terms of the GNU General Public License version 2 only,
+according with:
 
-			Linus Torvalds
+	LICENSES/preferred/GPL-2.0
 
-----------------------------------------
+With an explicit syscall exception, as stated at:
 
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+	LICENSES/exceptions/Linux-syscall-note
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
+In addition, other licenses may also apply. Please see:
 
-			    Preamble
+	Documentation/process/license-rules.rst
 
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-

-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-

-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-

-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-

-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
-
-		     END OF TERMS AND CONDITIONS
-

-	    How to Apply These Terms to Your New Programs
-
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
-
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
-Public License instead of this License.
+for more details.
diff --git a/linux-headers/LICENSES/exceptions/Linux-syscall-note b/linux-headers/LICENSES/exceptions/Linux-syscall-note
new file mode 100644
index 0000000000..6b60b61be4
--- /dev/null
+++ b/linux-headers/LICENSES/exceptions/Linux-syscall-note
@@ -0,0 +1,25 @@
+SPDX-Exception-Identifier: Linux-syscall-note
+SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
+SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+Usage-Guide:
+  This exception is used together with one of the above SPDX-Licenses
+  to mark user space API (uapi) header files so they can be included
+  into non GPL compliant user space application code.
+  To use this exception add it with the keyword WITH to one of the
+  identifiers in the SPDX-Licenses tag:
+    SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
+License-Text:
+
+   NOTE! This copyright does *not* cover user programs that use kernel
+ services by normal system calls - this is merely considered normal use
+ of the kernel, and does *not* fall under the heading of "derived work".
+ Also note that the GPL below is copyrighted by the Free Software
+ Foundation, but the instance of code that it refers to (the Linux
+ kernel) is copyrighted by me and others who actually wrote it.
+
+ Also note that the only valid version of the GPL as far as the kernel
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+			Linus Torvalds
+
diff --git a/linux-headers/LICENSES/preferred/BSD-2-Clause b/linux-headers/LICENSES/preferred/BSD-2-Clause
new file mode 100644
index 0000000000..da366e2ce5
--- /dev/null
+++ b/linux-headers/LICENSES/preferred/BSD-2-Clause
@@ -0,0 +1,32 @@
+Valid-License-Identifier: BSD-2-Clause
+SPDX-URL: https://spdx.org/licenses/BSD-2-Clause.html
+Usage-Guide:
+  To use the BSD 2-clause "Simplified" License put the following SPDX
+  tag/value pair into a comment according to the placement guidelines in
+  the licensing rules documentation:
+    SPDX-License-Identifier: BSD-2-Clause
+License-Text:
+
+Copyright (c) <year> <owner> . All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are met:
+
+1. Redistributions of source code must retain the above copyright notice,
+   this list of conditions and the following disclaimer.
+
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGE.
diff --git a/linux-headers/LICENSES/preferred/BSD-3-Clause b/linux-headers/LICENSES/preferred/BSD-3-Clause
new file mode 100644
index 0000000000..34c7f057c8
--- /dev/null
+++ b/linux-headers/LICENSES/preferred/BSD-3-Clause
@@ -0,0 +1,36 @@
+Valid-License-Identifier: BSD-3-Clause
+SPDX-URL: https://spdx.org/licenses/BSD-3-Clause.html
+Usage-Guide:
+  To use the BSD 3-clause "New" or "Revised" License put the following SPDX
+  tag/value pair into a comment according to the placement guidelines in
+  the licensing rules documentation:
+    SPDX-License-Identifier: BSD-3-Clause
+License-Text:
+
+Copyright (c) <year> <owner> . All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are met:
+
+1. Redistributions of source code must retain the above copyright notice,
+   this list of conditions and the following disclaimer.
+
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+
+3. Neither the name of the copyright holder nor the names of its
+   contributors may be used to endorse or promote products derived from this
+   software without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGE.
diff --git a/linux-headers/COPYING b/linux-headers/LICENSES/preferred/GPL-2.0
similarity index 96%
copy from linux-headers/COPYING
copy to linux-headers/LICENSES/preferred/GPL-2.0
index ca442d313d..b8db91d3a1 100644
--- a/linux-headers/COPYING
+++ b/linux-headers/LICENSES/preferred/GPL-2.0
@@ -1,18 +1,15 @@
-
-   NOTE! This copyright does *not* cover user programs that use kernel
- services by normal system calls - this is merely considered normal use
- of the kernel, and does *not* fall under the heading of "derived work".
- Also note that the GPL below is copyrighted by the Free Software
- Foundation, but the instance of code that it refers to (the Linux
- kernel) is copyrighted by me and others who actually wrote it.
-
- Also note that the only valid version of the GPL as far as the kernel
- is concerned is _this_ particular version of the license (ie v2, not
- v2.2 or v3.x or whatever), unless explicitly otherwise stated.
-
-			Linus Torvalds
-
-----------------------------------------
+Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0+
+SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+Usage-Guide:
+  To use this license in source code, put one of the following SPDX
+  tag/value pairs into a comment according to the placement
+  guidelines in the licensing rules documentation.
+  For 'GNU General Public License (GPL) version 2 only' use:
+    SPDX-License-Identifier: GPL-2.0
+  For 'GNU General Public License (GPL) version 2 or any later version' use:
+    SPDX-License-Identifier: GPL-2.0+
+License-Text:
 
 		    GNU GENERAL PUBLIC LICENSE
 		       Version 2, June 1991
-- 
2.17.0
