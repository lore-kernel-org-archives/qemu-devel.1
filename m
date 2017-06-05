Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrIE-00009n-52
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrID-0006A5-B2
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrID-00068n-2b
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:33 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:07 +0200
Message-Id: <20170605123908.18777-19-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 18/19] block: split BlockAcctStats creation and
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, Alberto Garcia <berto@igalia.com>

block_acct_destroy is called unconditionally in blk_delete, but there is
no BlockAcctStats function that is called unconditionally in blk_new.
Split block_acct_init in two, so that it will be possible to create a
QemuMutex in block_acct_init and destroy it in block_acct_cleanup.

Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/accounting.c         | 13 ++++++++-----
 block/block-backend.c      |  1 +
 blockdev.c                 |  2 +-
 include/block/accounting.h |  3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index a279e0b124..ce6dbf7760 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -32,17 +32,20 @@
 static QEMUClockType clock_type = QEMU_CLOCK_REALTIME;
 static const int qtest_latency_ns = NANOSECONDS_PER_SECOND / 1000;
 
-void block_acct_init(BlockAcctStats *stats, bool account_invalid,
-                     bool account_failed)
+void block_acct_init(BlockAcctStats *stats)
 {
-    stats->account_invalid = account_invalid;
-    stats->account_failed = account_failed;
-
     if (qtest_enabled()) {
         clock_type = QEMU_CLOCK_VIRTUAL;
     }
 }
 
+void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
+                      bool account_failed)
+{
+    stats->account_invalid = account_invalid;
+    stats->account_failed = account_failed;
+}
+
 void block_acct_cleanup(BlockAcctStats *stats)
 {
     BlockAcctTimedStats *s, *next;
diff --git a/block/block-backend.c b/block/block-backend.c
index be2ddf173a..828497e27a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -219,6 +219,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     qemu_co_mutex_init(&blk->public.throttled_reqs_lock);
     qemu_co_queue_init(&blk->public.throttled_reqs[0]);
     qemu_co_queue_init(&blk->public.throttled_reqs[1]);
+    block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
diff --git a/blockdev.c b/blockdev.c
index 6e7c8a678c..0fa2e7e571 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -595,7 +595,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
             autostart = 0;
         }
 
-        block_acct_init(blk_get_stats(blk), account_invalid, account_failed);
+        block_acct_setup(blk_get_stats(blk), account_invalid, account_failed);
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 20891639d5..55cb06fdb6 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -61,7 +61,8 @@ typedef struct BlockAcctCookie {
     enum BlockAcctType type;
 } BlockAcctCookie;
 
-void block_acct_init(BlockAcctStats *stats, bool account_invalid,
+void block_acct_init(BlockAcctStats *stats);
+void block_acct_setup(BlockAcctStats *stats, bool account_invalid,
                      bool account_failed);
 void block_acct_cleanup(BlockAcctStats *stats);
 void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_length);
-- 
2.13.0
