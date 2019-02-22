Received: from eggs.gnu.org ([209.51.188.92]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBW3-00034u-6N
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVs-0002d2-Lt
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:45 +0000
Message-Id: <20190222140756.29834-17-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/27] hw/ide: drop iov field from
 IDEBufferedRequest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

@iov is used only to initialize @qiov. Let's use new
qemu_iovec_init_buf() instead, which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-17-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-17-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/ide/internal.h |  1 -
 hw/ide/core.c             | 11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index fa99486d7a..1b02bb9151 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -346,7 +346,6 @@ extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT]=
;
=20
 typedef struct IDEBufferedRequest {
     QLIST_ENTRY(IDEBufferedRequest) list;
-    struct iovec iov;
     QEMUIOVector qiov;
     QEMUIOVector *original_qiov;
     BlockCompletionFunc *original_cb;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 13f8f78ca6..6afadf894f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -629,13 +629,15 @@ static void ide_buffered_readv_cb(void *opaque, int=
 ret)
     IDEBufferedRequest *req =3D opaque;
     if (!req->orphaned) {
         if (!ret) {
-            qemu_iovec_from_buf(req->original_qiov, 0, req->iov.iov_base=
,
+            assert(req->qiov.size =3D=3D req->original_qiov->size);
+            qemu_iovec_from_buf(req->original_qiov, 0,
+                                req->qiov.local_iov.iov_base,
                                 req->original_qiov->size);
         }
         req->original_cb(req->original_opaque, ret);
     }
     QLIST_REMOVE(req, list);
-    qemu_vfree(req->iov.iov_base);
+    qemu_vfree(qemu_iovec_buf(&req->qiov));
     g_free(req);
 }
=20
@@ -660,9 +662,8 @@ BlockAIOCB *ide_buffered_readv(IDEState *s, int64_t s=
ector_num,
     req->original_qiov =3D iov;
     req->original_cb =3D cb;
     req->original_opaque =3D opaque;
-    req->iov.iov_base =3D qemu_blockalign(blk_bs(s->blk), iov->size);
-    req->iov.iov_len =3D iov->size;
-    qemu_iovec_init_external(&req->qiov, &req->iov, 1);
+    qemu_iovec_init_buf(&req->qiov, blk_blockalign(s->blk, iov->size),
+                        iov->size);
=20
     aioreq =3D blk_aio_preadv(s->blk, sector_num << BDRV_SECTOR_BITS,
                             &req->qiov, 0, ide_buffered_readv_cb, req);
--=20
2.20.1
