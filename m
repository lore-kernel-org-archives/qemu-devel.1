Received: from eggs.gnu.org ([209.51.188.92]:37751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV1-00027X-Hd
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV0-0001ZJ-It
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:35 +0000
Message-Id: <20190222140756.29834-7-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] block/stream: use QEMU_IOVEC_INIT_BUF
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

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-7-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-7-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/stream.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7a49ac0992..e14579ff80 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -41,14 +41,9 @@ static int coroutine_fn stream_populate(BlockBackend *=
blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
 {
-    struct iovec iov =3D {
-        .iov_base =3D buf,
-        .iov_len  =3D bytes,
-    };
-    QEMUIOVector qiov;
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
     assert(bytes < SIZE_MAX);
-    qemu_iovec_init_external(&qiov, &iov, 1);
=20
     /* Copy-on-read the unallocated clusters */
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON=
_READ);
--=20
2.20.1
