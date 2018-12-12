Received: from eggs.gnu.org ([2001:4830:134:3::10]:41468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWzeL-0001Ir-Fc
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWzeI-0000OA-AE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:45117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gWzeH-0000NH-UK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:13:42 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 12 Dec 2018 16:13:31 +0800
Message-Id: <3b909bab9a2146d095eed73b61be97d3af2c2510.1544598069.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1544598069.git.yi.z.zhang@linux.intel.com>
References: <cover.1544598069.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V6 4/6] util/mmap-alloc: Switch the RAM_SYNC
 flags to OnOffAuto
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

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

A set of RAM_SYNC_ON_OFF_AUTO{AUTO,ON,OFF} flags are added to
qemu_ram_mmap():

- If RAM_SYNC_ON_OFF_AUTO_ON is present, qemu_ram_mmap() will try to pass
  MAP_SYNC to mmap(). It will then fail if the host OS or the backend
  file do not support MAP_SYNC, or MAP_SYNC is conflict with other
  flags.

- If RAM_SYNC_ON_OFF_AUTO_OFF is present, qemu_ram_mmap() will never pass
  MAP_SYNC to mmap().

- If RAM_SYNC_ON_OFF_AUTO_AUTO is present, and
  * if the host OS and the backend file support MAP_SYNC, and MAP_SYNC
    is not conflict with other flags, qemu_ram_mmap() will work as if
    RAM_SYNC_ON_OFF_AUTO_ON is present;
  * otherwise, qemu_ram_mmap() will work as if RAM_SYNC_ON_OFF_AUTO_OFF is
    present.
---
 include/exec/memory.h |  9 ++++++++-
 util/mmap-alloc.c     | 13 +++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 33a4e2c..c74c467 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -127,7 +127,14 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 #define RAM_PMEM (1 << 5)
 
 /* RAM can be mmap by a MAP_SYNC flag */
-#define RAM_SYNC (1 << 6)
+#define RAM_SYNC_SHIFT  6
+#define RAM_SYNC_SHIFT_AUTO  7
+
+#define RAM_SYNC_ON_OFF_AUTO_ON   (1UL << RAM_SYNC_SHIFT)
+#define RAM_SYNC_ON_OFF_AUTO_OFF  (0UL << RAM_SYNC_SHIFT)
+#define RAM_SYNC_ON_OFF_AUTO_AUTO (1UL << RAM_SYNC_SHIFT_AUTO)
+
+#define RAM_SYNC (RAM_SYNC_ON_OFF_AUTO_ON | RAM_SYNC_ON_OFF_AUTO_AUTO)
 
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 025ab6a..bda6024 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -110,6 +110,11 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
     assert(is_power_of_2(align));
     /* Always align to host page size */
     assert(align >= getpagesize());
+    if ((flags & RAM_SYNC_ON_OFF_AUTO_ON) &&
+        (!shared || !MAP_SYNC_FLAGS)) {
+        munmap(ptr, total);
+        return MAP_FAILED;
+    }
     if ((flags & RAM_SYNC) && shared) {
         mmap_xflags |= MAP_SYNC_FLAGS;
     }
@@ -122,8 +127,12 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
                 (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
                 fd, 0);
     if ((ptr1 == MAP_FAILED) && (mmap_xflags & MAP_SYNC_FLAGS)) {
-        mmap_xflags &= ~MAP_SYNC_FLAGS;
-        goto retry_mmap_fd;
+        if (flags & RAM_SYNC_ON_OFF_AUTO_AUTO) {
+            mmap_xflags &= ~MAP_SYNC_FLAGS;
+            goto retry_mmap_fd;
+        }
+        munmap(ptr, total);
+        return MAP_FAILED;
     }
 
     if (offset > 0) {
-- 
2.7.4
