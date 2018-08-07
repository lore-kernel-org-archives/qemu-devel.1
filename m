Received: from eggs.gnu.org ([2001:4830:134:3::10]:48471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy2t-0003CO-8Z
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy2p-00056Q-WE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fmy2p-00056G-PZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:12:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id n7-v6so7556650pgq.4
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 02:12:47 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue,  7 Aug 2018 17:12:02 +0800
Message-Id: <20180807091209.13531-4-xiaoguangrong@tencent.com>
In-Reply-To: <20180807091209.13531-1-xiaoguangrong@tencent.com>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 03/10] migration: introduce
 save_zero_page_to_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It will be used by the compression threads

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d631b9a6fe..49ace30614 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1667,27 +1667,47 @@ static void migration_bitmap_sync(RAMState *rs)
 /**
  * save_zero_page: send the zero page to the stream
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
-        ram_counters.duplicate++;
-        ram_counters.transferred +=
-            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_ZERO);
-        qemu_put_byte(rs->f, 0);
-        ram_counters.transferred += 1;
-        pages = 1;
+        len += save_page_header(rs, file, block, offset | RAM_SAVE_FLAG_ZERO);
+        qemu_put_byte(file, 0);
+        len += 1;
     }
+    return len;
+}
 
-    return pages;
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
+        ram_counters.duplicate++;
+        ram_counters.transferred += len;
+        return 1;
+    }
+    return -1;
 }
 
 static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
-- 
2.14.4
