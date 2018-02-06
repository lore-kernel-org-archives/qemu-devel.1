Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uE-000399-Vu
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uA-0004F9-Pa
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:30 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  6 Feb 2018 17:07:21 +0300
Message-Id: <20180206140722.10110-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180206140722.10110-1-vsementsov@virtuozzo.com>
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block/accounting: introduce latency
 histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, vsementsov@virtuozzo.com

Introduce latency histogram statics for block devices.
For each accounted operation type latency region [0, +inf) is
divided into subregions by several points. Then, calculate
hits for each subregion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/accounting.h |  8 +++++
 block/accounting.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index b833d26d6c..7fbfc86c43 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -45,6 +45,12 @@ struct BlockAcctTimedStats {
     QSLIST_ENTRY(BlockAcctTimedStats) entries;
 };
 
+typedef struct BlockLatencyHistogram {
+    int size;
+    uint64_t *points; /* @size-1 points here (all points, except 0 and +inf) */
+    uint64_t *histogram[BLOCK_MAX_IOTYPE]; /* @size elements for each type */
+} BlockLatencyHistogram;
+
 struct BlockAcctStats {
     QemuMutex lock;
     uint64_t nr_bytes[BLOCK_MAX_IOTYPE];
@@ -57,6 +63,7 @@ struct BlockAcctStats {
     QSLIST_HEAD(, BlockAcctTimedStats) intervals;
     bool account_invalid;
     bool account_failed;
+    BlockLatencyHistogram latency_histogram;
 };
 
 typedef struct BlockAcctCookie {
@@ -82,5 +89,6 @@ void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats);
 double block_acct_queue_depth(BlockAcctTimedStats *stats,
                               enum BlockAcctType type);
+int block_latency_histogram_set(BlockAcctStats *stats, uint64List *latency);
 
 #endif
diff --git a/block/accounting.c b/block/accounting.c
index 87ef5bbfaa..a34ef09015 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -94,6 +94,86 @@ void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
     cookie->type = type;
 }
 
+/* block_latency_histogram_compare_func
+ * Compare @key with interval [@el, @el+1), where @el+1 is a next array element
+ * after @el.
+ * Return: -1 if @key < @el
+ *          0 if @key in [@el, @el+1)
+ *         +1 if @key >= @el+1
+ */
+static int block_latency_histogram_compare_func(const void *key, const void *el)
+{
+    uint64_t k = *(uint64_t *)key;
+    uint64_t a = *(uint64_t *)el;
+    uint64_t b = *((uint64_t *)el + 1);
+
+    return k < a ? -1 : (k < b ? 0 : 1);
+}
+
+static void block_latency_histogram_account(BlockLatencyHistogram *hist,
+                                            enum BlockAcctType type,
+                                            int64_t latency_ns)
+{
+    uint64_t *data, *pos;
+
+    if (hist->points == NULL) {
+        /* histogram disabled */
+        return;
+    }
+
+    data = hist->histogram[type];
+
+    if (latency_ns < hist->points[0]) {
+        data[0]++;
+        return;
+    }
+
+    if (latency_ns >= hist->points[hist->size - 2]) {
+        data[hist->size - 1]++;
+        return;
+    }
+
+    pos = bsearch(&latency_ns, hist->points, hist->size - 2,
+                  sizeof(hist->points[0]),
+                  block_latency_histogram_compare_func);
+    assert(pos != NULL);
+
+    data[pos - hist->points + 1]++;
+}
+
+int block_latency_histogram_set(BlockAcctStats *stats, uint64List *latency)
+{
+    BlockLatencyHistogram *hist = &stats->latency_histogram;
+    uint64List *entry;
+    uint64_t *ptr;
+    int i;
+    uint64_t prev = 0;
+
+    hist->size = 1;
+
+    for (entry = latency; entry; entry = entry->next) {
+        if (entry->value <= prev) {
+            return -EINVAL;
+        }
+        hist->size++;
+        prev = entry->value;
+    }
+
+    hist->points = g_renew(uint64_t, hist->points, hist->size - 1);
+    for (entry = latency, ptr = hist->points; entry;
+         entry = entry->next, ptr++)
+    {
+        *ptr = entry->value;
+    }
+
+    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
+        hist->histogram[i] = g_renew(uint64_t, hist->histogram[i], hist->size);
+        memset(hist->histogram[i], 0, hist->size * sizeof(uint64_t));
+    }
+
+    return 0;
+}
+
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
                                  bool failed)
 {
@@ -116,6 +196,9 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
         stats->nr_ops[cookie->type]++;
     }
 
+    block_latency_histogram_account(&stats->latency_histogram, cookie->type,
+                                    latency_ns);
+
     if (!failed || stats->account_failed) {
         stats->total_time_ns[cookie->type] += latency_ns;
         stats->last_access_time_ns = time_ns;
-- 
2.11.1
