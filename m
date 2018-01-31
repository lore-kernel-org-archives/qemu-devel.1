Received: from eggs.gnu.org ([2001:4830:134:3::10]:37888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUQ-0006SD-FK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUL-0007Xg-NN
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eglUL-0007VH-AF
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:17 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 31 Jan 2018 14:02:25 +0800
Message-Id: <20180131060229.9294-3-haozhong.zhang@intel.com>
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 2/6] exec: switch qemu_ram_alloc_from_{file,
 fd} to the 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

As more flag parameters besides the existing 'share' are going to be
added to qemu_ram_alloc_from_{file,fd}(), let's swith 'share' to a
'flags' parameters in advance, so as to ease the further additions.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 exec.c                  | 15 ++++++++-------
 include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
 memory.c                |  8 ++++++--
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index c0a5a52c4a..0b46b03d87 100644
--- a/exec.c
+++ b/exec.c
@@ -1607,6 +1607,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
                             bool truncate,
+                            uint64_t flags,
                             Error **errp)
 {
     void *area;
@@ -1652,8 +1653,7 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         (block->flags & RAM_SHARED) ? QEMU_RAM_SHARE : 0);
+    area = qemu_ram_mmap(fd, memory, block->mr->align, flags);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
@@ -2000,7 +2000,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 
 #ifdef __linux__
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 bool share, int fd,
+                                 uint64_t flags, int fd,
                                  Error **errp)
 {
     RAMBlock *new_block;
@@ -2042,8 +2042,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
-    new_block->flags = share ? RAM_SHARED : 0;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->flags = (flags & QEMU_RAM_SHARE) ? RAM_SHARED : 0;
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, flags,
+                                     errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2061,7 +2062,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
 
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
+                                   uint64_t flags, const char *mem_path,
                                    Error **errp)
 {
     int fd;
@@ -2073,7 +2074,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, flags, fd, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7633ef6342..e24aae75a2 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -72,12 +72,33 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 long qemu_getrampagesize(void);
 unsigned long last_ram_page(void);
+
+/**
+ * qemu_ram_alloc_from_file,
+ * qemu_ram_alloc_from_fd: Allocate a ram block from the specified back
+ *                         file or device
+ *
+ * Parameters:
+ *  @size: the size in bytes of the ram block
+ *  @mr: the memory region where the ram block is
+ *  @flags: specify the properties of the ram block, which can be one
+ *          or bit-or of following values
+ *          - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED
+ *          Other bits are ignored.
+ *  @mem_path or @fd: specify the back file or device
+ *  @errp: pointer to Error*, to store an error if it happens
+ *
+ * Return:
+ *  On success, return a pointer to the ram block.
+ *  On failure, return NULL.
+ */
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
+                                   uint64_t flags, const char *mem_path,
                                    Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 bool share, int fd,
+                                 uint64_t flags, int fd,
                                  Error **errp);
+
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
 RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp);
diff --git a/memory.c b/memory.c
index 449a1429b9..1ac4ebcaca 100644
--- a/memory.c
+++ b/memory.c
@@ -1580,7 +1580,9 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr,
+                                             share ? QEMU_RAM_SHARE : 0,
+                                             path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
@@ -1596,7 +1598,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
+                                           share ? QEMU_RAM_SHARE : 0,
+                                           fd, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 #endif
-- 
2.14.1
