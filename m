Received: from eggs.gnu.org ([2001:4830:134:3::10]:52982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hs-Km
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000HV-HU
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000Fu-4c
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:56 +0300
Message-Id: <20180718154200.26777-14-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 13/17] background snapshot: add
 write-protected page access handler function
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

The handler does all the necessary operations to save the page being
accessed to the snapshot file(stream).

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/ram.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index b1623e96e7..04a4bf708d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1762,6 +1762,49 @@ int ram_copy_page(RAMBlock *block, unsigned long page_nr,
     return 1;
 }
 
+/**
+ * ram_process_page_fault
+ *
+ * Used in the background snapshot to queue the copy of the memory
+ * page for writing.
+ *
+ * Returns:
+ *    0 > - on error
+ *    0   - success
+ *
+ * @address:  guest address
+ *
+ */
+int ram_process_page_fault(void *address)
+{
+    int ret;
+    void *page_copy = NULL;
+    unsigned long page_nr;
+    ram_addr_t offset;
+
+    RAMBlock *block = ram_bgs_block_find(address, &offset);
+
+    if (!block) {
+        return -1;
+    }
+
+    page_nr = offset >> TARGET_PAGE_BITS;
+
+    ret = ram_copy_page(block, page_nr, &page_copy);
+
+    if (ret < 0) {
+        return ret;
+    } else if (ret > 0) {
+        if (ram_save_queue_pages(block, NULL, offset,
+                                 TARGET_PAGE_SIZE, page_copy)) {
+            ram_page_buffer_free(page_copy);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
diff --git a/migration/ram.h b/migration/ram.h
index 76ab0a3377..2b565ce620 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -76,4 +76,5 @@ int ram_block_list_set_readonly(void);
 int ram_block_list_set_writable(void);
 
 int ram_copy_page(RAMBlock *block, unsigned long page_nr, void **page_copy);
+int ram_process_page_fault(void *address);
 #endif
-- 
2.17.0
