Received: from eggs.gnu.org ([2001:4830:134:3::10]:46617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWo-0004h8-Iq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWn-0007hy-M6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:14 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:22 +0200
Message-Id: <1499238885-26161-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/42] virtio-scsi: finalize IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

From: Jason Wang <jasowang@redhat.com>

After converting to use DMA api for virtio devices, we should use
dma_as instead of address_space_memory. Otherwise it won't work if
IOMMU is enabled.

Fixes: commit 8607f5c3072c ("virtio: convert to use DMA api")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f46f06d..d076fe7 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -43,12 +43,13 @@ static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
 
 void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
 {
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     const size_t zero_skip =
         offsetof(VirtIOSCSIReq, resp_iov) + sizeof(req->resp_iov);
 
     req->vq = vq;
     req->dev = s;
-    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, &address_space_memory);
+    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, vdev->dma_as);
     qemu_iovec_init(&req->resp_iov, 1);
     memset((uint8_t *)req + zero_skip, 0, sizeof(*req) - zero_skip);
 }
-- 
1.8.3.1
