Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFn-0006hA-Kd
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFm-0002yc-I7
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:23 +0100
Message-Id: <1483969476-7172-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/14] qemu-img: fix in-flight count for
 qemu-img bench
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

From: Paolo Bonzini <pbonzini@redhat.com>

With aio=native (qemu-img bench -n) one or more requests can be completed
when a new request is submitted.  This in turn can cause bench_cb to
recurse before b->in_flight is updated.  This causes multiple I/Os
to be submitted with the same offset and, furthermore, the blk_aio_*
coroutines are never freed and qemu-img aborts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6949b73..5df66fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3559,20 +3559,23 @@ static void bench_cb(void *opaque, int ret)
     }
 
     while (b->n > b->in_flight && b->in_flight < b->nrreq) {
+        int64_t offset = b->offset;
+        /* blk_aio_* might look for completed I/Os and kick bench_cb
+         * again, so make sure this operation is counted by in_flight
+         * and b->offset is ready for the next submission.
+         */
+        b->in_flight++;
+        b->offset += b->step;
+        b->offset %= b->image_size;
         if (b->write) {
-            acb = blk_aio_pwritev(b->blk, b->offset, b->qiov, 0,
-                                  bench_cb, b);
+            acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
         } else {
-            acb = blk_aio_preadv(b->blk, b->offset, b->qiov, 0,
-                                 bench_cb, b);
+            acb = blk_aio_preadv(b->blk, offset, b->qiov, 0, bench_cb, b);
         }
         if (!acb) {
             error_report("Failed to issue request");
             exit(EXIT_FAILURE);
         }
-        b->in_flight++;
-        b->offset += b->step;
-        b->offset %= b->image_size;
     }
 }
 
-- 
1.8.3.1
