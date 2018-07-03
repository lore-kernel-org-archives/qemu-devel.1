Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiZ-0004XK-4d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiV-0006TZ-5k
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:07:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  3 Jul 2018 21:07:50 +0300
Message-Id: <20180703180751.243496-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180703180751.243496-1-vsementsov@virtuozzo.com>
References: <20180703180751.243496-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Serialized writes should be used in copy-on-write of backup(sync=none)
for image fleecing scheme.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 5 ++++-
 block/io.c            | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index e5c7759a0c..107113aad5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -58,8 +58,11 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
+    /* Force request serializing. Only for writes. */
+    BDRV_REQ_SERIALISING        = 0x80,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x7f,
+    BDRV_REQ_MASK               = 0xff,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 1a2272fad3..d5ba078514 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1572,6 +1572,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
+    if (flags & BDRV_REQ_SERIALISING) {
+        mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    }
+
     waited = wait_serialising_requests(req);
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
-- 
2.11.1
