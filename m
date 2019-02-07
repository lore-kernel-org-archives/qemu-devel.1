Received: from eggs.gnu.org ([209.51.188.92]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrb-0002iT-9u
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001je-1e
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:44 +0300
Message-Id: <20190207102445.71998-17-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 16/17] hw/ide: drop iov field from
 IDEBufferedRequest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

@iov is used only to initialize @qiov. Let's use new
qemu_iovec_init_buf() instead, which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/hw/ide/internal.h |  1 -
 hw/ide/core.c             | 11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index fa99486d7a..1b02bb9151 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -346,7 +346,6 @@ extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
 typedef struct IDEBufferedRequest {
     QLIST_ENTRY(IDEBufferedRequest) list;
-    struct iovec iov;
     QEMUIOVector qiov;
     QEMUIOVector *original_qiov;
     BlockCompletionFunc *original_cb;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index e94ba8c488..1cf87fdefe 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -629,13 +629,15 @@ static void ide_buffered_readv_cb(void *opaque, int ret)
     IDEBufferedRequest *req = opaque;
     if (!req->orphaned) {
         if (!ret) {
-            qemu_iovec_from_buf(req->original_qiov, 0, req->iov.iov_base,
+            assert(req->qiov.size == req->original_qiov->size);
+            qemu_iovec_from_buf(req->original_qiov, 0,
+                                req->qiov.local_iov.iov_base,
                                 req->original_qiov->size);
         }
         req->original_cb(req->original_opaque, ret);
     }
     QLIST_REMOVE(req, list);
-    qemu_vfree(req->iov.iov_base);
+    qemu_vfree(qemu_iovec_get_buf(&req->qiov));
     g_free(req);
 }
 
@@ -660,9 +662,8 @@ BlockAIOCB *ide_buffered_readv(IDEState *s, int64_t sector_num,
     req->original_qiov = iov;
     req->original_cb = cb;
     req->original_opaque = opaque;
-    req->iov.iov_base = qemu_blockalign(blk_bs(s->blk), iov->size);
-    req->iov.iov_len = iov->size;
-    qemu_iovec_init_external(&req->qiov, &req->iov, 1);
+    qemu_iovec_init_buf(&req->qiov, blk_blockalign(s->blk, iov->size),
+                        iov->size);
 
     aioreq = blk_aio_preadv(s->blk, sector_num << BDRV_SECTOR_BITS,
                             &req->qiov, 0, ide_buffered_readv_cb, req);
-- 
2.18.0
