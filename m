Received: from eggs.gnu.org ([2001:4830:134:3::10]:33809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmEF-0002GY-4S
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmED-00038x-OL
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmED-00037M-H0
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B32AE7FE85
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:14 +0100
Message-Id: <1485207141-1941-11-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/17] migration: create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

The function still don't use multifd, but we have simplified
ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
counter and a new flag for this type of pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                         |  2 ++
 include/migration/migration.h |  1 +
 migration/migration.c         |  1 +
 migration/ram.c               | 51 ++++++++++++++++++++++++++++++++++++++++++-
 qapi-schema.json              |  4 +++-
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index e579766..76bc8c7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -222,6 +222,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
                            info->ram->postcopy_requests);
         }
+        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
+                       info->ram->multifd);
     }

     if (info->has_disk) {
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3989bd6..b3e4f31 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -282,6 +282,7 @@ uint64_t xbzrle_mig_pages_transferred(void);
 uint64_t xbzrle_mig_pages_overflow(void);
 uint64_t xbzrle_mig_pages_cache_miss(void);
 double xbzrle_mig_cache_miss_rate(void);
+uint64_t multifd_mig_pages_transferred(void);

 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
diff --git a/migration/migration.c b/migration/migration.c
index ab48f06..1d62b91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -652,6 +652,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = s->dirty_sync_count;
     info->ram->postcopy_requests = s->postcopy_requests;
+    info->ram->multifd = multifd_mig_pages_transferred();

     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
diff --git a/migration/ram.c b/migration/ram.c
index 5ad7cb3..c71929e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -61,6 +61,7 @@ static uint64_t bitmap_sync_count;
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200

 static uint8_t *ZERO_TARGET_PAGE;

@@ -141,6 +142,7 @@ typedef struct AccountingInfo {
     uint64_t dup_pages;
     uint64_t skipped_pages;
     uint64_t norm_pages;
+    uint64_t multifd_pages;
     uint64_t iterations;
     uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
@@ -211,6 +213,11 @@ uint64_t xbzrle_mig_pages_overflow(void)
     return acct_info.xbzrle_overflows;
 }

+uint64_t multifd_mig_pages_transferred(void)
+{
+    return acct_info.multifd_pages;
+}
+
 /* This is the last block that we have visited serching for dirty pages
  */
 static RAMBlock *last_seen_block;
@@ -990,6 +997,33 @@ static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
     return pages;
 }

+static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
+                            bool last_stage, uint64_t *bytes_transferred)
+{
+    int pages;
+    uint8_t *p;
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = pss->offset;
+
+    p = block->host + offset;
+
+    if (block == last_sent_block) {
+        offset |= RAM_SAVE_FLAG_CONTINUE;
+    }
+    pages = save_zero_page(f, block, offset, p, bytes_transferred);
+    if (pages == -1) {
+        *bytes_transferred +=
+            save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
+        *bytes_transferred += TARGET_PAGE_SIZE;
+        pages = 1;
+        acct_info.norm_pages++;
+        acct_info.multifd_pages++;
+    }
+
+    return pages;
+}
+
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
@@ -1427,6 +1461,8 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
             res = ram_save_compressed_page(f, pss,
                                            last_stage,
                                            bytes_transferred);
+        } else if (migrate_use_multifd()) {
+            res = ram_multifd_page(f, pss, last_stage, bytes_transferred);
         } else {
             res = ram_save_page(f, pss, last_stage,
                                 bytes_transferred);
@@ -2678,6 +2714,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     if (!migrate_use_compression()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
+
+    if (!migrate_use_multifd()) {
+        invalid_flags |= RAM_SAVE_FLAG_MULTIFD_PAGE;
+    }
     /* This RCU critical section can be very long running.
      * When RCU reclaims in the code start to become numerous,
      * it will be necessary to reduce the granularity of this
@@ -2705,13 +2745,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             if (flags & invalid_flags  & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
+            if (flags & invalid_flags  & RAM_SAVE_FLAG_MULTIFD_PAGE) {
+                error_report("Received an unexpected multifd page");
+            }

             ret = -EINVAL;
             break;
         }

         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
+                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                     RAM_SAVE_FLAG_MULTIFD_PAGE)) {
             RAMBlock *block = ram_block_from_stream(f, flags);

             host = host_from_ram_block_offset(block, addr);
@@ -2786,6 +2830,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                 break;
             }
             break;
+
+        case RAM_SAVE_FLAG_MULTIFD_PAGE:
+            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
+            break;
+
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             break;
diff --git a/qapi-schema.json b/qapi-schema.json
index 54232ee..3e93f7f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -574,6 +574,7 @@
 #
 # @postcopy-requests: The number of page requests received from the destination
 #        (since 2.7)
+# @multifd: number of pages sent with multifd (since 2.9)
 #
 # Since: 0.14.0
 ##
@@ -582,7 +583,8 @@
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
-           'postcopy-requests' : 'int' } }
+           'postcopy-requests' : 'int',
+           'multifd' : 'int'} }

 ##
 # @XBZRLECacheStats:
-- 
2.9.3
