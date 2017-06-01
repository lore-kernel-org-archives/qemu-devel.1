Received: from eggs.gnu.org ([2001:4830:134:3::10]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq8-0007oN-34
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq7-0006bO-8n
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXq7-0006b1-2R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08717C057FA8
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:41:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:40:55 +0200
Message-Id: <20170601214056.30387-4-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-1-quintela@redhat.com>
References: <20170601214056.30387-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] ram: Print block stats also in the
 complete case
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

To make things easier, I just moved it to populate_ram_info().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7f79da0..8289544 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -509,6 +509,14 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->cpu_throttle_percentage = cpu_throttle_get_percentage();
     }
 
+    if (blk_mig_active()) {
+        info->has_disk = true;
+        info->disk = g_malloc0(sizeof(*info->disk));
+        info->disk->transferred = blk_mig_bytes_transferred();
+        info->disk->remaining = blk_mig_bytes_remaining();
+        info->disk->total = blk_mig_bytes_total();
+    }
+
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
         info->ram->dirty_pages_rate = ram_dirty_pages_rate();
@@ -540,15 +548,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         info->setup_time = s->setup_time;
 
         populate_ram_info(info, s);
-
-        if (blk_mig_active()) {
-            info->has_disk = true;
-            info->disk = g_malloc0(sizeof(*info->disk));
-            info->disk->transferred = blk_mig_bytes_transferred();
-            info->disk->remaining = blk_mig_bytes_remaining();
-            info->disk->total = blk_mig_bytes_total();
-        }
-
         break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
         /* Mostly the same as active; TODO add some postcopy stats */
@@ -562,15 +561,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         info->setup_time = s->setup_time;
 
         populate_ram_info(info, s);
-
-        if (blk_mig_active()) {
-            info->has_disk = true;
-            info->disk = g_malloc0(sizeof(*info->disk));
-            info->disk->transferred = blk_mig_bytes_transferred();
-            info->disk->remaining = blk_mig_bytes_remaining();
-            info->disk->total = blk_mig_bytes_total();
-        }
-
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
-- 
2.9.4
