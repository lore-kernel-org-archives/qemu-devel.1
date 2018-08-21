Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3Fc-0003zQ-Ih
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FX-00084J-OJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:47:00 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:18 +0300
Message-Id: <1534844779-118784-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 7/8] file-posix: account discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

This will help to identify how many of the user-issued discard operations
(accounted on a device level) have actually suceeded down on the host file
(even though the numbers will not be exactly the same if non-raw format
driver is used (e.g. qcow2 sending metadata discards)).

Note that these numbers will not include discards triggered by
write-zeroes + MAY_UNMAP calls.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/file-posix.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index fe83cbf..c420f76 100644
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
@@ -2575,12 +2580,25 @@ static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
 #endif /* !__linux__ */
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
 static coroutine_fn int
 raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
     BDRVRawState *s = bs->opaque;
+    int ret;
 
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCARD);
+    ret = paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCARD);
+    raw_account_discard(s, bytes, ret);
+    return ret;
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(
@@ -3077,10 +3095,14 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 
     ret = fd_open(bs);
     if (ret < 0) {
+        raw_account_discard(s, bytes, ret);
         return ret;
     }
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                          QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
+
+    ret = paio_submit_co(bs, s->fd, offset, NULL, bytes,
+                         QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
+    raw_account_discard(s, bytes, ret);
+    return ret;
 }
 
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
-- 
2.7.4
