Received: from eggs.gnu.org ([209.51.188.92]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBUz-000263-Ms
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBUx-0001SD-OD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:33 +0000
Message-Id: <20190222140756.29834-5-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/27] block/backup: use qemu_iovec_init_buf
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
Message-id: 20190218140926.333779-5-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-5-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/backup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 435414e964..9988753249 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -107,7 +107,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
                                                       void **bounce_buff=
er)
 {
     int ret;
-    struct iovec iov;
     QEMUIOVector qiov;
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
@@ -119,9 +118,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     if (!*bounce_buffer) {
         *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
     }
-    iov.iov_base =3D *bounce_buffer;
-    iov.iov_len =3D nbytes;
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, *bounce_buffer, nbytes);
=20
     ret =3D blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
     if (ret < 0) {
--=20
2.20.1
