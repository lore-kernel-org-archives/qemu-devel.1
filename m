Received: from eggs.gnu.org ([2001:4830:134:3::10]:56758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176c-00015i-4B
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f176b-0005Cf-2i
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:54 -0400
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:39038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f176a-0005CN-Th
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:10:53 -0400
Received: by mail-pl0-x22c.google.com with SMTP id s24-v6so1201805plq.6
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:10:52 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 27 Mar 2018 17:10:42 +0800
Message-Id: <20180327091043.30220-10-xiaoguangrong@tencent.com>
In-Reply-To: <20180327091043.30220-1-xiaoguangrong@tencent.com>
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 09/10] migration: introduce
 save_normal_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It directly sends the page to the stream neither checking zero nor
using xbzrle or compression

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 771763985d..e71a9aee11 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1014,6 +1014,34 @@ static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     return true;
 }
 
+/*
+ * directly send the page to the stream
+ *
+ * Returns the number of pages written.
+ *
+ * @rs: current RAM state
+ * @block: block that contains the page we want to send
+ * @offset: offset inside the block for the page
+ * @buf: the page to be sent
+ * @async: send to page asyncly
+ */
+static int save_normal_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
+                            uint8_t *buf, bool async)
+{
+    ram_counters.transferred += save_page_header(rs, rs->f, block,
+                                                 offset | RAM_SAVE_FLAG_PAGE);
+    if (async) {
+        qemu_put_buffer_async(rs->f, buf, TARGET_PAGE_SIZE,
+                              migrate_release_ram() &
+                              migration_in_postcopy());
+    } else {
+        qemu_put_buffer(rs->f, buf, TARGET_PAGE_SIZE);
+    }
+    ram_counters.transferred += TARGET_PAGE_SIZE;
+    ram_counters.normal++;
+    return 1;
+}
+
 /**
  * ram_save_page: send the given page to the stream
  *
@@ -1054,18 +1082,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
     /* XBZRLE overflow or normal page */
     if (pages == -1) {
-        ram_counters.transferred +=
-            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_PAGE);
-        if (send_async) {
-            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                                  migrate_release_ram() &
-                                  migration_in_postcopy());
-        } else {
-            qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
-        }
-        ram_counters.transferred += TARGET_PAGE_SIZE;
-        pages = 1;
-        ram_counters.normal++;
+        pages = save_normal_page(rs, block, offset, p, send_async);
     }
 
     XBZRLE_cache_unlock();
@@ -1196,14 +1213,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
          * we post it as normal page as compression will take much
          * CPU resource.
          */
-        ram_counters.transferred += save_page_header(rs, rs->f, block,
-                                        offset | RAM_SAVE_FLAG_PAGE);
-        qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
-                              migrate_release_ram() &
-                              migration_in_postcopy());
-        ram_counters.transferred += TARGET_PAGE_SIZE;
-        ram_counters.normal++;
-        pages = 1;
+        pages = save_normal_page(rs, block, offset, p, true);
     } else {
         pages = compress_page_with_multi_thread(rs, block, offset);
     }
-- 
2.14.3
