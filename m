Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cj-0007xt-Bi
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9ci-0000Nc-FU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9ci-0000M0-9o
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BB9680474
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:14 +0100
Message-Id: <20170323204544.12015-22-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 21/51] ram: Move xbzrle_overflows into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Once there, remove the now unused AccountingInfo struct and var.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c398ff9..3292eb0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -180,23 +180,13 @@ struct RAMState {
     uint64_t xbzrle_cache_miss;
     /* xbzrle miss rate */
     double xbzrle_cache_miss_rate;
+    /* xbzrle number of overflows */
+    uint64_t xbzrle_overflows;
 };
 typedef struct RAMState RAMState;
 
 static RAMState ram_state;
 
-/* accounting for migration statistics */
-typedef struct AccountingInfo {
-    uint64_t xbzrle_overflows;
-} AccountingInfo;
-
-static AccountingInfo acct_info;
-
-static void acct_clear(void)
-{
-    memset(&acct_info, 0, sizeof(acct_info));
-}
-
 uint64_t dup_mig_pages_transferred(void)
 {
     return ram_state.zero_pages;
@@ -229,7 +219,7 @@ double xbzrle_mig_cache_miss_rate(void)
 
 uint64_t xbzrle_mig_pages_overflow(void)
 {
-    return acct_info.xbzrle_overflows;
+    return ram_state.xbzrle_overflows;
 }
 
 static QemuMutex migration_bitmap_mutex;
@@ -527,7 +517,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
         return 0;
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
-        acct_info.xbzrle_overflows++;
+        rs->xbzrle_overflows++;
         /* update data in the cache */
         if (!last_stage) {
             memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
@@ -2003,6 +1993,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->xbzrle_pages = 0;
     rs->xbzrle_cache_miss = 0;
     rs->xbzrle_cache_miss_rate = 0;
+    rs->xbzrle_overflows = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
@@ -2033,8 +2024,6 @@ static int ram_save_init_globals(RAMState *rs)
             XBZRLE.encoded_buf = NULL;
             return -1;
         }
-
-        acct_clear();
     }
 
     /* For memory_global_dirty_log_start below.  */
-- 
2.9.3
