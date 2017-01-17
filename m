Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZo-0002Wh-Jl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZl-0008Bv-Gf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZl-0008BN-6p
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8tKfI070758
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:08 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28126fvvme-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:07 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:57:05 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:45 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-13-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 12/12] virtio-ccw: fix ring sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

Current code seems to assume ring size is
always decreased but this is not required by spec:
what spec says is just that size can not exceed
the maximum. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <1484256243-1982-1-git-send-email-mst@redhat.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c      | 2 +-
 hw/virtio/virtio.c         | 5 +++++
 include/hw/virtio/virtio.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 07650683f7..63c46373fb 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -149,7 +149,7 @@ static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
     } else {
         if (info) {
             /* virtio-1 allows changing the ring size. */
-            if (virtio_queue_get_num(vdev, index) < num) {
+            if (virtio_queue_get_max_num(vdev, index) < num) {
                 /* Fail if we exceed the maximum number. */
                 return -EINVAL;
             }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index aa4f38f50a..94d7dbae6c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1262,6 +1262,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
     return vdev->vq[n].vring.num;
 }
 
+int virtio_queue_get_max_num(VirtIODevice *vdev, int n)
+{
+    return vdev->vq[n].vring.num_default;
+}
+
 int virtio_get_num_queues(VirtIODevice *vdev)
 {
     int i;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index e5541c61f7..6523bacd2f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -228,6 +228,7 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+int virtio_queue_get_max_num(VirtIODevice *vdev, int n);
 int virtio_get_num_queues(VirtIODevice *vdev);
 void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
                             hwaddr avail, hwaddr used);
-- 
2.11.0
