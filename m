Received: from eggs.gnu.org ([209.51.188.92]:49070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv0-0008CD-DY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuz-0002ET-Dm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:39 +0200
Message-Id: <20190430154244.30083-23-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/27] block/commit: use buffer-based io
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
 block/commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..08204fa6f8 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -48,16 +48,15 @@ static int coroutine_fn commit_populate(BlockBackend =
*bs, BlockBackend *base,
                                         void *buf)
 {
     int ret =3D 0;
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
     assert(bytes < SIZE_MAX);
=20
-    ret =3D blk_co_preadv(bs, offset, qiov.size, &qiov, 0);
+    ret =3D blk_co_pread(bs, offset, bytes, buf, 0);
     if (ret < 0) {
         return ret;
     }
=20
-    ret =3D blk_co_pwritev(base, offset, qiov.size, &qiov, 0);
+    ret =3D blk_co_pwrite(base, offset, bytes, buf, 0);
     if (ret < 0) {
         return ret;
     }
--=20
2.20.1
