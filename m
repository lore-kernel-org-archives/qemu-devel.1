Received: from eggs.gnu.org ([209.51.188.92]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081V-G2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00024i-9x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:20 +0200
Message-Id: <20190430154244.30083-4-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] vpc: unlock Coroutine lock to make IO
 submit Concurrently
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

From: Zhengui li <lizhengui@huawei.com>

Concurrent IO becomes serial IO because of the qemu Coroutine lock,
which reduce IO performance severely.

So unlock Coroutine lock before bdrv_co_pwritev and
bdrv_co_preadv to fix it.

Signed-off-by: Zhengui li <lizhengui@huawei.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vpc.c b/block/vpc.c
index a902a4c54d..0c279b87c8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -639,8 +639,10 @@ vpc_co_preadv(BlockDriverState *bs, uint64_t offset,=
 uint64_t bytes,
             qemu_iovec_reset(&local_qiov);
             qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
=20
+            qemu_co_mutex_unlock(&s->lock);
             ret =3D bdrv_co_preadv(bs->file, image_offset, n_bytes,
                                  &local_qiov, 0);
+            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
@@ -697,8 +699,10 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset=
, uint64_t bytes,
         qemu_iovec_reset(&local_qiov);
         qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
=20
+        qemu_co_mutex_unlock(&s->lock);
         ret =3D bdrv_co_pwritev(bs->file, image_offset, n_bytes,
                               &local_qiov, 0);
+        qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             goto fail;
         }
--=20
2.20.1
