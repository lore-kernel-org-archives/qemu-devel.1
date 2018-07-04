Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faluw-0000Un-Il
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 13:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1falut-0006Yy-57
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 13:50:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  4 Jul 2018 20:50:03 +0300
Message-Id: <20180704175006.519184-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180704175006.519184-1-vsementsov@virtuozzo.com>
References: <20180704175006.519184-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/4] block: disallow BDRV_REQ_NO_SERIALISING
 for write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Before commit 9ded4a01149 "backup: Use copy offloading",
BDRV_REQ_NO_SERIALISING was used for only one case: read in
copy-on-write operation during backup. Also, the flag was handled only
on read path (in bdrv_co_preadv and bdrv_aligned_preadv).

After 9ded4a01149, flag is used for not waiting serializing operations
on backup target (in same case of copy-on-write operation). This
behavior change is unsubstantiated and potentially dangerous, let's
drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 13 +++++++++++++
 block/io.c            |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index e5c7759a0c..a06a4d27de 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -50,6 +50,19 @@ typedef enum {
      * opened with BDRV_O_UNMAP.
      */
     BDRV_REQ_MAY_UNMAP          = 0x4,
+
+    /* The BDRV_REQ_NO_SERIALISING means that we don't want to
+     * wait_serialising_requests(), when reading.
+     *
+     * This flag is used for backup copy on write operation, when we need to
+     * read old data before write (write notifier triggered). It is ok, due to
+     * we already waited for serializing requests in initiative write (see
+     * bdrv_aligned_pwritev), and it is necessary for the case when initiative
+     * write is serializing itself (we'll dead lock waiting it).
+     *
+     * The described case is the only usage for the flag for now, so, it is
+     * supported only for read operation and restricted for write.
+     */
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
diff --git a/block/io.c b/block/io.c
index 1a2272fad3..51bef9fc50 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1572,6 +1572,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
+    /* BDRV_REQ_NO_SERIALISING is only for read operation */
+    assert(!(flags & BDRV_REQ_NO_SERIALISING));
     waited = wait_serialising_requests(req);
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
@@ -2931,9 +2933,12 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                           bytes, BDRV_TRACKED_WRITE);
 
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
+        /* BDRV_REQ_NO_SERIALISING is only for read */
         wait_serialising_requests(&src_req);
-        wait_serialising_requests(&dst_req);
     }
+
+    wait_serialising_requests(&dst_req);
+
     if (recurse_src) {
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
-- 
2.11.1
