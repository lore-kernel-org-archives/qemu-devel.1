Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cjGN8-0000QD-1K
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cjGN4-0006cD-Q4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:21:38 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  2 Mar 2017 13:21:27 +1100
Message-Id: <20170302022127.13741-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3] exec, kvm,
 target-ppc: Move getrampagesize() to common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

getrampagesize() returns the largest supported page size and mainly
used to know if huge pages are enabled.

However is implemented in target-ppc/kvm.c and not available
in TCG or other architectures.

This renames and moves gethugepagesize() to mmap-alloc.c where
fd-based analog of it is already implemented. This renames and moves
getrampagesize() to exec.c as it seems to be the common place for
helpers like this.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* in exec.c, moved "include numa.h" under #ifndef CONFIG_USER_ONLY to
fix linux-user target build

v2:
* rebased on top of ppc-for-2.9-20170301
---
 include/exec/ram_addr.h   |   1 +
 include/qemu/mmap-alloc.h |   2 +
 exec.c                    |  82 +++++++++++++++++++++++++++++++++++
 target/ppc/kvm.c          | 108 +++-------------------------------------------
 util/mmap-alloc.c         |  25 +++++++++++
 5 files changed, 115 insertions(+), 103 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3e79466a44..cd432e73ae 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -52,6 +52,7 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
     return (char *)block->host + offset;
 }
 
+long qemu_getrampagesize(void);
 ram_addr_t last_ram_offset(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 933c024ac5..50385e3f81 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -5,6 +5,8 @@
 
 size_t qemu_fd_getpagesize(int fd);
 
+size_t qemu_mempath_getpagesize(const char *mem_path);
+
 void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
 
 void qemu_ram_munmap(void *ptr, size_t size);
diff --git a/exec.c b/exec.c
index 3adf2b1861..4c90cbf366 100644
--- a/exec.c
+++ b/exec.c
@@ -42,6 +42,7 @@
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
+#include "sysemu/numa.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace-root.h"
@@ -1251,6 +1252,87 @@ void qemu_mutex_unlock_ramlist(void)
 }
 
 #ifdef __linux__
+/*
+ * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
+ * may or may not name the same files / on the same filesystem now as
+ * when we actually open and map them.  Iterate over the file
+ * descriptors instead, and use qemu_fd_getpagesize().
+ */
+static int find_max_supported_pagesize(Object *obj, void *opaque)
+{
+    char *mem_path;
+    long *hpsize_min = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
+        mem_path = object_property_get_str(obj, "mem-path", NULL);
+        if (mem_path) {
+            long hpsize = qemu_mempath_getpagesize(mem_path);
+            if (hpsize < *hpsize_min) {
+                *hpsize_min = hpsize;
+            }
+        } else {
+            *hpsize_min = getpagesize();
+        }
+    }
+
+    return 0;
+}
+
+long qemu_getrampagesize(void)
+{
+    long hpsize = LONG_MAX;
+    long mainrampagesize;
+    Object *memdev_root;
+
+    if (mem_path) {
+        mainrampagesize = qemu_mempath_getpagesize(mem_path);
+    } else {
+        mainrampagesize = getpagesize();
+    }
+
+    /* it's possible we have memory-backend objects with
+     * hugepage-backed RAM. these may get mapped into system
+     * address space via -numa parameters or memory hotplug
+     * hooks. we want to take these into account, but we
+     * also want to make sure these supported hugepage
+     * sizes are applicable across the entire range of memory
+     * we may boot from, so we take the min across all
+     * backends, and assume normal pages in cases where a
+     * backend isn't backed by hugepages.
+     */
+    memdev_root = object_resolve_path("/objects", NULL);
+    if (memdev_root) {
+        object_child_foreach(memdev_root, find_max_supported_pagesize, &hpsize);
+    }
+    if (hpsize == LONG_MAX) {
+        /* No additional memory regions found ==> Report main RAM page size */
+        return mainrampagesize;
+    }
+
+    /* If NUMA is disabled or the NUMA nodes are not backed with a
+     * memory-backend, then there is at least one node using "normal" RAM,
+     * so if its page size is smaller we have got to report that size instead.
+     */
+    if (hpsize > mainrampagesize &&
+        (nb_numa_nodes == 0 || numa_info[0].node_memdev == NULL)) {
+        static bool warned;
+        if (!warned) {
+            error_report("Huge page support disabled (n/a for main memory).");
+            warned = true;
+        }
+        return mainrampagesize;
+    }
+
+    return hpsize;
+}
+#else
+long qemu_getrampagesize(void)
+{
+    return getpagesize();
+}
+#endif
+
+#ifdef __linux__
 static int64_t get_file_size(int fd)
 {
     int64_t size = lseek(fd, 0, SEEK_END);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 18f33f2d93..d2835ef6b3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -43,8 +43,10 @@
 #include "trace.h"
 #include "exec/gdbstub.h"
 #include "exec/memattrs.h"
+#include "exec/ram_addr.h"
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
+#include "qemu/mmap-alloc.h"
 #if defined(TARGET_PPC64)
 #include "hw/ppc/spapr_cpu_core.h"
 #endif
@@ -331,106 +333,6 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
     kvm_get_fallback_smmu_info(cpu, info);
 }
 
-static long gethugepagesize(const char *mem_path)
-{
-    struct statfs fs;
-    int ret;
-
-    do {
-        ret = statfs(mem_path, &fs);
-    } while (ret != 0 && errno == EINTR);
-
-    if (ret != 0) {
-        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
-                strerror(errno));
-        exit(1);
-    }
-
-#define HUGETLBFS_MAGIC       0x958458f6
-
-    if (fs.f_type != HUGETLBFS_MAGIC) {
-        /* Explicit mempath, but it's ordinary pages */
-        return getpagesize();
-    }
-
-    /* It's hugepage, return the huge page size */
-    return fs.f_bsize;
-}
-
-/*
- * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
- * may or may not name the same files / on the same filesystem now as
- * when we actually open and map them.  Iterate over the file
- * descriptors instead, and use qemu_fd_getpagesize().
- */
-static int find_max_supported_pagesize(Object *obj, void *opaque)
-{
-    char *mem_path;
-    long *hpsize_min = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
-        mem_path = object_property_get_str(obj, "mem-path", NULL);
-        if (mem_path) {
-            long hpsize = gethugepagesize(mem_path);
-            if (hpsize < *hpsize_min) {
-                *hpsize_min = hpsize;
-            }
-        } else {
-            *hpsize_min = getpagesize();
-        }
-    }
-
-    return 0;
-}
-
-static long getrampagesize(void)
-{
-    long hpsize = LONG_MAX;
-    long mainrampagesize;
-    Object *memdev_root;
-
-    if (mem_path) {
-        mainrampagesize = gethugepagesize(mem_path);
-    } else {
-        mainrampagesize = getpagesize();
-    }
-
-    /* it's possible we have memory-backend objects with
-     * hugepage-backed RAM. these may get mapped into system
-     * address space via -numa parameters or memory hotplug
-     * hooks. we want to take these into account, but we
-     * also want to make sure these supported hugepage
-     * sizes are applicable across the entire range of memory
-     * we may boot from, so we take the min across all
-     * backends, and assume normal pages in cases where a
-     * backend isn't backed by hugepages.
-     */
-    memdev_root = object_resolve_path("/objects", NULL);
-    if (memdev_root) {
-        object_child_foreach(memdev_root, find_max_supported_pagesize, &hpsize);
-    }
-    if (hpsize == LONG_MAX) {
-        /* No additional memory regions found ==> Report main RAM page size */
-        return mainrampagesize;
-    }
-
-    /* If NUMA is disabled or the NUMA nodes are not backed with a
-     * memory-backend, then there is at least one node using "normal" RAM,
-     * so if its page size is smaller we have got to report that size instead.
-     */
-    if (hpsize > mainrampagesize &&
-        (nb_numa_nodes == 0 || numa_info[0].node_memdev == NULL)) {
-        static bool warned;
-        if (!warned) {
-            error_report("Huge page support disabled (n/a for main memory).");
-            warned = true;
-        }
-        return mainrampagesize;
-    }
-
-    return hpsize;
-}
-
 static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
 {
     if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
@@ -462,7 +364,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
 
     if (!max_cpu_page_size) {
-        max_cpu_page_size = getrampagesize();
+        max_cpu_page_size = qemu_getrampagesize();
     }
 
     /* Convert to QEMU form */
@@ -523,7 +425,7 @@ bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
     long pagesize;
 
     if (mempath) {
-        pagesize = gethugepagesize(mempath);
+        pagesize = qemu_mempath_getpagesize(mempath);
     } else {
         pagesize = getpagesize();
     }
@@ -2207,7 +2109,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
     kvm_get_smmu_info(POWERPC_CPU(first_cpu), &info);
-    rampagesize = getrampagesize();
+    rampagesize = qemu_getrampagesize();
     best_page_shift = 0;
 
     for (i = 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 2f55f5e94f..3ec029a9ea 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -40,6 +40,31 @@ size_t qemu_fd_getpagesize(int fd)
     return getpagesize();
 }
 
+size_t qemu_mempath_getpagesize(const char *mem_path)
+{
+#ifdef CONFIG_LINUX
+    struct statfs fs;
+    int ret;
+
+    do {
+        ret = statfs(mem_path, &fs);
+    } while (ret != 0 && errno == EINTR);
+
+    if (ret != 0) {
+        fprintf(stderr, "Couldn't statfs() memory path: %s\n",
+                strerror(errno));
+        exit(1);
+    }
+
+    if (fs.f_type == HUGETLBFS_MAGIC) {
+        /* It's hugepage, return the huge page size */
+        return fs.f_bsize;
+    }
+#endif
+
+    return getpagesize();
+}
+
 void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
 {
     /*
-- 
2.11.0
