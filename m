Received: from eggs.gnu.org ([209.51.188.92]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLH-0001fL-ID
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLG-0004gf-HT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLG-0004gD-7X
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:22 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:20:41 -0800
Message-Id: <20190307072041.8098-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 01/37] multi-process: memory:
 alloc RAM from file at offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, pbonzini@redhat.com, rth@twiddle.net

From: Jagannathan Raman <jag.raman@oracle.com>

Allow RAM MemoryRegion to be created from an offset in a file, instead
of allocating at offset of 0 by default. This is needed to synchronize
RAM between QEMU & remote process.
This will be needed for the following patches.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 exec.c                    | 9 +++++----
 include/exec/ram_addr.h   | 2 +-
 include/qemu/mmap-alloc.h | 2 +-
 memory.c                  | 2 +-
 util/mmap-alloc.c         | 5 +++--
 util/oslib-posix.c        | 2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 1d4f378..dcef041 100644
--- a/exec.c
+++ b/exec.c
@@ -1813,6 +1813,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
                             bool truncate,
+                            off_t offset,
                             Error **errp)
 {
     void *area;
@@ -1863,7 +1864,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED);
+                         block->flags & RAM_SHARED, offset);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
@@ -2252,7 +2253,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp)
+                                 off_t offset, Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
@@ -2297,7 +2298,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2327,7 +2328,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9ecd911..2ed4579 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -100,7 +100,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp);
+                                 off_t offset, Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index ef04f0e..25c4b12 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,7 +7,7 @@ size_t qemu_fd_getpagesize(int fd);
 
 size_t qemu_mempath_getpagesize(const char *mem_path);
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
+void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared, off_t start);
 
 void qemu_ram_munmap(int fd, void *ptr, size_t size);
 
diff --git a/memory.c b/memory.c
index 61d66e4..ffa91d0 100644
--- a/memory.c
+++ b/memory.c
@@ -1619,7 +1619,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
                                            share ? RAM_SHARED : 0,
-                                           fd, &err);
+                                           fd, 0, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
         mr->size = int128_zero();
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 8565885..58cb4cc 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -75,7 +75,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return getpagesize();
 }
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
+void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared, off_t start)
 {
     int flags;
     int guardfd;
@@ -130,7 +130,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
     flags |= shared ? MAP_SHARED : MAP_PRIVATE;
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
-    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd, 0);
+    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd,
+               start);
 
     if (ptr == MAP_FAILED) {
         munmap(guardptr, total);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 37c5854..e4c6380 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -203,7 +203,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared);
+    void *ptr = qemu_ram_mmap(-1, size, align, shared, 0);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
1.8.3.1
