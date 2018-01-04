Received: from eggs.gnu.org ([2001:4830:134:3::10]:50217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX8W8-0002Yu-Qw
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eX8W0-0001HN-DZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:37:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eX8W0-0001Ey-2k
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:37:12 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Thu,  4 Jan 2018 18:36:49 +0200
Message-Id: <20180104163652.65450-3-marcel@redhat.com>
In-Reply-To: <20180104163652.65450-1-marcel@redhat.com>
References: <20180104163652.65450-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V4 2/5] mem: add share parameter to
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
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, f4bug@amsat.org

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
 util/oslib-posix.c       |  4 ++--
 util/oslib-win32.c       |  2 +-
 12 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e44c319915..bc95022a68 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -31,7 +31,6 @@ typedef struct HostMemoryBackendFile HostMemoryBackendFile;
 struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
-    bool share;
     bool discard_data;
     char *mem_path;
 };
@@ -58,7 +57,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->share,
+                                 backend->size, backend->share,
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -85,25 +84,6 @@ static void set_mem_path(Object *o, const char *str, Error **errp)
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
@@ -136,9 +116,6 @@ file_backend_class_init(ObjectClass *oc, void *data)
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
index ee2c2d5bfd..1daf13bd2e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -369,6 +369,24 @@ static void set_id(Object *o, const char *str, Error **errp)
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
@@ -399,6 +417,9 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
         host_memory_backend_get_policy,
         host_memory_backend_set_policy, &error_abort);
     object_class_property_add_str(oc, "id", get_id, set_id, &error_abort);
+    object_class_property_add_bool(oc, "share",
+        host_memory_backend_get_share, host_memory_backend_set_share,
+        &error_abort);
 }
 
 static void host_memory_backend_finalize(Object *o)
diff --git a/exec.c b/exec.c
index 4722e521d4..247f8bd0c0 100644
--- a/exec.c
+++ b/exec.c
@@ -1278,7 +1278,7 @@ static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
                              uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 
-static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
+static void *(*phys_mem_alloc)(size_t size, uint64_t *align, bool shared) =
                                qemu_anon_ram_alloc;
 
 /*
@@ -1286,7 +1286,7 @@ static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
  * Accelerators with unusual needs may need this.  Hopefully, we can
  * get rid of it eventually.
  */
-void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align))
+void phys_mem_set_alloc(void *(*alloc)(size_t, uint64_t *align, bool shared))
 {
     phys_mem_alloc = alloc;
 }
@@ -1889,7 +1889,7 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
-static void ram_block_add(RAMBlock *new_block, Error **errp)
+static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 {
     RAMBlock *block;
     RAMBlock *last_block = NULL;
@@ -1912,7 +1912,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             }
         } else {
             new_block->host = phys_mem_alloc(new_block->max_length,
-                                             &new_block->mr->align);
+                                             &new_block->mr->align, shared);
             if (!new_block->host) {
                 error_setg_errno(errp, errno,
                                  "cannot set up guest memory '%s'",
@@ -2017,7 +2017,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    ram_block_add(new_block, &local_err);
+    ram_block_add(new_block, &local_err, share);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2059,7 +2059,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void (*resized)(const char*,
                                                   uint64_t length,
                                                   void *host),
-                                  void *host, bool resizeable,
+                                  void *host, bool resizeable, bool share,
                                   MemoryRegion *mr, Error **errp)
 {
     RAMBlock *new_block;
@@ -2082,7 +2082,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     if (resizeable) {
         new_block->flags |= RAM_RESIZEABLE;
     }
-    ram_block_add(new_block, &local_err);
+    ram_block_add(new_block, &local_err, share);
     if (local_err) {
         g_free(new_block);
         error_propagate(errp, local_err);
@@ -2094,12 +2094,15 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
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
@@ -2108,7 +2111,8 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
                                                      void *host),
                                      MemoryRegion *mr, Error **errp)
 {
-    return qemu_ram_alloc_internal(size, maxsz, resized, NULL, true, mr, errp);
+    return qemu_ram_alloc_internal(size, maxsz, resized, NULL, true,
+                                   false, mr, errp);
 }
 
 static void reclaim_ramblock(RAMBlock *block)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index a4cabdf44c..dd28eaba68 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -428,6 +428,29 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
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
index 6cbc02aa0f..7d980572c0 100644
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
index ed6a437f4d..4d8f859f03 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -55,7 +55,7 @@ struct HostMemoryBackend {
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
index 4b41fb837b..cb4fe1a55a 100644
--- a/memory.c
+++ b/memory.c
@@ -1538,11 +1538,21 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
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
 
@@ -1651,7 +1661,7 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
     mr->readonly = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, mr, errp);
+    mr->ram_block = qemu_ram_alloc(size, false, mr, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
@@ -1670,7 +1680,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     mr->terminates = true;
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, mr, errp);
+    mr->ram_block = qemu_ram_alloc(size, false,  mr, errp);
 }
 
 void memory_region_init_iommu(void *_iommu_mr,
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 77369c92ce..0cf3548778 100644
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
