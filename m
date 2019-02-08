Received: from eggs.gnu.org ([209.51.188.92]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grv90-00005b-Ns
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grv8z-0004hP-SK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:39:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:34887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1grv8z-0004fs-JK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:39:53 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Fri,  8 Feb 2019 18:10:37 +0800
Message-Id: <786c46862cfeb253ee0ea2f44d62ffe76edb7fa4.1549555521.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V13 1/5] util/mmap-alloc: Add a 'is_pmem'
 parameter to qemu_ram_mmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

besides the existing 'shared' flags, we are going to add
'is_pmem' to qemu_ram_mmap(), which indicated the memory backend
file is a persist memory.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
---
 exec.c                    |  2 +-
 include/qemu/mmap-alloc.h | 21 ++++++++++++++++++++-
 util/mmap-alloc.c         |  6 +++++-
 util/oslib-posix.c        |  2 +-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index bb6170d..27cea52 100644
--- a/exec.c
+++ b/exec.c
@@ -1860,7 +1860,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED);
+                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 50385e3..190688a 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,7 +7,26 @@ size_t qemu_fd_getpagesize(int fd);
 
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
+ *  @shared: map has RAM_SHARED flag.
+ *  @is_pmem: map has RAM_PMEM flag.
+ *
+ * Return:
+ *  On success, return a pointer to the mapped area.
+ *  On failure, return MAP_FAILED.
+ */
+void *qemu_ram_mmap(int fd,
+                    size_t size,
+                    size_t align,
+                    bool shared,
+                    bool is_pmem);
 
 void qemu_ram_munmap(void *ptr, size_t size);
 
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index fd329ec..97bbeed 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -75,7 +75,11 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return getpagesize();
 }
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
+void *qemu_ram_mmap(int fd,
+                    size_t size,
+                    size_t align,
+                    bool shared,
+                    bool is_pmem)
 {
     /*
      * Note: this always allocates at least one extra page of virtual address
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8..040937f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -203,7 +203,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared);
+    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.7.4
