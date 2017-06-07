Received: from eggs.gnu.org ([2001:4830:134:3::10]:33605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkU-0005SQ-Lo
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkT-0005Jp-Hv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXkT-0005Jl-9Z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 416DAC0587C6
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:59:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:20 +0200
Message-Id: <20170607095926.1834-2-quintela@redhat.com>
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] ram: Unfold get_xbzrle_cache_stats() into
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

They were called consecutively always.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/migration.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 48c94c9..b1e68c0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -588,20 +588,6 @@ static bool migration_is_setup_or_active(int state)
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
@@ -619,6 +605,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
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
@@ -664,7 +661,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->cpu_throttle_percentage = cpu_throttle_get_percentage();
         }
 
-        get_xbzrle_cache_stats(info);
         break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
         /* Mostly the same as active; TODO add some postcopy stats */
@@ -687,15 +683,12 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
