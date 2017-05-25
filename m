Received: from eggs.gnu.org ([2001:4830:134:3::10]:51996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvh5-000512-Oh
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvh4-0004CQ-Sz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:24 +0200
Message-Id: <20170525163225.29954-18-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/18] block: introduce block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

This is the common code to account operations that produced actual I/O.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/accounting.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 3f457c4..a279e0b 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -86,7 +86,8 @@ void block_acct_start(BlockAcctStats *stats, BlockAcctCookie *cookie,
     cookie->type = type;
 }
 
-void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
+static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
+                                 bool failed)
 {
     BlockAcctTimedStats *s;
     int64_t time_ns = qemu_clock_get_ns(clock_type);
@@ -98,31 +99,14 @@ void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
 
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
-    stats->nr_bytes[cookie->type] += cookie->bytes;
-    stats->nr_ops[cookie->type]++;
-    stats->total_time_ns[cookie->type] += latency_ns;
-    stats->last_access_time_ns = time_ns;
-
-    QSLIST_FOREACH(s, &stats->intervals, entries) {
-        timed_average_account(&s->latency[cookie->type], latency_ns);
+    if (failed) {
+        stats->failed_ops[cookie->type]++;
+    } else {
+        stats->nr_bytes[cookie->type] += cookie->bytes;
+        stats->nr_ops[cookie->type]++;
     }
-}
-
-void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie)
-{
-    assert(cookie->type < BLOCK_MAX_IOTYPE);
-
-    stats->failed_ops[cookie->type]++;
-
-    if (stats->account_failed) {
-        BlockAcctTimedStats *s;
-        int64_t time_ns = qemu_clock_get_ns(clock_type);
-        int64_t latency_ns = time_ns - cookie->start_time_ns;
-
-        if (qtest_enabled()) {
-            latency_ns = qtest_latency_ns;
-        }
 
+    if (!failed || stats->account_failed) {
         stats->total_time_ns[cookie->type] += latency_ns;
         stats->last_access_time_ns = time_ns;
 
@@ -132,15 +116,24 @@ void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie)
     }
 }
 
+void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
+{
+    block_account_one_io(stats, cookie, false);
+}
+
+void block_acct_failed(BlockAcctStats *stats, BlockAcctCookie *cookie)
+{
+    block_account_one_io(stats, cookie, true);
+}
+
 void block_acct_invalid(BlockAcctStats *stats, enum BlockAcctType type)
 {
     assert(type < BLOCK_MAX_IOTYPE);
 
-    /* block_acct_done() and block_acct_failed() update
-     * total_time_ns[], but this one does not. The reason is that
-     * invalid requests are accounted during their submission,
-     * therefore there's no actual I/O involved. */
-
+    /* block_account_one_io() updates total_time_ns[], but this one does
+     * not.  The reason is that invalid requests are accounted during their
+     * submission, therefore there's no actual I/O involved.
+     */
     stats->invalid_ops[type]++;
 
     if (stats->account_invalid) {
-- 
1.8.3.1
