Received: from eggs.gnu.org ([2001:4830:134:3::10]:49080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euK1p-0003Wq-Mu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euK1m-0006LN-IO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:33:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  9 Mar 2018 18:33:46 +0300
Message-Id: <20180309153347.62552-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180309153347.62552-1-vsementsov@virtuozzo.com>
References: <20180309153347.62552-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 1/2] block/accounting: introduce latency
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
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com

Introduce latency histogram statics for block devices.
For each accounted operation type latency region [0, +inf) is
divided into subregions by several points. Then, calculate
hits for each subregion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/accounting.h | 32 +++++++++++++++++++++++++
 block/accounting.c         | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index b833d26d6c..e23951619e 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -45,6 +45,36 @@ struct BlockAcctTimedStats {
     QSLIST_ENTRY(BlockAcctTimedStats) entries;
 };
 
+typedef struct BlockLatencyHistogram {
+    /* The following histogram is represented like this:
+     *
+     * 5|           *
+     * 4|           *
+     * 3| *         *
+     * 2| *         *    *
+     * 1| *    *    *    *
+     *  +------------------
+     *      10   50   100
+     *
+     * BlockLatencyHistogram histogram = {
+     *     .nbins = 4,
+     *     .boundaries = {10, 50, 100},
+     *     .bins = {3, 1, 5, 2},
+     * };
+     *
+     * @boundaries array define histogram intervals as follows:
+     * [0, boundaries[0]), [boundaries[0], boundaries[1]), ...
+     * [boundaries[nbins-2], +inf)
+     *
+     * So, for example above, histogram intervals are:
+     * [0, 10), [10, 50), [50, 100), [100, +inf)
+     */
+    int nbins;
+    uint64_t *boundaries; /* @nbins-1 numbers here
+                             (all boundaries, except 0 and +inf) */
+    uint64_t *bins;
+} BlockLatencyHistogram;
+
 struct BlockAcctStats {
     QemuMutex lock;
     uint64_t nr_bytes[BLOCK_MAX_IOTYPE];
@@ -57,6 +87,7 @@ struct BlockAcctStats {
     QSLIST_HEAD(, BlockAcctTimedStats) intervals;
     bool account_invalid;
     bool account_failed;
+    BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
 };
 
 typedef struct BlockAcctCookie {
@@ -82,5 +113,6 @@ void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats);
 double block_acct_queue_depth(BlockAcctTimedStats *stats,
                               enum BlockAcctType type);
+void block_latency_histograms_clear(BlockAcctStats *stats);
 
 #endif
diff --git a/block/accounting.c b/block/accounting.c
index 87ef5bbfaa..26a880bc6d 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -94,6 +94,62 @@ void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
     cookie->type = type;
 }
 
+/* block_latency_histogram_compare_func:
+ * Compare @key with interval [@it[0], @it[1]).
+ * Return: -1 if @key < @it[0]
+ *          0 if @key in [@it[0], @it[1])
+ *         +1 if @key >= @it[1]
+ */
+static int block_latency_histogram_compare_func(const void *key, const void *it)
+{
+    uint64_t k = *(uint64_t *)key;
+    uint64_t a = ((uint64_t *)it)[0];
+    uint64_t b = ((uint64_t *)it)[1];
+
+    return k < a ? -1 : (k < b ? 0 : 1);
+}
+
+static void block_latency_histogram_account(BlockLatencyHistogram *hist,
+                                            int64_t latency_ns)
+{
+    uint64_t *pos;
+
+    if (hist->bins == NULL) {
+        /* histogram disabled */
+        return;
+    }
+
+
+    if (latency_ns < hist->boundaries[0]) {
+        hist->bins[0]++;
+        return;
+    }
+
+    if (latency_ns >= hist->boundaries[hist->nbins - 2]) {
+        hist->bins[hist->nbins - 1]++;
+        return;
+    }
+
+    pos = bsearch(&latency_ns, hist->boundaries, hist->nbins - 2,
+                  sizeof(hist->boundaries[0]),
+                  block_latency_histogram_compare_func);
+    assert(pos != NULL);
+
+    hist->bins[pos - hist->boundaries + 1]++;
+}
+
+void block_latency_histograms_clear(BlockAcctStats *stats)
+{
+    int i;
+
+    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
+        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
+        g_free(hist->bins);
+        g_free(hist->boundaries);
+        memset(hist, 0, sizeof(*hist));
+    }
+}
+
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
                                  bool failed)
 {
@@ -116,6 +172,9 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
         stats->nr_ops[cookie->type]++;
     }
 
+    block_latency_histogram_account(&stats->latency_histogram[cookie->type],
+                                    latency_ns);
+
     if (!failed || stats->account_failed) {
         stats->total_time_ns[cookie->type] += latency_ns;
         stats->last_access_time_ns = time_ns;
-- 
2.11.1
