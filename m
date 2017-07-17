Received: from eggs.gnu.org ([2001:4830:134:3::10]:56728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18V-0005Os-9d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18S-0001MB-Jb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18S-0001Lq-Am
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:08 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:47 +0200
Message-Id: <20170717081152.17153-5-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/9] virtio-9p: use virtqueue_error for
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
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

virtqueue_error includes the queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/virtio-9p-device.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 62650b0..cf16b4b 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -54,16 +54,16 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         if (iov_size(elem->in_sg, elem->in_num) < 7) {
-            virtio_error(vdev,
-                         "The guest sent a VirtFS request without space for "
-                         "the reply");
+            virtqueue_error(vq,
+                            "The guest sent a VirtFS request without space for "
+                            "the reply");
             goto out_free_req;
         }
 
         len = iov_to_buf(elem->out_sg, elem->out_num, 0, &out, 7);
         if (len != 7) {
-            virtio_error(vdev, "The guest sent a malformed VirtFS request: "
-                         "header size is %zd, should be 7", len);
+            virtqueue_error(vq, "The guest sent a malformed VirtFS request: "
+                            "header size is %zd, should be 7", len);
             goto out_free_req;
         }
 
@@ -150,10 +150,8 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
 
     ret = v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, ap);
     if (ret < 0) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
-                     pdu->id + 1);
+        virtqueue_error(v->vq, "Failed to encode VirtFS reply type %d",
+                        pdu->id + 1);
     }
     return ret;
 }
@@ -168,9 +166,8 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
 
     ret = v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, fmt, ap);
     if (ret < 0) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev, "Failed to decode VirtFS request type %d", pdu->id);
+        virtqueue_error(v->vq, "Failed to decode VirtFS request type %d",
+                        pdu->id);
     }
     return ret;
 }
@@ -184,11 +181,9 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
     if (buf_size < size) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
-                     pdu->id + 1, size, buf_size);
+        virtqueue_error(v->vq,
+                        "VirtFS reply type %d needs %zu bytes, buffer has %zu",
+                        pdu->id + 1, size, buf_size);
     }
 
     *piov = elem->in_sg;
@@ -204,11 +199,9 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     size_t buf_size = iov_size(elem->out_sg, elem->out_num);
 
     if (buf_size < size) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev,
-                     "VirtFS request type %d needs %zu bytes, buffer has %zu",
-                     pdu->id, size, buf_size);
+        virtqueue_error(v->vq,
+                        "VirtFS request type %d needs %zu bytes, "
+                        "buffer has %zu", pdu->id, size, buf_size);
     }
 
     *piov = elem->out_sg;
-- 
2.9.3
