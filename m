Received: from eggs.gnu.org ([2001:4830:134:3::10]:45516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9ci-0007wb-3k
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9ch-0000L8-5t
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9ch-0000KE-0H
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0554F4E4D0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:13 +0100
Message-Id: <20170323204544.12015-21-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 20/51] ram: Move xbzrle_cache_miss_rate into
 RAMState
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
---
 migration/ram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cc19406..c398ff9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -178,6 +178,8 @@ struct RAMState {
     uint64_t xbzrle_pages;
     /* xbzrle number of cache miss */
     uint64_t xbzrle_cache_miss;
+    /* xbzrle miss rate */
+    double xbzrle_cache_miss_rate;
 };
 typedef struct RAMState RAMState;
 
@@ -185,7 +187,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    double xbzrle_cache_miss_rate;
     uint64_t xbzrle_overflows;
 } AccountingInfo;
 
@@ -223,7 +224,7 @@ uint64_t xbzrle_mig_pages_cache_miss(void)
 
 double xbzrle_mig_cache_miss_rate(void)
 {
-    return acct_info.xbzrle_cache_miss_rate;
+    return ram_state.xbzrle_cache_miss_rate;
 }
 
 uint64_t xbzrle_mig_pages_overflow(void)
@@ -698,7 +699,7 @@ static void migration_bitmap_sync(RAMState *rs)
 
         if (migrate_use_xbzrle()) {
             if (rs->iterations_prev != rs->iterations) {
-                acct_info.xbzrle_cache_miss_rate =
+                rs->xbzrle_cache_miss_rate =
                    (double)(rs->xbzrle_cache_miss -
                             rs->xbzrle_cache_miss_prev) /
                    (rs->iterations - rs->iterations_prev);
@@ -2001,6 +2002,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->xbzrle_bytes = 0;
     rs->xbzrle_pages = 0;
     rs->xbzrle_cache_miss = 0;
+    rs->xbzrle_cache_miss_rate = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
