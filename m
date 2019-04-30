Received: from eggs.gnu.org ([209.51.188.92]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv0-0008Bp-5w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuz-0002EI-9U
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:40 +0200
Message-Id: <20190430154244.30083-24-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/27] block/stream: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index bfaebb861a..1a906fd860 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -42,12 +42,10 @@ static int coroutine_fn stream_populate(BlockBackend =
*blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
 {
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
     assert(bytes < SIZE_MAX);
=20
     /* Copy-on-read the unallocated clusters */
-    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON=
_READ);
+    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
 }
=20
 static void stream_abort(Job *job)
--=20
2.20.1
