Received: from eggs.gnu.org ([2001:4830:134:3::10]:53296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHAA-0001s8-Db
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA9-0001NQ-Eh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHA9-0001Mx-5v
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5487013A5E
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:41 +0100
Message-Id: <20170111113347.7577-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/9] exec: split qemu_ram_alloc_from_file()
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

Add qemu_ram_alloc_from_fd(), which can be use to allocate ramblock from
fd only.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/ram_addr.h |  3 +++
 exec.c                  | 45 ++++++++++++++++++++++++++++++-------------=
--
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 54d7108a9e..7f013fe795 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -98,6 +98,9 @@ void qemu_mutex_unlock_ramlist(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
                                    Error **errp);
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+                                 bool share, int fd,
+                                 Error **errp);
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
 RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **errp=
);
diff --git a/exec.c b/exec.c
index b6d52e7c43..fbf02d15d0 100644
--- a/exec.c
+++ b/exec.c
@@ -1674,14 +1674,12 @@ static void ram_block_add(RAMBlock *new_block, Er=
ror **errp)
 }
=20
 #ifdef __linux__
-RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   bool share, const char *mem_path,
-                                   Error **errp)
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+                                 bool share, int fd,
+                                 Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err =3D NULL;
-    int fd;
-    bool created;
     int64_t file_size;
=20
     if (xen_enabled()) {
@@ -1706,18 +1704,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t siz=
e, MemoryRegion *mr,
         return NULL;
     }
=20
-    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, err=
p);
-    if (fd < 0) {
-        return NULL;
-    }
-
     size =3D HOST_PAGE_ALIGN(size);
     file_size =3D get_file_size(fd);
     if (file_size > 0 && file_size < size) {
         error_setg(errp, "backing store %s size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
                    mem_path, file_size, size);
-        close(fd);
         return NULL;
     }
=20
@@ -1728,10 +1720,6 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
, MemoryRegion *mr,
     new_block->flags =3D share ? RAM_SHARED : 0;
     new_block->host =3D file_ram_alloc(new_block, size, fd, !file_size, =
errp);
     if (!new_block->host) {
-        if (created) {
-            unlink(mem_path);
-        }
-        close(fd);
         g_free(new_block);
         return NULL;
     }
@@ -1743,6 +1731,33 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
, MemoryRegion *mr,
         return NULL;
     }
     return new_block;
+
+}
+
+
+RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
+                                   bool share, const char *mem_path,
+                                   Error **errp)
+{
+    int fd;
+    bool created;
+    RAMBlock *block;
+
+    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, err=
p);
+    if (fd < 0) {
+        return NULL;
+    }
+
+    block =3D qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
+    if (!block) {
+        if (created) {
+            unlink(mem_path);
+        }
+        close(fd);
+        return NULL;
+    }
+
+    return block;
 }
 #endif
=20
--=20
2.11.0
