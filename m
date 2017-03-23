Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dG-0008UB-7l
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dD-0000gW-53
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dC-0000gI-T6
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A2D80F9D
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:36 +0100
Message-Id: <20170323204544.12015-44-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 43/51] ram: ram_discard_range() don't use the
 mis parameter
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 3 +--
 migration/postcopy-ram.c      | 6 ++----
 migration/ram.c               | 9 +++------
 migration/savevm.c            | 3 +--
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 90849a5..39a8e7e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -270,8 +270,7 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
 /* For outgoing discard bitmap */
 int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
-int ram_discard_range(MigrationIncomingState *mis, const char *block_name,
-                      uint64_t start, size_t length);
+int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 8756364..85fd8d7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -213,8 +213,6 @@ out:
 static int init_range(const char *block_name, void *host_addr,
                       ram_addr_t offset, ram_addr_t length, void *opaque)
 {
-    MigrationIncomingState *mis = opaque;
-
     trace_postcopy_init_range(block_name, host_addr, offset, length);
 
     /*
@@ -223,7 +221,7 @@ static int init_range(const char *block_name, void *host_addr,
      * - we're going to get the copy from the source anyway.
      * (Precopy will just overwrite this data, so doesn't need the discard)
      */
-    if (ram_discard_range(mis, block_name, 0, length)) {
+    if (ram_discard_range(block_name, 0, length)) {
         return -1;
     }
 
@@ -271,7 +269,7 @@ static int cleanup_range(const char *block_name, void *host_addr,
  */
 int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
 {
-    if (qemu_ram_foreach_block(init_range, mis)) {
+    if (qemu_ram_foreach_block(init_range, NULL)) {
         return -1;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 9772fd8..83c749c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -784,7 +784,7 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
         return;
     }
 
-    ram_discard_range(NULL, rbname, offset, pages << TARGET_PAGE_BITS);
+    ram_discard_range(rbname, offset, pages << TARGET_PAGE_BITS);
 }
 
 /**
@@ -1602,7 +1602,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
 
         while (run_start < range) {
             unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
-            ram_discard_range(NULL, block->idstr, run_start << TARGET_PAGE_BITS,
+            ram_discard_range(block->idstr, run_start << TARGET_PAGE_BITS,
                               (run_end - run_start) << TARGET_PAGE_BITS);
             run_start = find_next_zero_bit(bitmap, range, run_end + 1);
         }
@@ -1942,15 +1942,12 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
  *
  * Returns zero on success
  *
- * @mis: current migration incoming state
  * @rbname: name of the RAMBLock of the request. NULL means the
  *          same that last one.
  * @start: RAMBlock starting page
  * @length: RAMBlock size
  */
-int ram_discard_range(MigrationIncomingState *mis,
-                      const char *rbname,
-                      uint64_t start, size_t length)
+int ram_discard_range(const char *rbname, uint64_t start, size_t length)
 {
     int ret = -1;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index bbf055d..7cf387f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1479,8 +1479,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         block_length = qemu_get_be64(mis->from_src_file);
 
         len -= 16;
-        int ret = ram_discard_range(mis, ramid, start_addr,
-                                    block_length);
+        int ret = ram_discard_range(ramid, start_addr, block_length);
         if (ret) {
             return ret;
         }
-- 
2.9.3
