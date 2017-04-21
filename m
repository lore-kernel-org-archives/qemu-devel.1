Received: from eggs.gnu.org ([2001:4830:134:3::10]:44560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBG-0001cf-0w
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBE-00071T-SG
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XBE-000718-MI
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98823C067C0A
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:56:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:55:43 +0200
Message-Id: <20170421115646.15544-3-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/65] ram: Rename flush_page_queue() to
 migration_page_queue_free()
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

It reflects better what it does.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 2 +-
 migration/migration.c         | 2 +-
 migration/ram.c               | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..24487be 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -377,7 +377,7 @@ void savevm_skip_configuration(void);
 int global_state_store(void);
 void global_state_store_running(void);
 
-void flush_page_queue(MigrationState *ms);
+void migration_page_queue_free(MigrationState *ms);
 int ram_save_queue_pages(MigrationState *ms, const char *rbname,
                          ram_addr_t start, ram_addr_t len);
 uint64_t ram_pagesize_summary(void);
diff --git a/migration/migration.c b/migration/migration.c
index ad4036f..4bee05d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -955,7 +955,7 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
-    flush_page_queue(s);
+    migration_page_queue_free(s);
 
     if (s->to_dst_file) {
         trace_migrate_fd_cleanup();
diff --git a/migration/ram.c b/migration/ram.c
index 652abe4..356f8ce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1186,14 +1186,15 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
 }
 
 /**
- * flush_page_queue: flush any remaining pages in the ram request queue
+ * migration_page_queue_free: drop any remaining pages in the ram
+ * request queue
  *
  * It should be empty at the end anyway, but in error cases there may
  * be some left.  in case that there is any page left, we drop it.
  *
  * @ms: current migration state
  */
-void flush_page_queue(MigrationState *ms)
+void migration_page_queue_free(MigrationState *ms)
 {
     struct MigrationSrcPageRequest *mspr, *next_mspr;
     /* This queue generally should be empty - but in the case of a failed
-- 
2.9.3
