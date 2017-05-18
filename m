Received: from eggs.gnu.org ([2001:4830:134:3::10]:57667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPCB-0001Du-2R
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPC9-000728-Fo
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPC9-00071p-6G
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 367D18123F
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:26:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:25:42 +0200
Message-Id: <20170518172543.32694-11-quintela@redhat.com>
In-Reply-To: <20170518172543.32694-1-quintela@redhat.com>
References: <20170518172543.32694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] migration: Export ram.c functions in its
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
 include/migration/migration.h | 38 -----------------------
 include/migration/misc.h      | 21 +++++++++++++
 migration/migration.c         |  1 +
 migration/postcopy-ram.c      |  1 +
 migration/ram.c               |  2 ++
 migration/ram.h               | 70 +++++++++++++++++++++++++++++++++++++++++++
 migration/rdma.c              |  2 +-
 migration/savevm.c            |  1 +
 vl.c                          |  1 +
 9 files changed, 98 insertions(+), 39 deletions(-)
 create mode 100644 include/migration/misc.h
 create mode 100644 migration/ram.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 4695af7..e0c66c5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -176,38 +176,6 @@ bool migration_in_postcopy(void);
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
@@ -218,8 +186,6 @@ int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
 bool migrate_colo_enabled(void);
 
-int64_t xbzrle_cache_resize(int64_t new_size);
-
 bool migrate_use_block(void);
 bool migrate_use_block_incremental(void);
 
@@ -258,7 +224,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                              ram_addr_t offset, size_t size,
                              uint64_t *bytes_sent);
 
-void ram_mig_init(void);
 void savevm_skip_section_footers(void);
 void register_global_state(void);
 void global_state_set_optional(void);
@@ -266,7 +231,4 @@ void savevm_skip_configuration(void);
 int global_state_store(void);
 void global_state_store_running(void);
 
-void migration_page_queue_free(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-uint64_t ram_pagesize_summary(void);
 #endif
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
index bacdb44..ffad8e5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -22,6 +22,7 @@
 #include "fd.h"
 #include "socket.h"
 #include "rdma.h"
+#include "ram.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6f239f9..230b5dc 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -24,6 +24,7 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
+#include "ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
diff --git a/migration/ram.c b/migration/ram.c
index cbb7b7a..f09549d 100644
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
index 0000000..c9563d1
--- /dev/null
+++ b/migration/ram.h
@@ -0,0 +1,70 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2011-2015 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
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
index fab30ea..e446c6f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -20,7 +20,7 @@
 #include "rdma.h"
 #include "migration/migration.h"
 #include "qemu-file.h"
-#include "exec/cpu-common.h"
+#include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 10731ea..6198ec2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "migration/snapshot.h"
+#include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
 #include "savevm.h"
diff --git a/vl.c b/vl.c
index 478ebce..5b09937 100644
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
