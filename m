Received: from eggs.gnu.org ([2001:4830:134:3::10]:55442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38af-0007Ob-5X
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ad-0005Ys-Iz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38ad-0005Xv-8h
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 480D9C04B31F
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:34 +0200
Message-Id: <20170425220451.6028-25-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 24/41] migration: Export ram.c functions in its
 own file
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

All functions are internal except for ram_mig_init().  Create
migration/misc.h for this kind of functions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 39 ------------------------------
 include/migration/misc.h      | 21 +++++++++++++++++
 migration/migration.c         |  1 +
 migration/postcopy-ram.c      |  1 +
 migration/ram.c               |  2 ++
 migration/ram.h               | 55 +++++++++++++++++++++++++++++++++++++++++++
 migration/rdma.c              |  2 +-
 migration/savevm.c            |  1 +
 vl.c                          |  1 +
 9 files changed, 83 insertions(+), 40 deletions(-)
 create mode 100644 include/migration/misc.h
 create mode 100644 migration/ram.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 08867c6..38ba508 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -202,38 +202,6 @@ bool migration_in_postcopy(void);
 bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
 
-void migrate_compress_threads_create(void);
-void migrate_compress_threads_join(void);
-void migrate_decompress_threads_create(void);
-void migrate_decompress_threads_join(void);
-uint64_t ram_bytes_remaining(void);
-uint64_t ram_bytes_transferred(void);
-uint64_t ram_bytes_total(void);
-uint64_t ram_dirty_sync_count(void);
-uint64_t ram_dirty_pages_rate(void);
-uint64_t ram_postcopy_requests(void);
-void free_xbzrle_decoded_buf(void);
-
-void acct_update_position(QEMUFile *f, size_t size, bool zero);
-
-uint64_t dup_mig_pages_transferred(void);
-uint64_t norm_mig_pages_transferred(void);
-uint64_t xbzrle_mig_bytes_transferred(void);
-uint64_t xbzrle_mig_pages_transferred(void);
-uint64_t xbzrle_mig_pages_overflow(void);
-uint64_t xbzrle_mig_pages_cache_miss(void);
-double xbzrle_mig_cache_miss_rate(void);
-
-void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
-void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
-                           unsigned long pages);
-/* For outgoing discard bitmap */
-int ram_postcopy_send_discard_bitmap(MigrationState *ms);
-/* For incoming postcopy discard */
-int ram_discard_range(const char *block_name, uint64_t start, size_t length);
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);
-void ram_postcopy_migrated_memory_release(MigrationState *ms);
-
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
@@ -244,8 +212,6 @@ int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
 bool migrate_colo_enabled(void);
 
-int64_t xbzrle_cache_resize(int64_t new_size);
-
 bool migrate_use_block_enabled(void);
 bool migrate_use_block_shared(void);
 
@@ -284,7 +250,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
 
-void ram_mig_init(void);
 void savevm_skip_section_footers(void);
 void register_global_state(void);
 void global_state_set_optional(void);
@@ -292,10 +257,6 @@ void savevm_skip_configuration(void);
 int global_state_store(void);
 void global_state_store_running(void);
 
-void migration_page_queue_free(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-uint64_t ram_pagesize_summary(void);
-
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state);
diff --git a/include/migration/misc.h b/include/migration/misc.h
new file mode 100644
index 0000000..0b37714
--- /dev/null
+++ b/include/migration/misc.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU migration miscellaneus exported functions
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MIGRATION_MISC_H
+#define MIGRATION_MISC_H
+
+/* migration/ram.c */
+
+void ram_mig_init(void);
+
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index 175e5c9..ef966ca 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,6 +21,7 @@
 #include "exec.h"
 #include "fd.h"
 #include "socket.h"
+#include "ram.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 07fbc25..3359224 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -23,6 +23,7 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
+#include "ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
diff --git a/migration/ram.c b/migration/ram.c
index 36afa98..89637eb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,7 +36,9 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
+#include "ram.h"
 #include "migration/migration.h"
+#include "migration/misc.h"
 #include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "postcopy-ram.h"
diff --git a/migration/ram.h b/migration/ram.h
new file mode 100644
index 0000000..1d9d6c4
--- /dev/null
+++ b/migration/ram.h
@@ -0,0 +1,55 @@
+/*
+ * QEMU migration ram
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_RAM_H
+#define QEMU_MIGRATION_RAM_H
+
+#include "qemu-common.h"
+#include "exec/cpu-common.h"
+
+int64_t xbzrle_cache_resize(int64_t new_size);
+uint64_t dup_mig_pages_transferred(void);
+uint64_t norm_mig_pages_transferred(void);
+uint64_t xbzrle_mig_bytes_transferred(void);
+uint64_t xbzrle_mig_pages_transferred(void);
+uint64_t xbzrle_mig_pages_cache_miss(void);
+double xbzrle_mig_cache_miss_rate(void);
+uint64_t xbzrle_mig_pages_overflow(void);
+uint64_t ram_bytes_transferred(void);
+uint64_t ram_bytes_remaining(void);
+uint64_t ram_dirty_sync_count(void);
+uint64_t ram_dirty_pages_rate(void);
+uint64_t ram_postcopy_requests(void);
+uint64_t ram_bytes_total(void);
+
+void migrate_compress_threads_create(void);
+void migrate_compress_threads_join(void);
+void migrate_decompress_threads_create(void);
+void migrate_decompress_threads_join(void);
+
+uint64_t ram_pagesize_summary(void);
+void migration_page_queue_free(void);
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+void acct_update_position(QEMUFile *f, size_t size, bool zero);
+void free_xbzrle_decoded_buf(void);
+void ram_debug_dump_bitmap(unsigned long *todump, bool expected,
+                           unsigned long pages);
+void ram_postcopy_migrated_memory_release(MigrationState *ms);
+/* For outgoing discard bitmap */
+int ram_postcopy_send_discard_bitmap(MigrationState *ms);
+/* For incoming postcopy discard */
+int ram_discard_range(const char *block_name, uint64_t start, size_t length);
+int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+
+void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
+#endif
diff --git a/migration/rdma.c b/migration/rdma.c
index 2fda7a5..96a90dd 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,7 +19,7 @@
 #include "qemu/cutils.h"
 #include "migration/migration.h"
 #include "qemu-file.h"
-#include "exec/cpu-common.h"
+#include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index d3e4d8e..a80bc83 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,6 +37,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "migration/snapshot.h"
+#include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
 #include "savevm.h"
diff --git a/vl.c b/vl.c
index 5b79f5b..17c0297 100644
--- a/vl.c
+++ b/vl.c
@@ -87,6 +87,7 @@ int main(int argc, char **argv)
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "migration/block.h"
+#include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
-- 
2.9.3
