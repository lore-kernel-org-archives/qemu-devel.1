Received: from eggs.gnu.org ([2001:4830:134:3::10]:38746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amq-0007gh-5N
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amk-00035N-LV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:12 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:58 +0200
Message-Id: <20170420120058.28404-18-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

I'm not trying too hard yet.  Later, with multiqueue support,
this may cause cacheline bouncing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/accounting.c         | 15 +++++++++++++++
 include/block/accounting.h |  8 ++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 3f457c4..dc10855 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -35,6 +35,7 @@ static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
 void block_acct_init(BlockAcctStats *stats, bool account_invalid,
                      bool account_failed)
 {
+    qemu_spin_init(&stats->spin);
     stats->account_invalid = account_invalid;
     stats->account_failed = account_failed;
 
@@ -58,12 +59,15 @@ void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length)
 
     s = g_new0(BlockAcctTimedStats, 1);
     s->interval_length = interval_length;
+    s->stats = stats;
+    qemu_spin_lock(&stats->spin);
     QSLIST_INSERT_HEAD(&stats->intervals, s, entries);
 
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         timed_average_init(&s->latency[i], clock_type,
                            (uint64_t) interval_length * NANOSECONDS_PER_SECOND);
     }
+    qemu_spin_unlock(&stats->spin);
 }
 
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
@@ -98,6 +102,7 @@ void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
 
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
+    qemu_spin_lock(&stats->spin);
     stats->nr_bytes[cookie->type] += cookie->bytes;
     stats->nr_ops[cookie->type]++;
     stats->total_time_ns[cookie->type] += latency_ns;
@@ -106,12 +111,14 @@ void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
     QSLIST_FOREACH(s, &stats->intervals, entries) {
         timed_average_account(&s->latency[cookie->type], latency_ns);
     }
+    qemu_spin_unlock(&stats->spin);
 }
 
 void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie)
 {
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
+    qemu_spin_lock(&stats->spin);
     stats->failed_ops[cookie->type]++;
 
     if (stats->account_failed) {
@@ -130,6 +137,7 @@ void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie)
             timed_average_account(&s->latency[cookie->type], latency_ns);
         }
     }
+    qemu_spin_unlock(&stats->spin);
 }
 
 void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type)
@@ -141,18 +149,23 @@ void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type)
      * invalid requests are accounted during their submission,
      * therefore there's no actual I/O involved. */
 
+    qemu_spin_lock(&stats->spin);
     stats->invalid_ops[type]++;
 
     if (stats->account_invalid) {
         stats->last_access_time_ns = qemu_clock_get_ns(clock_type);
     }
+    qemu_spin_unlock(&stats->spin);
 }
 
 void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
                       int num_requests)
 {
     assert(type < BLOCK_MAX_IOTYPE);
+
+    qemu_spin_lock(&stats->spin);
     stats->merged[type] += num_requests;
+    qemu_spin_unlock(&stats->spin);
 }
 
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats)
@@ -167,7 +180,9 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
 
     assert(type < BLOCK_MAX_IOTYPE);
 
+    qemu_spin_lock(&stats->stats->spin);
     sum = timed_average_sum(&stats->latency[type], &elapsed);
+    qemu_spin_unlock(&stats->stats->spin);
 
     return (double) sum / elapsed;
 }
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 2089163..90b7a1d 100644
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
+    QemuSpin spin;
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
2.9.3
