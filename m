Received: from eggs.gnu.org ([2001:4830:134:3::10]:48941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCs-0001nT-Qa
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCp-0006FF-NW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCp-0006D8-Fo
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0GFQg082669
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:34 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yvhs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:34 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:33 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:43 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-69-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 68/79] virtio-scsi: finalize IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Jason Wang <jasowang@redhat.com>

After converting to use DMA api for virtio devices, we should use
dma_as instead of address_space_memory. Otherwise it won't work if
IOMMU is enabled.

Fixes: commit 8607f5c3072c ("virtio: convert to use DMA api")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 025bdeab3c163aee9604a60b2332a5fcbcc00f8d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/virtio-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index cb1c123..3915c2e 100644
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
2.7.4
