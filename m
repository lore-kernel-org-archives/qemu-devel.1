Received: from eggs.gnu.org ([2001:4830:134:3::10]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82L-0006lr-C1
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82H-0003fa-Ep
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dD82H-0003ez-7D
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQE0016WLCJ5K70@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:31 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 23 May 2017 14:31:08 +0300
Message-id: <1495539071-12995-8-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113130eucas1p1babac9d8659c10abe22ddc7d5b9526ab@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V6 07/10] migration: add bitmap for copied page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

This patch adds ability to track down already copied
pages, it's necessary for calculation vCPU block time in
postcopy migration feature and maybe for restore after
postcopy migration failure.

Functions which work with RAMBlock are placed into ram.c,
due to TARGET_WORDS_BIGENDIAN is poisoned int postcopy-ram.c -
hardware independed code.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h | 16 +++++++++++
 migration/postcopy-ram.c      | 22 ++++++++++++---
 migration/ram.c               | 63 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 449cb07..4e05c83 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -101,6 +101,20 @@ struct MigrationIncomingState {
     LoadStateEntry_Head loadvm_handlers;
 
     /*
+     * bitmap indicates whether page copied,
+     * based on ramblock offset
+     * now it is using only for blocktime calculation in
+     * postcopy migration, so livetime of this entry:
+     * since user requested blocktime calculation,
+     * till the end of postcopy migration
+     * as an example it could represend following memory map
+     * ___________________________________
+     * |4k pages | hugepages | 4k pages
+     *
+     * */
+    unsigned long *copied_pages;
+
+    /*
      * PostcopyBlocktimeContext to keep information for postcopy
      * live migration, to calculate vCPU block time
      * */
@@ -279,6 +293,8 @@ int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
+unsigned long int get_copied_bit_offset(ram_addr_t addr);
+unsigned long int *copied_pages_bitmap_new(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_message(MigrationIncomingState *mis,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5435a40..d647769 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -94,23 +94,34 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 
 static void postcopy_migration_cb(Notifier *n, void *data)
 {
-    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
-                                               postcopy_notifier);
     MigrationState *s = data;
     if (migration_has_finished(s) || migration_has_failed(s)) {
+        MigrationIncomingState *mis = migration_incoming_get_current();
+        PostcopyBlocktimeContext *ctx = mis->blocktime_ctx;
+
+        if (!ctx) {
+            return;
+        }
+
         g_free(ctx->page_fault_vcpu_time);
         /* g_free is NULL robust */
         ctx->page_fault_vcpu_time = NULL;
         g_free(ctx->vcpu_addr);
         ctx->vcpu_addr = NULL;
+        g_free(mis->copied_pages);
+        mis->copied_pages = NULL;
     }
 }
 
 static void migration_exit_cb(Notifier *n, void *data)
 {
-    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
-                                               exit_notifier);
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyBlocktimeContext *ctx = mis->blocktime_ctx;
+    if (!ctx) {
+        return;
+    }
     destroy_blocktime_context(ctx);
+    mis->blocktime_ctx = NULL;
 }
 
 static struct PostcopyBlocktimeContext *blocktime_context_new(void)
@@ -227,6 +238,9 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
             mis->blocktime_ctx = blocktime_context_new();
         }
 
+        if (!mis->copied_pages) {
+            mis->copied_pages = copied_pages_bitmap_new();
+        }
         asked_features |= UFFD_FEATURE_THREAD_ID;
     }
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index f59fdd4..1abb6bb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2661,6 +2661,69 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static unsigned long get_total_bits_per_page(ram_addr_t mem_length,
+        size_t page_size)
+{
+    unsigned long page_size_bit = find_last_bit((unsigned long *)&page_size,
+            BITS_PER_LONG);
+    unsigned long total_bits = mem_length >> page_size_bit;
+    if (mem_length % page_size) {
+        total_bits += 1;
+    }
+    return total_bits;
+}
+
+/*
+ * this function allocates bitmap for copied pages,
+ * also it calculates
+ * how many entries do we need
+ * */
+unsigned long int *copied_pages_bitmap_new(void)
+{
+    RAMBlock *block;
+    unsigned long int total_bits = 0;
+
+    rcu_read_lock();
+    RAMBLOCK_FOREACH(block) {
+        /* in general case used_length may not be aligned
+         * by page_size */
+
+        total_bits += get_total_bits_per_page(block->used_length,
+                block->page_size);
+    }
+    rcu_read_unlock();
+
+    return bitmap_new(total_bits);
+}
+
+unsigned long int get_copied_bit_offset(ram_addr_t addr)
+{
+    RAMBlock *block;
+    unsigned long int iter_bit = 0;
+
+    rcu_read_lock();
+    RAMBLOCK_FOREACH(block) {
+        /* in general case used_length may not be aligned
+         * by page_size */
+        if (block->host == NULL) {
+            continue;
+        }
+        if (addr - (ram_addr_t)block->host < block->max_length) {
+            unsigned long page_size_bit = find_last_bit(
+                    (unsigned long *)&block->page_size,
+                    BITS_PER_LONG);
+            ram_addr_t offset = addr - (ram_addr_t)block->host;
+            iter_bit += offset >> page_size_bit;
+            break;
+        }
+        iter_bit += get_total_bits_per_page(block->used_length,
+                block->page_size);
+    }
+    rcu_read_unlock();
+
+    return iter_bit;
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_live_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-- 
1.8.3.1
