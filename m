Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlu7-0005p0-Fz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlu6-0006VP-6E
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:14:59 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:29 +0200
Message-Id: <1533586484-5737-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 01/16] linux-headers: Partial update for
 virtio-iommu v0.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

Partial sync against Jean-Philippe's branch:
git://linux-arm.org/linux-jpb.git virtio-iommu/v0.7

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h   |   1 +
 include/standard-headers/linux/virtio_iommu.h | 172 ++++++++++++++++++++++++++
 linux-headers/linux/virtio_iommu.h            |   1 +
 3 files changed, 174 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2..cfe47c5 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/standard-headers/linux/virtio_iommu.h
new file mode 100644
index 0000000..a233206
--- /dev/null
+++ b/include/standard-headers/linux/virtio_iommu.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Virtio-iommu definition v0.7
+ *
+ * Copyright (C) 2018 Arm Ltd.
+ */
+#ifndef _LINUX_VIRTIO_IOMMU_H
+#define _LINUX_VIRTIO_IOMMU_H
+
+#include "standard-headers/linux/types.h"
+
+/* Feature bits */
+#define VIRTIO_IOMMU_F_INPUT_RANGE		0
+#define VIRTIO_IOMMU_F_DOMAIN_BITS		1
+#define VIRTIO_IOMMU_F_MAP_UNMAP		2
+#define VIRTIO_IOMMU_F_BYPASS			3
+#define VIRTIO_IOMMU_F_PROBE			4
+
+struct virtio_iommu_config {
+	/* Supported page sizes */
+	uint64_t					page_size_mask;
+	/* Supported IOVA range */
+	struct virtio_iommu_range {
+		uint64_t				start;
+		uint64_t				end;
+	} input_range;
+	/* Max domain ID size */
+	uint8_t					domain_bits;
+	uint8_t					padding[3];
+	/* Probe buffer size */
+	uint32_t					probe_size;
+} QEMU_PACKED;
+
+/* Request types */
+#define VIRTIO_IOMMU_T_ATTACH			0x01
+#define VIRTIO_IOMMU_T_DETACH			0x02
+#define VIRTIO_IOMMU_T_MAP			0x03
+#define VIRTIO_IOMMU_T_UNMAP			0x04
+#define VIRTIO_IOMMU_T_PROBE			0x05
+
+/* Status types */
+#define VIRTIO_IOMMU_S_OK			0x00
+#define VIRTIO_IOMMU_S_IOERR			0x01
+#define VIRTIO_IOMMU_S_UNSUPP			0x02
+#define VIRTIO_IOMMU_S_DEVERR			0x03
+#define VIRTIO_IOMMU_S_INVAL			0x04
+#define VIRTIO_IOMMU_S_RANGE			0x05
+#define VIRTIO_IOMMU_S_NOENT			0x06
+#define VIRTIO_IOMMU_S_FAULT			0x07
+
+struct virtio_iommu_req_head {
+	uint8_t					type;
+	uint8_t					reserved[3];
+} QEMU_PACKED;
+
+struct virtio_iommu_req_tail {
+	uint8_t					status;
+	uint8_t					reserved[3];
+} QEMU_PACKED;
+
+struct virtio_iommu_req_attach {
+	struct virtio_iommu_req_head		head;
+
+	uint32_t					domain;
+	uint32_t					endpoint;
+	uint32_t					reserved;
+
+	struct virtio_iommu_req_tail		tail;
+} QEMU_PACKED;
+
+struct virtio_iommu_req_detach {
+	struct virtio_iommu_req_head		head;
+
+	uint32_t					endpoint;
+	uint32_t					reserved;
+
+	struct virtio_iommu_req_tail		tail;
+} QEMU_PACKED;
+
+#define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
+#define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
+#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 3)
+
+#define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
+						 VIRTIO_IOMMU_MAP_F_WRITE |	\
+						 VIRTIO_IOMMU_MAP_F_EXEC |	\
+						 VIRTIO_IOMMU_MAP_F_MMIO)
+
+struct virtio_iommu_req_map {
+	struct virtio_iommu_req_head		head;
+
+	uint32_t					domain;
+	uint64_t					virt_start;
+	uint64_t					virt_end;
+	uint64_t					phys_start;
+	uint32_t					flags;
+
+	struct virtio_iommu_req_tail		tail;
+} QEMU_PACKED;
+
+struct virtio_iommu_req_unmap {
+	struct virtio_iommu_req_head		head;
+
+	uint32_t					domain;
+	uint64_t					virt_start;
+	uint64_t					virt_end;
+	uint32_t					reserved;
+
+	struct virtio_iommu_req_tail		tail;
+} QEMU_PACKED;
+
+#define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
+#define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
+
+struct virtio_iommu_probe_resv_mem {
+	uint8_t					subtype;
+	uint8_t					reserved[3];
+	uint64_t					start;
+	uint64_t					end;
+} QEMU_PACKED;
+
+#define VIRTIO_IOMMU_PROBE_T_NONE		0
+#define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+
+#define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
+
+struct virtio_iommu_probe_property {
+	uint16_t					type;
+	uint16_t					length;
+	uint8_t					value[];
+} QEMU_PACKED;
+
+struct virtio_iommu_req_probe {
+	struct virtio_iommu_req_head		head;
+	uint32_t					endpoint;
+	uint8_t					reserved[64];
+
+	uint8_t					properties[];
+
+	/* Tail follows the variable-length properties array (no padding) */
+} QEMU_PACKED;
+
+union virtio_iommu_req {
+	struct virtio_iommu_req_head		head;
+
+	struct virtio_iommu_req_attach		attach;
+	struct virtio_iommu_req_detach		detach;
+	struct virtio_iommu_req_map		map;
+	struct virtio_iommu_req_unmap		unmap;
+	struct virtio_iommu_req_probe		probe;
+};
+
+/* Fault types */
+#define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
+#define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
+#define VIRTIO_IOMMU_FAULT_R_MAPPING		2
+
+#define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
+
+struct virtio_iommu_fault {
+	uint8_t					reason;
+	uint8_t					padding[3];
+	uint32_t					flags;
+	uint32_t					endpoint;
+	uint64_t					address;
+} QEMU_PACKED;
+
+#endif
diff --git a/linux-headers/linux/virtio_iommu.h b/linux-headers/linux/virtio_iommu.h
new file mode 100644
index 0000000..2dc4609
--- /dev/null
+++ b/linux-headers/linux/virtio_iommu.h
@@ -0,0 +1 @@
+#include "standard-headers/linux/virtio_iommu.h"
-- 
2.5.5
