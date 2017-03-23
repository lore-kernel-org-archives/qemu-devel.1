Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cJ-0007bQ-KJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cF-0008Ue-Tg
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cF-0008TT-Jt
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93D0B61E7C
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:45:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:44:54 +0100
Message-Id: <20170323204544.12015-2-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/51] ram: Update all functions comments
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

Added doc comments for existing functions comment and rewrite them in
a common style.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 348 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 227 insertions(+), 121 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index de1e0a3..76f1fc4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -96,11 +96,17 @@ static void XBZRLE_cache_unlock(void)
         qemu_mutex_unlock(&XBZRLE.lock);
 }
 
-/*
- * called from qmp_migrate_set_cache_size in main thread, possibly while
- * a migration is in progress.
- * A running migration maybe using the cache and might finish during this
- * call, hence changes to the cache are protected by XBZRLE.lock().
+/**
+ * xbzrle_cache_resize: resize the xbzrle cache
+ *
+ * This function is called from qmp_migrate_set_cache_size in main
+ * thread, possibly while a migration is in progress.  A running
+ * migration may be using the cache and might finish during this call,
+ * hence changes to the cache are protected by XBZRLE.lock().
+ *
+ * Returns the new_size or negative in case of error.
+ *
+ * @new_size: new cache size
  */
 int64_t xbzrle_cache_resize(int64_t new_size)
 {
@@ -323,6 +329,7 @@ static inline void terminate_compression_threads(void)
     int idx, thread_count;
 
     thread_count = migrate_compress_threads();
+
     for (idx = 0; idx < thread_count; idx++) {
         qemu_mutex_lock(&comp_param[idx].mutex);
         comp_param[idx].quit = true;
@@ -383,11 +390,11 @@ void migrate_compress_threads_create(void)
 }
 
 /**
- * save_page_header: Write page header to wire
+ * save_page_header: write page header to wire
  *
  * If this is the 1st block, it also writes the block identification
  *
- * Returns: Number of bytes written
+ * Returns the number of bytes written
  *
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -410,11 +417,14 @@ static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
     return size;
 }
 
-/* Reduce amount of guest cpu execution to hopefully slow down memory writes.
- * If guest dirty memory rate is reduced below the rate at which we can
- * transfer pages to the destination then we should be able to complete
- * migration. Some workloads dirty memory way too fast and will not effectively
- * converge, even with auto-converge.
+/**
+ * mig_throotle_guest_down: throotle down the guest
+ *
+ * Reduce amount of guest cpu execution to hopefully slow down memory
+ * writes. If guest dirty memory rate is reduced below the rate at
+ * which we can transfer pages to the destination then we should be
+ * able to complete migration. Some workloads dirty memory way too
+ * fast and will not effectively converge, even with auto-converge.
  */
 static void mig_throttle_guest_down(void)
 {
@@ -431,11 +441,16 @@ static void mig_throttle_guest_down(void)
     }
 }
 
-/* Update the xbzrle cache to reflect a page that's been sent as all 0.
+/**
+ * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
+ *
+ * @current_addr: address for the zero page
+ *
+ * Update the xbzrle cache to reflect a page that's been sent as all 0.
  * The important thing is that a stale (not-yet-0'd) page be replaced
  * by the new data.
  * As a bonus, if the page wasn't in the cache it gets added so that
- * when a small write is made into the 0'd page it gets XBZRLE sent
+ * when a small write is made into the 0'd page it gets XBZRLE sent.
  */
 static void xbzrle_cache_zero_page(ram_addr_t current_addr)
 {
@@ -459,8 +474,8 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
  *          -1 means that xbzrle would be longer than normal
  *
  * @f: QEMUFile where to send the data
- * @current_data:
- * @current_addr:
+ * @current_data: contents of the page
+ * @current_addr: addr of the page
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
@@ -530,13 +545,17 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
     return 1;
 }
 
-/* Called with rcu_read_lock() to protect migration_bitmap
- * rb: The RAMBlock  to search for dirty pages in
- * start: Start address (typically so we can continue from previous page)
- * ram_addr_abs: Pointer into which to store the address of the dirty page
- *               within the global ram_addr space
+/**
+ * migration_bitmap_find_dirty: find the next drity page from start
  *
- * Returns: byte offset within memory region of the start of a dirty page
+ * Called with rcu_read_lock() to protect migration_bitmap
+ *
+ * Returns the byte offset within memory region of the start of a dirty page
+ *
+ * @rb: RAMBlock where to search for dirty pages
+ * @start: starting address (typically so we can continue from previous page)
+ * @ram_addr_abs: pointer into which to store the address of the dirty page
+ *                within the global ram_addr space
  */
 static inline
 ram_addr_t migration_bitmap_find_dirty(RAMBlock *rb,
@@ -600,10 +619,14 @@ static void migration_bitmap_sync_init(void)
     iterations_prev = 0;
 }
 
-/* Returns a summary bitmap of the page sizes of all RAMBlocks;
- * for VMs with just normal pages this is equivalent to the
- * host page size.  If it's got some huge pages then it's the OR
- * of all the different page sizes.
+/**
+ * ram_pagesize_summary: calculate all the pagesizes of a VM
+ *
+ * Returns a summary bitmap of the page sizes of all RAMBlocks
+ *
+ * For VMs with just normal pages this is equivalent to the host page
+ * size. If it's got some huge pages then it's the OR of all the
+ * different page sizes.
  */
 uint64_t ram_pagesize_summary(void)
 {
@@ -693,9 +716,9 @@ static void migration_bitmap_sync(void)
 }
 
 /**
- * save_zero_page: Send the zero page to the stream
+ * save_zero_page: send the zero page to the stream
  *
- * Returns: Number of pages written.
+ * Returns the number of pages written.
  *
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
@@ -731,14 +754,14 @@ static void ram_release_pages(MigrationState *ms, const char *block_name,
 }
 
 /**
- * ram_save_page: Send the given page to the stream
+ * ram_save_page: send the given page to the stream
  *
- * Returns: Number of pages written.
+ * Returns the number of pages written.
  *          < 0 - error
  *          >=0 - Number of pages written - this might legally be 0
  *                if xbzrle noticed the page was the same.
  *
- * @ms: The current migration state.
+ * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
@@ -921,9 +944,9 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
 /**
  * ram_save_compressed_page: compress the given page and send it to the stream
  *
- * Returns: Number of pages written.
+ * Returns the number of pages written.
  *
- * @ms: The current migration state.
+ * @ms: current migration state
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
@@ -1000,17 +1023,17 @@ static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
     return pages;
 }
 
-/*
- * Find the next dirty page and update any state associated with
- * the search process.
+/**
+ * find_dirty_block: find the next dirty page and update any state
+ * associated with the search process.
  *
- * Returns: True if a page is found
+ * Returns if a page is found
  *
- * @f: Current migration stream.
- * @pss: Data about the state of the current dirty page scan.
- * @*again: Set to false if the search has scanned the whole of RAM
- * *ram_addr_abs: Pointer into which to store the address of the dirty page
- *               within the global ram_addr space
+ * @f: QEMUFile where to send the data
+ * @pss: data about the state of the current dirty page scan
+ * @again: set to false if the search has scanned the whole of RAM
+ * @ram_addr_abs: pointer into which to store the address of the dirty page
+ *                within the global ram_addr space
  */
 static bool find_dirty_block(QEMUFile *f, PageSearchStatus *pss,
                              bool *again, ram_addr_t *ram_addr_abs)
@@ -1055,13 +1078,17 @@ static bool find_dirty_block(QEMUFile *f, PageSearchStatus *pss,
     }
 }
 
-/*
+/**
+ * unqueue_page: gets a page of the queue
+ *
  * Helper for 'get_queued_page' - gets a page off the queue
- *      ms:      MigrationState in
- * *offset:      Used to return the offset within the RAMBlock
- * ram_addr_abs: global offset in the dirty/sent bitmaps
  *
- * Returns:      block (or NULL if none available)
+ * Returns the block of the page (or NULL if none available)
+ *
+ * @ms: current migration state
+ * @offset: used to return the offset within the RAMBlock
+ * @ram_addr_abs: pointer into which to store the address of the dirty page
+ *                within the global ram_addr space
  */
 static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
                               ram_addr_t *ram_addr_abs)
@@ -1091,15 +1118,17 @@ static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
     return block;
 }
 
-/*
- * Unqueue a page from the queue fed by postcopy page requests; skips pages
- * that are already sent (!dirty)
+/**
+ * get_queued_page: unqueue a page from the postocpy requests
  *
- *      ms:      MigrationState in
- *     pss:      PageSearchStatus structure updated with found block/offset
- * ram_addr_abs: global offset in the dirty/sent bitmaps
+ * Skips pages that are already sent (!dirty)
  *
- * Returns:      true if a queued page is found
+ * Returns if a queued page is found
+ *
+ * @ms: current migration state
+ * @pss: data about the state of the current dirty page scan
+ * @ram_addr_abs: pointer into which to store the address of the dirty page
+ *                within the global ram_addr space
  */
 static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
                             ram_addr_t *ram_addr_abs)
@@ -1157,11 +1186,12 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
 }
 
 /**
- * flush_page_queue: Flush any remaining pages in the ram request queue
- *    it should be empty at the end anyway, but in error cases there may be
- *    some left.
+ * flush_page_queue: flush any remaining pages in the ram request queue
  *
- * ms: MigrationState
+ * It should be empty at the end anyway, but in error cases there may
+ * xbe some left.
+ *
+ * @ms: current migration state
  */
 void flush_page_queue(MigrationState *ms)
 {
@@ -1179,12 +1209,17 @@ void flush_page_queue(MigrationState *ms)
 }
 
 /**
- * Queue the pages for transmission, e.g. a request from postcopy destination
- *   ms: MigrationStatus in which the queue is held
- *   rbname: The RAMBlock the request is for - may be NULL (to mean reuse last)
- *   start: Offset from the start of the RAMBlock
- *   len: Length (in bytes) to send
- *   Return: 0 on success
+ * ram_save_queue_pages: queue the page for transmission
+ *
+ * A request from postcopy destination for example.
+ *
+ * Returns zero on success or negative on error
+ *
+ * @ms: current migration state
+ * @rbname: Name of the RAMBLock of the request. NULL means the
+ *          same that last one.
+ * @start: starting address from the start of the RAMBlock
+ * @len: length (in bytes) to send
  */
 int ram_save_queue_pages(MigrationState *ms, const char *rbname,
                          ram_addr_t start, ram_addr_t len)
@@ -1243,17 +1278,16 @@ err:
 }
 
 /**
- * ram_save_target_page: Save one target page
+ * ram_save_target_page: save one target page
  *
+ * Returns the umber of pages written
  *
+ * @ms: current migration state
  * @f: QEMUFile where to send the data
- * @block: pointer to block that contains the page we want to send
- * @offset: offset inside the block for the page;
+ * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
- * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
- *
- * Returns: Number of pages written.
+ * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
  */
 static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
                                 PageSearchStatus *pss,
@@ -1295,20 +1329,19 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
 }
 
 /**
- * ram_save_host_page: Starting at *offset send pages up to the end
- *                     of the current host page.  It's valid for the initial
- *                     offset to point into the middle of a host page
- *                     in which case the remainder of the hostpage is sent.
- *                     Only dirty target pages are sent.
- *                     Note that the host page size may be a huge page for this
- *                     block.
+ * ram_save_host_page: save a whole host page
  *
- * Returns: Number of pages written.
+ * Starting at *offset send pages up to the end of the current host
+ * page. It's valid for the initial offset to point into the middle of
+ * a host page in which case the remainder of the hostpage is sent.
+ * Only dirty target pages are sent. Note that the host page size may
+ * be a huge page for this block.
  *
+ * Returns the number of pages written or negative on error
+ *
+ * @ms: current migration state
  * @f: QEMUFile where to send the data
- * @block: pointer to block that contains the page we want to send
- * @offset: offset inside the block for the page; updated to last target page
- *          sent
+ * @pss: data about the page we want to send
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
@@ -1340,12 +1373,11 @@ static int ram_save_host_page(MigrationState *ms, QEMUFile *f,
 }
 
 /**
- * ram_find_and_save_block: Finds a dirty page and sends it to f
+ * ram_find_and_save_block: finds a dirty page and sends it to f
  *
  * Called within an RCU critical section.
  *
- * Returns:  The number of pages written
- *           0 means no dirty pages
+ * Returns the number of pages written where zero means no dirty pages
  *
  * @f: QEMUFile where to send the data
  * @last_stage: if we are at the completion stage
@@ -1580,12 +1612,19 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
     }
 }
 
-/*
+/**
+ * postcopy_send_discard_bm_ram: discard a RAMBlock
+ *
+ * Returns zero on success
+ *
  * Callback from postcopy_each_ram_send_discard for each RAMBlock
  * Note: At this point the 'unsentmap' is the processed bitmap combined
  *       with the dirtymap; so a '1' means it's either dirty or unsent.
- * start,length: Indexes into the bitmap for the first bit
- *            representing the named block and length in target-pages
+ *
+ * @ms: current migration state
+ * @pds: state for postcopy
+ * @start: RAMBlock starting page
+ * @length: RAMBlock size
  */
 static int postcopy_send_discard_bm_ram(MigrationState *ms,
                                         PostcopyDiscardState *pds,
@@ -1621,13 +1660,18 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
     return 0;
 }
 
-/*
+/**
+ * postcopy_each_ram_send_discard: discard all RAMBlocks
+ *
+ * Returns 0 for success or negative for error
+ *
  * Utility for the outgoing postcopy code.
  *   Calls postcopy_send_discard_bm_ram for each RAMBlock
  *   passing it bitmap indexes and name.
- * Returns: 0 on success
  * (qemu_ram_foreach_block ends up passing unscaled lengths
  *  which would mean postcopy code would have to deal with target page)
+ *
+ * @ms: current migration state
  */
 static int postcopy_each_ram_send_discard(MigrationState *ms)
 {
@@ -1656,17 +1700,21 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
     return 0;
 }
 
-/*
- * Helper for postcopy_chunk_hostpages; it's called twice to cleanup
- *   the two bitmaps, that are similar, but one is inverted.
+/**
+ * postcopy_chuck_hostpages_pass: canocalize bitmap in hostpages
  *
- * We search for runs of target-pages that don't start or end on a
- * host page boundary;
- * unsent_pass=true: Cleans up partially unsent host pages by searching
- *                 the unsentmap
- * unsent_pass=false: Cleans up partially dirty host pages by searching
- *                 the main migration bitmap
+ * Helper for postcopy_chunk_hostpages; it's called twice to
+ * canonicalize the two bitmaps, that are similar, but one is
+ * inverted.
  *
+ * Postcopy requires that all target pages in a hostpage are dirty or
+ * clean, not a mix.  This function canonicalizes the bitmaps.
+ *
+ * @ms: current migration state
+ * @unsent_pass: if true we need to canonicalize partially unsent host pages
+ *               otherwise we need to canonicalize partially dirty host pages
+ * @block: block that contains the page we want to canonicalize
+ * @pds: state for postcopy
  */
 static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                                           RAMBlock *block,
@@ -1784,14 +1832,18 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
     }
 }
 
-/*
+/**
+ * postcopy_chuck_hostpages: discrad any partially sent host page
+ *
  * Utility for the outgoing postcopy code.
  *
  * Discard any partially sent host-page size chunks, mark any partially
  * dirty host-page size chunks as all dirty.  In this case the host-page
  * is the host-page for the particular RAMBlock, i.e. it might be a huge page
  *
- * Returns: 0 on success
+ * Returns zero on success
+ *
+ * @ms: current migration state
  */
 static int postcopy_chunk_hostpages(MigrationState *ms)
 {
@@ -1822,7 +1874,11 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
     return 0;
 }
 
-/*
+/**
+ * ram_postcopy_send_discard_bitmap: transmit the discard bitmap
+ *
+ * Returns zero on success
+ *
  * Transmit the set of pages to be discarded after precopy to the target
  * these are pages that:
  *     a) Have been previously transmitted but are now dirty again
@@ -1830,6 +1886,8 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
  *        any pages on the destination that have been mapped by background
  *        tasks get discarded (transparent huge pages is the specific concern)
  * Hopefully this is pretty sparse
+ *
+ * @ms: current migration state
  */
 int ram_postcopy_send_discard_bitmap(MigrationState *ms)
 {
@@ -1878,13 +1936,16 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
     return ret;
 }
 
-/*
- * At the start of the postcopy phase of migration, any now-dirty
- * precopied pages are discarded.
+/**
+ * ram_discard_range: discard dirtied pages at the beginning of postcopy
  *
- * start, length describe a byte address range within the RAMBlock
+ * Returns zero on success
  *
- * Returns 0 on success.
+ * @mis: current migration incoming state
+ * @block_name: Name of the RAMBLock of the request. NULL means the
+ *              same that last one.
+ * @start: RAMBlock starting page
+ * @length: RAMBlock size
  */
 int ram_discard_range(MigrationIncomingState *mis,
                       const char *block_name,
@@ -1987,12 +2048,21 @@ static int ram_save_init_globals(void)
     return 0;
 }
 
-/* Each of ram_save_setup, ram_save_iterate and ram_save_complete has
+/*
+ * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
  * start to become numerous it will be necessary to reduce the
  * granularity of these critical sections.
  */
 
+/**
+ * ram_save_setup: Setup RAM for migration
+ *
+ * Returns zero to indicate success and negative for error
+ *
+ * @f: QEMUFile where to send the data
+ * @opaque: RAMState pointer
+ */
 static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMBlock *block;
@@ -2027,6 +2097,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     return 0;
 }
 
+/**
+ * ram_save_setup: iterative stage for migration
+ *
+ * Returns zero to indicate success and negative for error
+ *
+ * @f: QEMUFile where to send the data
+ * @opaque: RAMState pointer
+ */
 static int ram_save_iterate(QEMUFile *f, void *opaque)
 {
     int ret;
@@ -2091,7 +2169,16 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     return done;
 }
 
-/* Called with iothread lock */
+/**
+ * ram_save_complete: function called to send the remaining amount of ram
+ *
+ * Returns zero to indicate success
+ *
+ * Called with iothread lock
+ *
+ * @f: QEMUFile where to send the data
+ * @opaque: RAMState pointer
+ */
 static int ram_save_complete(QEMUFile *f, void *opaque)
 {
     rcu_read_lock();
@@ -2185,17 +2272,17 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
     return 0;
 }
 
-/* Must be called from within a rcu critical section.
+/**
+ * ram_block_from_stream: read a RAMBlock id from the migration stream
+ *
+ * Must be called from within a rcu critical section.
+ *
  * Returns a pointer from within the RCU-protected ram_list.
- */
-/*
- * Read a RAMBlock ID from the stream f.
  *
- * f: Stream to read from
- * flags: Page flags (mostly to see if it's a continuation of previous block)
+ * @f: QEMUFile where to read the data from
+ * @flags: Page flags (mostly to see if it's a continuation of previous block)
  */
-static inline RAMBlock *ram_block_from_stream(QEMUFile *f,
-                                              int flags)
+static inline RAMBlock *ram_block_from_stream(QEMUFile *f, int flags)
 {
     static RAMBlock *block = NULL;
     char id[256];
@@ -2232,9 +2319,15 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
     return block->host + offset;
 }
 
-/*
+/**
+ * ram_handle_compressed: handle the zero page case
+ *
  * If a page (or a whole RDMA chunk) has been
  * determined to be zero, then zap it.
+ *
+ * @host: host address for the zero page
+ * @ch: what the page is filled from.  We only support zero
+ * @size: size of the zero page
  */
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
 {
@@ -2373,9 +2466,16 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
-/*
- * Allocate data structures etc needed by incoming migration with postcopy-ram
- * postcopy-ram's similarly names postcopy_ram_incoming_init does the work
+/**
+ * ram_postococpy_incoming_init: allocate postcopy data structures
+ *
+ * Returns 0 for success and negative if there was one error
+ *
+ * @mis: current migration incoming state
+ *
+ * Allocate data structures etc needed by incoming migration with
+ * postcopy-ram postcopy-ram's similarly names
+ * postcopy_ram_incoming_init does the work
  */
 int ram_postcopy_incoming_init(MigrationIncomingState *mis)
 {
@@ -2384,9 +2484,15 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis)
     return postcopy_ram_incoming_init(mis, ram_pages);
 }
 
-/*
+/**
+ * ram_load_postocpy: load a page in postcopy case
+ *
+ * Returns 0 for success or -errno in case of error
+ *
  * Called in postcopy mode by ram_load().
  * rcu_read_lock is taken prior to this being called.
+ *
+ * @f: QEMUFile where to send the data
  */
 static int ram_load_postcopy(QEMUFile *f)
 {
-- 
2.9.3
