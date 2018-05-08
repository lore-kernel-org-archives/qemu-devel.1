Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44l-0000I9-4x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44h-0001Ye-0k
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:47 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  8 May 2018 17:58:12 +0300
Message-Id: <1525791496-125188-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 5/9] block: treat BDRV_REQ_ALLOCATE as
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
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 660702a..a2fb69a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -598,12 +598,13 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
+static bool coroutine_fn find_or_wait_serialising_requests(
+    BdrvTrackedRequest *self, bool wait)
 {
     BlockDriverState *bs = self->bs;
     BdrvTrackedRequest *req;
     bool retry;
-    bool waited = false;
+    bool found = false;
 
     if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
@@ -629,11 +630,14 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * will wait for us as soon as it wakes up, then just go on
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
+                    found = true;
+                    if (!wait) {
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
@@ -641,7 +645,12 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
         qemu_co_mutex_unlock(&bs->reqs_lock);
     } while (retry);
 
-    return waited;
+    return found;
+}
+
+static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
+{
+    return find_or_wait_serialising_requests(self, true);
 }
 
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
@@ -1473,7 +1482,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
-    bool waited;
+    bool found;
     int ret;
 
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
@@ -1497,8 +1506,13 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
-    waited = wait_serialising_requests(req);
-    assert(!waited || !req->serialising);
+    found = find_or_wait_serialising_requests(req,
+                                              !(flags & BDRV_REQ_ALLOCATE));
+    if (found && (flags & BDRV_REQ_ALLOCATE)) {
+        return -EAGAIN;
+    }
+
+    assert(!found || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
     assert(child->perm & BLK_PERM_WRITE);
@@ -1623,6 +1637,10 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         bytes -= zero_bytes;
     }
 
+    if (flags & BDRV_REQ_ALLOCATE) {
+        mark_request_serialising(req, align);
+    }
+
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes >= align) {
         /* Write the aligned part in the middle. */
-- 
2.7.4
