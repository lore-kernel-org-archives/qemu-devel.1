Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1evep5-00033m-AO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1evep4-0007m1-8J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:15 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1evep4-0007ku-1G
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 03:58:14 -0400
Received: by mail-pf0-x22f.google.com with SMTP id h19so5528900pfd.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 00:58:13 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 13 Mar 2018 15:57:38 +0800
Message-Id: <20180313075739.11194-8-xiaoguangrong@tencent.com>
In-Reply-To: <20180313075739.11194-1-xiaoguangrong@tencent.com>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 7/8] migration: introduce save_normal_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It directly sends the page to the stream neither checking zero nor
using xbzrle or compression

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9627ce18e9..f778627992 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -995,6 +995,34 @@ static bool control_save_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
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
@@ -1035,18 +1063,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
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
@@ -1172,14 +1189,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
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
