Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA9-0001rz-BH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA8-0001Mn-67
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHA7-0001Mb-TU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:52 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17F5F3D97C
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:40 +0100
Message-Id: <20170111113347.7577-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/9] exec: split file_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Move file opening part in a seperate function file_ram_open(). This
allows for reuse of file_ram_alloc() with only a fd.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 exec.c | 83 +++++++++++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/exec.c b/exec.c
index 172baba30e..b6d52e7c43 100644
--- a/exec.c
+++ b/exec.c
@@ -1260,19 +1260,17 @@ static int64_t get_file_size(int fd)
     return size;
 }
=20
-static void *file_ram_alloc(RAMBlock *block,
-                            ram_addr_t memory,
-                            const char *path,
-                            Error **errp)
+static int file_ram_open(const char *path,
+                         const char *region_name,
+                         bool *created,
+                         Error **errp)
 {
-    bool unlink_on_error =3D false;
     char *filename;
     char *sanitized_name;
     char *c;
-    void *area =3D MAP_FAILED;
     int fd =3D -1;
-    int64_t file_size;
=20
+    *created =3D false;
     for (;;) {
         fd =3D open(path, O_RDWR);
         if (fd >=3D 0) {
@@ -1283,13 +1281,13 @@ static void *file_ram_alloc(RAMBlock *block,
             /* @path names a file that doesn't exist, create it */
             fd =3D open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
             if (fd >=3D 0) {
-                unlink_on_error =3D true;
+                *created =3D true;
                 break;
             }
         } else if (errno =3D=3D EISDIR) {
             /* @path names a directory, create a file there */
             /* Make name safe to use with mkstemp by replacing '/' with =
'_'. */
-            sanitized_name =3D g_strdup(memory_region_name(block->mr));
+            sanitized_name =3D g_strdup(region_name);
             for (c =3D sanitized_name; *c !=3D '\0'; c++) {
                 if (*c =3D=3D '/') {
                     *c =3D '_';
@@ -1312,7 +1310,7 @@ static void *file_ram_alloc(RAMBlock *block,
             error_setg_errno(errp, errno,
                              "can't open backing store %s for guest RAM"=
,
                              path);
-            goto error;
+            return -1;
         }
         /*
          * Try again on EINTR and EEXIST.  The latter happens when
@@ -1320,6 +1318,17 @@ static void *file_ram_alloc(RAMBlock *block,
          */
     }
=20
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
     block->page_size =3D qemu_fd_getpagesize(fd);
     block->mr->align =3D block->page_size;
 #if defined(__s390x__)
@@ -1328,20 +1337,11 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 #endif
=20
-    file_size =3D get_file_size(fd);
-
     if (memory < block->page_size) {
         error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal t=
o "
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
=20
     memory =3D ROUND_UP(memory, block->page_size);
@@ -1360,7 +1360,7 @@ static void *file_ram_alloc(RAMBlock *block,
      * those labels. Therefore, extending the non-empty backend file
      * is disabled as well.
      */
-    if (!file_size && ftruncate(fd, memory)) {
+    if (truncate && ftruncate(fd, memory)) {
         perror("ftruncate");
     }
=20
@@ -1369,30 +1369,19 @@ static void *file_ram_alloc(RAMBlock *block,
     if (area =3D=3D MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
-        goto error;
+        return NULL;
     }
=20
     if (mem_prealloc) {
         os_mem_prealloc(fd, area, memory, errp);
         if (errp && *errp) {
-            goto error;
+            qemu_ram_munmap(area, memory);
+            return NULL;
         }
     }
=20
     block->fd =3D fd;
     return area;
-
-error:
-    if (area !=3D MAP_FAILED) {
-        qemu_ram_munmap(area, memory);
-    }
-    if (unlink_on_error) {
-        unlink(path);
-    }
-    if (fd !=3D -1) {
-        close(fd);
-    }
-    return NULL;
 }
 #endif
=20
@@ -1691,6 +1680,9 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size,=
 MemoryRegion *mr,
 {
     RAMBlock *new_block;
     Error *local_err =3D NULL;
+    int fd;
+    bool created;
+    int64_t file_size;
=20
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1714,15 +1706,32 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t siz=
e, MemoryRegion *mr,
         return NULL;
     }
=20
+    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, err=
p);
+    if (fd < 0) {
+        return NULL;
+    }
+
     size =3D HOST_PAGE_ALIGN(size);
+    file_size =3D get_file_size(fd);
+    if (file_size > 0 && file_size < size) {
+        error_setg(errp, "backing store %s size 0x%" PRIx64
+                   " does not match 'size' option 0x" RAM_ADDR_FMT,
+                   mem_path, file_size, size);
+        close(fd);
+        return NULL;
+    }
+
     new_block =3D g_malloc0(sizeof(*new_block));
     new_block->mr =3D mr;
     new_block->used_length =3D size;
     new_block->max_length =3D size;
     new_block->flags =3D share ? RAM_SHARED : 0;
-    new_block->host =3D file_ram_alloc(new_block, size,
-                                     mem_path, errp);
+    new_block->host =3D file_ram_alloc(new_block, size, fd, !file_size, =
errp);
     if (!new_block->host) {
+        if (created) {
+            unlink(mem_path);
+        }
+        close(fd);
         g_free(new_block);
         return NULL;
     }
--=20
2.11.0
