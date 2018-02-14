Received: from eggs.gnu.org ([2001:4830:134:3::10]:47728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dn-00035l-VR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dk-0008CW-Mf
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1em2dk-0008C4-Gq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:48 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 14 Feb 2018 21:22:21 +0200
Message-Id: <20180214192230.70287-2-marcel@redhat.com>
In-Reply-To: <20180214192230.70287-1-marcel@redhat.com>
References: <20180214192230.70287-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V11 01/10] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com, ghammer@redhat.com

Currently only file backed memory backend can
be created with a "share" flag in order to allow
sharing guest RAM with other processes in the host.

Add the "share" flag also to RAM Memory Backend
in order to allow remapping parts of the guest RAM
to different host virtual addresses. This is needed
by the RDMA devices in order to remap non-contiguous
QEMU virtual addresses to a contiguous virtual address range.

Moved the "share" flag to the Host Memory base class,
modified phys_mem_alloc to include the new parameter
and a new interface memory_region_init_ram_shared_nomigrate.

There are no functional changes if the new flag is not used.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 backends/hostmem-file.c  | 25 +------------------------
 backends/hostmem-ram.c   |  4 ++--
 backends/hostmem.c       | 21 +++++++++++++++++++++
 exec.c                   | 26 +++++++++++++++-----------
 include/exec/memory.h    | 23 +++++++++++++++++++++++
 include/exec/ram_addr.h  |  3 ++-
 include/qemu/osdep.h     |  2 +-
 include/sysemu/hostmem.h |  2 +-
 include/sysemu/kvm.h     |  2 +-
 memory.c                 | 16 +++++++++++++---
 qemu-options.hx          | 10 +++++++++-
 target/s390x/kvm.c       |  4 ++--
 util/oslib-posix.c       |  4 ++--
 util/oslib-win32.c       |  2 +-
 14 files changed, 94 insertions(+), 50 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e319ec1ad8..134b08d63a 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -31,7 +31,6 @@ typedef struct HostMemoryBackendFile HostMemoryBackendFile;
 struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
-    bool share;
     bool discard_data;
     char *mem_path;
     uint64_t align;
@@ -59,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->align, fb->share,
+                                 backend->size, fb->align, backend->share,
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -86,25 +85,6 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
     fb->mem_path = g_strdup(str);
 }
 
-static bool file_memory_backend_get_share(Object *o, Error **errp)
-{
-    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
-
-    return fb->share;
-}
-
-static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
-{
-    HostMemoryBackend *backend = MEMORY_BACKEND(o);
-    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
-
-    if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property value");
-        return;
-    }
-    fb->share = value;
-}
-
 static bool file_memory_backend_get_discard_data(Object *o, Error **errp)
 {
     return MEMORY_BACKEND_FILE(o)->discard_data;
@@ -171,9 +151,6 @@ file_backend_class_init(ObjectClass *oc, void *data)
     bc->alloc = file_backend_memory_alloc;
     oc->unparent = file_backend_unparent;
 
-    object_class_property_add_bool(oc, "share",
-        file_memory_backend_get_share, file_memory_backend_set_share,
-        &error_abort);
     object_class_property_add_bool(oc, "discard-data",
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data,
         &error_abort);
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 38977be73e..7ddd08d370 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -28,8 +28,8 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     path = object_get_canonical_path_component(OBJECT(backend));
-    memory_region_init_ram_nomigrate(&backend->mr, OBJECT(backend), path,
-                           backend->size, errp);
+    memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend), path,
+                           backend->size, backend->share, errp);
     g_free(path);
 }
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 81d14554a7..8aa0412032 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -368,6 +368,24 @@ static void set_id(Object *o, const char *str, Error **errp)
     backend->id = g_strdup(str);
 }
 
+static bool host_memory_backend_get_share(Object *o, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    return backend->share;
+}
+
+static void host_memory_backend_set_share(Object *o, bool value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+    backend->share = value;
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, void *data)
 {
@@ -398,6 +416,9 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
     object_class_property_add_str(oc, "id", get_id, set_id, &error_abort);
+    object_class_property_add_bool(oc, "share",
+        host_memory_backend_get_share, host_memory_backend_set_share,
+        &error_abort);
 }
 
 static void host_memory_backend_finalize(Object *o)
diff --git a/exec.c b/exec.c
index e8d7b335b6..4d8addb263 100644
--- a/exec.c
+++ b/exec.c
@@ -1285,7 +1285,7 @@ static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
                              uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 
-static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
+static void *(*phys_mem_alloc)(size_t size, uint64_t *align, bool shared) =
                                qemu_anon_ram_alloc;
 
 /*
@@ -1293,7 +1293,7 @@ static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
  * Accelerators with unusual needs may need this.  Hopefully, we can
  * get rid of it eventually.
  */
-void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align))
+void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align, bool shared))
 {
     phys_mem_alloc = alloc;
 }
@@ -1921,7 +1921,7 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
-static void ram_block_add(RAMBlock *new_block, Error **errp)
+static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 {
     RAMBlock *block;
     RAMBlock *last_block = NULL;
@@ -1944,7 +1944,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             }
         } else {
             new_block->host = phys_mem_alloc(new_block->max_length,
-                                             &new_block->mr->align);
+                                             &new_block->mr->align, shared);
             if (!new_block->host) {
                 error_setg_errno(errp, errno,
                                  "cannot set up guest memory '%s'",
@@ -2049,7 +2049,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    ram_block_add(new_block, &local_err);
+    ram_block_add(new_block, &local_err, share);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2091,7 +2091,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void (*resized)(const char*,
                                                   uint64_t length,
                                                   void *host),
-                                  void *host, bool resizeable,
+                                  void *host, bool resizeable, bool share,
                                   MemoryRegion *mr, Error **errp)
 {
     RAMBlock *new_block;
@@ -2114,7 +2114,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     if (resizeable) {
         new_block->flags |= RAM_RESIZEABLE;
     }
-    ram_block_add(new_block, &local_err);
+    ram_block_add(new_block, &local_err, share);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2126,12 +2126,15 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                    MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, size, NULL, host, false, mr, errp);
+    return qemu_ram_alloc_internal(size, size, NULL, host, false,
+                                   false, mr, errp);
 }
 
-RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp)
+RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share,
+                         MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, size, NULL, NULL, false, mr, errp);
+    return qemu_ram_alloc_internal(size, size, NULL, NULL, false,
+                                   share, mr, errp);
 }
 
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
@@ -2140,7 +2143,8 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
                                                      void *host),
                                      MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, maxsz, resized, NULL, true, mr, errp);
+    return qemu_ram_alloc_internal(size, maxsz, resized, NULL, true,
+                                   false, mr, errp);
 }
 
 static void reclaim_ramblock(RAMBlock *block)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fff9b1d871..15e81113ba 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -436,6 +436,29 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Error **errp);
 
 /**
+ * memory_region_init_ram_shared_nomigrate:  Initialize RAM memory region.
+ *                                           Accesses into the region will
+ *                                           modify memory directly.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @share: allow remapping RAM to different addresses
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function is similar to memory_region_init_ram_nomigrate.
+ * The only difference is part of the RAM region can be remapped.
+ */
+void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
+                                             struct Object *owner,
+                                             const char *name,
+                                             uint64_t size,
+                                             bool share,
+                                             Error **errp);
+
+/**
  * memory_region_init_resizeable_ram:  Initialize memory region with resizeable
  *                                     RAM.  Accesses into the region will
  *                                     modify memory directly.  Only an initial
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7633ef6342..cf2446a176 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -80,7 +80,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  Error **errp);
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
-RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp);
+RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
+                         Error **errp);
 RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
                                     void (*resized)(const char*,
                                                     uint64_t length,
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index adb3758275..41658060a7 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -255,7 +255,7 @@ extern int daemon(int, int);
 int qemu_daemon(int nochdir, int noclose);
 void *qemu_try_memalign(size_t alignment, size_t size);
 void *qemu_memalign(size_t alignment, size_t size);
-void *qemu_anon_ram_alloc(size_t size, uint64_t *align);
+void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared);
 void qemu_vfree(void *ptr);
 void qemu_anon_ram_free(void *ptr, size_t size);
 
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 621a3f9d42..d5ab0b99c6 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -54,7 +54,7 @@ struct HostMemoryBackend {
     char *id;
     uint64_t size;
     bool merge, dump;
-    bool prealloc, force_prealloc, is_mapped;
+    bool prealloc, force_prealloc, is_mapped, share;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index bbf12a1723..85002ac49a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -248,7 +248,7 @@ int kvm_on_sigbus(int code, void *addr);
 
 /* interface with exec.c */
 
-void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align));
+void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align, bool shared));
 
 /* internal API */
 
diff --git a/memory.c b/memory.c
index c7f6588452..6515131ac2 100644
--- a/memory.c
+++ b/memory.c
@@ -1539,11 +1539,21 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
+    memory_region_init_ram_shared_nomigrate(mr, owner, name, size, false, errp);
+}
+
+void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
+                                             Object *owner,
+                                             const char *name,
+                                             uint64_t size,
+                                             bool share,
+                                             Error **errp)
+{
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, mr, errp);
+    mr->ram_block = qemu_ram_alloc(size, share, mr, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
@@ -1654,7 +1664,7 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
     mr->readonly = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, mr, errp);
+    mr->ram_block = qemu_ram_alloc(size, false, mr, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
@@ -1673,7 +1683,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     mr->terminates = true;
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, mr, errp);
+    mr->ram_block = qemu_ram_alloc(size, false,  mr, errp);
 }
 
 void memory_region_init_iommu(void *_iommu_mr,
diff --git a/qemu-options.hx b/qemu-options.hx
index 5050a49a5e..8ccd5dcaa6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3975,6 +3975,14 @@ The @option{share} boolean option determines whether the memory
 region is marked as private to QEMU, or shared. The latter allows
 a co-operating external process to access the QEMU memory region.
 
+The @option{share} is also required for pvrdma devices due to
+limitations in the RDMA API provided by Linux.
+
+Setting share=on might affect the ability to configure NUMA
+bindings for the memory backend under some circumstances, see
+Documentation/vm/numa_memory_policy.txt on the Linux kernel
+source tree for additional details.
+
 Setting the @option{discard-data} boolean option to @var{on}
 indicates that file contents can be destroyed when QEMU exits,
 to avoid unnecessarily flushing data to the backing file.  Note
@@ -4017,7 +4025,7 @@ requires an alignment different than the default one used by QEMU, eg
 the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
 such cases, users can specify the required alignment via this option.
 
-@item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
+@item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
 Creates a memory backend object, which can be used to back the guest RAM.
 Memory backend objects offer more control than the @option{-m} option that is
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0301e9d519..e13c8907df 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -144,7 +144,7 @@ static int cap_gs;
 
 static int active_cmma;
 
-static void *legacy_s390_alloc(size_t size, uint64_t *align);
+static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared);
 
 static int kvm_s390_query_mem_limit(uint64_t *memory_limit)
 {
@@ -752,7 +752,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
  * to grow. We also have to use MAP parameters that avoid
  * read-only mapping of guest pages.
  */
-static void *legacy_s390_alloc(size_t size, uint64_t *align)
+static void *legacy_s390_alloc(size_t size, uint64_t *align, bool shared)
 {
     void *mem;
 
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4655bc1f89..13b6f8d776 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -127,10 +127,10 @@ void *qemu_memalign(size_t alignment, size_t size)
 }
 
 /* alloc shared memory pages */
-void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment)
+void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, false);
+    void *ptr = qemu_ram_mmap(-1, size, align, shared);
 
     if (ptr == MAP_FAILED) {
         return NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 69a6286d50..bb5ad28bd3 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -67,7 +67,7 @@ void *qemu_memalign(size_t alignment, size_t size)
     return qemu_oom_check(qemu_try_memalign(alignment, size));
 }
 
-void *qemu_anon_ram_alloc(size_t size, uint64_t *align)
+void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
 {
     void *ptr;
 
-- 
2.13.5
