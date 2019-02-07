Received: from eggs.gnu.org ([209.51.188.92]:37044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgru-0002z8-PW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrt-00025t-Sq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:42 +0300
Message-Id: <20190207102445.71998-15-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 14/17] tests/test-bdrv-drain: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/test-bdrv-drain.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index ee1740ff06..821be405f0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -204,12 +204,7 @@ static void test_drv_cb_common(enum drain_type drain_type, bool recursive)
     BlockAIOCB *acb;
     int aio_ret;
 
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = NULL,
-        .iov_len = 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
     blk = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
     bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
@@ -670,12 +665,7 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
     AioContext *ctx_a = iothread_get_aio_context(a);
     AioContext *ctx_b = iothread_get_aio_context(b);
 
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = NULL,
-        .iov_len = 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
     /* bdrv_drain_all() may only be called from the main loop thread */
     if (drain_type == BDRV_DRAIN_ALL && drain_thread != 0) {
@@ -1148,13 +1138,7 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
     BlockDriverState *bs = blk_bs(blk);
     BDRVTestTopState *tts = bs->opaque;
     void *buffer = g_malloc(65536);
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = buffer,
-        .iov_len  = 65536,
-    };
-
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buffer, 65536);
 
     /* Pretend some internal write operation from parent to child.
      * Important: We have to read from the child, not from the parent!
@@ -1365,12 +1349,7 @@ static void test_detach_indirect(bool by_parent_cb)
     BdrvChild *child_a, *child_b;
     BlockAIOCB *acb;
 
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = NULL,
-        .iov_len = 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
     if (!by_parent_cb) {
         detach_by_driver_cb_role = child_file;
-- 
2.18.0
