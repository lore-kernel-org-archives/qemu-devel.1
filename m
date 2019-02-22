Received: from eggs.gnu.org ([209.51.188.92]:38016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVF-0002O7-Qy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVC-0001sl-1M
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:42 +0000
Message-Id: <20190222140756.29834-14-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] migration/block: use qemu_iovec_init_buf
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

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-14-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-14-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/block.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 0e24e18d13..83c633fb3f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -83,7 +83,6 @@ typedef struct BlkMigBlock {
     BlkMigDevState *bmds;
     int64_t sector;
     int nr_sectors;
-    struct iovec iov;
     QEMUIOVector qiov;
     BlockAIOCB *aiocb;
=20
@@ -314,9 +313,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDe=
vState *bmds)
     blk->sector =3D cur_sector;
     blk->nr_sectors =3D nr_sectors;
=20
-    blk->iov.iov_base =3D blk->buf;
-    blk->iov.iov_len =3D nr_sectors * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&blk->qiov, &blk->iov, 1);
+    qemu_iovec_init_buf(&blk->qiov, blk->buf, nr_sectors * BDRV_SECTOR_S=
IZE);
=20
     blk_mig_lock();
     block_mig_state.submitted++;
@@ -556,9 +553,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigD=
evState *bmds,
             blk->nr_sectors =3D nr_sectors;
=20
             if (is_async) {
-                blk->iov.iov_base =3D blk->buf;
-                blk->iov.iov_len =3D nr_sectors * BDRV_SECTOR_SIZE;
-                qemu_iovec_init_external(&blk->qiov, &blk->iov, 1);
+                qemu_iovec_init_buf(&blk->qiov, blk->buf,
+                                    nr_sectors * BDRV_SECTOR_SIZE);
=20
                 blk->aiocb =3D blk_aio_preadv(bmds->blk,
                                             sector * BDRV_SECTOR_SIZE,
--=20
2.20.1
