Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zq-0001DS-KD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY9zp-0001bc-J4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51856 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY9zp-0001bA-Em
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:56:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED3C9401C978
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:56:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Jun 2018 14:55:57 +0200
Message-Id: <20180627125604.15275-10-quintela@redhat.com>
In-Reply-To: <20180627125604.15275-1-quintela@redhat.com>
References: <20180627125604.15275-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/16] migration: Create multifd_bytes
 ram_counter
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

This will include how many bytes they are sent through multifd.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                 | 2 ++
 migration/migration.c | 1 +
 qapi/migration.json   | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index f601099f90..0da0b0ac33 100644
--- a/hmp.c
+++ b/hmp.c
@@ -234,6 +234,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->dirty_sync_count);
         monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
                        info->ram->page_size >> 10);
+        monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
+                       info->ram->multifd_bytes >> 10);
 
         if (info->ram->dirty_pages_rate) {
             monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
diff --git a/migration/migration.c b/migration/migration.c
index 264f3ce84e..2680ba2d47 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -708,6 +708,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
     info->ram->postcopy_requests = ram_counters.postcopy_requests;
     info->ram->page_size = qemu_target_page_size();
+    info->ram->multifd_bytes = ram_counters.multifd_bytes;
 
     if (migrate_use_xbzrle()) {
         info->has_xbzrle_cache = true;
diff --git a/qapi/migration.json b/qapi/migration.json
index 1b4c1db670..186e8a7303 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -39,6 +39,8 @@
 # @page-size: The number of bytes per page for the various page-based
 #        statistics (since 2.10)
 #
+# @multifd-bytes: The number of bytes sent through multifd (since 3.0)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -46,7 +48,8 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int', 'page-size' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'int',
+           'multifd-bytes' : 'uint64' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.17.1
