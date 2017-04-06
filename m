Received: from eggs.gnu.org ([2001:4830:134:3::10]:50227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Ab-0005lY-DS
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Aa-0008BS-Hg
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7Aa-0008Aw-CL
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 797A980F8F
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:41 +0200
Message-Id: <20170406130913.2232-23-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 22/54] ram: Move xbzrle_cache_miss into RAMState
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cf6681c..b70db68 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -177,6 +177,8 @@ struct RAMState {
     uint64_t xbzrle_bytes;
     /* xbzrle transmmited pages */
     uint64_t xbzrle_pages;
+    /* xbzrle number of cache miss */
+    uint64_t xbzrle_cache_miss;
 };
 typedef struct RAMState RAMState;
 
@@ -184,7 +186,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t xbzrle_cache_miss;
     double xbzrle_cache_miss_rate;
     uint64_t xbzrle_overflows;
 } AccountingInfo;
@@ -218,7 +219,7 @@ uint64_t xbzrle_mig_pages_transferred(void)
 
 uint64_t xbzrle_mig_pages_cache_miss(void)
 {
-    return acct_info.xbzrle_cache_miss;
+    return ram_state.xbzrle_cache_miss;
 }
 
 double xbzrle_mig_cache_miss_rate(void)
@@ -498,7 +499,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
     uint8_t *prev_cached_page;
 
     if (!cache_is_cached(XBZRLE.cache, current_addr, rs->bitmap_sync_count)) {
-        acct_info.xbzrle_cache_miss++;
+        rs->xbzrle_cache_miss++;
         if (!last_stage) {
             if (cache_insert(XBZRLE.cache, current_addr, *current_data,
                              rs->bitmap_sync_count) == -1) {
@@ -699,12 +700,12 @@ static void migration_bitmap_sync(RAMState *rs)
         if (migrate_use_xbzrle()) {
             if (rs->iterations_prev != rs->iterations) {
                 acct_info.xbzrle_cache_miss_rate =
-                   (double)(acct_info.xbzrle_cache_miss -
+                   (double)(rs->xbzrle_cache_miss -
                             rs->xbzrle_cache_miss_prev) /
                    (rs->iterations - rs->iterations_prev);
             }
             rs->iterations_prev = rs->iterations;
-            rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
+            rs->xbzrle_cache_miss_prev = rs->xbzrle_cache_miss;
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->time_last_bitmap_sync);
@@ -2001,6 +2002,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->iterations = 0;
     rs->xbzrle_bytes = 0;
     rs->xbzrle_pages = 0;
+    rs->xbzrle_cache_miss = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
