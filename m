Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhC7-0001xJ-H8
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffhC4-0003ZX-TB
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:63886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffhC4-0003XX-I2
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:48:16 -0400
From: junyan.he@gmx.com
Date: Wed, 18 Jul 2018 15:47:58 +0800
Message-Id: <1531900083-18167-3-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
References: <1531900083-18167-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 2/7 V11] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

As more flag parameters besides the existing 'share' are going to be
added to following functions
memory_region_init_ram_from_file
qemu_ram_alloc_from_fd
qemu_ram_alloc_from_file
let's switch them to use the 'flags' parameters so as to ease future
flag additions.

The existing 'share' flag is converted to the RAM_SHARED bit in ram_flags,
and other flag bits are ignored by above functions right now.

Signed-off-by: Junyan He <junyan.he@intel.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 backends/hostmem-file.c |  3 ++-
 exec.c                  | 10 +++++-----
 include/exec/memory.h   |  7 +++++--
 include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
 memory.c                |  8 +++++---
 numa.c                  |  2 +-
 6 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 134b08d..34c68bb 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -58,7 +58,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->align, backend->share,
+                                 backend->size, fb->align,
+                                 backend->share ? RAM_SHARED : 0,
                                  fb->mem_path, errp);
         g_free(path);
     }
diff --git a/exec.c b/exec.c
index cc042dc..3b8f914 100644
--- a/exec.c
+++ b/exec.c
@@ -2238,7 +2238,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 
 #ifdef __linux__
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 bool share, int fd,
+                                 uint32_t ram_flags, int fd,
                                  Error **errp)
 {
     RAMBlock *new_block;
@@ -2280,14 +2280,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
-    new_block->flags = share ? RAM_SHARED : 0;
+    new_block->flags = ram_flags;
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
     }
 
-    ram_block_add(new_block, &local_err, share);
+    ram_block_add(new_block, &local_err, ram_flags & RAM_SHARED);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2299,7 +2299,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
 
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
+                                   uint32_t ram_flags, const char *mem_path,
                                    Error **errp)
 {
     int fd;
@@ -2311,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6d0af29..30e7166 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -640,6 +640,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        void *host),
                                        Error **errp);
 #ifdef __linux__
+
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
  *                                    mmap-ed backend.
@@ -651,7 +652,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @size: size of the region.
  * @align: alignment of the region base address; if 0, the default alignment
  *         (getpagesize()) will be used.
- * @share: %true if memory must be mmaped with the MAP_SHARED flag
+ * @ram_flags: Memory region features:
+ *             - RAM_SHARED: memory must be mmaped with the MAP_SHARED flag
+ *             Other bits are ignored now.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
  *
@@ -663,7 +666,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       uint64_t align,
-                                      bool share,
+                                      uint32_t ram_flags,
                                       const char *path,
                                       Error **errp);
 
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index cf4ce06..8a4a9bc 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -71,12 +71,33 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 }
 
 long qemu_getrampagesize(void);
+
+/**
+ * qemu_ram_alloc_from_file,
+ * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
+ *                          file or device
+ *
+ * Parameters:
+ *  @size: the size in bytes of the ram block
+ *  @mr: the memory region where the ram block is
+ *  @ram_flags: specify the properties of the ram block, which can be one
+ *              or bit-or of following values
+ *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
+ *              Other bits are ignored.
+ *  @mem_path or @fd: specify the backing file or device
+ *  @errp: pointer to Error*, to store an error if it happens
+ *
+ * Return:
+ *  On success, return a pointer to the ram block.
+ *  On failure, return NULL.
+ */
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
+                                   uint32_t ram_flags, const char *mem_path,
                                    Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 bool share, int fd,
+                                 uint32_t ram_flags, int fd,
                                  Error **errp);
+
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
 RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
diff --git a/memory.c b/memory.c
index e9cd446..d20f0a7 100644
--- a/memory.c
+++ b/memory.c
@@ -1551,7 +1551,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       uint64_t align,
-                                      bool share,
+                                      uint32_t ram_flags,
                                       const char *path,
                                       Error **errp)
 {
@@ -1560,7 +1560,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
@@ -1576,7 +1576,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
+                                           share ? RAM_SHARED : 0,
+                                           fd, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 #endif
diff --git a/numa.c b/numa.c
index 5f6367b..81542d4 100644
--- a/numa.c
+++ b/numa.c
@@ -479,7 +479,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
                                          mem_path, &err);
         if (err) {
             error_report_err(err);
-- 
2.7.4
