Received: from eggs.gnu.org ([209.51.188.92]:54906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz2-0004J3-Tl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz1-0004wo-E2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 15:57:04 +0300
Message-Id: <20190423125706.26989-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190423125706.26989-1-vsementsov@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/3] block/qcow2-refcount: add trace-point
 to qcow2_process_discards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, eblake@redhat.com

Let's at least trace ignored failure.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-refcount.c | 7 ++++++-
 block/trace-events     | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e0fe322500..60284bcaac 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -30,6 +30,7 @@
 #include "qemu/range.h"
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
                                     uint64_t max);
@@ -738,7 +739,11 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
 
         /* Discard is optional, ignore the return value */
         if (ret >= 0) {
-            bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            int r2 = bdrv_pdiscard(bs->file, d->offset, d->bytes);
+            if (r2 < 0) {
+                trace_qcow2_process_discards_failed_region(d->offset, d->bytes,
+                                                           r2);
+            }
         }
 
         g_free(d);
diff --git a/block/trace-events b/block/trace-events
index 7335a42540..ea508f637e 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -91,6 +91,9 @@ qcow2_cache_get_done(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_flush(void *co, int c) "co %p is_l2_cache %d"
 qcow2_cache_entry_flush(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 
+# qcow2-refcount.c
+qcow2_process_discards_failed_region(uint64_t offset, uint64_t bytes, int ret) "offset 0x%" PRIx64 " bytes 0x%" PRIx64 " ret %d"
+
 # qed-l2-cache.c
 qed_alloc_l2_cache_entry(void *l2_cache, void *entry) "l2_cache %p entry %p"
 qed_unref_l2_cache_entry(void *entry, int ref) "entry %p ref %d"
-- 
2.18.0
