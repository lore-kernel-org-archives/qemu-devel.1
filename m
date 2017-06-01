Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGb-00077P-9l
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGa-0002G2-7U
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYGZ-0002FM-Uz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BDF880472
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:08:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:08:11 +0200
Message-Id: <20170601220813.30535-4-quintela@redhat.com>
In-Reply-To: <20170601220813.30535-1-quintela@redhat.com>
References: <20170601220813.30535-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] migration: Print statistics about the
 number of remaining target pages
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 4 +++-
 migration/ram.c       | 4 ++--
 migration/ram.h       | 2 +-
 qapi-schema.json      | 6 +++++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ea3d41c..2c13217 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -518,7 +518,9 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
-        info->ram->remaining = ram_bytes_remaining();
+        info->ram->remaining_pages = ram_pages_remaining();
+        info->ram->remaining = ram_pages_remaining() *
+            qemu_target_page_size();
         info->ram->dirty_pages_rate = ram_dirty_pages_rate();
     }
 }
diff --git a/migration/ram.c b/migration/ram.c
index 04b55a7..30519e1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -265,9 +265,9 @@ uint64_t ram_bytes_transferred(void)
     return ram_state.bytes_transferred;
 }
 
-uint64_t ram_bytes_remaining(void)
+uint64_t ram_pages_remaining(void)
 {
-    return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
+    return ram_state.migration_dirty_pages;
 }
 
 uint64_t ram_dirty_sync_count(void)
diff --git a/migration/ram.h b/migration/ram.h
index d4da419..5864470 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -41,7 +41,7 @@ uint64_t xbzrle_mig_pages_cache_miss(void);
 double xbzrle_mig_cache_miss_rate(void);
 uint64_t xbzrle_mig_pages_overflow(void);
 uint64_t ram_bytes_transferred(void);
-uint64_t ram_bytes_remaining(void);
+uint64_t ram_pages_remaining(void);
 uint64_t ram_dirty_sync_count(void);
 uint64_t ram_dirty_pages_rate(void);
 uint64_t ram_postcopy_requests(void);
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b65..ff1c048 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -601,6 +601,9 @@
 # @page-size: The number of bytes per page for the various page-based
 #        statistics (since 2.10)
 #
+# @remaining-pages: amount of pages remaining to be transferred to the target VM
+#        (since 2.10)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -608,7 +611,8 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int', 'page-size' : 'int' } }
+           'postcopy-requests' : 'int', 'page-size' : 'int',
+           'remaining-pages' : 'int' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.9.4
