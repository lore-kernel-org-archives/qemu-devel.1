Received: from eggs.gnu.org ([2001:4830:134:3::10]:41522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fV7Jn-00084s-Jr
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 23:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fV7Jk-00028l-BT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 23:28:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:12286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fV7Jj-00028Z-V1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 23:28:28 -0400
From: junyan.he@gmx.com
Date: Tue, 19 Jun 2018 11:28:19 +0800
Message-Id: <1529378899-24086-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 3/7 V7 RESEND] hostmem-file: add the 'pmem'
 option
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

Signed-off-by: Junyan He <junyan.he@intel.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 backends/hostmem-file.c | 39 ++++++++++++++++++++++++++++++++++++++-
 docs/nvdimm.txt         | 18 ++++++++++++++++++
 exec.c                  |  9 +++++++++
 include/exec/memory.h   |  4 ++++
 include/exec/ram_addr.h |  3 +++
 qemu-options.hx         |  7 +++++++
 6 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 34c68bb..4607651 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/error-report.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
@@ -34,6 +35,7 @@ struct HostMemoryBackendFile {
     bool discard_data;
     char *mem_path;
     uint64_t align;
+    bool is_pmem;
 };
 
 static void
@@ -59,7 +61,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
                                  backend->size, fb->align,
-                                 backend->share ? RAM_SHARED : 0,
+                                 (backend->share ? RAM_SHARED : 0) |
+                                 (fb->is_pmem ? RAM_PMEM : 0),
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -131,6 +134,37 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
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
+                   object_get_typename(o),
+                   object_get_canonical_path_component(o));
+        return;
+    }
+
+#ifndef CONFIG_LIBPMEM
+    if (value) {
+        error_report("Lack of libpmem support while setting the 'pmem=on'"
+                     " of %s '%s'. We can not ensure the persistence of it"
+                     " without libpmem support, this may cause serious"
+                     " problems." , object_get_typename(o),
+                     object_get_canonical_path_component(o));
+        exit(1);
+    }
+#endif
+
+    fb->is_pmem = value;
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -162,6 +196,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL, &error_abort);
+    object_class_property_add_bool(oc, "pmem",
+        file_memory_backend_get_pmem, file_memory_backend_set_pmem,
+        &error_abort);
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 8b48fb4..2f7d348 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -180,3 +180,21 @@ supports CPU Cache Flush and Memory Controller Flush on Power Loss, etc.
 
 For a complete list of the flags available and for more detailed descriptions,
 please consult the ACPI spec.
+
+guest software that this vNVDIMM device contains a region that cannot
+accept persistent writes. In result, for example, the guest Linux
+NVDIMM driver, marks such vNVDIMM device as read-only.
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
index 8e079df..c42483e 100644
--- a/exec.c
+++ b/exec.c
@@ -2077,6 +2077,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     Error *local_err = NULL;
     int64_t file_size;
 
+    /* Just support these ram flags by now. */
+    assert(ram_flags == 0 || (ram_flags & (RAM_SHARED | RAM_PMEM)));
+
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
         return NULL;
@@ -4007,6 +4010,11 @@ err:
     return ret;
 }
 
+bool ramblock_is_pmem(RAMBlock *rb)
+{
+    return rb->flags & RAM_PMEM;
+}
+
 #endif
 
 void page_size_init(void)
@@ -4105,3 +4113,4 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
 }
 
 #endif
+
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3769c06..7dd43b0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -122,6 +122,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM can be migrated */
 #define RAM_MIGRATABLE (1 << 4)
 
+/* RAM is a persistent kind memory */
+#define RAM_PMEM (1 << 5)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end)
@@ -613,6 +616,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: Memory region features:
  *             - RAM_SHARED: memory must be mmaped with the MAP_SHARED flag
+ *             - RAM_PMEM: the memory is persistent memory
  *             Other bits are ignored now.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5545cf3..3c65643 100644
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
  *  @ram_flags: specify the properties of the ram block, which can be one
  *              or bit-or of following values
  *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
+ *              - RAM_PMEM: the backend @mem_path or @fd is persistent memory
  *              Other bits are ignored.
  *  @mem_path or @fd: specify the backing file or device
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951..006ca44 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4045,6 +4045,13 @@ requires an alignment different than the default one used by QEMU, eg
 the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
 such cases, users can specify the required alignment via this option.
 
+The @option{pmem} option specifies whether the backing file specified
+by @option{mem-path} is on the persistent memory that can be accessed
+using the SNIA NVM programming model (e.g. Intel NVDIMM).
+If @option{pmem}, QEMU will take necessary operations to
+guarantee the persistence of its own writes to @option{mem-path}
+(e.g. in vNVDIMM label emulation and live migration).
+
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory backend object, which can be used to back the guest RAM.
-- 
2.7.4
