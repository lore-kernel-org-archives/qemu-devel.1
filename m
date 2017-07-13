Received: from eggs.gnu.org ([2001:4830:134:3::10]:40295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbti-0005uN-30
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbth-0001Ng-AH
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbth-0001NX-4J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:03:05 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:36 +0200
Message-Id: <20170713110237.6712-8-lprosek@redhat.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/8] virtio-scsi: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

virtqueue_error includes queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/scsi/virtio-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d076fe7..a633d51 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -84,7 +84,7 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req)
 
 static void virtio_scsi_bad_req(VirtIOSCSIReq *req)
 {
-    virtio_error(VIRTIO_DEVICE(req->dev), "wrong size for virtio-scsi headers");
+    virtqueue_error(req->vq, "wrong size for virtio-scsi headers");
     virtqueue_detach_element(req->vq, &req->elem, 0);
     virtio_scsi_free_req(req);
 }
-- 
2.9.3
