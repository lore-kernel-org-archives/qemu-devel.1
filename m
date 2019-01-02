Received: from eggs.gnu.org ([208.118.235.92]:39460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1geZ2k-0001gE-5n
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1geZ2h-0006a7-2L
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:26:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:11102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1geZ2g-0006Zh-Qy
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:26:11 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed,  2 Jan 2019 13:26:15 +0800
Message-Id: <0b17cd9e914372c4790296b2cc21d6dd6e6d5466.1546399191.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V8 3/5] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com, Zhang Yi <yi.z.zhang@linux.intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition which can ensure file system metadata
synced in each guest writes to the backend file, without other QEMU
actions (e.g., periodic fsync() by QEMU).

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 include/qemu/osdep.h | 16 ++++++++++++++++
 util/mmap-alloc.c    | 12 +++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bc..bb1eba1 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -410,6 +410,22 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #  define QEMU_VMALLOC_ALIGN getpagesize()
 #endif
 
+/*
+ * MAP_SHARED_VALIDATE and MAP_SYNC are introduced in Linux kernel
+ * 4.15, so they may not be defined when compiling on older kernels.
+ */
+#ifdef CONFIG_LINUX
+
+#include <asm-generic/mman.h>
+
+#ifndef MAP_SYNC
+#define MAP_SYNC 0x0
+#endif
+
+#else  /* !CONFIG_LINUX */
+#define MAP_SYNC              0x0
+#endif /* CONFIG_LINUX */
+
 #ifdef CONFIG_POSIX
 struct qemu_signalfd_siginfo {
     uint32_t ssi_signo;   /* Signal number */
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 8f0a740..a9d5e56 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -99,6 +99,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
     void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 #endif
     bool shared = flags & RAM_SHARED;
+    bool is_pmem = flags & RAM_PMEM;
+    int mmap_xflags = 0;
     size_t offset;
     void *ptr1;
 
@@ -109,13 +111,21 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
     assert(is_power_of_2(align));
     /* Always align to host page size */
     assert(align >= getpagesize());
+    if (shared && is_pmem) {
+        mmap_xflags |= MAP_SYNC;
+    }
 
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
+ retry_mmap_fd:
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
                 fd, 0);
+    if ((ptr1 == MAP_FAILED) && (mmap_xflags & MAP_SYNC)) {
+        mmap_xflags &= ~MAP_SYNC;
+        goto retry_mmap_fd;
+    }
     if (ptr1 == MAP_FAILED) {
         munmap(ptr, total);
         return MAP_FAILED;
-- 
2.7.4
