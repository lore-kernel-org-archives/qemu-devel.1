Received: from eggs.gnu.org ([2001:4830:134:3::10]:46279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIw47-00022s-RZ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIw46-00020H-S1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dIw46-0001zs-JQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:57:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Jun 2017 19:56:41 +0800
Message-Id: <20170608115643.18859-22-famz@redhat.com>
In-Reply-To: <20170608115643.18859-1-famz@redhat.com>
References: <20170608115643.18859-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v3 21/23] block: introduce block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Paolo Bonzini <pbonzini@redhat.com>

This is the common code to account operations that produced actual I/O.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170605123908.18777-18-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.4
