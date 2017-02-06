Received: from eggs.gnu.org ([2001:4830:134:3::10]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAD-0003uU-Ow
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canAC-0006Pw-JJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canAC-0006Pj-At
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85FFE3D955
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:56 +0000
Message-Id: <20170206173306.20603-7-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/16] Fold postcopy_ram_discard_range into
 ram_discard_range
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

Using the previously created ram_block_discard_range,
kill off postcopy_ram_discard_range.
ram_discard_range is just a wrapper that does the name lookup.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/postcopy-ram.h |  7 -------
 migration/postcopy-ram.c         | 30 +-----------------------------
 migration/ram.c                  | 24 +++---------------------
 migration/trace-events           |  2 +-
 4 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
index b6a7491f..43bbbca 100644
--- a/include/migration/postcopy-ram.h
+++ b/include/migration/postcopy-ram.h
@@ -35,13 +35,6 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages);
 int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis);
 
 /*
- * Discard the contents of 'length' bytes from 'start'
- * We can assume that if we've been called postcopy_ram_hosttest returned true
- */
-int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
-                               size_t length);
-
-/*
  * Userfault requires us to mark RAM as NOHUGEPAGE prior to discard
  * however leaving it until after precopy means that most of the precopy
  * data is still THPd
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a40dddb..1e3d22f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -200,27 +200,6 @@ out:
     return ret;
 }
 
-/**
- * postcopy_ram_discard_range: Discard a range of memory.
- * We can assume that if we've been called postcopy_ram_hosttest returned true.
- *
- * @mis: Current incoming migration state.
- * @start, @length: range of memory to discard.
- *
- * returns: 0 on success.
- */
-int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
-                               size_t length)
-{
-    trace_postcopy_ram_discard_range(start, length);
-    if (madvise(start, length, MADV_DONTNEED)) {
-        error_report("%s MADV_DONTNEED: %s", __func__, strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
 /*
  * Setup an area of RAM so that it *can* be used for postcopy later; this
  * must be done right at the start prior to pre-copy.
@@ -239,7 +218,7 @@ static int init_range(const char *block_name, void *host_addr,
      * - we're going to get the copy from the source anyway.
      * (Precopy will just overwrite this data, so doesn't need the discard)
      */
-    if (postcopy_ram_discard_range(mis, host_addr, length)) {
+    if (ram_discard_range(mis, block_name, 0, length)) {
         return -1;
     }
 
@@ -658,13 +637,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     return -1;
 }
 
-int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
-                               size_t length)
-{
-    assert(0);
-    return -1;
-}
-
 int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
 {
     assert(0);
diff --git a/migration/ram.c b/migration/ram.c
index d33bd21..136996a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1845,6 +1845,8 @@ int ram_discard_range(MigrationIncomingState *mis,
 {
     int ret = -1;
 
+    trace_ram_discard_range(block_name, start, length);
+
     rcu_read_lock();
     RAMBlock *rb = qemu_ram_block_by_name(block_name);
 
@@ -1854,27 +1856,7 @@ int ram_discard_range(MigrationIncomingState *mis,
         goto err;
     }
 
-    uint8_t *host_startaddr = rb->host + start;
-
-    if ((uintptr_t)host_startaddr & (qemu_host_page_size - 1)) {
-        error_report("ram_discard_range: Unaligned start address: %p",
-                     host_startaddr);
-        goto err;
-    }
-
-    if ((start + length) <= rb->used_length) {
-        uint8_t *host_endaddr = host_startaddr + length;
-        if ((uintptr_t)host_endaddr & (qemu_host_page_size - 1)) {
-            error_report("ram_discard_range: Unaligned end address: %p",
-                         host_endaddr);
-            goto err;
-        }
-        ret = postcopy_ram_discard_range(mis, host_startaddr, length);
-    } else {
-        error_report("ram_discard_range: Overrun block '%s' (%" PRIu64
-                     "/%zx/" RAM_ADDR_FMT")",
-                     block_name, start, length, rb->used_length);
-    }
+    ret = ram_block_discard_range(rb, start, length);
 
 err:
     rcu_read_unlock();
diff --git a/migration/trace-events b/migration/trace-events
index fa660e3..7372ce2 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -68,6 +68,7 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, uint64_t
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
+ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
@@ -176,7 +177,6 @@ rdma_start_outgoing_migration_after_rdma_source_init(void) ""
 # migration/postcopy-ram.c
 postcopy_discard_send_finish(const char *ramblock, int nwords, int ncmds) "%s mask words sent=%d in %d commands"
 postcopy_discard_send_range(const char *ramblock, unsigned long start, unsigned long length) "%s:%lx/%lx"
-postcopy_ram_discard_range(void *start, size_t length) "%p,+%zx"
 postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
 postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
 postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
-- 
2.9.3
