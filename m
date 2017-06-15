Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-00082o-Ia
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOj-0007Pk-Me
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:11 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOj-0007PF-Di
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:09 -0400
Received: by mail-wr0-x244.google.com with SMTP id y25so544152wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:22 +0200
Message-Id: <1497523981-38449-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/41] exec: split file_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move file opening part in a seperate function, file_ram_open(). This
allows for reuse of file_ram_alloc() with a given fd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170602141229.15326-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 83 +++++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/exec.c b/exec.c
index a5be851..42a5a7c 100644
--- a/exec.c
+++ b/exec.c
@@ -1482,19 +1482,17 @@ static int64_t get_file_size(int fd)
     return size;
 }
 
-static void *file_ram_alloc(RAMBlock *block,
-                            ram_addr_t memory,
-                            const char *path,
-                            Error **errp)
+static int file_ram_open(const char *path,
+                         const char *region_name,
+                         bool *created,
+                         Error **errp)
 {
-    bool unlink_on_error = false;
     char *filename;
     char *sanitized_name;
     char *c;
-    void *area = MAP_FAILED;
     int fd = -1;
-    int64_t file_size;
 
+    *created = false;
     for (;;) {
         fd = open(path, O_RDWR);
         if (fd >= 0) {
@@ -1505,13 +1503,13 @@ static void *file_ram_alloc(RAMBlock *block,
             /* @path names a file that doesn't exist, create it */
             fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
             if (fd >= 0) {
-                unlink_on_error = true;
+                *created = true;
                 break;
             }
         } else if (errno == EISDIR) {
             /* @path names a directory, create a file there */
             /* Make name safe to use with mkstemp by replacing '/' with '_'. */
-            sanitized_name = g_strdup(memory_region_name(block->mr));
+            sanitized_name = g_strdup(region_name);
             for (c = sanitized_name; *c != '\0'; c++) {
                 if (*c == '/') {
                     *c = '_';
@@ -1534,7 +1532,7 @@ static void *file_ram_alloc(RAMBlock *block,
             error_setg_errno(errp, errno,
                              "can't open backing store %s for guest RAM",
                              path);
-            goto error;
+            return -1;
         }
         /*
          * Try again on EINTR and EEXIST.  The latter happens when
@@ -1542,6 +1540,17 @@ static void *file_ram_alloc(RAMBlock *block,
          */
     }
 
+    return fd;
+}
+
+static void *file_ram_alloc(RAMBlock *block,
+                            ram_addr_t memory,
+                            int fd,
+                            bool truncate,
+                            Error **errp)
+{
+    void *area;
+
     block->page_size = qemu_fd_getpagesize(fd);
     block->mr->align = block->page_size;
 #if defined(__s390x__)
@@ -1550,20 +1559,11 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 #endif
 
-    file_size = get_file_size(fd);
-
     if (memory < block->page_size) {
         error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal to "
                    "or larger than page size 0x%zx",
                    memory, block->page_size);
-        goto error;
-    }
-
-    if (file_size > 0 && file_size < memory) {
-        error_setg(errp, "backing store %s size 0x%" PRIx64
-                   " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   path, file_size, memory);
-        goto error;
+        return NULL;
     }
 
     memory = ROUND_UP(memory, block->page_size);
@@ -1582,7 +1582,7 @@ static void *file_ram_alloc(RAMBlock *block,
      * those labels. Therefore, extending the non-empty backend file
      * is disabled as well.
      */
-    if (!file_size && ftruncate(fd, memory)) {
+    if (truncate && ftruncate(fd, memory)) {
         perror("ftruncate");
     }
 
@@ -1591,30 +1591,19 @@ static void *file_ram_alloc(RAMBlock *block,
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
-        goto error;
+        return NULL;
     }
 
     if (mem_prealloc) {
         os_mem_prealloc(fd, area, memory, smp_cpus, errp);
         if (errp && *errp) {
-            goto error;
+            qemu_ram_munmap(area, memory);
+            return NULL;
         }
     }
 
     block->fd = fd;
     return area;
-
-error:
-    if (area != MAP_FAILED) {
-        qemu_ram_munmap(area, memory);
-    }
-    if (unlink_on_error) {
-        unlink(path);
-    }
-    if (fd != -1) {
-        close(fd);
-    }
-    return NULL;
 }
 #endif
 
@@ -1931,6 +1920,9 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
+    int fd;
+    bool created;
+    int64_t file_size;
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1954,15 +1946,32 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
+    fd = file_ram_open(mem_path, memory_region_name(mr), &created, errp);
+    if (fd < 0) {
+        return NULL;
+    }
+
     size = HOST_PAGE_ALIGN(size);
+    file_size = get_file_size(fd);
+    if (file_size > 0 && file_size < size) {
+        error_setg(errp, "backing store %s size 0x%" PRIx64
+                   " does not match 'size' option 0x" RAM_ADDR_FMT,
+                   mem_path, file_size, size);
+        close(fd);
+        return NULL;
+    }
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = share ? RAM_SHARED : 0;
-    new_block->host = file_ram_alloc(new_block, size,
-                                     mem_path, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
     if (!new_block->host) {
+        if (created) {
+            unlink(mem_path);
+        }
+        close(fd);
         g_free(new_block);
         return NULL;
     }
-- 
1.8.3.1
