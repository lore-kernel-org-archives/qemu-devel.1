Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Ah-0005s0-Sx
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Ad-0008Ci-Dw
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7Ad-0008CI-7h
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37804C065845
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:43 +0200
Message-Id: <20170406130913.2232-25-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 24/54] ram: Move xbzrle_overflows into RAMState
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 09f9eff..88392e4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -181,23 +181,13 @@ struct RAMState {
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
@@ -230,7 +220,7 @@ double xbzrle_mig_cache_miss_rate(void)
 
 uint64_t xbzrle_mig_pages_overflow(void)
 {
-    return acct_info.xbzrle_overflows;
+    return ram_state.xbzrle_overflows;
 }
 
 static QemuMutex migration_bitmap_mutex;
@@ -528,7 +518,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
         return 0;
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
-        acct_info.xbzrle_overflows++;
+        rs->xbzrle_overflows++;
         /* update data in the cache */
         if (!last_stage) {
             memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
@@ -2005,6 +1995,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->xbzrle_pages = 0;
     rs->xbzrle_cache_miss = 0;
     rs->xbzrle_cache_miss_rate = 0;
+    rs->xbzrle_overflows = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
@@ -2035,8 +2026,6 @@ static int ram_save_init_globals(RAMState *rs)
             XBZRLE.encoded_buf = NULL;
             return -1;
         }
-
-        acct_clear();
     }
 
     /* For memory_global_dirty_log_start below.  */
-- 
2.9.3
