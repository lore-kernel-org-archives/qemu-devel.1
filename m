Received: from eggs.gnu.org ([2001:4830:134:3::10]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eU5eJ-0000Pe-OD
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 01:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eU5eF-0002QG-3P
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 01:57:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:40921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eU5eE-0002Ng-Rb
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 01:57:07 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 27 Dec 2017 14:56:20 +0800
Message-Id: <20171227065620.20889-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] util/mmap-alloc: support MAP_SYNC in
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition can guarantee the persistence of guest write
to the backend file without other QEMU actions (e.g., periodic fsync()
by QEMU).

By using MAP_SHARED_VALIDATE flag with MAP_SYNC, we can ensure mmap
with MAP_SYNC fails if MAP_SYNC is not supported by the kernel or the
backend file. On such failures, QEMU retries mmap without MAP_SYNC and
MAP_SHARED_VALIDATE.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 util/mmap-alloc.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2fd8cbcc6f..37b302f057 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -18,7 +18,18 @@
 
 #ifdef CONFIG_LINUX
 #include <sys/vfs.h>
+
+/*
+ * MAP_SHARED_VALIDATE and MAP_SYNC were introduced in 4.15 kernel, so
+ * they may not be defined when compiling on older kernels.
+ */
+#ifndef MAP_SHARED_VALIDATE
+#define MAP_SHARED_VALIDATE   0x3
 #endif
+#ifndef MAP_SYNC
+#define MAP_SYNC              0x80000
+#endif
+#endif /* CONFIG_LINUX */
 
 size_t qemu_fd_getpagesize(int fd)
 {
@@ -97,6 +108,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
 #endif
     size_t offset;
     void *ptr1;
+    int xflags = 0;
 
     if (ptr == MAP_FAILED) {
         return MAP_FAILED;
@@ -107,12 +119,34 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
     assert(align >= getpagesize());
 
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
+
+#if defined(__linux__)
+    /*
+     * If 'fd' refers to a file supporting DAX, mmap it with MAP_SYNC
+     * will guarantee the guest write persistence without other
+     * actions in QEMU (e.g., fsync() in QEMU).
+     *
+     * MAP_SHARED_VALIDATE ensures mmap with MAP_SYNC fails if
+     * MAP_SYNC is not supported by the kernel or the file.
+     *
+     * On failures of mmap with xflags, QEMU will retry mmap without
+     * xflags.
+     */
+    xflags = shared ? (MAP_SHARED_VALIDATE | MAP_SYNC) : 0;
+#endif
+
+ retry_mmap_fd:
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                (shared ? MAP_SHARED : MAP_PRIVATE) | xflags,
                 fd, 0);
     if (ptr1 == MAP_FAILED) {
+        if (xflags) {
+            xflags = 0;
+            goto retry_mmap_fd;
+        }
+
         munmap(ptr, total);
         return MAP_FAILED;
     }
-- 
2.14.1
