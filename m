Received: from eggs.gnu.org ([2001:4830:134:3::10]:55636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvM-0002dn-PE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ebQvI-0006UQ-L4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:05:08 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 16 Jan 2018 16:04:25 +0300
Message-Id: <1516107870-8110-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The idea is that ALLOCATE requests may overlap with other requests.
Reuse the existing block layer infrastructure for serialising requests.
Use the following approach:
  - mark ALLOCATE serialising, so subsequent requests to the area wait
  - ALLOCATE request itself must never wait if another request is in flight
    already. Return EAGAIN, let the caller reconsider.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/io.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index cf2f84c..4b0d34f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -605,7 +605,8 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
+static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self,
+                                                   bool nowait)
 {
     BlockDriverState *bs = self->bs;
     BdrvTrackedRequest *req;
@@ -636,11 +637,14 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * will wait for us as soon as it wakes up, then just go on
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
+                    waited = true;
+                    if (nowait) {
+                        break;
+                    }
                     self->waiting_for = req;
                     qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
                     self->waiting_for = NULL;
                     retry = true;
-                    waited = true;
                     break;
                 }
             }
@@ -1206,7 +1210,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     }
 
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
-        wait_serialising_requests(req);
+        wait_serialising_requests(req, false);
     }
 
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1504,7 +1508,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
-    waited = wait_serialising_requests(req);
+    waited = wait_serialising_requests(req, flags & BDRV_REQ_ALLOCATE);
+    if (waited && flags & BDRV_REQ_ALLOCATE) {
+        return -EAGAIN;
+    }
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
@@ -1608,7 +1615,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
         /* RMW the unaligned part before head. */
         mark_request_serialising(req, align);
-        wait_serialising_requests(req);
+        wait_serialising_requests(req, false);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
         ret = bdrv_aligned_preadv(child, req, offset & ~(align - 1), align,
                                   align, &local_qiov, 0);
@@ -1628,6 +1635,10 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         bytes -= zero_bytes;
     }
 
+    if (flags & BDRV_REQ_ALLOCATE) {
+        mark_request_serialising(req, align);
+    }
+
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes >= align) {
         /* Write the aligned part in the middle. */
@@ -1646,7 +1657,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         assert(align == tail_padding_bytes + bytes);
         /* RMW the unaligned part after tail. */
         mark_request_serialising(req, align);
-        wait_serialising_requests(req);
+        wait_serialising_requests(req, false);
         bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
         ret = bdrv_aligned_preadv(child, req, offset, align,
                                   align, &local_qiov, 0);
@@ -1717,7 +1728,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         struct iovec head_iov;
 
         mark_request_serialising(&req, align);
-        wait_serialising_requests(&req);
+        wait_serialising_requests(&req, false);
 
         head_buf = qemu_blockalign(bs, align);
         head_iov = (struct iovec) {
@@ -1758,7 +1769,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         bool waited;
 
         mark_request_serialising(&req, align);
-        waited = wait_serialising_requests(&req);
+        waited = wait_serialising_requests(&req, false);
         assert(!waited || !use_local_qiov);
 
         tail_buf = qemu_blockalign(bs, align);
-- 
2.7.4
