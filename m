Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pO-0003Rx-3I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pL-0007R0-Bc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:45:02 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 13 Jun 2018 20:44:25 +0300
Message-Id: <1528911866-37489-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 7/8] file-posix: account discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

This will help to identify how many of the user-issued discard operations
(accounted on a device level) have actually suceeded down on the host file
(even though the numbers will not be exactly the same if non-raw format
driver is used (e.g. qcow2 sending metadata discards)).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 07bb061..4a2e394 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -163,6 +163,11 @@ typedef struct BDRVRawState {
     bool has_fallocate;
     bool needs_alignment;
     bool check_cache_dropped;
+    struct {
+        int64_t discard_nb_ok;
+        int64_t discard_nb_failed;
+        int64_t discard_bytes_ok;
+    } stats;
 
     PRManager *pr_mgr;
 } BDRVRawState;
@@ -1533,6 +1538,16 @@ static ssize_t handle_aiocb_discard(RawPosixAIOData *aiocb)
     return ret;
 }
 
+static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int ret)
+{
+    if (ret) {
+        s->stats.discard_nb_failed++;
+    } else {
+        s->stats.discard_nb_ok++;
+        s->stats.discard_bytes_ok += nbytes;
+    }
+}
+
 static int aio_worker(void *arg)
 {
     RawPosixAIOData *aiocb = arg;
@@ -1569,6 +1584,7 @@ static int aio_worker(void *arg)
         break;
     case QEMU_AIO_DISCARD:
         ret = handle_aiocb_discard(aiocb);
+        raw_account_discard(aiocb->bs->opaque, aiocb->aio_nbytes, ret);
         break;
     case QEMU_AIO_WRITE_ZEROES:
         ret = handle_aiocb_write_zeroes(aiocb);
@@ -2965,8 +2981,9 @@ static coroutine_fn BlockAIOCB *hdev_aio_pdiscard(BlockDriverState *bs,
     BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
-
-    if (fd_open(bs) < 0) {
+    int ret = fd_open(bs);
+    if (ret < 0) {
+        raw_account_discard(s, bytes, ret);
         return NULL;
     }
     return paio_submit(bs, s->fd, offset, NULL, bytes,
-- 
2.7.4
