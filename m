Received: from eggs.gnu.org ([209.51.188.92]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-00083O-Vb
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-000269-9Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:33 +0200
Message-Id: <20190430154244.30083-17-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/27] block: introduce byte-based io helpers
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
 include/block/block_int.h      | 16 ++++++++++++++++
 include/sysemu/block-backend.h | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..94d45c9708 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -925,6 +925,22 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
=20
+static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
+    int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flag=
s)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return bdrv_co_preadv(child, offset, bytes, &qiov, flags);
+}
+
+static inline int coroutine_fn bdrv_co_pwrite(BdrvChild *child,
+    int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flag=
s)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return bdrv_co_pwritev(child, offset, bytes, &qiov, flags);
+}
+
 extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_=
parent);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 3be05c2d68..5be6224226 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -124,6 +124,25 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, in=
t64_t offset,
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
+
+static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t o=
ffset,
+                                            unsigned int bytes, void *bu=
f,
+                                            BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return blk_co_preadv(blk, offset, bytes, &qiov, flags);
+}
+
+static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t =
offset,
+                                             unsigned int bytes, void *b=
uf,
+                                             BdrvRequestFlags flags)
+{
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+
+    return blk_co_pwritev(blk, offset, bytes, &qiov, flags);
+}
+
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                       int bytes, BdrvRequestFlags flags);
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
--=20
2.20.1
