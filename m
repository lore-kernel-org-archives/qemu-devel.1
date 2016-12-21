Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cJarc-0007lZ-41
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cJarZ-0006iA-1H
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:59:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:14119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cJarY-0006i4-Nd
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:58:56 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 21 Dec 2016 14:52:27 +0800
Message-Id: <1482303148-22059-5-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v6 kernel 4/5] virtio-balloon: define flags and
 head for host request vq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mst@redhat.com, david@redhat.com, aarcange@redhat.com, dgilbert@redhat.com, quintela@redhat.com, Liang Li <liang.z.li@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>

Define the flags and head struct for a new host request virtual
queue. Guest can get requests from host and then responds to them on
this new virtual queue.
Host can make use of this virtual queue to request the guest do some
operations, e.g. drop page cache, synchronize file system, etc.
And the hypervisor can get some of guest's runtime information
through this virtual queue too, e.g. the guest's unused page
information, which can be used for live migration optimization.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
---
 include/uapi/linux/virtio_balloon.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 2f850bf..b367020 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -35,6 +35,7 @@
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_PAGE_RANGE	3 /* Send page info with ranges */
+#define VIRTIO_BALLOON_F_HOST_REQ_VQ	4 /* Host request virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -94,4 +95,25 @@ struct virtio_balloon_resp_hdr {
 	__le64 data_len: 32; /* Length of the following data, in bytes */
 };
 
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
+	__le16 cmd;
+	/* Reserved */
+	__le16 reserved[3];
+	/* Request parameter */
+	__le64 param;
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
1.9.1
