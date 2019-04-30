Received: from eggs.gnu.org ([209.51.188.92]:37401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLRzd-0000p8-Cr
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLRzc-00041y-06
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:36:17 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 Apr 2019 15:36:11 +0300
Message-Id: <20190430123611.31203-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/qed: add missed coroutine_fn markers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

qed_read_table and qed_write_table use coroutine-only interfaces but
are not marked coroutine_fn. Happily, they are called only from
coroutine context, so we only need to add missed markers.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

This is a follow-up for my "block: buffer-based io" series, proposed by
Kevin, based on Kevin's block branch.

Based-on: git://repo.or.cz/qemu/kevin.git block

 block/qed.h       | 28 ++++++++++++++++------------
 block/qed-check.c |  4 ++--
 block/qed-table.c | 33 ++++++++++++++++++++-------------
 block/qed.c       |  5 +++--
 4 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/block/qed.h b/block/qed.h
index f35341f134..42c115d822 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -201,17 +201,21 @@ void qed_commit_l2_cache_entry(L2TableCache *l2_cache, CachedL2Table *l2_table);
 /**
  * Table I/O functions
  */
-int qed_read_l1_table_sync(BDRVQEDState *s);
-int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n);
-int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
-                            unsigned int n);
-int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                           uint64_t offset);
-int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset);
-int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                       unsigned int index, unsigned int n, bool flush);
-int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                            unsigned int index, unsigned int n, bool flush);
+int coroutine_fn qed_read_l1_table_sync(BDRVQEDState *s);
+int coroutine_fn qed_write_l1_table(BDRVQEDState *s, unsigned int index,
+                                    unsigned int n);
+int coroutine_fn qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
+                                         unsigned int n);
+int coroutine_fn qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
+                                        uint64_t offset);
+int coroutine_fn qed_read_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                   uint64_t offset);
+int coroutine_fn qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                    unsigned int index, unsigned int n,
+                                    bool flush);
+int coroutine_fn qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
+                                         unsigned int index, unsigned int n,
+                                         bool flush);
 
 /**
  * Cluster functions
@@ -223,7 +227,7 @@ int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
 /**
  * Consistency check
  */
-int qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix);
+int coroutine_fn qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix);
 
 QEDTable *qed_alloc_table(BDRVQEDState *s);
 
diff --git a/block/qed-check.c b/block/qed-check.c
index 0edac03159..418033ee24 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -106,7 +106,7 @@ static unsigned int qed_check_l2_table(QEDCheck *check, QEDTable *table)
 /**
  * Descend tables and check each cluster is referenced once only
  */
-static int qed_check_l1_table(QEDCheck *check, QEDTable *table)
+static int coroutine_fn qed_check_l1_table(QEDCheck *check, QEDTable *table)
 {
     BDRVQEDState *s = check->s;
     unsigned int i, num_invalid_l1 = 0;
@@ -218,7 +218,7 @@ static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
 }
 
 /* Called with table_lock held.  */
-int qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix)
+int coroutine_fn qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix)
 {
     QEDCheck check = {
         .s = s,
diff --git a/block/qed-table.c b/block/qed-table.c
index cf30edd977..405d446cbe 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -19,7 +19,8 @@
 #include "qemu/bswap.h"
 
 /* Called with table_lock held.  */
-static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
+static int coroutine_fn qed_read_table(BDRVQEDState *s, uint64_t offset,
+                                       QEDTable *table)
 {
     unsigned int bytes = s->header.cluster_size * s->header.table_size;
 
@@ -60,8 +61,9 @@ out:
  *
  * Called with table_lock held.
  */
-static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
-                           unsigned int index, unsigned int n, bool flush)
+static int coroutine_fn qed_write_table(BDRVQEDState *s, uint64_t offset,
+                                        QEDTable *table, unsigned int index,
+                                        unsigned int n, bool flush)
 {
     unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
     unsigned int start, end, i;
@@ -109,27 +111,29 @@ out:
     return ret;
 }
 
-int qed_read_l1_table_sync(BDRVQEDState *s)
+int coroutine_fn qed_read_l1_table_sync(BDRVQEDState *s)
 {
     return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
 
 /* Called with table_lock held.  */
-int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n)
+int coroutine_fn qed_write_l1_table(BDRVQEDState *s, unsigned int index,
+                                    unsigned int n)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
     return qed_write_table(s, s->header.l1_table_offset,
                            s->l1_table, index, n, false);
 }
 
-int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
-                            unsigned int n)
+int coroutine_fn qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
+                                         unsigned int n)
 {
     return qed_write_l1_table(s, index, n);
 }
 
 /* Called with table_lock held.  */
-int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
+int coroutine_fn qed_read_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                   uint64_t offset)
 {
     int ret;
 
@@ -166,22 +170,25 @@ int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
     return ret;
 }
 
-int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
+int coroutine_fn qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
+                                        uint64_t offset)
 {
     return qed_read_l2_table(s, request, offset);
 }
 
 /* Called with table_lock held.  */
-int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                       unsigned int index, unsigned int n, bool flush)
+int coroutine_fn qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
+                                    unsigned int index, unsigned int n,
+                                    bool flush)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L2_UPDATE);
     return qed_write_table(s, request->l2_table->offset,
                            request->l2_table->table, index, n, flush);
 }
 
-int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
-                            unsigned int index, unsigned int n, bool flush)
+int coroutine_fn qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
+                                         unsigned int index, unsigned int n,
+                                         bool flush)
 {
     return qed_write_l2_table(s, request, index, n, flush);
 }
diff --git a/block/qed.c b/block/qed.c
index 912edaf56a..dcdcd62b4a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1604,8 +1604,9 @@ static void coroutine_fn bdrv_qed_co_invalidate_cache(BlockDriverState *bs,
     }
 }
 
-static int bdrv_qed_co_check(BlockDriverState *bs, BdrvCheckResult *result,
-                             BdrvCheckMode fix)
+static int coroutine_fn bdrv_qed_co_check(BlockDriverState *bs,
+                                          BdrvCheckResult *result,
+                                          BdrvCheckMode fix)
 {
     BDRVQEDState *s = bs->opaque;
     int ret;
-- 
2.18.0
