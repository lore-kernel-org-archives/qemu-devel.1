Received: from eggs.gnu.org ([209.51.188.92]:49134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arusakova917@gmail.com>) id 1h1vkG-00068n-Es
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arusakova917@gmail.com>) id 1h1vkE-0008H1-HQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:19:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arusakova917@gmail.com>)
	id 1h1vkA-00087l-US
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:19:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id r5so18119154wrg.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:19:34 -0800 (PST)
From: Anastasiia Rusakova <arusakova917@gmail.com>
Date: Thu,  7 Mar 2019 18:19:25 +0200
Message-Id: <20190307161925.4158-1-rusakova.nastasia@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/block/virtio-blk: Clean req->dev
 repetitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jusual@mail.ru, Anastasiia Rusakova <arusakova917@gmail.com>

From: Anastasiia Rusakova <arusakova917@gmail.com>

Some functions sometimes uses req->dev even though a local variable
VirtIOBlock* s = req->dev has already been defined.
Updated places to use s everywhere in the file.

Signed-off-by: Anastasiia Rusakova <arusakova917@gmail.com>
---
 hw/block/virtio-blk.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 0cc3c590b9..06e57a4d39 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -127,7 +127,7 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
         }
 
         if (ret) {
-            int p = virtio_ldl_p(VIRTIO_DEVICE(req->dev), &req->out.type);
+            int p = virtio_ldl_p(VIRTIO_DEVICE(s), &req->out.type);
             bool is_read = !(p & VIRTIO_BLK_T_OUT);
             /* Note that memory may be dirtied on read failure.  If the
              * virtio request is not completed here, as is the case for
@@ -143,7 +143,7 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
         }
 
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
-        block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
+        block_acct_done(blk_get_stats(s->blk), &req->acct);
         virtio_blk_free_request(req);
     }
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
@@ -260,9 +260,9 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
 {
     int status = VIRTIO_BLK_S_OK;
     struct virtio_scsi_inhdr *scsi = NULL;
-    VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
-    VirtQueueElement *elem = &req->elem;
     VirtIOBlock *blk = req->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(blk);
+    VirtQueueElement *elem = &req->elem;
 
 #ifdef __linux__
     int i;
@@ -492,16 +492,18 @@ static void virtio_blk_submit_multireq(BlockBackend *blk, MultiReqBuffer *mrb)
 
 static void virtio_blk_handle_flush(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 {
-    block_acct_start(blk_get_stats(req->dev->blk), &req->acct, 0,
+    VirtIOBlock *s = req->dev;
+
+    block_acct_start(blk_get_stats(s->blk), &req->acct, 0,
                      BLOCK_ACCT_FLUSH);
 
     /*
      * Make sure all outstanding writes are posted to the backing device.
      */
     if (mrb->is_write && mrb->num_reqs > 0) {
-        virtio_blk_submit_multireq(req->dev->blk, mrb);
+        virtio_blk_submit_multireq(s->blk, mrb);
     }
-    blk_aio_flush(req->dev->blk, virtio_blk_flush_complete, req);
+    blk_aio_flush(s->blk, virtio_blk_flush_complete, req);
 }
 
 static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
-- 
2.20.1
