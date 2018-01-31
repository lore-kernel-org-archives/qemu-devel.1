Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUQ-0006SX-Lg
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eglUM-0007Z0-FU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eglUM-0007VH-4k
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 01:03:18 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 31 Jan 2018 14:02:26 +0800
Message-Id: <20180131060229.9294-4-haozhong.zhang@intel.com>
In-Reply-To: <20180131060229.9294-1-haozhong.zhang@intel.com>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 3/6] memory: switch
 memory_region_init_ram_from_file() to 'flags' parameter
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

As more flag parameters besides the existing 'share' are going to be
added to memory_region_init_ram_from_file(), let's switch 'share' to
a 'flags' parameter in advance, so as to ease the further additions.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 backends/hostmem-file.c | 3 ++-
 include/exec/memory.h   | 7 +++++--
 memory.c                | 6 ++----
 numa.c                  | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index e319ec1ad8..67ecfed895 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -59,7 +59,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->align, fb->share,
+                                 backend->size, fb->align,
+                                 fb->share ? QEMU_RAM_SHARE : 0,
                                  fb->mem_path, errp);
         g_free(path);
     }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4790cd9e13..6b547da6a3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -470,7 +470,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @size: size of the region.
  * @align: alignment of the region base address; if 0, the default alignment
  *         (getpagesize()) will be used.
- * @share: %true if memory must be mmaped with the MAP_SHARED flag
+ * @flags: specify properties of this memory region, which can be one or bit-or
+ *         of following values:
+ *         - QEMU_RAM_SHARE: memory must be mmaped with the MAP_SHARED flag
+ *         Other bits are ignored.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
  *
@@ -482,7 +485,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       uint64_t align,
-                                      bool share,
+                                      uint64_t flags,
                                       const char *path,
                                       Error **errp);
 
diff --git a/memory.c b/memory.c
index 1ac4ebcaca..a4f19a5d30 100644
--- a/memory.c
+++ b/memory.c
@@ -1571,7 +1571,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       uint64_t align,
-                                      bool share,
+                                      uint64_t flags,
                                       const char *path,
                                       Error **errp)
 {
@@ -1580,9 +1580,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr,
-                                             share ? QEMU_RAM_SHARE : 0,
-                                             path, errp);
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, flags, path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 
diff --git a/numa.c b/numa.c
index 83675a03f3..fa202a376d 100644
--- a/numa.c
+++ b/numa.c
@@ -456,7 +456,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
                                          mem_path, &err);
         if (err) {
             error_report_err(err);
-- 
2.14.1
