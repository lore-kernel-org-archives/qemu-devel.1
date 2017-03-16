Received: from eggs.gnu.org ([2001:4830:134:3::10]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1coR0M-0008NW-OX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1coR0J-0000Cr-Is
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:43:30 -0400
Received: from [59.151.112.132] (port=35305 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1coR0I-0000AU-Ih
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:43:27 -0400
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 16:42:29 +0800
Message-ID: <20170316084229.32497-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Add page-size to output in 'info migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Chao Fan <fanc.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

The number of dirty pages outputed in 'pages' in the command
'info migrate', so add page-size to calculate the number of dirty
pages in bytes.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hmp.c                         | 3 +++
 include/migration/migration.h | 1 +
 migration/migration.c         | 2 ++
 migration/ram.c               | 2 ++
 qapi-schema.json              | 5 ++++-
 5 files changed, 12 insertions(+), 1 deletion(-)

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
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..9fffe73 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -172,6 +172,7 @@ struct MigrationState
     int64_t xbzrle_cache_size;
     int64_t setup_time;
     int64_t dirty_sync_count;
+    int64_t page_size;
     /* Count of requests incoming from destination */
     int64_t postcopy_requests;
 
diff --git a/migration/migration.c b/migration/migration.c
index 3dab684..a1cb123 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -645,6 +645,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = s->dirty_sync_count;
     info->ram->postcopy_requests = s->postcopy_requests;
+    info->ram->page_size = s->page_size;
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
@@ -1115,6 +1116,7 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->last_req_rb = NULL;
     error_free(s->error);
     s->error = NULL;
+    s->page_size = 0;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/ram.c b/migration/ram.c
index 719425b..028cc4c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1998,7 +1998,9 @@ static int ram_save_init_globals(void)
 static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMBlock *block;
+    MigrationState *s = migrate_get_current();
 
+    s->page_size = TARGET_PAGE_SIZE;
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_save_init_globals() < 0) {
diff --git a/qapi-schema.json b/qapi-schema.json
index 32b4a4b..4658c3d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -575,6 +575,9 @@
 # @postcopy-requests: The number of page requests received from the destination
 #        (since 2.7)
 #
+# @page-size: The number of bytes in page of this gutst.
+#        (since 2.10)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -582,7 +585,7 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'int' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.9.3
