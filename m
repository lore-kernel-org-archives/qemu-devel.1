Received: from eggs.gnu.org ([2001:4830:134:3::10]:45887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d7-0008Jo-SE
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d6-0000bj-0r
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9d5-0000bM-PA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C36077E9CB
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:31 +0100
Message-Id: <20170323204544.12015-39-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 38/51] migration: Remove MigrationState from
 migration_in_postcopy
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

We need to call for the migrate_get_current() in more that half of the
uses, so call that inside.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  2 +-
 migration/migration.c         |  6 ++++--
 migration/ram.c               | 22 ++++++++++------------
 migration/savevm.c            |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index e88bbaf..90849a5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -238,7 +238,7 @@ bool migration_is_idle(MigrationState *s);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
-bool migration_in_postcopy(MigrationState *);
+bool migration_in_postcopy(void);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
diff --git a/migration/migration.c b/migration/migration.c
index ad4ea03..3f99ab3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1054,14 +1054,16 @@ bool migration_has_failed(MigrationState *s)
             s->state == MIGRATION_STATUS_FAILED);
 }
 
-bool migration_in_postcopy(MigrationState *s)
+bool migration_in_postcopy(void)
 {
+    MigrationState *s = migrate_get_current();
+
     return (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
 bool migration_in_postcopy_after_devices(MigrationState *s)
 {
-    return migration_in_postcopy(s) && s->postcopy_after_devices;
+    return migration_in_postcopy() && s->postcopy_after_devices;
 }
 
 bool migration_is_idle(MigrationState *s)
diff --git a/migration/ram.c b/migration/ram.c
index 591cf89..cb5f06f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -778,10 +778,9 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     return pages;
 }
 
-static void ram_release_pages(MigrationState *ms, const char *rbname,
-                              uint64_t offset, int pages)
+static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
 {
-    if (!migrate_release_ram() || !migration_in_postcopy(ms)) {
+    if (!migrate_release_ram() || !migration_in_postcopy()) {
         return;
     }
 
@@ -847,9 +846,9 @@ static int ram_save_page(RAMState *rs, MigrationState *ms,
              * page would be stale
              */
             xbzrle_cache_zero_page(rs, current_addr);
-            ram_release_pages(ms, block->idstr, pss->offset, pages);
+            ram_release_pages(block->idstr, pss->offset, pages);
         } else if (!rs->ram_bulk_stage &&
-                   !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
+                   !migration_in_postcopy() && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(rs, &p, current_addr, block,
                                      offset, last_stage);
             if (!last_stage) {
@@ -868,7 +867,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms,
         if (send_async) {
             qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
                                   migrate_release_ram() &
-                                  migration_in_postcopy(ms));
+                                  migration_in_postcopy());
         } else {
             qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         }
@@ -898,8 +897,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
         error_report("compressed data failed!");
     } else {
         bytes_sent += blen;
-        ram_release_pages(migrate_get_current(), block->idstr,
-                          offset & TARGET_PAGE_MASK, 1);
+        ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
     }
 
     return bytes_sent;
@@ -1035,7 +1033,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
                 }
             }
             if (pages > 0) {
-                ram_release_pages(ms, block->idstr, pss->offset, pages);
+                ram_release_pages(block->idstr, pss->offset, pages);
             }
         } else {
             offset |= RAM_SAVE_FLAG_CONTINUE;
@@ -1043,7 +1041,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(rs, block, offset);
             } else {
-                ram_release_pages(ms, block->idstr, pss->offset, pages);
+                ram_release_pages(block->idstr, pss->offset, pages);
             }
         }
     }
@@ -2194,7 +2192,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     rcu_read_lock();
 
-    if (!migration_in_postcopy(migrate_get_current())) {
+    if (!migration_in_postcopy()) {
         migration_bitmap_sync(rs);
     }
 
@@ -2232,7 +2230,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
 
     remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
 
-    if (!migration_in_postcopy(migrate_get_current()) &&
+    if (!migration_in_postcopy() &&
         remaining_size < max_size) {
         qemu_mutex_lock_iothread();
         rcu_read_lock();
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..853a81a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1062,7 +1062,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 static bool should_send_vmdesc(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-    bool in_postcopy = migration_in_postcopy(migrate_get_current());
+    bool in_postcopy = migration_in_postcopy();
     return !machine->suppress_vmdesc && !in_postcopy;
 }
 
@@ -1111,7 +1111,7 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
     int vmdesc_len;
     SaveStateEntry *se;
     int ret;
-    bool in_postcopy = migration_in_postcopy(migrate_get_current());
+    bool in_postcopy = migration_in_postcopy();
 
     trace_savevm_state_complete_precopy();
 
-- 
2.9.3
