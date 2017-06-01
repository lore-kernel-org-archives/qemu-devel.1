Received: from eggs.gnu.org ([2001:4830:134:3::10]:37302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq7-0007oL-9c
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq3-0006Zn-S0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXq3-0006Z6-J9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 554F47E9C0
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:41:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:40:53 +0200
Message-Id: <20170601214056.30387-2-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-1-quintela@redhat.com>
References: <20170601214056.30387-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] ram: Unfold get_xbzrle_cache_stats() into
 populate_ram_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

They were called consequtiveley always.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 60da9d6..fd8b406 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -476,20 +476,6 @@ static bool migration_is_setup_or_active(int state)
     }
 }
 
-static void get_xbzrle_cache_stats(MigrationInfo *info)
-{
-    if (migrate_use_xbzrle()) {
-        info->has_xbzrle_cache = true;
-        info->xbzrle_cache = g_malloc0(sizeof(*info->xbzrle_cache));
-        info->xbzrle_cache->cache_size = migrate_xbzrle_cache_size();
-        info->xbzrle_cache->bytes = xbzrle_mig_bytes_transferred();
-        info->xbzrle_cache->pages = xbzrle_mig_pages_transferred();
-        info->xbzrle_cache->cache_miss = xbzrle_mig_pages_cache_miss();
-        info->xbzrle_cache->cache_miss_rate = xbzrle_mig_cache_miss_rate();
-        info->xbzrle_cache->overflow = xbzrle_mig_pages_overflow();
-    }
-}
-
 static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_ram = true;
@@ -507,6 +493,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->postcopy_requests = ram_postcopy_requests();
     info->ram->page_size = qemu_target_page_size();
 
+    if (migrate_use_xbzrle()) {
+        info->has_xbzrle_cache = true;
+        info->xbzrle_cache = g_malloc0(sizeof(*info->xbzrle_cache));
+        info->xbzrle_cache->cache_size = migrate_xbzrle_cache_size();
+        info->xbzrle_cache->bytes = xbzrle_mig_bytes_transferred();
+        info->xbzrle_cache->pages = xbzrle_mig_pages_transferred();
+        info->xbzrle_cache->cache_miss = xbzrle_mig_pages_cache_miss();
+        info->xbzrle_cache->cache_miss_rate = xbzrle_mig_cache_miss_rate();
+        info->xbzrle_cache->overflow = xbzrle_mig_pages_overflow();
+    }
+
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
         info->ram->dirty_pages_rate = ram_dirty_pages_rate();
@@ -552,7 +549,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->cpu_throttle_percentage = cpu_throttle_get_percentage();
         }
 
-        get_xbzrle_cache_stats(info);
         break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
         /* Mostly the same as active; TODO add some postcopy stats */
@@ -575,15 +571,12 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->disk->total = blk_mig_bytes_total();
         }
 
-        get_xbzrle_cache_stats(info);
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
         /* TODO: display COLO specific information (checkpoint info etc.) */
         break;
     case MIGRATION_STATUS_COMPLETED:
-        get_xbzrle_cache_stats(info);
-
         info->has_status = true;
         info->has_total_time = true;
         info->total_time = s->total_time;
-- 
2.9.4
