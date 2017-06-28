Received: from eggs.gnu.org ([2001:4830:134:3::10]:51906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ9eN-0004sb-Oz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ9eM-0005wZ-Ke
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ9eM-0005wK-CG
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54DBDC0587D4
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 09:52:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 11:52:27 +0200
Message-Id: <20170628095228.4661-5-quintela@redhat.com>
In-Reply-To: <20170628095228.4661-1-quintela@redhat.com>
References: <20170628095228.4661-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] migration: Convert ram to use new
 load_setup()/load_cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com

Once there, I rename ram_migration_cleanup() to ram_save_cleanup().
Notice that this is the first pass, and I only passed XBZRLE to the
new scheme.  Moved decoded_buf to inside XBZRLE struct.
As a bonus, I don't have to export xbzrle functions from ram.c.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

loaded_data pointer was needed because called can change it (dave)
spell loaded correctly in comment (dave)
---
 migration/migration.c |  3 ---
 migration/ram.c       | 49 ++++++++++++++++++++++++++++++++++++-------------
 migration/ram.h       |  1 -
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8ea35f1..e244876 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -357,9 +357,6 @@ static void process_incoming_migration_co(void *opaque)
         migrate_decompress_threads_join();
         exit(EXIT_FAILURE);
     }
-
-    free_xbzrle_decoded_buf();
-
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
 }
diff --git a/migration/ram.c b/migration/ram.c
index 649f76c..73aec34 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -85,11 +85,10 @@ static struct {
     QemuMutex lock;
     /* it will store a page full of zeros */
     uint8_t *zero_target_page;
+    /* buffer used for XBZRLE decoding */
+    uint8_t *decoded_buf;
 } XBZRLE;
 
-/* buffer used for XBZRLE decoding */
-static uint8_t *xbzrle_decoded_buf;
-
 static void XBZRLE_cache_lock(void)
 {
     if (migrate_use_xbzrle())
@@ -1350,13 +1349,18 @@ uint64_t ram_bytes_total(void)
     return total;
 }
 
-void free_xbzrle_decoded_buf(void)
+static void xbzrle_load_setup(void)
 {
-    g_free(xbzrle_decoded_buf);
-    xbzrle_decoded_buf = NULL;
+    XBZRLE.decoded_buf = g_malloc(TARGET_PAGE_SIZE);
 }
 
-static void ram_migration_cleanup(void *opaque)
+static void xbzrle_load_cleanup(void)
+{
+    g_free(XBZRLE.decoded_buf);
+    XBZRLE.decoded_buf = NULL;
+}
+
+static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
@@ -2078,11 +2082,6 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
     int xh_flags;
     uint8_t *loaded_data;
 
-    if (!xbzrle_decoded_buf) {
-        xbzrle_decoded_buf = g_malloc(TARGET_PAGE_SIZE);
-    }
-    loaded_data = xbzrle_decoded_buf;
-
     /* extract RLE header */
     xh_flags = qemu_get_byte(f);
     xh_len = qemu_get_be16(f);
@@ -2096,7 +2095,9 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
         error_report("Failed to load XBZRLE page - len overflow!");
         return -1;
     }
+    loaded_data = XBZRLE.decoded_buf;
     /* load data and decode */
+    /* it can change loaded_data to point to an internal buffer */
     qemu_get_buffer_in_place(f, &loaded_data, xh_len);
 
     /* decode RLE */
@@ -2310,6 +2311,26 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
 }
 
 /**
+ * ram_load_setup: Setup RAM for migration incoming side
+ *
+ * Returns zero to indicate success and negative for error
+ *
+ * @f: QEMUFile where to receive the data
+ * @opaque: RAMState pointer
+ */
+static int ram_load_setup(QEMUFile *f, void *opaque)
+{
+    xbzrle_load_setup();
+    return 0;
+}
+
+static int ram_load_cleanup(void *opaque)
+{
+    xbzrle_load_cleanup();
+    return 0;
+}
+
+/**
  * ram_postcopy_incoming_init: allocate postcopy data structures
  *
  * Returns 0 for success and negative if there was one error
@@ -2629,7 +2650,9 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_live_complete_precopy = ram_save_complete,
     .save_live_pending = ram_save_pending,
     .load_state = ram_load,
-    .save_cleanup = ram_migration_cleanup,
+    .save_cleanup = ram_save_cleanup,
+    .load_setup = ram_load_setup,
+    .load_cleanup = ram_load_cleanup,
 };
 
 void ram_mig_init(void)
diff --git a/migration/ram.h b/migration/ram.h
index 6272eb0..a8b79a4 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -47,7 +47,6 @@ void migrate_decompress_threads_join(void);
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
-void free_xbzrle_decoded_buf(void);
 void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
                            unsigned long pages);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
-- 
2.9.4
