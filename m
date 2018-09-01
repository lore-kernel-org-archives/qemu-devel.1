Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qT-0006Tw-LG
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6oJ-0005MR-Fp
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:23:36 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:22:55 +0200
Message-Id: <20180901142312.11662-4-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 03/20] linux-headers: Partial header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

This imports both the iommu.h and vfio.h headers found on branch
https://github.com/eauger/linux/tree/v4.18-2stage-rfc++

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/linux/iommu.h | 157 ++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h  |  28 ++++++-
 2 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100644 linux-headers/linux/iommu.h

diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000000..72536cf412
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * IOMMU user API definitions
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UAPI_IOMMU_H
+#define _UAPI_IOMMU_H
+
+#include <linux/types.h>
+
+/**
+ * PASID table data used to bind guest PASID table to the host IOMMU. This will
+ * enable guest managed first level page tables.
+ * @version: for future extensions and identification of the data format
+ * @bytes: size of this structure
+ * @base_ptr:	PASID table pointer
+ * @pasid_bits:	number of bits supported in the guest PASID table, must be less
+ *		or equal than the host supported PASID size.
+ */
+struct iommu_pasid_table_config {
+	__u32 version;
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32 bytes;
+	__u64 base_ptr;
+	__u8 pasid_bits;
+};
+
+/**
+ * Stream Table Entry stage info
+ * @flags: indicate the stage 1 state
+ * @cdptr_dma: GPA of the Context Descriptor
+ * @asid_bits: number of asid bits supported in the guest, must be less or
+ *             equal than the host asid size
+ */
+struct iommu_smmu_s1_config {
+#define IOMMU_SMMU_S1_DISABLED	(1 << 0)
+#define IOMMU_SMMU_S1_BYPASSED	(1 << 1)
+#define IOMMU_SMMU_S1_ABORTED	(1 << 2)
+	__u32 flags;
+	__u64 cdptr_dma;
+	__u8 asid_bits;
+};
+
+struct iommu_guest_stage_config {
+#define PASID_TABLE	(1 << 0)
+#define SMMUV3_S1_CFG	(1 << 1)
+	__u32 flags;
+	union {
+		struct iommu_pasid_table_config pasidt;
+		struct iommu_smmu_s1_config smmu_s1;
+	};
+};
+
+/**
+ * enum iommu_inv_granularity - Generic invalidation granularity
+ * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID caches of all
+ *					PASIDs associated with a domain ID
+ * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID cache associated
+ *					with a PASID and a domain
+ * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of selected page range
+ *					within a PASID
+ *
+ * When an invalidation request is passed down to IOMMU to flush translation
+ * caches, it may carry different granularity levels, which can be specific
+ * to certain types of translation caches.
+ * This enum is a collection of granularities for all types of translation
+ * caches. The idea is to make it easy for IOMMU model specific driver to
+ * convert from generic to model specific value. Each IOMMU driver
+ * can enforce check based on its own conversion table. The conversion is
+ * based on 2D look-up with inputs as follows:
+ * - translation cache types
+ * - granularity
+ *
+ *             type |   DTLB    |    TLB    |   PASID   |
+ *  granule         |           |           |   cache   |
+ * -----------------+-----------+-----------+-----------+
+ *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
+ *  PASID_SEL       |   Y       |   Y       |   Y       |
+ *  PAGE_PASID      |   Y       |   Y       |   N/A     |
+ *
+ */
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
+	IOMMU_INV_GRANU_PASID_SEL,
+	IOMMU_INV_GRANU_PAGE_PASID,
+	IOMMU_INV_NR_GRANU,
+};
+
+/**
+ * enum iommu_inv_type - Generic translation cache types for invalidation
+ *
+ * @IOMMU_INV_TYPE_DTLB:	device IOTLB
+ * @IOMMU_INV_TYPE_TLB:		IOMMU paging structure cache
+ * @IOMMU_INV_TYPE_PASID:	PASID cache
+ * Invalidation requests sent to IOMMU for a given device need to indicate
+ * which type of translation cache to be operated on. Combined with enum
+ * iommu_inv_granularity, model specific driver can do a simple lookup to
+ * convert from generic to model specific value.
+ */
+enum iommu_inv_type {
+	IOMMU_INV_TYPE_DTLB,
+	IOMMU_INV_TYPE_TLB,
+	IOMMU_INV_TYPE_PASID,
+	IOMMU_INV_NR_TYPE
+};
+
+/**
+ * Translation cache invalidation header that contains mandatory meta data.
+ * @version:	info format version, expecting future extesions
+ * @type:	type of translation cache to be invalidated
+ */
+struct iommu_tlb_invalidate_hdr {
+	__u32 version;
+#define TLB_INV_HDR_VERSION_1 1
+	enum iommu_inv_type type;
+};
+
+/**
+ * Translation cache invalidation information, contains generic IOMMU
+ * data which can be parsed based on model ID by model specific drivers.
+ * Since the invalidation of second level page tables are included in the
+ * unmap operation, this info is only applicable to the first level
+ * translation caches, i.e. DMA request with PASID.
+ *
+ * @granularity:	requested invalidation granularity, type dependent
+ * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
+ * @nr_pages:		number of pages to invalidate
+ * @pasid:		processor address space ID value per PCI spec.
+ * @addr:		page address to be invalidated
+ * @flags		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
+ *			IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
+ *
+ */
+struct iommu_tlb_invalidate_info {
+	struct iommu_tlb_invalidate_hdr	hdr;
+	enum iommu_inv_granularity	granularity;
+	__u32		flags;
+#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 0)
+#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 1)
+	__u8		size;
+	__u64		nr_pages;
+	__u32		pasid;
+	__u64		addr;
+};
+
+struct iommu_guest_msi_binding {
+	__u64		iova;
+	__u64		gpa;
+	__u32		granule;
+};
+#endif /* _UAPI_IOMMU_H */
+
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3615a269d3..8b22565fba 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -9,11 +9,12 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef VFIO_H
-#define VFIO_H
+#ifndef _UAPIVFIO_H
+#define _UAPIVFIO_H
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
 
 #define VFIO_API_VERSION	0
 
@@ -665,6 +666,27 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+struct vfio_iommu_type1_bind_guest_stage {
+	__u32	argsz;
+	__u32	flags;
+	struct iommu_guest_stage_config config;
+};
+#define VFIO_IOMMU_BIND_GUEST_STAGE	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+struct vfio_iommu_type1_tlb_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_tlb_invalidate_info info;
+};
+#define VFIO_IOMMU_TLB_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
+
+struct vfio_iommu_type1_bind_guest_msi {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_guest_msi_binding binding;
+};
+#define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
@@ -816,4 +838,4 @@ struct vfio_iommu_spapr_tce_remove {
 
 /* ***************************************************************** */
 
-#endif /* VFIO_H */
+#endif /* _UAPIVFIO_H */
-- 
2.17.1
