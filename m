Received: from eggs.gnu.org ([2001:4830:134:3::10]:37892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUQ-0006SW-La
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUO-0007ay-R6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eglUO-0007QP-Ff
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:20 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 31 Jan 2018 14:02:27 +0800
Message-Id: <20180131060229.9294-5-haozhong.zhang@intel.com>
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 4/6] util/mmap-alloc: support MAP_SYNC in
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition can guarantee the persistence of guest write
to the backend file without other QEMU actions (e.g., periodic fsync()
by QEMU).

A set of QEMU_RAM_SYNC_{AUTO,ON,OFF} flags are added to qemu_ram_mmap():

- If QEMU_RAM_SYNC_ON is present, qemu_ram_mmap() will try to pass
  MAP_SYNC to mmap(). It will then fail if the host OS or the backend
  file do not support MAP_SYNC, or MAP_SYNC is conflict with other
  flags.

- If QEMU_RAM_SYNC_OFF is present, qemu_ram_mmap() will never pass
  MAP_SYNC to mmap().

- If QEMU_RAM_SYNC_AUTO is present, and
  * if the host OS and the backend file support MAP_SYNC, and MAP_SYNC
    is not conflict with other flags, qemu_ram_mmap() will work as if
    QEMU_RAM_SYNC_ON is present;
  * otherwise, qemu_ram_mmap() will work as if QEMU_RAM_SYNC_OFF is
    present.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 include/exec/memory.h                 | 26 ++++++++++++++++++++++
 include/exec/ram_addr.h               |  4 ++++
 include/qemu/mmap-alloc.h             |  4 ++++
 include/standard-headers/linux/mman.h | 42 +++++++++++++++++++++++++++++++++++
 util/mmap-alloc.c                     | 23 ++++++++++++++++++-
 5 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 include/standard-headers/linux/mman.h

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6b547da6a3..96a60e9c1d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -458,6 +458,28 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
 
 #define QEMU_RAM_SHARE      (1UL << 0)
 
+#define QEMU_RAM_SYNC_SHIFT 1
+#define QEMU_RAM_SYNC_MASK  0x6
+#define QEMU_RAM_SYNC_OFF   ((0UL << QEMU_RAM_SYNC_SHIFT) & QEMU_RAM_SYNC_MASK)
+#define QEMU_RAM_SYNC_ON    ((1UL << QEMU_RAM_SYNC_SHIFT) & QEMU_RAM_SYNC_MASK)
+#define QEMU_RAM_SYNC_AUTO  ((2UL << QEMU_RAM_SYNC_SHIFT) & QEMU_RAM_SYNC_MASK)
+
+static inline uint64_t qemu_ram_sync_flags(OnOffAuto v)
+{
+    return v == ON_OFF_AUTO_OFF ? QEMU_RAM_SYNC_OFF :
+           v == ON_OFF_AUTO_ON ? QEMU_RAM_SYNC_ON : QEMU_RAM_SYNC_AUTO;
+}
+
+static inline OnOffAuto qemu_ram_sync_val(uint64_t flags)
+{
+    unsigned int v = (flags & QEMU_RAM_SYNC_MASK) >> QEMU_RAM_SYNC_SHIFT;
+
+    assert(v < 3);
+
+    return v == 0 ? ON_OFF_AUTO_OFF :
+           v == 1 ? ON_OFF_AUTO_ON : ON_OFF_AUTO_AUTO;
+}
+
 #ifdef __linux__
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
@@ -473,6 +495,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @flags: specify properties of this memory region, which can be one or bit-or
  *         of following values:
  *         - QEMU_RAM_SHARE: memory must be mmaped with the MAP_SHARED flag
+ *         - One of
+ *           QEMU_RAM_SYNC_ON:   mmap with MAP_SYNC flag
+ *           QEMU_RAM_SYNC_OFF:  do not mmap with MAP_SYNC flag
+ *           QEMU_RAM_SYNC_AUTO: automatically decide the use of MAP_SYNC flag
  *         Other bits are ignored.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e24aae75a2..a2cc5a9f60 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -84,6 +84,10 @@ unsigned long last_ram_page(void);
  *  @flags: specify the properties of the ram block, which can be one
  *          or bit-or of following values
  *          - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED
+ *          - One of
+ *            QEMU_RAM_SYNC_ON:   mmap with MAP_SYNC flag
+ *            QEMU_RAM_SYNC_OFF:  do not mmap with MAP_SYNC flag
+ *            QEMU_RAM_SYNC_AUTO: automatically decide the use of MAP_SYNC flag
  *          Other bits are ignored.
  *  @mem_path or @fd: specify the back file or device
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index dc5e8b5efb..74346bdd3a 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -18,6 +18,10 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
  *  @flags: specifies additional properties of the mapping, which can be one or
  *          bit-or of following values
  *          - QEMU_RAM_SHARE: mmap with MAP_SHARED flag
+ *          - One of
+ *            QEMU_RAM_SYNC_ON:   mmap with MAP_SYNC flag
+ *            QEMU_RAM_SYNC_OFF:  do not mmap with MAP_SYNC flag
+ *            QEMU_RAM_SYNC_AUTO: automatically decide the use of MAP_SYNC flag
  *          Other bits are ignored.
  *
  * Return:
diff --git a/include/standard-headers/linux/mman.h b/include/standard-headers/linux/mman.h
new file mode 100644
index 0000000000..033332ad4f
--- /dev/null
+++ b/include/standard-headers/linux/mman.h
@@ -0,0 +1,42 @@
+/*
+ * Definitions of Linux-specific mmap flags.
+ *
+ * Copyright Intel Corporation, 2018
+ *
+ * Author: Haozhong Zhang <haozhong.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later. See the COPYING file in the top-level directory.
+ */
+
+#ifndef _LINUX_MMAN_H
+#define _LINUX_MMAN_H
+
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
+#define QEMU_HAS_MAP_SYNC     true
+
+#else  /* !CONFIG_LINUX */
+
+#define MAP_SHARED_VALIDATE   0x0
+#define MAP_SYNC              0x0
+
+#define QEMU_HAS_MAP_SYNC     false
+
+#endif /* CONFIG_LINUX */
+
+#endif /* !_LINUX_MMAN_H */
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index cd95566800..6df2f6d2c4 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -14,6 +14,7 @@
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
 #include "exec/memory.h"
+#include "standard-headers/linux/mman.h"
 
 #define HUGETLBFS_MAGIC       0x958458f6
 
@@ -97,6 +98,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint64_t flags)
     void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 #endif
     bool shared = flags & QEMU_RAM_SHARE;
+    OnOffAuto sync = qemu_ram_sync_val(flags);
+    int mmap_xflags = 0;
     size_t offset;
     void *ptr1;
 
@@ -108,13 +111,31 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint64_t flags)
     /* Always align to host page size */
     assert(align >= getpagesize());
 
+    if (!QEMU_HAS_MAP_SYNC || !shared) {
+        if (sync == ON_OFF_AUTO_ON) {
+            return MAP_FAILED;
+        }
+        sync = ON_OFF_AUTO_OFF;
+    }
+    if (sync != ON_OFF_AUTO_OFF) {
+        /* MAP_SYNC is only available with MAP_SHARED_VALIDATE. */
+        mmap_xflags |= MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
     offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
+ retry_mmap_fd:
     ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
                 MAP_FIXED |
                 (fd == -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
+                (shared ? MAP_SHARED : MAP_PRIVATE) | mmap_xflags,
                 fd, 0);
     if (ptr1 == MAP_FAILED) {
+        if (sync == ON_OFF_AUTO_AUTO) {
+            mmap_xflags &= ~(MAP_SYNC | MAP_SHARED_VALIDATE);
+            sync = ON_OFF_AUTO_OFF;
+            goto retry_mmap_fd;
+        }
+
         munmap(ptr, total);
         return MAP_FAILED;
     }
-- 
2.14.1
