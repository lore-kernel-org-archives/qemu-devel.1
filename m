Received: from eggs.gnu.org ([2001:4830:134:3::10]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWzeD-0001EY-1E
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWze9-0000Ep-S8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gWze9-0000Da-HX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:33 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 12 Dec 2018 16:13:23 +0800
Message-Id: <0b74ac642ab37ea912b8be8b3bf8dd74c10066e3.1544598069.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1544598069.git.yi.z.zhang@linux.intel.com>
References: <cover.1544598069.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V6 3/6] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com, Zhang Yi <yi.z.zhang@linux.intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition can guarantee the persistence of guest write
to the backend file without other QEMU actions (e.g., periodic fsync()
by QEMU).

A set of RAM_SYNC flags are added to qemu_ram_mmap():

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 exec.c                    |  2 +-
 include/exec/memory.h     |  3 +++
 include/exec/ram_addr.h   |  1 +
 include/qemu/mmap-alloc.h |  1 +
 include/qemu/osdep.h      | 29 +++++++++++++++++++++++++++++
 util/mmap-alloc.c         | 13 +++++++++----
 6 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index e92a7da..dc4d180 100644
--- a/exec.c
+++ b/exec.c
@@ -2241,7 +2241,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     int64_t file_size;
 
     /* Just support these ram flags by now. */
-    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_SYNC)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 667466b..33a4e2c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -126,6 +126,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM is a persistent kind memory */
 #define RAM_PMEM (1 << 5)
 
+/* RAM can be mmap by a MAP_SYNC flag */
+#define RAM_SYNC (1 << 6)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9ecd911..d239ce7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -87,6 +87,7 @@ long qemu_getrampagesize(void);
  *              or bit-or of following values
  *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
  *              - RAM_PMEM: the backend @mem_path or @fd is persistent memory
+ *              - RAM_SYNC:   mmap with MAP_SYNC flag
  *              Other bits are ignored.
  *  @mem_path or @fd: specify the backing file or device
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 6fe6ed4..1755a8b 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -18,6 +18,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
  *  @flags: specifies additional properties of the mapping, which can be one or
  *          bit-or of following values
  *          - RAM_SHARED: mmap with MAP_SHARED flag
+ *          - RAM_SYNC:   mmap with MAP_SYNC flag
  *          Other bits are ignored.
  *
  * Return:
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bc..f94ea68 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -410,6 +410,35 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #  define QEMU_VMALLOC_ALIGN getpagesize()
 #endif
 
+/*
+ * MAP_SHARED_VALIDATE and MAP_SYNC are introduced in Linux kernel
+ * 4.15, so they may not be defined when compiling on older kernels.
+ */
+#ifdef CONFIG_LINUX
+
+#include <sys/mman.h>
+
+#ifndef MAP_SHARED_VALIDATE
+#define MAP_SHARED_VALIDATE   0x3
+#endif
+
+#ifndef MAP_SYNC
+#define MAP_SYNC              0x80000
+#endif
+
+/* MAP_SYNC is only available with MAP_SHARED_VALIDATE. */
+#define MAP_SYNC_FLAGS (MAP_SYNC | MAP_SHARED_VALIDATE)
+
+#else  /* !CONFIG_LINUX */
+
+#define MAP_SHARED_VALIDATE   0x0
+#define MAP_SYNC              0x0
+
+#define QEMU_HAS_MAP_SYNC     false
+#define MAP_SYNC_FLAGS 0
+
+#endif /* CONFIG_LINUX */
+
 #ifdef CONFIG_POSIX
 struct qemu_signalfd_siginfo {
     uint32_t ssi_signo;   /* Signal number */
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 8f0a740..025ab6a 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -99,6 +99,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
     void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 #endif
     bool shared = flags & RAM_SHARED;
+    int mmap_xflags = 0;
     size_t offset;
     void *ptr1;
 
@@ -109,16 +110,20 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
     assert(is_power_of_2(align));
     /* Always align to host page size */
     assert(align >= getpagesize());
+    if ((flags & RAM_SYNC) && shared) {
+        mmap_xflags |= MAP_SYNC_FLAGS;
+    }
 
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
+ retry_mmap_fd:
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
                 fd, 0);
-    if (ptr1 == MAP_FAILED) {
-        munmap(ptr, total);
-        return MAP_FAILED;
+    if ((ptr1 == MAP_FAILED) && (mmap_xflags & MAP_SYNC_FLAGS)) {
+        mmap_xflags &= ~MAP_SYNC_FLAGS;
+        goto retry_mmap_fd;
     }
 
     if (offset > 0) {
-- 
2.7.4
