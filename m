Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D413D2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D413D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaEDl-0000eE-32
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jason.zeng@intel.com>) id 1iaCuu-0008Dq-RT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jason.zeng@intel.com>) id 1iaCus-0005MH-AH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:04:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:19889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jason.zeng@intel.com>)
 id 1iaCuq-00052u-25
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:04:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 22:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; d="scan'208";a="261207498"
Received: from x48.bj.intel.com ([10.238.157.73])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2019 22:04:24 -0800
From: Jason Zeng <jason.zeng@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Add a parameter 'offset' for HostMemoryBackendFile
Date: Thu, 28 Nov 2019 14:03:56 +0800
Message-Id: <20191128060356.9050-1-jason.zeng@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
X-Mailman-Approved-At: Thu, 28 Nov 2019 02:26:16 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 brho@google.com, lei.l.li@intel.com, steven.sistare@oracle.com,
 zhiyuan.lv@intel.com, Jason Zeng <jason.zeng@intel.com>, jschoenh@amazon.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In cloud environment, when using DRAM-emulated-PMEM DAX device (by kernel
parameter 'memmap=nn!ss') to mmap guest memory, multiple VMs may need to
share the same DAX device. This is because we can't dynamically create
multiple namespaces in one DRAM-emulated-PMEM region. It is also hard to
figure out how many 'memmap=nn!ss' regions need to be created at kernel
boot time.

This patch introduces a parameter 'offset' for HostMemoryBackendFile to
specify the offset in the file this HostMemoryBackendFile will mmap to,
so that different HostMemoryBackendFiles can mmap to different address
ranges of the backing file.

Signed-off-by: Jason Zeng <jason.zeng@intel.com>
---
 backends/hostmem-file.c   | 46 ++++++++++++++++++++++++++++++++++++++-
 exec.c                    | 20 ++++++++++-------
 hw/core/numa.c            |  2 +-
 include/exec/memory.h     |  1 +
 include/exec/ram_addr.h   |  4 ++--
 include/qemu/mmap-alloc.h |  1 +
 memory.c                  |  6 +++--
 util/mmap-alloc.c         |  5 +++--
 util/oslib-posix.c        |  2 +-
 9 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index be64020746..1fe814d52e 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -34,6 +34,7 @@ struct HostMemoryBackendFile {
     HostMemoryBackend parent_obj;
 
     char *mem_path;
+    uint64_t offset;
     uint64_t align;
     bool discard_data;
     bool is_pmem;
@@ -57,6 +58,10 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         error_setg(errp, "mem-path property not set");
         return;
     }
+    if (fb->align && fb->offset && (fb->offset % fb->align)) {
+        error_setg(errp, "offset doesn't match align");
+        return;
+    }
 
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
@@ -65,7 +70,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
                                      backend->size, fb->align,
                                      (backend->share ? RAM_SHARED : 0) |
                                      (fb->is_pmem ? RAM_PMEM : 0),
-                                     fb->mem_path, errp);
+                                     fb->mem_path, fb->offset, errp);
     g_free(name);
 #endif
 }
@@ -137,6 +142,41 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     error_propagate(errp, local_err);
 }
 
+static void file_memory_backend_get_offset(Object *o, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    uint64_t val = fb->offset;
+
+    visit_type_size(v, name, &val, errp);
+}
+
+static void file_memory_backend_set_offset(Object *o, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    Error *local_err = NULL;
+    uint64_t val;
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(&local_err, "cannot change property '%s' of %s",
+                   name, object_get_typename(o));
+        goto out;
+    }
+
+    visit_type_size(v, name, &val, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    fb->offset = val;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static bool file_memory_backend_get_pmem(Object *o, Error **errp)
 {
     return MEMORY_BACKEND_FILE(o)->is_pmem;
@@ -197,6 +237,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path,
         &error_abort);
+    object_class_property_add(oc, "offset", "uint64",
+        file_memory_backend_get_offset,
+        file_memory_backend_set_offset,
+        NULL, NULL, &error_abort);
     object_class_property_add(oc, "align", "int",
         file_memory_backend_get_align,
         file_memory_backend_set_align,
diff --git a/exec.c b/exec.c
index ffdb518535..7018ef343f 100644
--- a/exec.c
+++ b/exec.c
@@ -1838,6 +1838,7 @@ static int file_ram_open(const char *path,
 static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
+                            off_t offset,
                             bool truncate,
                             Error **errp)
 {
@@ -1889,7 +1890,7 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    area = qemu_ram_mmap(fd, memory, block->mr->align,
+    area = qemu_ram_mmap(fd, memory, block->mr->align, offset,
                          block->flags & RAM_SHARED, block->flags & RAM_PMEM);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -2277,7 +2278,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp)
+                                 off_t offset, Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
@@ -2309,11 +2310,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     }
 
     size = HOST_PAGE_ALIGN(size);
+    offset = HOST_PAGE_ALIGN(offset);
     file_size = get_file_size(fd);
-    if (file_size > 0 && file_size < size) {
+    if (file_size > 0 && file_size < offset + size) {
         error_setg(errp, "backing store %s size 0x%" PRIx64
-                   " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   mem_path, file_size, size);
+                   " does not match 'size' option 0x" RAM_ADDR_FMT
+                   " and 'offset' option 0x" RAM_ADDR_FMT,
+                   mem_path, file_size, size, offset);
         return NULL;
     }
 
@@ -2322,7 +2325,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, offset,
+                                     !file_size, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2341,7 +2345,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   Error **errp)
+                                   off_t offset, Error **errp)
 {
     int fd;
     bool created;
@@ -2352,7 +2356,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a984f..be310fc0cc 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -494,7 +494,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
 #ifdef __linux__
         Error *err = NULL;
         memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
+                                         mem_path, 0, &err);
         if (err) {
             error_report_err(err);
             if (mem_prealloc) {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc215b..eba2fc894e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -690,6 +690,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint64_t align,
                                       uint32_t ram_flags,
                                       const char *path,
+                                      off_t offset,
                                       Error **errp);
 
 /**
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index bed0554f4d..721c26a4c0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -156,10 +156,10 @@ long qemu_maxrampagesize(void);
  */
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   Error **errp);
+                                   off_t offset, Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp);
+                                 off_t offset, Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index e786266b92..80b8df7f70 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -24,6 +24,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
 void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
+                    off_t offset_in_fd,
                     bool shared,
                     bool is_pmem);
 
diff --git a/memory.c b/memory.c
index 06484c2bff..62e8d8acbe 100644
--- a/memory.c
+++ b/memory.c
@@ -1563,6 +1563,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint64_t align,
                                       uint32_t ram_flags,
                                       const char *path,
+                                      off_t offset,
                                       Error **errp)
 {
     Error *err = NULL;
@@ -1571,7 +1572,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags,
+                                             path, offset, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
         mr->size = int128_zero();
@@ -1595,7 +1597,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
                                            share ? RAM_SHARED : 0,
-                                           fd, &err);
+                                           fd, 0, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
         mr->size = int128_zero();
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd8ec..e99e63c5fe 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -85,6 +85,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
 void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
+                    off_t offset_in_fd,
                     bool shared,
                     bool is_pmem)
 {
@@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
     ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-               flags | map_sync_flags, fd, 0);
+               flags | map_sync_flags, fd, offset_in_fd);
 
     if (ptr == MAP_FAILED && map_sync_flags) {
         if (errno == ENOTSUP) {
@@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
          * we will remove these flags to handle compatibility.
          */
         ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-                   flags, fd, 0);
+                   flags, fd, offset_in_fd);
     }
 
     if (ptr == MAP_FAILED) {
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5a291cc982..f8c13ada9a 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -205,7 +205,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
+    void *ptr = qemu_ram_mmap(-1, size, align, 0, shared, false);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.20.1


