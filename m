Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAH-0003y8-RB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAE-0006Qh-Ty
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAE-0006QM-MA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DADFF4DB14
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:58 +0000
Message-Id: <20170206173306.20603-9-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/16] postcopy: Plumb pagesize down into
 place helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now we deal with normal size pages and huge pages we need
to tell the place handlers the size we're dealing with
and make sure the temporary page is large enough.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/postcopy-ram.h |  6 +++--
 migration/postcopy-ram.c         | 47 ++++++++++++++++++++++++----------------
 migration/ram.c                  | 15 +++++++------
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
index 43bbbca..8e036b9 100644
--- a/include/migration/postcopy-ram.h
+++ b/include/migration/postcopy-ram.h
@@ -74,13 +74,15 @@ void postcopy_discard_send_finish(MigrationState *ms,
  *    to use other postcopy_ routines to allocate.
  * returns 0 on success
  */
-int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from);
+int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
+                        size_t pagesize);
 
 /*
  * Place a zero page at (host) atomically
  * returns 0 on success
  */
-int postcopy_place_page_zero(MigrationIncomingState *mis, void *host);
+int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
+                             size_t pagesize);
 
 /*
  * Allocate a page of memory that can be mapped at a later point in time
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1e3d22f..a8b7fed 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -321,7 +321,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
-        munmap(mis->postcopy_tmp_page, getpagesize());
+        munmap(mis->postcopy_tmp_page, mis->largest_page_size);
         mis->postcopy_tmp_page = NULL;
     }
     trace_postcopy_ram_incoming_cleanup_exit();
@@ -543,13 +543,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
  * Place a host page (from) at (host) atomically
  * returns 0 on success
  */
-int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from)
+int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
+                        size_t pagesize)
 {
     struct uffdio_copy copy_struct;
 
     copy_struct.dst = (uint64_t)(uintptr_t)host;
     copy_struct.src = (uint64_t)(uintptr_t)from;
-    copy_struct.len = getpagesize();
+    copy_struct.len = pagesize;
     copy_struct.mode = 0;
 
     /* copy also acks to the kernel waking the stalled thread up
@@ -559,8 +560,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from)
      */
     if (ioctl(mis->userfault_fd, UFFDIO_COPY, &copy_struct)) {
         int e = errno;
-        error_report("%s: %s copy host: %p from: %p",
-                     __func__, strerror(e), host, from);
+        error_report("%s: %s copy host: %p from: %p (size: %zd)",
+                     __func__, strerror(e), host, from, pagesize);
 
         return -e;
     }
@@ -573,23 +574,29 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from)
  * Place a zero page at (host) atomically
  * returns 0 on success
  */
-int postcopy_place_page_zero(MigrationIncomingState *mis, void *host)
+int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
+                             size_t pagesize)
 {
-    struct uffdio_zeropage zero_struct;
+    trace_postcopy_place_page_zero(host);
 
-    zero_struct.range.start = (uint64_t)(uintptr_t)host;
-    zero_struct.range.len = getpagesize();
-    zero_struct.mode = 0;
+    if (pagesize == getpagesize()) {
+        struct uffdio_zeropage zero_struct;
+        zero_struct.range.start = (uint64_t)(uintptr_t)host;
+        zero_struct.range.len = getpagesize();
+        zero_struct.mode = 0;
 
-    if (ioctl(mis->userfault_fd, UFFDIO_ZEROPAGE, &zero_struct)) {
-        int e = errno;
-        error_report("%s: %s zero host: %p",
-                     __func__, strerror(e), host);
+        if (ioctl(mis->userfault_fd, UFFDIO_ZEROPAGE, &zero_struct)) {
+            int e = errno;
+            error_report("%s: %s zero host: %p",
+                         __func__, strerror(e), host);
 
-        return -e;
+            return -e;
+        }
+    } else {
+        /* TODO: The kernel can't use UFFDIO_ZEROPAGE for hugepages */
+        assert(0);
     }
 
-    trace_postcopy_place_page_zero(host);
     return 0;
 }
 
@@ -604,7 +611,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host)
 void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 {
     if (!mis->postcopy_tmp_page) {
-        mis->postcopy_tmp_page = mmap(NULL, getpagesize(),
+        mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
                              PROT_READ | PROT_WRITE, MAP_PRIVATE |
                              MAP_ANONYMOUS, -1, 0);
         if (mis->postcopy_tmp_page == MAP_FAILED) {
@@ -649,13 +656,15 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     return -1;
 }
 
-int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from)
+int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
+                        size_t pagesize)
 {
     assert(0);
     return -1;
 }
 
-int postcopy_place_page_zero(MigrationIncomingState *mis, void *host)
+int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
+                        size_t pagesize)
 {
     assert(0);
     return -1;
diff --git a/migration/ram.c b/migration/ram.c
index 136996a..ff448ef 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2354,6 +2354,7 @@ static int ram_load_postcopy(QEMUFile *f)
         void *host = NULL;
         void *page_buffer = NULL;
         void *place_source = NULL;
+        RAMBlock *block = NULL;
         uint8_t ch;
 
         addr = qemu_get_be64(f);
@@ -2363,7 +2364,7 @@ static int ram_load_postcopy(QEMUFile *f)
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
         place_needed = false;
         if (flags & (RAM_SAVE_FLAG_COMPRESS | RAM_SAVE_FLAG_PAGE)) {
-            RAMBlock *block = ram_block_from_stream(f, flags);
+            block = ram_block_from_stream(f, flags);
 
             host = host_from_ram_block_offset(block, addr);
             if (!host) {
@@ -2438,14 +2439,14 @@ static int ram_load_postcopy(QEMUFile *f)
 
         if (place_needed) {
             /* This gets called at the last target page in the host page */
+            void *place_dest = host + TARGET_PAGE_SIZE - block->page_size;
+
             if (all_zero) {
-                ret = postcopy_place_page_zero(mis,
-                                               host + TARGET_PAGE_SIZE -
-                                               qemu_host_page_size);
+                ret = postcopy_place_page_zero(mis, place_dest,
+                                               block->page_size);
             } else {
-                ret = postcopy_place_page(mis, host + TARGET_PAGE_SIZE -
-                                               qemu_host_page_size,
-                                               place_source);
+                ret = postcopy_place_page(mis, place_dest,
+                                          place_source, block->page_size);
             }
         }
         if (!ret) {
-- 
2.9.3
