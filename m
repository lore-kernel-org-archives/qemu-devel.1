Received: from eggs.gnu.org ([2001:4830:134:3::10]:52488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli8-0007nL-Px
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli7-0000o8-Vz
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOli7-0000ni-QT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:08 +0000
Message-Id: <20170104133414.6524-9-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 08/14] virtio-blk: suppress virtqueue kick
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
Message-id: 20161201192652.9509-8-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 0c5fd27..50bb0cb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -588,13 +588,19 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
 
     blk_io_plug(s->blk);
 
-    while ((req = virtio_blk_get_request(s, vq))) {
-        if (virtio_blk_handle_request(req, &mrb)) {
-            virtqueue_detach_element(req->vq, &req->elem, 0);
-            virtio_blk_free_request(req);
-            break;
+    do {
+        virtio_queue_set_notification(vq, 0);
+
+        while ((req = virtio_blk_get_request(s, vq))) {
+            if (virtio_blk_handle_request(req, &mrb)) {
+                virtqueue_detach_element(req->vq, &req->elem, 0);
+                virtio_blk_free_request(req);
+                break;
+            }
         }
-    }
+
+        virtio_queue_set_notification(vq, 1);
+    } while (!virtio_queue_empty(vq));
 
     if (mrb.num_reqs) {
         virtio_blk_submit_multireq(s->blk, &mrb);
-- 
2.9.3
