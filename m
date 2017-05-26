Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dE4w1-0001ok-Mv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dE4w0-0002IP-CU
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:25:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:56309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dE4w0-0002Hy-0v
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:25:00 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 26 May 2017 10:24:38 +0800
Message-Id: <20170526022438.17478-2-haozhong.zhang@intel.com>
In-Reply-To: <20170526022438.17478-1-haozhong.zhang@intel.com>
References: <20170526022438.17478-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] hostmem-file: add an attribute 'align' to
 set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

file_ram_alloc() currently maps the backend file via mmap to a virtual
address aligned to the value returned by qemu_fd_getpagesize(). When a
DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
mmap implementation may require an alignment larger than what
qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.

This commit adds an attribute 'align' to hostmem-file, so that users
can specify a proper alignment that satisfies the kernel requirement.

If 'align' is not specified or is 0, the value returned by
qemu_fd_get_pagesize() will be used as before.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 exec.c                  |  8 +++++++-
 include/exec/memory.h   |  2 ++
 memory.c                |  2 ++
 numa.c                  |  2 +-
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index fc4ef46d11..d44fb41b55 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -33,6 +33,7 @@ struct HostMemoryBackendFile {
 
     bool share;
     char *mem_path;
+    uint64_t align;
 };
 
 static void
@@ -57,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->share,
+                                 backend->size, fb->align, fb->share,
                                  fb->mem_path, errp);
         g_free(path);
     }
@@ -104,6 +105,40 @@ static void file_memory_backend_set_share(Object *o, bool value, Error **errp)
 }
 
 static void
+file_memory_backend_get_align(Object *o, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    uint64_t val = fb->align;
+
+    visit_type_size(v, name, &val, errp);
+}
+
+static void
+file_memory_backend_set_align(Object *o, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    Error *local_err = NULL;
+    uint64_t val;
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(&local_err, "cannot change property value");
+        goto out;
+    }
+
+    visit_type_size(v, name, &val, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    fb->align = val;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
+static void
 file_backend_class_init(ObjectClass *oc, void *data)
 {
     HostMemoryBackendClass *bc = MEMORY_BACKEND_CLASS(oc);
@@ -116,6 +151,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path,
         &error_abort);
+    object_class_property_add(oc, "align", "int",
+        file_memory_backend_get_align,
+        file_memory_backend_set_align,
+        NULL, NULL, &error_abort);
 }
 
 static void file_backend_instance_finalize(Object *o)
diff --git a/exec.c b/exec.c
index ff16f04f2b..5bb62e2e98 100644
--- a/exec.c
+++ b/exec.c
@@ -1549,7 +1549,13 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     block->page_size = qemu_fd_getpagesize(fd);
-    block->mr->align = block->page_size;
+    if (block->mr->align % block->page_size) {
+        error_setg(errp, "alignment 0x%" PRIx64 " must be "
+                   "multiple of page size 0x%" PRIx64,
+                   block->mr->align, block->page_size);
+        goto error;
+    }
+    block->mr->align = MAX(block->page_size, block->mr->align);
 #if defined(__s390x__)
     if (kvm_enabled()) {
         block->mr->align = MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 99e0f54d86..05d3d0da3b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -441,6 +441,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
+ * @align: alignment of the region.
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
@@ -449,6 +450,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       struct Object *owner,
                                       const char *name,
                                       uint64_t size,
+                                      uint64_t align,
                                       bool share,
                                       const char *path,
                                       Error **errp);
diff --git a/memory.c b/memory.c
index b727f5ec0e..5165b9aa08 100644
--- a/memory.c
+++ b/memory.c
@@ -1386,6 +1386,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       struct Object *owner,
                                       const char *name,
                                       uint64_t size,
+                                      uint64_t align,
                                       bool share,
                                       const char *path,
                                       Error **errp)
@@ -1394,6 +1395,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
+    mr->align = align;
     mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
diff --git a/numa.c b/numa.c
index ca731455e9..39a25aa1d2 100644
--- a/numa.c
+++ b/numa.c
@@ -541,7 +541,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, false,
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
                                          mem_path, &err);
         if (err) {
             error_report_err(err);
-- 
2.11.0
