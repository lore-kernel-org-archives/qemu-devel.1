Received: from eggs.gnu.org ([2001:4830:134:3::10]:52973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hm-IY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000H6-Db
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000Fn-3K
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:54 +0300
Message-Id: <20180718154200.26777-12-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 11/17] background snapshot: add a memory
 page copying function
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

It's the only function making a memory page copy.
It supports multithreading semantics ensuring that
the page is copied by one thread only and releasing
the copied page from write protection.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/ram.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 3c4ccd85b4..10b6fdf23e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1706,6 +1706,62 @@ RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset)
     return NULL;
 }
 
+/**
+ * ram_copy_page: make a page copy
+ *
+ * Used in the background snapshot to make a copy of a memeory page.
+ * Ensures that the memeory page is copied only once.
+ * When a page copy is done, restores read/write access to the memory
+ * page.
+ * If a page is being copied by another thread, wait until the copying
+ * ends and exit.
+ *
+ * Returns:
+ *   -1 - on error
+ *    0 - the page wasn't copied by the function call
+ *    1 - the page has been copied
+ *
+ * @block:     RAM block to use
+ * @page_nr:   the page number to copy
+ * @page_copy: the pointer to return a page copy
+ *
+ */
+int ram_copy_page(RAMBlock *block, unsigned long page_nr,
+                          void **page_copy)
+{
+    void *host_page;
+
+    if (test_and_set_bit_atomic(page_nr, block->touched_map)) {
+        while (!test_bit_atomic(page_nr, block->copied_map)) {
+            /* the page is being copied -- wait for the end of the copying
+             * and check once again
+             */
+            qemu_event_wait(&ram_state->page_copying_done);
+        }
+        return 0;
+    }
+
+    *page_copy = ram_page_buffer_get();
+    if (!*page_copy) {
+        return -1;
+    }
+
+    host_page = block->host + (page_nr << TARGET_PAGE_BITS);
+    memcpy(*page_copy, host_page, TARGET_PAGE_SIZE);
+
+    if (ram_set_rw(host_page, TARGET_PAGE_SIZE)) {
+        ram_page_buffer_free(*page_copy);
+        *page_copy = NULL;
+        return -1;
+    }
+
+    set_bit_atomic(page_nr, block->copied_map);
+    qemu_event_set(&ram_state->page_copying_done);
+    qemu_event_reset(&ram_state->page_copying_done);
+
+    return 1;
+}
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
diff --git a/migration/ram.h b/migration/ram.h
index c3679ba65e..76ab0a3377 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -75,4 +75,5 @@ int ram_page_buffer_free(void *buffer);
 int ram_block_list_set_readonly(void);
 int ram_block_list_set_writable(void);
 
+int ram_copy_page(RAMBlock *block, unsigned long page_nr, void **page_copy);
 #endif
-- 
2.17.0
