Received: from eggs.gnu.org ([2001:4830:134:3::10]:34417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvx-00019t-E6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvw-0005oV-EG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEvw-0005oO-4r
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 235BAC04B302
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:29:59 -0300
Message-Id: <20170614203000.19984-5-ehabkost@redhat.com>
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] memory: Add 'persistent' parameter to
 memory_region_init_ram_from_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Make it possible to set the RAM_NONPERSISTENT flag on the RAMBlock when
mapping a file.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/exec/memory.h   | 4 ++++
 include/exec/ram_addr.h | 4 ++--
 backends/hostmem-file.c | 2 +-
 exec.c                  | 7 +++++--
 memory.c                | 4 +++-
 numa.c                  | 2 +-
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 80e605a96a..f47c534179 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -446,6 +446,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
+ * @persistent: %false if RAM contents can be discarded and don't
+ *              need to be flushed to disk when the memory region
+ *              is freed.
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
  */
@@ -454,6 +457,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       bool share,
+                                      bool persistent,
                                       const char *path,
                                       Error **errp);
 #endif
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 140efa840c..67dc099355 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -63,8 +63,8 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
 long qemu_getrampagesize(void);
 unsigned long last_ram_page(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
-                                   Error **errp);
+                                   bool share, bool persistent,
+                                   const char *mem_path, Error **errp);
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
 RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index fc4ef46d11..d078775b4b 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -57,7 +57,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         path = object_get_canonical_path(OBJECT(backend));
         memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                  path,
-                                 backend->size, fb->share,
+                                 backend->size, fb->share, true,
                                  fb->mem_path, errp);
         g_free(path);
     }
diff --git a/exec.c b/exec.c
index a6e9ed4ece..77734198d0 100644
--- a/exec.c
+++ b/exec.c
@@ -1937,8 +1937,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 
 #ifdef __linux__
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
-                                   Error **errp)
+                                   bool share, bool persistent,
+                                   const char *mem_path, Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
@@ -1965,6 +1965,9 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = share ? RAM_SHARED : 0;
+    if (!persistent) {
+        new_block->flags |= RAM_NONPERSISTENT;
+    }
     new_block->host = file_ram_alloc(new_block, size,
                                      mem_path, errp);
     if (!new_block->host) {
diff --git a/memory.c b/memory.c
index 0ddc4cc28d..3c0c0ff141 100644
--- a/memory.c
+++ b/memory.c
@@ -1387,6 +1387,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       const char *name,
                                       uint64_t size,
                                       bool share,
+                                      bool persistent,
                                       const char *path,
                                       Error **errp)
 {
@@ -1394,7 +1395,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, persistent,
+                                             path, errp);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
 }
 #endif
diff --git a/numa.c b/numa.c
index 65701cb6c8..825d5933ca 100644
--- a/numa.c
+++ b/numa.c
@@ -531,7 +531,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, false,
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, false, true,
                                          mem_path, &err);
         if (err) {
             error_report_err(err);
-- 
2.11.0.259.g40922b1
