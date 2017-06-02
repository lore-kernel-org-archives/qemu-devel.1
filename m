Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhh3-0002iB-TN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhh2-0002c2-Lg
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhh2-0002bf-D0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:12:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Jun 2017 16:11:20 +0800
Message-Id: <20170602081120.3497-23-famz@redhat.com>
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/22] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

I'm not trying too hard yet.  Later, with multiqueue support,
this may cause mutex contention or cacheline bouncing.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-19-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/accounting.c         | 16 ++++++++++++++++
 include/block/accounting.h |  8 ++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index a279e0b..37ed66f 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -35,6 +35,7 @@ static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
 void block_acct_init(BlockAcctStats *stats, bool account_invalid,
                      bool account_failed)
 {
+    qemu_mutex_init(&stats->lock);
     stats->account_invalid = account_invalid;
     stats->account_failed = account_failed;
 
@@ -49,6 +50,7 @@ void block_acct_cleanup(BlockAcctStats *stats)
     QSLIST_FOREACH_SAFE(s, &stats->intervals, entries, next) {
         g_free(s);
     }
+    qemu_mutex_destroy(&stats->lock);
 }
 
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length)
@@ -58,12 +60,15 @@ void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length)
 
     s = g_new0(BlockAcctTimedStats, 1);
     s->interval_length = interval_length;
+    s->stats = stats;
+    qemu_mutex_lock(&stats->lock);
     QSLIST_INSERT_HEAD(&stats->intervals, s, entries);
 
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         timed_average_init(&s->latency[i], clock_type,
                            (uint64_t) interval_length * NANOSECONDS_PER_SECOND);
     }
+    qemu_mutex_unlock(&stats->lock);
 }
 
 BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
@@ -99,6 +104,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
 
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
+    qemu_mutex_lock(&stats->lock);
+
     if (failed) {
         stats->failed_ops[cookie->type]++;
     } else {
@@ -114,6 +121,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
             timed_average_account(&s->latency[cookie->type], latency_ns);
         }
     }
+
+    qemu_mutex_unlock(&stats->lock);
 }
 
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
@@ -134,18 +143,23 @@ void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type)
      * not.  The reason is that invalid requests are accounted during their
      * submission, therefore there's no actual I/O involved.
      */
+    qemu_mutex_lock(&stats->lock);
     stats->invalid_ops[type]++;
 
     if (stats->account_invalid) {
         stats->last_access_time_ns = qemu_clock_get_ns(clock_type);
     }
+    qemu_mutex_unlock(&stats->lock);
 }
 
 void block_acct_merge_done(BlockAcctStats *stats, enum BlockAcctType type,
                       int num_requests)
 {
     assert(type < BLOCK_MAX_IOTYPE);
+
+    qemu_mutex_lock(&stats->lock);
     stats->merged[type] += num_requests;
+    qemu_mutex_unlock(&stats->lock);
 }
 
 int64_t block_acct_idle_time_ns(BlockAcctStats *stats)
@@ -160,7 +174,9 @@ double block_acct_queue_depth(BlockAcctTimedStats *stats,
 
     assert(type < BLOCK_MAX_IOTYPE);
 
+    qemu_mutex_lock(&stats->stats->lock);
     sum = timed_average_sum(&stats->latency[type], &elapsed);
+    qemu_mutex_unlock(&stats->stats->lock);
 
     return (double) sum / elapsed;
 }
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 2089163..2687be7 100644
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
+    QemuMutex lock;
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
2.9.4
