Received: from eggs.gnu.org ([2001:4830:134:3::10]:52962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hh-FU
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000IB-LD
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000FN-8h
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:51 +0300
Message-Id: <20180718154200.26777-9-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 08/17] migration: add helpers to change VM
 memory protection rights
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

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/ram.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 27d3403435..ce3dead932 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1555,6 +1555,60 @@ void ram_block_list_destroy(void)
     }
 }
 
+static int mem_protect(void *addr, uint64_t length, int prot)
+{
+    int ret = mprotect(addr, length, prot);
+
+    if (ret < 0) {
+        error_report("%s: Can't change protection on ram block at %p",
+                     __func__, addr);
+    }
+
+    return ret;
+}
+
+static int ram_set_ro(void *addr, uint64_t length)
+{
+    return mem_protect(addr, length, PROT_READ);
+}
+
+static int ram_set_rw(void *addr, uint64_t length)
+{
+    return mem_protect(addr, length, PROT_READ | PROT_WRITE);
+}
+
+int ram_block_list_set_readonly(void)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+    int ret = 0;
+
+    QLIST_FOREACH(block, block_list, bgs_next) {
+        ret = ram_set_ro(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+int ram_block_list_set_writable(void)
+{
+    RAMBlock *block = NULL;
+    RamBlockList *block_list = ram_bgs_block_list_get();
+    int ret = 0;
+
+    QLIST_FOREACH(block, block_list, bgs_next) {
+        ret = ram_set_rw(block->host, block->used_length);
+        if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static void ram_page_buffer_decrease_used(void)
 {
     qemu_event_reset(&ram_state->page_buffer.used_decreased);
diff --git a/migration/ram.h b/migration/ram.h
index 7c802c1d7f..4c463597a5 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -71,4 +71,7 @@ RAMBlock *ram_bgs_block_find(uint8_t *address, ram_addr_t *page_offset);
 void *ram_page_buffer_get(void);
 int ram_page_buffer_free(void *buffer);
 
+int ram_block_list_set_readonly(void);
+int ram_block_list_set_writable(void);
+
 #endif
-- 
2.17.0
