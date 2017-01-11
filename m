Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhZ-0002Za-OI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhW-0004rl-Mm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:14592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhW-0004qC-Cu
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:10 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:39 +0800
Message-Id: <1484124524-481-2-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 1/6] virtio-balloon: update linux head
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

Update the linux head file to keep consistent with kernel side.
The new definition will be used in the following patches.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 include/standard-headers/linux/virtio_balloon.h | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd..c15d592 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -34,10 +34,15 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_PAGE_RANGE	3 /* Send page info with ranges */
+#define VIRTIO_BALLOON_F_HOST_REQ_VQ	4 /* Host request virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+/* Bits width for the length of the pfn range */
+#define VIRTIO_BALLOON_NR_PFN_BITS 12
+
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
 	uint32_t num_pages;
@@ -82,4 +87,33 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } QEMU_PACKED;
 
+/* Response header structure */
+struct virtio_balloon_resp_hdr {
+	uint64_t cmd : 8; /* Distinguish different requests type */
+	uint64_t flag: 8; /* Mark status for a specific request type */
+	uint64_t id : 16; /* Distinguish requests of a specific type */
+	uint64_t data_len: 32; /* Length of the following data, in bytes */
+};
+
+enum virtio_balloon_req_id {
+	/* Get unused page information */
+	BALLOON_GET_UNUSED_PAGES,
+};
+
+enum virtio_balloon_flag {
+	/* Have more data for a request */
+	BALLOON_FLAG_CONT,
+	/* No more data for a request */
+	BALLOON_FLAG_DONE,
+};
+
+struct virtio_balloon_req_hdr {
+	/* Used to distinguish different requests */
+	uint16_t cmd;
+	/* Reserved */
+	uint16_t reserved[3];
+	/* Request parameter */
+	uint64_t param;
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
1.9.1
