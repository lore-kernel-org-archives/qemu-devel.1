Received: from eggs.gnu.org ([209.51.188.92]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV8-0002EG-Rf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV3-0001fh-8F
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:34 +0000
Message-Id: <20190222140756.29834-6-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/27] block/commit: use QEMU_IOVEC_INIT_BUF
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
Message-id: 20190218140926.333779-6-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-6-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/commit.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 53148e610b..d500a93068 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -47,14 +47,9 @@ static int coroutine_fn commit_populate(BlockBackend *=
bs, BlockBackend *base,
                                         void *buf)
 {
     int ret =3D 0;
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D buf,
-        .iov_len =3D bytes,
-    };
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
=20
     assert(bytes < SIZE_MAX);
-    qemu_iovec_init_external(&qiov, &iov, 1);
=20
     ret =3D blk_co_preadv(bs, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
--=20
2.20.1
