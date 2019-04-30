Received: from eggs.gnu.org ([209.51.188.92]:48995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUux-00089g-Dy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-0002CP-DD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:38 +0200
Message-Id: <20190430154244.30083-22-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/27] block/backup: use buffer-based io
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
 block/backup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9988753249..910ed764aa 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -107,7 +107,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
                                                       void **bounce_buff=
er)
 {
     int ret;
-    QEMUIOVector qiov;
     BlockBackend *blk =3D job->common.blk;
     int nbytes;
     int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
@@ -118,9 +117,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer=
(BackupBlockJob *job,
     if (!*bounce_buffer) {
         *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
     }
-    qemu_iovec_init_buf(&qiov, *bounce_buffer, nbytes);
=20
-    ret =3D blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
+    ret =3D blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags)=
;
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -129,13 +127,13 @@ static int coroutine_fn backup_cow_with_bounce_buff=
er(BackupBlockJob *job,
         goto fail;
     }
=20
-    if (qemu_iovec_is_zero(&qiov)) {
+    if (buffer_is_zero(*bounce_buffer, nbytes)) {
         ret =3D blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, write_flags | BDRV_REQ_MAY=
_UNMAP);
+                                   nbytes, write_flags | BDRV_REQ_MAY_UN=
MAP);
     } else {
-        ret =3D blk_co_pwritev(job->target, start,
-                             qiov.size, &qiov, write_flags |
-                             (job->compress ? BDRV_REQ_WRITE_COMPRESSED =
: 0));
+        ret =3D blk_co_pwrite(job->target, start,
+                            nbytes, *bounce_buffer, write_flags |
+                            (job->compress ? BDRV_REQ_WRITE_COMPRESSED :=
 0));
     }
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
--=20
2.20.1
