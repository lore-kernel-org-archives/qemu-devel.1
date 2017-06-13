Received: from eggs.gnu.org ([2001:4830:134:3::10]:57038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU0-00013p-Qf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU0-0003JN-3g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiTz-0003J3-Tf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAC72145FB5
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:09 +0200
Message-Id: <20170613095120.11373-4-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] ram: Print block stats also in the
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

Once there, create populate_disk_info.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>

--

- create populate_disk_info instead of "abusing" populate_ram_info
---
 migration/migration.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ae087df..2f5f270 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -627,6 +627,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
+static void populate_disk_info(MigrationInfo *info)
+{
+    if (blk_mig_active()) {
+        info->has_disk = true;
+        info->disk = g_malloc0(sizeof(*info->disk));
+        info->disk->transferred = blk_mig_bytes_transferred();
+        info->disk->remaining = blk_mig_bytes_remaining();
+        info->disk->total = blk_mig_bytes_total();
+    }
+}
+
 MigrationInfo *qmp_query_migrate(Error **errp)
 {
     MigrationInfo *info = g_malloc0(sizeof(*info));
@@ -652,15 +663,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
+        populate_disk_info(info);
         break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
         /* Mostly the same as active; TODO add some postcopy stats */
@@ -674,15 +677,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
+        populate_disk_info(info);
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
-- 
2.9.4
