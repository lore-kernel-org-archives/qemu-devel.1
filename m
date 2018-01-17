Received: from eggs.gnu.org ([2001:4830:134:3::10]:54663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYF-00055a-JQ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYE-0003tR-4b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:59302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebhYD-0003no-Sj
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:22 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:32:00 +0800
Message-Id: <1516170720-4948-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 4/4] virtio-balloon: Don't skip free pages
 if the poison val is non-zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

If the guest is using a non-zero poisoning, we don't skip the transfer
of guest free pages.

Todo: As a next step optimization, we can try
1) skip the transfer of guest poisoned free pages;
2) send the poison value to destination; and
3) seek a way to poison the guest free pages before the guest starts to
run on the destination.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 3 ++-
 include/hw/virtio/virtio-balloon.h              | 1 +
 include/standard-headers/linux/virtio_balloon.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index dcc8cb3..0cdc755 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -403,7 +403,7 @@ static void virtio_balloon_handle_free_pages(VirtIODevice *vdev, VirtQueue *vq)
             ram_addr_t offset;
 
             if (atomic_read(&dev->free_page_report_status) ==
-                FREE_PAGE_REPORT_S_IN_PROGRESS) {
+                FREE_PAGE_REPORT_S_IN_PROGRESS && !dev->poison_val) {
                 block = qemu_ram_block_from_host(elem->in_sg[0].iov_base,
                                                  false, &offset);
                 size = elem->in_sg[0].iov_len;
@@ -530,6 +530,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
                         &error_abort);
     }
+    dev->poison_val = le32_to_cpu(config.poison_val);
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 268f7d6..0bb80cd 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -43,6 +43,7 @@ typedef struct VirtIOBalloon {
     uint32_t num_pages;
     uint32_t actual;
     uint32_t free_page_report_cmd_id;
+    uint32_t poison_val;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 596df5d..f6f4ff3 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -47,6 +47,8 @@ struct virtio_balloon_config {
 	uint32_t actual;
         /* The free_page report command id, readonly by guest */
 	uint32_t free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning with sanity check is in use */
+	uint32_t poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
1.8.3.1
