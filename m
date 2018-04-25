Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdq-0003h9-Eu
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdp-00036q-Im
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdp-00036W-D5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:49 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:25 +0100
Message-Id: <20180425200326.72337-16-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 15/16] migration: introduce save_normal_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It directly sends the page to the stream neither checking zero nor
using xbzrle or compression

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180330075128.26919-10-xiaoguangrong@tencent.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 97917542c5..2eb4c0bf49 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1012,6 +1012,34 @@ static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
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
@@ -1052,18 +1080,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
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
@@ -1194,14 +1211,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
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
2.17.0
