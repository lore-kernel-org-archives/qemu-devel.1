Received: from eggs.gnu.org ([209.51.188.92]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grvA2-0000mX-9J
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1grvA0-000563-Dg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:39253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1grv9z-0004xR-Dm
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 20:40:56 -0500
From: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Date: Fri,  8 Feb 2019 18:11:11 +0800
Message-Id: <5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V13 4/5] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
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

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition which can ensure file system metadata
synced in each guest writes to the backend file, without other QEMU
actions (e.g., periodic fsync() by QEMU).

Current, We have below different possible use cases:

1. pmem=on is set, shared=on is set, MAP_SYNC supported:
   a: backend is a dax supporting file.
    - MAP_SYNC will active.
   b: backend is not a dax supporting file.
    - mmap will trigger a warning. then MAP_SYNC flag will be ignored

2. The rest of cases:
   - we will never pass the MAP_SYNC to mmap2

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 util/mmap-alloc.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 97bbeed..2f21efd 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -10,6 +10,13 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+#ifdef CONFIG_LINUX
+#include <linux/mman.h>
+#else  /* !CONFIG_LINUX */
+#define MAP_SYNC              0x0
+#define MAP_SHARED_VALIDATE   0x0
+#endif /* CONFIG_LINUX */
+
 #include "qemu/osdep.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
@@ -101,6 +108,8 @@ void *qemu_ram_mmap(int fd,
 #else
     void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 #endif
+    int mmap_flags;
+    int map_sync_flags = 0;
     size_t offset;
     void *ptr1;
 
@@ -111,13 +120,47 @@ void *qemu_ram_mmap(int fd,
     assert(is_power_of_2(align));
     /* Always align to host page size */
     assert(align >= getpagesize());
+    mmap_flags = shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
+        mmap_flags |= map_sync_flags;
+    }
 
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                mmap_flags,
                 fd, 0);
+
+
+    if (ptr1 == MAP_FAILED && map_sync_flags) {
+        if (errno == ENOTSUP) {
+            char *proc_link, *file_name;
+            int len;
+            proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
+            file_name = g_malloc0(PATH_MAX);
+            len = readlink(proc_link, file_name, PATH_MAX - 1);
+            if (len < 0) {
+                len = 0;
+            }
+            file_name[len] = '\0';
+            fprintf(stderr, "Warning: requesting persistence across crashes "
+                    "for backend file %s failed. Proceeding without "
+                    "persistence, data might become corrupted in case of host "
+                    "crash.\n", file_name);
+            g_free(proc_link);
+            g_free(file_name);
+        }
+        /* if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
+         * we will remove these flags to handle compatibility.
+         */
+        ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
+                    MAP_FIXED |
+                    (fd == -1 ? MAP_ANONYMOUS : 0) |
+                    MAP_SHARED,
+                    fd, 0);
+    }
     if (ptr1 == MAP_FAILED) {
         munmap(ptr, total);
         return MAP_FAILED;
-- 
2.7.4
