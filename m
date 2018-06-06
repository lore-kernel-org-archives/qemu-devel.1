Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@lfy-macbookpro2.roam.corp.google.com>)
	id 1fQfUH-0007Vz-DB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@lfy-macbookpro2.roam.corp.google.com>)
	id 1fQfUE-0003QF-Az
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:56:57 -0400
Received: from [104.132.0.76] (port=41417
	helo=lfy-macbookpro2.roam.corp.google.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@lfy-macbookpro2.roam.corp.google.com>)
	id 1fQfUE-0003Pm-1T
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:56:54 -0400
From: Lingfeng Yang <lfy@google.com>
Date: Wed,  6 Jun 2018 13:56:29 -0700
Message-Id: <20180606205629.66987-1-lfy@google.com>
Subject: [Qemu-devel] [PATCH] Improve file-backed RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lingfeng Yang <lfy@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

1. Add support for all platforms
2. Add option to map in shared mode, allowing the guest to write
through to the backing file

Taken together, this allows one to write RAM snapshots as the guest is
running. Saving RAM snapshots is then equivalent to exiting the qemu
process or unmapping the file. This can be faster than waiting for a
lengthy explicit migration process.

Eventually, we want to go in the direction of allowing the launch of
multiple guest instances from the same RAM snapshot, which aids
virtualization-based integration testing; boot and other initializations
for multiple guest instances can be skipped, and the host OS will have
optimized shared RAM usage using its existing copy-on-write mechanisms.

Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:Overall)
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com> (maintainer:Overall)
Cc: Richard Henderson <rth@twiddle.net> (maintainer:Overall)
Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:NUMA)
Cc: qemu-devel@nongnu.org (open list:Overall)

Signed-off-by: Lingfeng Yang <lfy@google.com>
---
 exec.c                  | 18 +++++++++++++-----
 include/exec/memory.h   |  2 --
 include/sysemu/sysemu.h |  1 +
 memory.c                |  2 --
 numa.c                  |  5 -----
 qemu-options.hx         |  9 ++++++++-
 util/mmap-alloc.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 vl.c                    |  4 ++++
 8 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index f6645ede0c..8ee61d5fd6 100644
--- a/exec.c
+++ b/exec.c
@@ -65,9 +65,7 @@
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
-#ifndef _WIN32
 #include "qemu/mmap-alloc.h"
-#endif
 
 #include "monitor/monitor.h"
 
@@ -99,6 +97,9 @@ static MemoryRegion io_mem_unassigned;
  */
 #define RAM_RESIZEABLE (1 << 2)
 
+/* RAM is a mapped file */
+#define RAM_MAPPED (1 << 3)
+
 /* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
  * zero the page and wake waiting processes.
  * (Set during postcopy)
@@ -1667,6 +1668,10 @@ static int file_ram_open(const char *path,
     return fd;
 }
 
+#ifdef _WIN32
+#define MAP_FAILED 0
+#endif
+
 static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
@@ -1831,6 +1836,11 @@ bool qemu_ram_is_shared(RAMBlock *rb)
     return rb->flags & RAM_SHARED;
 }
 
+bool qemu_ram_is_mapped(RAMBlock *rb)
+{
+    return rb->flags & RAM_MAPPED;
+}
+
 /* Note: Only set at the start of postcopy */
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
 {
@@ -2088,7 +2098,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
     }
 }
 
-#ifdef __linux__
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  bool share, int fd,
                                  Error **errp)
@@ -2132,7 +2141,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
-    new_block->flags = share ? RAM_SHARED : 0;
+    new_block->flags = RAM_MAPPED | (share ? RAM_SHARED : 0);
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
     if (!new_block->host) {
         g_free(new_block);
@@ -2174,7 +2183,6 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 
     return block;
 }
-#endif
 
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index eb2ba06519..02e7bbcf0f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -578,7 +578,6 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        uint64_t length,
                                                        void *host),
                                        Error **errp);
-#ifdef __linux__
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
  *                                    mmap-ed backend.
@@ -628,7 +627,6 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     bool share,
                                     int fd,
                                     Error **errp);
-#endif
 
 /**
  * memory_region_init_ram_ptr:  Initialize RAM memory region from a
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index e893f72f3b..279315b05a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -132,6 +132,7 @@ extern uint8_t qemu_extra_params_fw[2];
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
 extern int mem_prealloc;
+extern int mem_file_shared;
 
 #define MAX_NODES 128
 #define NUMA_NODE_UNASSIGNED MAX_NODES
diff --git a/memory.c b/memory.c
index 3212acc7f4..6244f31e60 100644
--- a/memory.c
+++ b/memory.c
@@ -1545,7 +1545,6 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
-#ifdef __linux__
 void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       struct Object *owner,
                                       const char *name,
@@ -1579,7 +1578,6 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
-#endif
 
 void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 Object *owner,
diff --git a/numa.c b/numa.c
index 33572bfa74..994821a0c6 100644
--- a/numa.c
+++ b/numa.c
@@ -477,7 +477,6 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                            uint64_t ram_size)
 {
     if (mem_path) {
-#ifdef __linux__
         Error *err = NULL;
         memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
                                          mem_path, &err);
@@ -494,10 +493,6 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
             mem_path = NULL;
             memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
         }
-#else
-        fprintf(stderr, "-mem-path not supported on this host\n");
-        exit(1);
-#endif
     } else {
         memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951e9f..2eff4e32c2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -403,6 +403,14 @@ STEXI
 Preallocate memory when using -mem-path.
 ETEXI
 
+DEF("mem-file-shared", 0, QEMU_OPTION_mem_file_shared,
+"-mem-file-shared (use with -mem-path) initializes RAM backing file (specified in -mem-path) as a shared mapping\n", QEMU_ARCH_ALL)
+STEXI
+@item -mem-file-shared
+@findex -mem-file-shared
+Map backing RAM file as shared to allow write through.
+ETEXI
+
 DEF("k", HAS_ARG, QEMU_OPTION_k,
     "-k language     use keyboard layout (for example 'fr' for French)\n",
     QEMU_ARCH_ALL)
@@ -4408,7 +4416,6 @@ e.g to launch a SEV guest
 
 ETEXI
 
-
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
 @end table
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index fd329eccd8..e4be798076 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -20,8 +20,13 @@
 #include <sys/vfs.h>
 #endif
 
+#ifdef _WIN32
+#define WIN_FILE_PAGE_SIZE 65536
+#endif
+
 size_t qemu_fd_getpagesize(int fd)
 {
+#ifndef _WIN32
 #ifdef CONFIG_LINUX
     struct statfs fs;
     int ret;
@@ -42,10 +47,14 @@ size_t qemu_fd_getpagesize(int fd)
 #endif
 
     return getpagesize();
+#else
+    return WIN_FILE_PAGE_SIZE;
+#endif
 }
 
 size_t qemu_mempath_getpagesize(const char *mem_path)
 {
+#ifndef _WIN32
 #ifdef CONFIG_LINUX
     struct statfs fs;
     int ret;
@@ -73,10 +82,14 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
 #endif
 
     return getpagesize();
+#else
+    return WIN_FILE_PAGE_SIZE;
+#endif
 }
 
 void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
 {
+#ifndef _WIN32
     /*
      * Note: this always allocates at least one extra page of virtual address
      * space, even if size is already aligned.
@@ -133,12 +146,39 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
     }
 
     return ptr1;
+#else
+    size_t total = size + align;
+
+    /* On Windows, we first create a file mapping and then call MapViewOfFile.
+     * Private mapping is done as FILE_MAP_COPY to take advantage of
+     * copy-on-write.
+     */
+    HANDLE fileMapping =
+        CreateFileMapping(
+            (HANDLE)_get_osfhandle(fd),
+            NULL, /* security attribs */
+            PAGE_READWRITE,
+            0,
+            (uint32_t)(size + align),
+            NULL);
+
+    void *ptr =
+        MapViewOfFile(
+            fileMapping,
+            shared ? FILE_MAP_ALL_ACCESS : FILE_MAP_COPY,
+            0, 0, 0);
+    return ptr;
+#endif
 }
 
 void qemu_ram_munmap(void *ptr, size_t size)
 {
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
+#ifndef _WIN32
         munmap(ptr, size + getpagesize());
+#else
+        UnmapViewOfFile(ptr);
+#endif
     }
 }
diff --git a/vl.c b/vl.c
index 06031715ac..89739854d6 100644
--- a/vl.c
+++ b/vl.c
@@ -141,6 +141,7 @@ const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
+int mem_file_shared = 0; /* map file-backed RAM in shared mode */
 bool enable_mlock = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
@@ -3244,6 +3245,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
                 break;
+            case QEMU_OPTION_mem_file_shared:
+                mem_file_shared = 1;
+                break;
             case QEMU_OPTION_d:
                 log_mask = optarg;
                 break;
-- 
2.17.0.441.gb46fe60e1d-goog
