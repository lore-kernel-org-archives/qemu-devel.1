Received: from eggs.gnu.org ([2001:4830:134:3::10]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjL-0001NR-9p
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqjJ-0008OY-Jn
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqjJ-0008No-8d
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:49 -0400
Date: Mon, 20 Aug 2018 23:24:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-5-mst@redhat.com>
References: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820104045.133968-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Junyan He <junyan.he@intel.com>

When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
needs to know whether the backend storage is a real persistent memory,
in order to decide whether special operations should be performed to
ensure the data persistence.

This boolean option 'pmem' allows users to specify whether the backend
storage of memory-backend-file is a real persistent memory. If
'pmem=on', QEMU will set the flag RAM_PMEM in the RAM block of the
corresponding memory region. If 'pmem' is set while lack of libpmem
support, a error is generated.

Signed-off-by: Junyan He <junyan.he@intel.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/nvdimm.txt         | 22 +++++++++++++++++++++
 include/exec/memory.h   |  4 ++++
 include/exec/ram_addr.h |  3 +++
 backends/hostmem-file.c | 43 +++++++++++++++++++++++++++++++++++++++--
 exec.c                  |  8 ++++++++
 qemu-options.hx         |  7 +++++++
 6 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 24b443b655..5f158a6170 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -173,3 +173,25 @@ There are currently two valid values for this option:
              the NVDIMMs in the event of power loss.  This implies that the
              platform also supports flushing dirty data through the memory
              controller on power loss.
+
+If the vNVDIMM backend is in host persistent memory that can be accessed in
+SNIA NVM Programming Model [1] (e.g., Intel NVDIMM), it's suggested to set
+the 'pmem' option of memory-backend-file to 'on'. When 'pmem' is 'on' and QEMU
+is built with libpmem [2] support (configured with --enable-libpmem), QEMU
+will take necessary operations to guarantee the persistence of its own writes
+to the vNVDIMM backend(e.g., in vNVDIMM label emulation and live migration).
+If 'pmem' is 'on' while there is no libpmem support, qemu will exit and report
+a "lack of libpmem support" message to ensure the persistence is available.
+For example, if we want to ensure the persistence for some backend file,
+use the QEMU command line:
+
+    -object memory-backend-file,id=nv_mem,mem-path=/XXX/yyy,size=4G,pmem=on
+
+References
+----------
+
+[1] NVM Programming Model (NPM)
+	Version 1.2
+    https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
+[2] Persistent Memory Development Kit (PMDK), formerly known as NVML project, home page:
+    http://pmem.io/pmdk/
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 30e7166dd1..cd62029a7d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -123,6 +123,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
 /* RAM can be migrated */
 #define RAM_MIGRATABLE (1 << 4)
 
+/* RAM is a persistent kind memory */
+#define RAM_PMEM (1 << 5)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -654,6 +657,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: Memory region features:
  *             - RAM_SHARED: memory must be mmaped with the MAP_SHARED flag
+ *             - RAM_PMEM: the memory is persistent memory
  *             Other bits are ignored now.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 8a4a9bc614..3abb639056 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -70,6 +70,8 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
     return host_addr_offset >> TARGET_PAGE_BITS;
 }
 
+bool ramblock_is_pmem(RAMBlock *rb);
+
 long qemu_getrampagesize(void);
 
 /**
@@ -83,6 +85,7 @@ long qemu_getrampagesize(void);
  *  @ram_flags: specify the properties of the ram block, which can be one
  *              or bit-or of following values
  *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
+ *              - RAM_PMEM: the backend @mem_path or @fd is persistent memory
  *              Other bits are ignored.
  *  @mem_path or @fd: specify the backing file or device
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 34c68bb081..2476dcb435 100644
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
@@ -31,9 +32,10 @@ typedef struct HostMemoryBackendFile HostMemoryBackendFile;
 struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
-    bool discard_data;
     char *mem_path;
     uint64_t align;
+    bool discard_data;
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
@@ -131,6 +134,39 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
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
+        Error *local_err = NULL;
+        error_setg(&local_err,
+                   "Lack of libpmem support while setting the 'pmem=on'"
+                   " of %s '%s'. We can't ensure data persistence.",
+                   object_get_typename(o),
+                   object_get_canonical_path_component(o));
+        error_propagate(errp, local_err);
+        return;
+    }
+#endif
+
+    fb->is_pmem = value;
+}
+
 static void file_backend_unparent(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
@@ -162,6 +198,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL, &error_abort);
+    object_class_property_add_bool(oc, "pmem",
+        file_memory_backend_get_pmem, file_memory_backend_set_pmem,
+        &error_abort);
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/exec.c b/exec.c
index 3b8f91448d..fa3fbc6646 100644
--- a/exec.c
+++ b/exec.c
@@ -2245,6 +2245,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     Error *local_err = NULL;
     int64_t file_size;
 
+    /* Just support these ram flags by now. */
+    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
+
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
         return NULL;
@@ -4072,6 +4075,11 @@ err:
     return ret;
 }
 
+bool ramblock_is_pmem(RAMBlock *rb)
+{
+    return rb->flags & RAM_PMEM;
+}
+
 #endif
 
 void page_size_init(void)
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..9b920f294f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4070,6 +4070,13 @@ requires an alignment different than the default one used by QEMU, eg
 the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
 such cases, users can specify the required alignment via this option.
 
+The @option{pmem} option specifies whether the backing file specified
+by @option{mem-path} is in host persistent memory that can be accessed
+using the SNIA NVM programming model (e.g. Intel NVDIMM).
+If @option{pmem} is set to 'on', QEMU will take necessary operations to
+guarantee the persistence of its own writes to @option{mem-path}
+(e.g. in vNVDIMM label emulation and live migration).
+
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory backend object, which can be used to back the guest RAM.
-- 
MST
