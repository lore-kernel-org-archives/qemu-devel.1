Received: from eggs.gnu.org ([209.51.188.92]:41627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINEd-0007lQ-MW
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINEc-0003dy-K2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hINEc-0003ci-CM
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:02 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 22 Apr 2019 08:48:48 +0800
Message-Id: <20190422004849.26463-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190422004849.26463-1-richardw.yang@linux.intel.com>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC in
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
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, yi.z.zhang@linux.intel.com, Haozhong Zhang <haozhong.zhang@intel.com>

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
[ehabkost: Rebased patch to latest code on master]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Tested-by: Wei Yang <richardw.yang@linux.intel.com>

---
v14: rebase on top of current upstream
---
 util/mmap-alloc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 9713f4b960..f7f177d0ea 100644
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
@@ -82,6 +89,7 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     int flags;
+    int map_sync_flags = 0;
     int guardfd;
     size_t offset;
     size_t pagesize;
@@ -132,9 +140,40 @@ void *qemu_ram_mmap(int fd,
     flags = MAP_FIXED;
     flags |= fd == -1 ? MAP_ANONYMOUS : 0;
     flags |= shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
-    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd, 0);
+    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+               flags | map_sync_flags, fd, 0);
+
+    if (ptr == MAP_FAILED && map_sync_flags) {
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
+        /*
+         * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
+         * we will remove these flags to handle compatibility.
+         */
+        ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+                   flags, fd, 0);
+    }
 
     if (ptr == MAP_FAILED) {
         munmap(guardptr, total);
-- 
2.19.1
