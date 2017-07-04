Received: from eggs.gnu.org ([2001:4830:134:3::10]:49372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyD-00018i-9i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyA-0001SY-Pa
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:57 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:41 +0200
Message-Id: <20170704220346.29244-31-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 30/35] block-backend: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/block-backend.h |  4 ++--
 block/block-backend.c          | 36 ++++++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 1e05281fff..2f967037af 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -165,8 +165,8 @@ int blk_co_ioctl(BlockBackend *blk, unsigned long int=
 req, void *buf);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void=
 *buf,
                           BlockCompletionFunc *cb, void *opaque);
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
-int blk_co_flush(BlockBackend *blk);
+int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset, int =
bytes);
+int coroutine_fn blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
 int blk_commit_all(void);
 void blk_drain(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 56fc0a4d1e..a48aa4f900 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1032,7 +1032,8 @@ typedef struct BlkRwCo {
     BdrvRequestFlags flags;
 } BlkRwCo;
=20
-static void blk_read_entry(void *opaque)
+static void coroutine_fn
+blk_read_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
=20
@@ -1040,7 +1041,8 @@ static void blk_read_entry(void *opaque)
                               rwco->qiov, rwco->flags);
 }
=20
-static void blk_write_entry(void *opaque)
+static void coroutine_fn
+blk_write_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
=20
@@ -1195,7 +1197,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, =
int64_t offset, int bytes,
     return &acb->common;
 }
=20
-static void blk_aio_read_entry(void *opaque)
+static void coroutine_fn
+blk_aio_read_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
@@ -1206,7 +1209,8 @@ static void blk_aio_read_entry(void *opaque)
     blk_aio_complete(acb);
 }
=20
-static void blk_aio_write_entry(void *opaque)
+static void coroutine_fn
+blk_aio_write_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
@@ -1288,7 +1292,8 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int6=
4_t offset,
                         blk_aio_write_entry, flags, cb, opaque);
 }
=20
-static void blk_aio_flush_entry(void *opaque)
+static void coroutine_fn
+blk_aio_flush_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
@@ -1303,7 +1308,8 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
     return blk_aio_prwv(blk, 0, 0, NULL, blk_aio_flush_entry, 0, cb, opa=
que);
 }
=20
-static void blk_aio_pdiscard_entry(void *opaque)
+static void coroutine_fn
+blk_aio_pdiscard_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
@@ -1339,7 +1345,8 @@ int blk_co_ioctl(BlockBackend *blk, unsigned long i=
nt req, void *buf)
     return bdrv_co_ioctl(blk_bs(blk), req, buf);
 }
=20
-static void blk_ioctl_entry(void *opaque)
+static void coroutine_fn
+blk_ioctl_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
     rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
@@ -1351,7 +1358,8 @@ int blk_ioctl(BlockBackend *blk, unsigned long int =
req, void *buf)
     return blk_prw(blk, req, buf, 0, blk_ioctl_entry, 0);
 }
=20
-static void blk_aio_ioctl_entry(void *opaque)
+static void coroutine_fn
+blk_aio_ioctl_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
@@ -1376,7 +1384,8 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsign=
ed long int req, void *buf,
     return blk_aio_prwv(blk, req, 0, &qiov, blk_aio_ioctl_entry, 0, cb, =
opaque);
 }
=20
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+int coroutine_fn
+blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
     int ret =3D blk_check_byte_request(blk, offset, bytes);
     if (ret < 0) {
@@ -1386,7 +1395,8 @@ int blk_co_pdiscard(BlockBackend *blk, int64_t offs=
et, int bytes)
     return bdrv_co_pdiscard(blk_bs(blk), offset, bytes);
 }
=20
-int blk_co_flush(BlockBackend *blk)
+int coroutine_fn
+blk_co_flush(BlockBackend *blk)
 {
     if (!blk_is_available(blk)) {
         return -ENOMEDIUM;
@@ -1395,7 +1405,8 @@ int blk_co_flush(BlockBackend *blk)
     return bdrv_co_flush(blk_bs(blk));
 }
=20
-static void blk_flush_entry(void *opaque)
+static void coroutine_fn
+blk_flush_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
     rwco->ret =3D blk_co_flush(rwco->blk);
@@ -1785,7 +1796,8 @@ int blk_truncate(BlockBackend *blk, int64_t offset,=
 Error **errp)
     return bdrv_truncate(blk->root, offset, errp);
 }
=20
-static void blk_pdiscard_entry(void *opaque)
+static void coroutine_fn
+blk_pdiscard_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
     rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, rwco->qiov->s=
ize);
--=20
2.13.1.395.gf7b71de06
