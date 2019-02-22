Received: from eggs.gnu.org ([209.51.188.92]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVd-0002iR-MK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVS-00029X-KU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:44 +0000
Message-Id: <20190222140756.29834-16-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/27] hw/ide: drop iov field from IDEState
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
Message-id: 20190218140926.333779-16-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-16-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/ide/internal.h | 1 -
 hw/ide/atapi.c            | 9 ++++-----
 hw/ide/core.c             | 8 ++------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 880413ddc7..fa99486d7a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -405,7 +405,6 @@ struct IDEState {
     int atapi_dma; /* true if dma is requested for the packet cmd */
     BlockAcctCookie acct;
     BlockAIOCB *pio_aiocb;
-    struct iovec iov;
     QEMUIOVector qiov;
     QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
     /* ATA DMA state */
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 39e473f9c2..4de86555d9 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -174,16 +174,15 @@ static void cd_read_sector_cb(void *opaque, int ret=
)
=20
 static int cd_read_sector(IDEState *s)
 {
+    void *buf;
+
     if (s->cd_sector_size !=3D 2048 && s->cd_sector_size !=3D 2352) {
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
         return -EINVAL;
     }
=20
-    s->iov.iov_base =3D (s->cd_sector_size =3D=3D 2352) ?
-                      s->io_buffer + 16 : s->io_buffer;
-
-    s->iov.iov_len =3D ATAPI_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    buf =3D (s->cd_sector_size =3D=3D 2352) ? s->io_buffer + 16 : s->io_=
buffer;
+    qemu_iovec_init_buf(&s->qiov, buf, ATAPI_SECTOR_SIZE);
=20
     trace_cd_read_sector(s->lba);
=20
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 84832008b8..13f8f78ca6 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -774,9 +774,7 @@ static void ide_sector_read(IDEState *s)
         return;
     }
=20
-    s->iov.iov_base =3D s->io_buffer;
-    s->iov.iov_len  =3D n * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
=20
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      n * BDRV_SECTOR_SIZE, BLOCK_ACCT_READ);
@@ -1045,9 +1043,7 @@ static void ide_sector_write(IDEState *s)
         return;
     }
=20
-    s->iov.iov_base =3D s->io_buffer;
-    s->iov.iov_len  =3D n * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
=20
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      n * BDRV_SECTOR_SIZE, BLOCK_ACCT_WRITE);
--=20
2.20.1
