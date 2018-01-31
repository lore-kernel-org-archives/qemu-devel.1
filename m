Received: from eggs.gnu.org ([2001:4830:134:3::10]:37890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUQ-0006SR-Kq
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUN-0007ZX-3I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eglUM-0007Sc-Qd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:19 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 31 Jan 2018 14:02:24 +0800
Message-Id: <20180131060229.9294-2-haozhong.zhang@intel.com>
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 1/6] util/mmap-alloc: switch qemu_ram_mmap()
 to 'flags' parameter
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

As more flag parameters besides the existing 'shared' are going to be
added to qemu_ram_mmap(), let's switch 'shared' to a 'flags' parameter
in advance, so as to ease the further additions.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
---
 exec.c                    |  2 +-
 include/exec/memory.h     |  3 +++
 include/qemu/mmap-alloc.h | 19 ++++++++++++++++++-
 util/mmap-alloc.c         |  8 +++++---
 util/oslib-posix.c        |  2 +-
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 629a508385..c0a5a52c4a 100644
--- a/exec.c
+++ b/exec.c
@@ -1653,7 +1653,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED);
+                         (block->flags & RAM_SHARED) ? QEMU_RAM_SHARE : 0);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 07c5d6d597..4790cd9e13 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -455,6 +455,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        uint64_t length,
                                                        void *host),
                                        Error **errp);
+
+#define QEMU_RAM_SHARE      (1UL << 0)
+
 #ifdef __linux__
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 50385e3f81..dc5e8b5efb 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,7 +7,24 @@ size_t qemu_fd_getpagesize(int fd);
 
 size_t qemu_mempath_getpagesize(const char *mem_path);
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
+/**
+ * qemu_ram_mmap: mmap the specified file or device.
+ *
+ * Parameters:
+ *  @fd: the file or the device to mmap
+ *  @size: the number of bytes to be mmaped
+ *  @align: if not zero, specify the alignment of the starting mapping address;
+ *          otherwise, the alignment in use will be determined by QEMU.
+ *  @flags: specifies additional properties of the mapping, which can be one or
+ *          bit-or of following values
+ *          - QEMU_RAM_SHARE: mmap with MAP_SHARED flag
+ *          Other bits are ignored.
+ *
+ * Return:
+ *  On success, return a pointer to the mapped area.
+ *  On failure, return MAP_FAILED.
+ */
+void *qemu_ram_mmap(int fd, size_t size, size_t align, uint64_t flags);
 
 void qemu_ram_munmap(void *ptr, size_t size);
 
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2fd8cbcc6f..cd95566800 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
+#include "exec/memory.h"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
@@ -73,7 +74,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return getpagesize();
 }
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
+void *qemu_ram_mmap(int fd, size_t size, size_t align, uint64_t flags)
 {
     /*
      * Note: this always allocates at least one extra page of virtual address
@@ -90,11 +91,12 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
      * anonymous memory is OK.
      */
     int anonfd = fd == -1 || qemu_fd_getpagesize(fd) == getpagesize() ? -1 : fd;
-    int flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
-    void *ptr = mmap(0, total, PROT_NONE, flags | MAP_PRIVATE, anonfd, 0);
+    int mmap_flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
+    void *ptr = mmap(0, total, PROT_NONE, mmap_flags | MAP_PRIVATE, anonfd, 0);
 #else
     void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 #endif
+    bool shared = flags & QEMU_RAM_SHARE;
     size_t offset;
     void *ptr1;
 
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 77369c92ce..2a78cfb67e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -130,7 +130,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, false);
+    void *ptr = qemu_ram_mmap(-1, size, align, 0);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.14.1
