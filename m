Received: from eggs.gnu.org ([209.51.188.92]:33108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcX-00056c-RB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcW-0007S4-3n
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:09 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:14 +0300
Message-Id: <20190218140926.333779-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 05/17] block/commit: use QEMU_IOVEC_INIT_BUF
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

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/commit.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 53148e610b..d500a93068 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -47,14 +47,9 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
                                         void *buf)
 {
     int ret = 0;
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = buf,
-        .iov_len = bytes,
-    };
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     assert(bytes < SIZE_MAX);
-    qemu_iovec_init_external(&qiov, &iov, 1);
 
     ret = blk_co_preadv(bs, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
-- 
2.18.0
