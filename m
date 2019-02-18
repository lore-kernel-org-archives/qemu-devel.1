Received: from eggs.gnu.org ([209.51.188.92]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcD-0004kH-GJ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjc3-00077S-9O
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:45 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:13 +0300
Message-Id: <20190218140926.333779-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 04/17] block/backup: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/backup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 435414e964..9988753249 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -107,7 +107,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       void **bounce_buffer)
 {
     int ret;
-    struct iovec iov;
     QEMUIOVector qiov;
     BlockBackend *blk = job->common.blk;
     int nbytes;
@@ -119,9 +118,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
     }
-    iov.iov_base = *bounce_buffer;
-    iov.iov_len = nbytes;
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, *bounce_buffer, nbytes);
 
     ret = blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
     if (ret < 0) {
-- 
2.18.0
