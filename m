Received: from eggs.gnu.org ([2001:4830:134:3::10]:39073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKm0-0003Xu-DK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlx-0005vk-EO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKlw-0005v8-UZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:45 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:24 +0000
Message-Id: <20170213175033.7314-6-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] migration: discard non-dirty ram pages
 after the start of postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

After the start of postcopy migration there are some non-dirty pages which have
already been migrated. These pages are no longer needed on the source vm so that
we can free them and it doen't hurt to complete the migration.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-Id: <20170203152321.19739-4-pbutsykin@virtuozzo.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/migration.c         |  4 ++++
 migration/ram.c               | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index b9b706a..71ce190 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -285,6 +285,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 int ram_discard_range(MigrationIncomingState *mis, const char *block_name,
                       uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+void ram_postcopy_migrated_memory_release(MigrationState *ms);
 
 /**
  * @migrate_add_blocker - prevent migration from proceeding
diff --git a/migration/migration.c b/migration/migration.c
index 68afc07..2a26a20 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1722,6 +1722,10 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      */
     qemu_savevm_send_ping(ms->to_dst_file, 4);
 
+    if (migrate_release_ram()) {
+        ram_postcopy_migrated_memory_release(ms);
+    }
+
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_report("postcopy_start: Migration stream errored");
diff --git a/migration/ram.c b/migration/ram.c
index c22209d..67f2efb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1537,6 +1537,25 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 
 /* **** functions for postcopy ***** */
 
+void ram_postcopy_migrated_memory_release(MigrationState *ms)
+{
+    struct RAMBlock *block;
+    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        unsigned long first = block->offset >> TARGET_PAGE_BITS;
+        unsigned long range = first + (block->used_length >> TARGET_PAGE_BITS);
+        unsigned long run_start = find_next_zero_bit(bitmap, range, first);
+
+        while (run_start < range) {
+            unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
+            ram_discard_range(NULL, block->idstr, run_start << TARGET_PAGE_BITS,
+                              (run_end - run_start) << TARGET_PAGE_BITS);
+            run_start = find_next_zero_bit(bitmap, range, run_end + 1);
+        }
+    }
+}
+
 /*
  * Callback from postcopy_each_ram_send_discard for each RAMBlock
  * Note: At this point the 'unsentmap' is the processed bitmap combined
-- 
2.9.3
