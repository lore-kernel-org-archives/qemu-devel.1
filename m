Received: from eggs.gnu.org ([2001:4830:134:3::10]:52500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliA-0007pb-Un
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliA-0000oz-2B
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOli9-0000oh-TC
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:09 +0000
Message-Id: <20170104133414.6524-10-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 09/14] virtio-scsi: suppress virtqueue kick
 during processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The guest does not need to kick the virtqueue while we are processing
it.  This reduces the number of vmexits during periods of heavy I/O.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-9-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 34bba35..204e14f 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -592,26 +592,32 @@ static void virtio_scsi_handle_cmd_req_submit(VirtIOSCSI *s, VirtIOSCSIReq *req)
 void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req, *next;
-    int ret;
+    int ret = 0;
 
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
 
-    while ((req = virtio_scsi_pop_req(s, vq))) {
-        ret = virtio_scsi_handle_cmd_req_prepare(s, req);
-        if (!ret) {
-            QTAILQ_INSERT_TAIL(&reqs, req, next);
-        } else if (ret == -EINVAL) {
-            /* The device is broken and shouldn't process any request */
-            while (!QTAILQ_EMPTY(&reqs)) {
-                req = QTAILQ_FIRST(&reqs);
-                QTAILQ_REMOVE(&reqs, req, next);
-                blk_io_unplug(req->sreq->dev->conf.blk);
-                scsi_req_unref(req->sreq);
-                virtqueue_detach_element(req->vq, &req->elem, 0);
-                virtio_scsi_free_req(req);
+    do {
+        virtio_queue_set_notification(vq, 0);
+
+        while ((req = virtio_scsi_pop_req(s, vq))) {
+            ret = virtio_scsi_handle_cmd_req_prepare(s, req);
+            if (!ret) {
+                QTAILQ_INSERT_TAIL(&reqs, req, next);
+            } else if (ret == -EINVAL) {
+                /* The device is broken and shouldn't process any request */
+                while (!QTAILQ_EMPTY(&reqs)) {
+                    req = QTAILQ_FIRST(&reqs);
+                    QTAILQ_REMOVE(&reqs, req, next);
+                    blk_io_unplug(req->sreq->dev->conf.blk);
+                    scsi_req_unref(req->sreq);
+                    virtqueue_detach_element(req->vq, &req->elem, 0);
+                    virtio_scsi_free_req(req);
+                }
             }
         }
-    }
+
+        virtio_queue_set_notification(vq, 1);
+    } while (ret != -EINVAL && !virtio_queue_empty(vq));
 
     QTAILQ_FOREACH_SAFE(req, &reqs, next, next) {
         virtio_scsi_handle_cmd_req_submit(s, req);
-- 
2.9.3
