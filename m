Received: from eggs.gnu.org ([2001:4830:134:3::10]:40649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-00082p-V5
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-0007R0-0m
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOk-0007Pu-QA
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:10 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so2760525wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:23 +0200
Message-Id: <1497523981-38449-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/41] exec: split qemu_ram_alloc_from_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add qemu_ram_alloc_from_fd(), which can be use to allocate ramblock from
fd only.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                  | 45 ++++++++++++++++++++++++++++++---------------
 include/exec/ram_addr.h |  3 +++
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 42a5a7c..42ad1ea 100644
--- a/exec.c
+++ b/exec.c
@@ -1914,14 +1914,12 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 }
 
 #ifdef __linux__
-RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
-                                   Error **errp)
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+                                 bool share, int fd,
+                                 Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int fd;
-    bool created;
     int64_t file_size;
 
     if (xen_enabled()) {
@@ -1946,18 +1944,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    fd = file_ram_open(mem_path, memory_region_name(mr), &created, errp);
-    if (fd < 0) {
-        return NULL;
-    }
-
     size = HOST_PAGE_ALIGN(size);
     file_size = get_file_size(fd);
     if (file_size > 0 && file_size < size) {
         error_setg(errp, "backing store %s size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
                    mem_path, file_size, size);
-        close(fd);
         return NULL;
     }
 
@@ -1968,10 +1960,6 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     new_block->flags = share ? RAM_SHARED : 0;
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
     if (!new_block->host) {
-        if (created) {
-            unlink(mem_path);
-        }
-        close(fd);
         g_free(new_block);
         return NULL;
     }
@@ -1983,6 +1971,33 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
     return new_block;
+
+}
+
+
+RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
+                                   bool share, const char *mem_path,
+                                   Error **errp)
+{
+    int fd;
+    bool created;
+    RAMBlock *block;
+
+    fd = file_ram_open(mem_path, memory_region_name(mr), &created, errp);
+    if (fd < 0) {
+        return NULL;
+    }
+
+    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    if (!block) {
+        if (created) {
+            unlink(mem_path);
+        }
+        close(fd);
+        return NULL;
+    }
+
+    return block;
 }
 #endif
 
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 140efa8..73d1bea 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -65,6 +65,9 @@ unsigned long last_ram_page(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
                                    Error **errp);
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+                                 bool share, int fd,
+                                 Error **errp);
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
 RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp);
-- 
1.8.3.1
