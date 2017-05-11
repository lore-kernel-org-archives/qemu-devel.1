Received: from eggs.gnu.org ([2001:4830:134:3::10]:42702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIg-000236-0p
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIe-0004Tj-Mu
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:42 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:42:08 +0200
Message-Id: <20170511144208.24075-19-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 18/18] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

I'm not trying too hard yet.  Later, with multiqueue support,
this may cause mutex contention or cacheline bouncing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: QemuSpin -> QemuMutex [Stefan]

 block/accounting.c         | 16 ++++++++++++++++
 include/block/accounting.h |  8 ++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 0429e31c9f..85890e4fe5 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -35,6 +35,7 @@ static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
 void block_acct_init(BlockAcctStats *stats, bool account_invalid,
                      bool account_failed)
 {
+    qemu_mutex_init(&stats->spin);
     stats->account_invalid = account_invalid;
     stats->account_failed = account_failed;
 
@@ -49,6 +50,7 @@ void block_acct_cleanup(BlockAcctStats *stats)
     QSLIST_FOREACH_SAFE(s, &stats->intervals, entries, next) {
         g_free(s);
     }
+    qemu_mutex_destroy(&stats->spin);
 }
 
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length)
@@ -58,12 +60,15 @@ void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length)
 
     s = g_new0(BlockAcctTimedStats, 1);
     s->interval_length = interval_length;
+    s->stats = stats;
+    qemu_mutex_lock(&stats->spin);
     QSLIST_INSERT_HEAD(&stats->intervals, s, entries);
 
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         timed_average_init(&s->latency[i], clock_type,
                            (uint64_t) interval_length * NANOSECONDS_PER_SECOND);
     }
+    qemu_mutex_unlock(&stats->spin);
 }
 
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
@@ -98,6 +103,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
 
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
+    qemu_mutex_lock(&stats->spin);
+
     if (failed) {
         stats->failed_ops[cookie->type]++;
     } else {
@@ -113,6 +120,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
             timed_average_account(&s->latency[cookie->type], latency_ns);
         }
     }
+
+    qemu_mutex_unlock(&stats->spin);
 }
 
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
@@ -133,18 +142,23 @@ void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type)
      * not.  The reason is that invalid requests are accounted during their
      * submission, therefore there's no actual I/O involved.
      */
+    qemu_mutex_lock(&stats->spin);
     stats->invalid_ops[type]++;
 
     if (stats->account_invalid) {
         stats->last_access_time_ns = qemu_clock_get_ns(clock_type);
     }
+    qemu_mutex_unlock(&stats->spin);
 }
 
 void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
                       int num_requests)
 {
     assert(type < BLOCK_MAX_IOTYPE);
+
+    qemu_mutex_lock(&stats->spin);
     stats->merged[type] += num_requests;
+    qemu_mutex_unlock(&stats->spin);
 }
 
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats)
@@ -159,7 +173,9 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
 
     assert(type < BLOCK_MAX_IOTYPE);
 
+    qemu_mutex_lock(&stats->stats->spin);
     sum = timed_average_sum(&stats->latency[type], &elapsed);
+    qemu_mutex_unlock(&stats->stats->spin);
 
     return (double) sum / elapsed;
 }
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 20891639d5..eb690916a6 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -26,8 +26,10 @@
 #define BLOCK_ACCOUNTING_H
 
 #include "qemu/timed-average.h"
+#include "qemu/thread.h"
 
 typedef struct BlockAcctTimedStats BlockAcctTimedStats;
+typedef struct BlockAcctStats BlockAcctStats;
 
 enum BlockAcctType {
     BLOCK_ACCT_READ,
@@ -37,12 +39,14 @@ enum BlockAcctType {
 };
 
 struct BlockAcctTimedStats {
+    BlockAcctStats *stats;
     TimedAverage latency[BLOCK_MAX_IOTYPE];
     unsigned interval_length; /* in seconds */
     QSLIST_ENTRY(BlockAcctTimedStats) entries;
 };
 
-typedef struct BlockAcctStats {
+struct BlockAcctStats {
+    QemuMutex spin;
     uint64_t nr_bytes[BLOCK_MAX_IOTYPE];
     uint64_t nr_ops[BLOCK_MAX_IOTYPE];
     uint64_t invalid_ops[BLOCK_MAX_IOTYPE];
@@ -53,7 +57,7 @@ typedef struct BlockAcctStats {
     QSLIST_HEAD(, BlockAcctTimedStats) intervals;
     bool account_invalid;
     bool account_failed;
-} BlockAcctStats;
+};
 
 typedef struct BlockAcctCookie {
     int64_t bytes;
-- 
2.12.2
