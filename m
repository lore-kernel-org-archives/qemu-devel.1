Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cT9nE-0001C7-NA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cT9n9-0007Mu-3t
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:06:00 -0500
Received: from mail-db5eur01on0096.outbound.protection.outlook.com
	([104.47.2.96]:19763
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cT9n8-0007M6-9Z
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:05:55 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Mon, 16 Jan 2017 18:51:13 +0300
Message-ID: <20170116155113.21034-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
References: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] migration: discard non-dirty ram pages
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
Cc: quintela@redhat.com, amit.shah@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

After the start of postcopy migration there are some non-dirty pages which have
already been migrated. These pages are no longer needed on the source vm so that
we can free them and it doen't hurt to complete the migration.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 include/migration/migration.h |  1 +
 migration/migration.c         |  2 ++
 migration/ram.c               | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index d7bd404365..0d9b81545c 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -279,6 +279,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 int ram_discard_range(MigrationIncomingState *mis, const char *block_name,
                       uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+void ram_postcopy_migrated_memory_discard(MigrationState *ms);
 
 /**
  * @migrate_add_blocker - prevent migration from proceeding
diff --git a/migration/migration.c b/migration/migration.c
index 391db6f28b..20490ed020 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1662,6 +1662,8 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      */
     qemu_savevm_send_ping(ms->to_dst_file, 4);
 
+    ram_postcopy_migrated_memory_discard(ms);
+
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_report("postcopy_start: Migration stream errored");
diff --git a/migration/ram.c b/migration/ram.c
index b0322a0b5c..8a6b614b0d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1546,6 +1546,31 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
 
 /* **** functions for postcopy ***** */
 
+void ram_postcopy_migrated_memory_discard(MigrationState *ms)
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
+            uint8_t *addr = block->host + (run_start << TARGET_PAGE_BITS);
+            size_t chunk_size = (run_end - run_start) << TARGET_PAGE_BITS;
+
+            if (qemu_madvise(addr, chunk_size, QEMU_MADV_DONTNEED) < 0) {
+                error_report("migrate: madvise DONTNEED failed %p %ld: %s",
+                             addr, chunk_size, strerror(errno));
+            }
+
+            run_start = find_next_zero_bit(bitmap, range, run_end + 1);
+        }
+    }
+}
+
 /*
  * Callback from postcopy_each_ram_send_discard for each RAMBlock
  * Note: At this point the 'unsentmap' is the processed bitmap combined
-- 
2.11.0
