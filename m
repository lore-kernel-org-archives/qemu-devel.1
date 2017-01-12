Received: from eggs.gnu.org ([2001:4830:134:3::10]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmtF-0000zo-5P
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmtA-0003El-6E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:26:33 -0500
Received: from mail.kernel.org ([198.145.29.136]:39218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmt9-0003EB-Uz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:26:28 -0500
Date: Thu, 12 Jan 2017 23:26:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484256243-1982-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] virtio-ccw: fix ring sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Current code seems to assume ring size is
always decreased but this is not required by spec:
what spec says is just that size can not exceed
the maximum. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 1 +
 hw/s390x/virtio-ccw.c      | 2 +-
 hw/virtio/virtio.c         | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index e5541c6..6523bac 100644
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
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 0765068..63c4637 100644
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
index 34065c7..e52fd8e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1256,6 +1256,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
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
-- 
MST
