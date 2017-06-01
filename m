Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq7-0007oM-9e
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq5-0006ae-I4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXq5-0006aR-5U
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B7ABC057EC9
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:41:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:40:54 +0200
Message-Id: <20170601214056.30387-3-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-1-quintela@redhat.com>
References: <20170601214056.30387-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] ram: We only print throttling information
 sometimes
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

Change it to be consistent with everything else.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index fd8b406..7f79da0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -504,6 +504,11 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->overflow = xbzrle_mig_pages_overflow();
     }
 
+    if (cpu_throttle_active()) {
+        info->has_cpu_throttle_percentage = true;
+        info->cpu_throttle_percentage = cpu_throttle_get_percentage();
+    }
+
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
         info->ram->dirty_pages_rate = ram_dirty_pages_rate();
@@ -544,11 +549,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
             info->disk->total = blk_mig_bytes_total();
         }
 
-        if (cpu_throttle_active()) {
-            info->has_cpu_throttle_percentage = true;
-            info->cpu_throttle_percentage = cpu_throttle_get_percentage();
-        }
-
         break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
         /* Mostly the same as active; TODO add some postcopy stats */
-- 
2.9.4
