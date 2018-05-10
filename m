Received: from eggs.gnu.org ([2001:4830:134:3::10]:37216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1C-0002Sm-6G
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1A-0006ij-Aa
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:24344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fGb19-0006fc-UP
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:16 -0400
From: junyan.he@gmx.com
Date: Thu, 10 May 2018 10:08:51 +0800
Message-Id: <1525918138-6189-3-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 2/9 V5] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
needs to know whether the backend storage is a real persistent memory,
in order to decide whether special operations should be performed to
ensure the data persistence.

This boolean option 'pmem' allows users to specify whether the backend
storage of memory-backend-file is a real persistent memory. If
'pmem=on', QEMU will set the flag RAM_PMEM in the RAM block of the
corresponding memory region.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 backends/hostmem-file.c | 26 +++++++++++++++++++++++++-
 docs/nvdimm.txt         | 14 ++++++++++++++
 exec.c                  | 13 ++++++++++++-
 include/exec/memory.h   |  2 ++
 include/exec/ram_addr.h |  3 +++
 qemu-options.hx         |  7 +++++++
 6 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 30df843..5d706d4 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -34,6 +34,7 @@ struct HostMemoryBackendFile {
     bool discard_data;
     char *mem_path;
     uint64_t align;
+    bool is_pmem;
 };
 
 static void
@@ -59,7 +60,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
                                  backend->size, fb->align,
-                                 backend->share ? QEMU_RAM_SHARE : 0,
+                                 (backend->share ? QEMU_RAM_SHARE : 0) |
+                                 (fb->is_pmem ? QEMU_RAM_PMEM : 0),
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -131,6 +133,25 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     error_propagate(errp, local_err);
 }
 
+static bool file_memory_backend_get_pmem(Object *o, Error **errp)
+{
+    return MEMORY_BACKEND_FILE(o)->is_pmem;
+}
+
+static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property 'pmem' of %s '%s'",
+                   object_get_typename(o), backend->id);
+        return;
+    }
+
+    fb->is_pmem = value;
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -162,6 +183,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL, &error_abort);
+    object_class_property_add_bool(oc, "pmem",
+        file_memory_backend_get_pmem, file_memory_backend_set_pmem,
+        &error_abort);
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index e903d8b..bcb2032 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -153,3 +153,17 @@ guest NVDIMM region mapping structure.  This unarmed flag indicates
 guest software that this vNVDIMM device contains a region that cannot
 accept persistent writes. In result, for example, the guest Linux
 NVDIMM driver, marks such vNVDIMM device as read-only.
+
+If the vNVDIMM backend is on the host persistent memory that can be
+accessed in SNIA NVM Programming Model [1] (e.g., Intel NVDIMM), it's
+suggested to set the 'pmem' option of memory-backend-file to 'on'. When
+'pmem=on' and QEMU is built with libpmem [2] support (configured with
+--enable-libpmem), QEMU will take necessary operations to guarantee
+the persistence of its own writes to the vNVDIMM backend (e.g., in
+vNVDIMM label emulation and live migration).
+
+References
+----------
+
+[1] SNIA NVM Programming Model: https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
+[2] PMDK: http://pmem.io/pmdk/
diff --git a/exec.c b/exec.c
index fa33c29..dedeb4d 100644
--- a/exec.c
+++ b/exec.c
@@ -52,6 +52,9 @@
 #include <linux/falloc.h>
 #endif
 
+/* RAM is backed by the persistent memory. */
+#define RAM_PMEM       (1 << 3)
+
 #endif
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
@@ -2037,6 +2040,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     Error *local_err = NULL;
     int64_t file_size;
     bool share = flags & QEMU_RAM_SHARE;
+    bool is_pmem = flags & QEMU_RAM_PMEM;
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -2073,7 +2077,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
-    new_block->flags = share ? RAM_SHARED : 0;
+    new_block->flags = (share ? RAM_SHARED : 0) |
+                       (is_pmem ? RAM_PMEM : 0);
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
     if (!new_block->host) {
         g_free(new_block);
@@ -3836,6 +3841,11 @@ err:
     return ret;
 }
 
+bool ramblock_is_pmem(RAMBlock *rb)
+{
+    return rb->flags & RAM_PMEM;
+}
+
 #endif
 
 void page_size_init(void)
@@ -3934,3 +3944,4 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
 }
 
 #endif
+
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0460313..16385b5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -509,6 +509,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
 #ifdef __linux__
 
 #define QEMU_RAM_SHARE      (1UL << 0)
+#define QEMU_RAM_PMEM       (1UL << 1)
 
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
@@ -524,6 +525,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @flags: specify properties of this memory region, which can be one or bit-or
  *         of following values:
  *         - QEMU_RAM_SHARE: memory must be mmaped with the MAP_SHARED flag
+ *         - QEMU_RAM_PMEM: the backend @path is persistent memory
  *         Other bits are ignored.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b8b01d1..f8d8614 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -70,6 +70,8 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
     return host_addr_offset >> TARGET_PAGE_BITS;
 }
 
+bool ramblock_is_pmem(RAMBlock *rb);
+
 long qemu_getrampagesize(void);
 unsigned long last_ram_page(void);
 
@@ -84,6 +86,7 @@ unsigned long last_ram_page(void);
  *  @flags: specify the properties of the ram block, which can be one
  *          or bit-or of following values
  *          - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED
+ *          - QEMU_RAM_PMEM: the backend @mem_path or @fd is persistent memory
  *          Other bits are ignored.
  *  @mem_path or @fd: specify the back file or device
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..3fe1121 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4047,6 +4047,13 @@ requires an alignment different than the default one used by QEMU, eg
 the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
 such cases, users can specify the required alignment via this option.
 
+The @option{pmem} option specifies whether the backend store specified
+by @option{mem-path} is on the persistent memory that can be accessed
+in the SNIA NVM programming model (e.g. Intel NVDIMM).
+If @address@hidden, QEMU will take necessary operations to
+guarantee the persistence of its own writes to @option{mem-path}
+(e.g. in vNVDIMM label emulation and live migration).
+
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory backend object, which can be used to back the guest RAM.
-- 
2.7.4
