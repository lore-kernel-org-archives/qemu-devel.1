Received: from eggs.gnu.org ([2001:4830:134:3::10]:53521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZdkX-0001tt-5U
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eZdkS-0004H0-BG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:65248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eZdkS-0004Ez-3g
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:22:28 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu, 11 Jan 2018 22:22:07 +0800
Message-Id: <20180111142208.17617-2-haozhong.zhang@intel.com>
In-Reply-To: <20180111142208.17617-1-haozhong.zhang@intel.com>
References: <20180111142208.17617-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/2] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition can guarantee the persistence of guest write
to the backend file without other QEMU actions (e.g., periodic fsync()
by QEMU).

A OnOffAuto parameter 'sync' is added to qemu_ram_mmap():

- If sync == ON_OFF_AUTO_ON, qemu_ram_mmap() will try to pass MAP_SYNC
  to mmap(). It will then fail if the host OS or the backend file do
  not support MAP_SYNC, or MAP_SYNC is conflict with other flags.

- If sync == ON_OFF_AUTO_OFF, qemu_ram_mmap() will never pass MAP_SYNC
  to mmap().

- If sync == ON_OFF_AUTO_AUTO, and
  * if the host OS and the backend file support MAP_SYNC, and MAP_SYNC
    is not conflict with other flags, qemu_ram_mmap() will work as if
    sync == ON_OFF_AUTO_ON.
  * otherwise, qemu_ram_mmap() will work as if sync == ON_OFF_AUTO_OFF.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 exec.c                    |  2 +-
 include/qemu/mmap-alloc.h |  3 ++-
 include/qemu/osdep.h      | 16 ++++++++++++++++
 util/mmap-alloc.c         | 24 ++++++++++++++++++++++--
 util/oslib-posix.c        |  2 +-
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index 8fba88ae1c..f4254cb6d3 100644
--- a/exec.c
+++ b/exec.c
@@ -1646,7 +1646,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED);
+                         block->flags & RAM_SHARED, ON_OFF_AUTO_OFF);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 50385e3f81..dd5876471f 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,7 +7,8 @@ size_t qemu_fd_getpagesize(int fd);
 
 size_t qemu_mempath_getpagesize(const char *mem_path);
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
+void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared,
+                    OnOffAuto sync);
 
 void qemu_ram_munmap(void *ptr, size_t size);
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index adb3758275..55637e0724 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -372,6 +372,22 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #  define QEMU_VMALLOC_ALIGN getpagesize()
 #endif
 
+/*
+ * MAP_SHARED_VALIDATE and MAP_SYNC were introduced in Linux kernel
+ * 4.15, so they may not be defined when compiling on older kernels.
+ */
+#ifdef CONFIG_LINUX
+#ifndef MAP_SHARED_VALIDATE
+#define MAP_SHARED_VALIDATE   0x3
+#endif
+#ifndef MAP_SYNC
+#define MAP_SYNC              0x80000
+#endif
+#define QEMU_HAS_MAP_SYNC     true
+#else  /* !CONFIG_LINUX */
+#define QEMU_HAS_MAP_SYNC     false
+#endif /* CONFIG_LINUX */
+
 #ifdef CONFIG_POSIX
 struct qemu_signalfd_siginfo {
     uint32_t ssi_signo;   /* Signal number */
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2fd8cbcc6f..af57218669 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -73,7 +73,8 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return getpagesize();
 }
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
+void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared,
+                    OnOffAuto sync)
 {
     /*
      * Note: this always allocates at least one extra page of virtual address
@@ -97,6 +98,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
 #endif
     size_t offset;
     void *ptr1;
+    int xflags = 0;
 
     if (ptr == MAP_FAILED) {
         return MAP_FAILED;
@@ -106,11 +108,29 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
     /* Always align to host page size */
     assert(align >= getpagesize());
 
+    if (!QEMU_HAS_MAP_SYNC || !shared) {
+        if (sync == ON_OFF_AUTO_ON) {
+            return MAP_FAILED;
+        }
+        sync = ON_OFF_AUTO_OFF;
+    }
+    if (sync != ON_OFF_AUTO_OFF) {
+        xflags = MAP_SYNC;
+    }
+    /*
+     * If MAP_SHARED_VALIDATE is present, mmap will fail when MAP_SYNC
+     * is not supported. Otherwise, mmap will just ignore MAP_SYNC when
+     * it's not supported.
+     */
+    if (sync == ON_OFF_AUTO_ON) {
+        xflags |= MAP_SHARED_VALIDATE;
+    }
+
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                (shared ? MAP_SHARED : MAP_PRIVATE) | xflags,
                 fd, 0);
     if (ptr1 == MAP_FAILED) {
         munmap(ptr, total);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 77369c92ce..ecb1c275d2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -130,7 +130,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, false);
+    void *ptr = qemu_ram_mmap(-1, size, align, false, ON_OFF_AUTO_OFF);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.15.1
