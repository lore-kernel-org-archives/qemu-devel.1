Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z1-0003DG-V0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z1-0001ZY-0R
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:17 +0100
Message-Id: <20181212132735.16080-24-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/41] file-posix: Remove paio_submit_co()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The function is not used any more, remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0f64c83639..c8a085a911 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1824,40 +1824,6 @@ static int coroutine_fn raw_thread_pool_submit(Blo=
ckDriverState *bs,
     return thread_pool_submit_co(pool, func, arg);
 }
=20
-static int paio_submit_co_full(BlockDriverState *bs, int fd,
-                               int64_t offset, int fd2, int64_t offset2,
-                               QEMUIOVector *qiov,
-                               int bytes, int type)
-{
-    RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
-
-    acb->bs =3D bs;
-    acb->aio_type =3D type;
-    acb->aio_fildes =3D fd;
-
-    acb->aio_nbytes =3D bytes;
-    acb->aio_offset =3D offset;
-
-    if (qiov) {
-        acb->io.iov =3D qiov->iov;
-        acb->io.niov =3D qiov->niov;
-        assert(qiov->size =3D=3D bytes);
-    } else {
-        acb->copy_range.aio_fd2 =3D fd2;
-        acb->copy_range.aio_offset2 =3D offset2;
-    }
-
-    trace_file_paio_submit_co(offset, bytes, type);
-    return raw_thread_pool_submit(bs, aio_worker, acb);
-}
-
-static inline int paio_submit_co(BlockDriverState *bs, int fd,
-                                 int64_t offset, QEMUIOVector *qiov,
-                                 int bytes, int type)
-{
-    return paio_submit_co_full(bs, fd, offset, -1, 0, qiov, bytes, type)=
;
-}
-
 static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset=
,
                                    uint64_t bytes, QEMUIOVector *qiov, i=
nt type)
 {
--=20
2.19.2
