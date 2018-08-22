Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpO-0006rS-0G
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpM-0000DB-FG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpM-0000Ct-AL
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:32 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:47 +0200
Message-Id: <20180822120050.12694-18-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 17/20] migration: introduce
 save_zero_page_to_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It will be used by the compression threads

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9d2ec247ec..8ffa0a6d55 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1672,29 +1672,49 @@ static void migration_bitmap_sync(RAMState *rs)
 }
 
 /**
- * save_zero_page: send the zero page to the stream
+ * save_zero_page_to_file: send the zero page to the file
  *
- * Returns the number of pages written.
+ * Returns the size of data written to the file, 0 means the page is not
+ * a zero page
  *
  * @rs: current RAM state
+ * @file: the file where the data is saved
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  */
-static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
+static int save_zero_page_to_file(RAMState *rs, QEMUFile *file,
+                                  RAMBlock *block, ram_addr_t offset)
 {
     uint8_t *p = block->host + offset;
-    int pages = -1;
+    int len = 0;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
+        len += save_page_header(rs, file, block, offset | RAM_SAVE_FLAG_ZERO);
+        qemu_put_byte(file, 0);
+        len += 1;
+    }
+    return len;
+}
+
+/**
+ * save_zero_page: send the zero page to the stream
+ *
+ * Returns the number of pages written.
+ *
+ * @rs: current RAM state
+ * @block: block that contains the page we want to send
+ * @offset: offset inside the block for the page
+ */
+static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
+{
+    int len = save_zero_page_to_file(rs, rs->f, block, offset);
+
+    if (len) {
         ram_counters.duplicate++;
-        ram_counters.transferred +=
-            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_ZERO);
-        qemu_put_byte(rs->f, 0);
-        ram_counters.transferred += 1;
-        pages = 1;
+        ram_counters.transferred += len;
+        return 1;
     }
-
-    return pages;
+    return -1;
 }
 
 static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
-- 
2.17.1
