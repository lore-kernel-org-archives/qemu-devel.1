Received: from eggs.gnu.org ([2001:4830:134:3::10]:41801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrIC-000084-Pv
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrIB-00067L-LV
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrIB-00066e-D7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:31 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EE393D953
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:06 +0200
Message-Id: <20170605123908.18777-18-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/19] block: introduce block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

This is the common code to account operations that produced actual I/O.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/accounting.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 3f457c4e73..a279e0b124 100644
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
2.13.0
