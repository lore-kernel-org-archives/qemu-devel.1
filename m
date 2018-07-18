Received: from eggs.gnu.org ([2001:4830:134:3::10]:52974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hn-IH
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000HM-FP
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000F7-37
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:50 +0300
Message-Id: <20180718154200.26777-8-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 07/17] background snapshot: introduce page
 buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

To limit the amount of memory used by the background snapshot
a memory limiter is used which called "page buffer".
In fact, it's a memory page counter limiting the page allocation.
Currently, the limit of pages is hardcoded but its setter is
the matter of the future work.

The background snapshot makes a copy of the page before writing it
to the snapshot destination, but it doesn't use a preallocated buffer,
because the background snapshot employs the migration infrastructure
which, in turn, uses madvice to release the buffer.
The advice issuing is hard to track, so here we rely on anonymous
memory mapping and releasing it by the existing code.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/ram.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h |  3 ++
 2 files changed, 94 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4399c31606..27d3403435 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -192,6 +192,16 @@ struct RAMSrcPageRequest {
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
+/* Page buffer used for background snapshot */
+typedef struct RAMPageBuffer {
+    /* Page buffer capacity in host pages */
+    int capacity;
+    /* Current number of pages in the buffer */
+    int used;
+    /* Event to notify that buffer usage is under capacity */
+    QemuEvent used_decreased;
+} RAMPageBuffer;
+
 /* State of RAM for migration */
 struct RAMState {
     /* QEMUFile used for this migration */
@@ -230,6 +240,11 @@ struct RAMState {
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
+    /* The following 2 are for background snapshot */
+    /* Buffer data to store copies of ram pages while async vm saving */
+    RAMPageBuffer page_buffer;
+    /* Event to notify that a page copying just has finished*/
+    QemuEvent page_copying_done;
 };
 typedef struct RAMState RAMState;
 
@@ -1540,6 +1555,52 @@ void ram_block_list_destroy(void)
     }
 }
 
+static void ram_page_buffer_decrease_used(void)
+{
+    qemu_event_reset(&ram_state->page_buffer.used_decreased);
+    atomic_dec(&ram_state->page_buffer.used);
+    qemu_event_set(&ram_state->page_buffer.used_decreased);
+}
+
+static void ram_page_buffer_increase_used_wait(void)
+{
+    int used, *used_ptr;
+    RAMState *rs = ram_state;
+    used_ptr = &rs->page_buffer.used;
+    do {
+        used = atomic_read(used_ptr);
+        if (rs->page_buffer.capacity > used) {
+            if (atomic_cmpxchg(used_ptr, used, used + 1) == used) {
+                return;
+            } else {
+                continue;
+            }
+        } else {
+            qemu_event_wait(&rs->page_buffer.used_decreased);
+        }
+    } while (true);
+}
+
+void *ram_page_buffer_get(void)
+{
+    void *page;
+    ram_page_buffer_increase_used_wait();
+    page = mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_WRITE,
+                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+    if (page == MAP_FAILED) {
+        ram_page_buffer_decrease_used();
+        page = NULL;
+    }
+    return page;
+}
+
+int ram_page_buffer_free(void *buffer)
+{
+    ram_page_buffer_decrease_used();
+    return qemu_madvise(buffer, TARGET_PAGE_SIZE, MADV_DONTNEED);
+}
+
 RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset)
 {
     RAMBlock *block = NULL;
@@ -1559,6 +1620,7 @@ RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset)
 
     return NULL;
 }
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
@@ -1651,6 +1713,13 @@ static void xbzrle_load_cleanup(void)
 
 static void ram_state_cleanup(RAMState **rsp)
 {
+    if (migrate_background_snapshot()) {
+        qemu_event_destroy(&(*rsp)->page_buffer.used_decreased);
+        /* In case somebody is still waiting for the event */
+        qemu_event_set(&(*rsp)->page_copying_done);
+        qemu_event_destroy(&(*rsp)->page_copying_done);
+    }
+
     migration_page_queue_free(*rsp);
     qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
     qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
@@ -1689,6 +1758,13 @@ static void ram_save_cleanup(void *opaque)
         block->bmap = NULL;
         g_free(block->unsentmap);
         block->unsentmap = NULL;
+
+        if (migrate_background_snapshot()) {
+            g_free(block->touched_map);
+            block->touched_map = NULL;
+            g_free(block->copied_map);
+            block->copied_map = NULL;
+        }
     }
 
     xbzrle_cleanup();
@@ -1703,6 +1779,10 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+
+    /* page buffer capacity in number of pages */
+    rs->page_buffer.capacity = 1000;
+    rs->page_buffer.used = 0;
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2180,6 +2260,11 @@ static int ram_state_init(RAMState **rsp)
      */
     (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
 
+    if (migrate_background_snapshot()) {
+        qemu_event_init(&ram_state->page_buffer.used_decreased, false);
+        qemu_event_init(&ram_state->page_copying_done, false);
+    }
+
     ram_state_reset(*rsp);
 
     return 0;
@@ -2196,10 +2281,16 @@ static void ram_list_init_bitmaps(void)
             pages = block->max_length >> TARGET_PAGE_BITS;
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
+
             if (migrate_postcopy_ram()) {
                 block->unsentmap = bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
             }
+
+            if (migrate_background_snapshot()) {
+                block->touched_map = bitmap_new(pages);
+                block->copied_map = bitmap_new(pages);
+            }
         }
     }
 }
diff --git a/migration/ram.h b/migration/ram.h
index 385579cae9..7c802c1d7f 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -68,4 +68,7 @@ void ram_block_list_destroy(void);
 
 RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset);
 
+void *ram_page_buffer_get(void);
+int ram_page_buffer_free(void *buffer);
+
 #endif
-- 
2.17.0
