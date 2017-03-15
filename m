Received: from eggs.gnu.org ([2001:4830:134:3::10]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KK-0007T0-2C
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KI-0003cy-JD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KI-0003bH-8Q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:54 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4160A635D2
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:09 +0100
Message-Id: <20170315135021.6978-20-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 19/31] ram: move xbzrle_overflows into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Once there, remove the now unused AccountingInfo struct and var.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 23a7317..75ad17f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -174,23 +174,13 @@ struct RAMState {
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
@@ -223,7 +213,7 @@ double xbzrle_mig_cache_miss_rate(void)
 
 uint64_t xbzrle_mig_pages_overflow(void)
 {
-    return acct_info.xbzrle_overflows;
+    return ram_state.xbzrle_overflows;
 }
 
 static QemuMutex migration_bitmap_mutex;
@@ -510,7 +500,7 @@ static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
         return 0;
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
-        acct_info.xbzrle_overflows++;
+        rs->xbzrle_overflows++;
         /* update data in the cache */
         if (!last_stage) {
             memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
@@ -1936,6 +1926,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->xbzrle_pages = 0;
     rs->xbzrle_cache_miss = 0;
     rs->xbzrle_cache_miss_rate = 0;
+    rs->xbzrle_overflows = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
@@ -1966,8 +1957,6 @@ static int ram_save_init_globals(RAMState *rs)
             XBZRLE.encoded_buf = NULL;
             return -1;
         }
-
-        acct_clear();
     }
 
     /* For memory_global_dirty_log_start below.  */
-- 
2.9.3
