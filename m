Received: from eggs.gnu.org ([2001:4830:134:3::10]:45951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dB-0008M3-Dc
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dA-0000em-C0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dA-0000eB-5P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:48 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:34 +0100
Message-Id: <20170323204544.12015-42-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 41/51] Add page-size to output in 'info migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Chao Fan <fanc.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: Chao Fan <fanc.fnst@cn.fujitsu.com>

The number of dirty pages outputed in 'pages' in the command
'info migrate', so add page-size to calculate the number of dirty
pages in bytes.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 | 3 +++
 migration/migration.c | 1 +
 qapi-schema.json      | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index edb8970..be75e71 100644
--- a/hmp.c
+++ b/hmp.c
@@ -215,6 +215,9 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->normal_bytes >> 10);
         monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
                        info->ram->dirty_sync_count);
+        monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
+                       info->ram->page_size >> 10);
+
         if (info->ram->dirty_pages_rate) {
             monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
                            info->ram->dirty_pages_rate);
diff --git a/migration/migration.c b/migration/migration.c
index 92c3c6b..fc19ba7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -650,6 +650,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = ram_dirty_sync_count();
     info->ram->postcopy_requests = ram_postcopy_requests();
+    info->ram->page_size = qemu_target_page_size();
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..c7ec62c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -598,6 +598,9 @@
 # @postcopy-requests: The number of page requests received from the destination
 #        (since 2.7)
 #
+# @page-size: The number of bytes per page for the various page-based
+#        statistics (since 2.10)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -605,7 +608,7 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'int' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.9.3
