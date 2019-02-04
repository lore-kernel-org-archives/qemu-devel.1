Received: from eggs.gnu.org ([209.51.188.92]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9V-0001FA-OO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000HV-Ks
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:24 +1100
Message-Id: <20190204090124.26191-38-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/37] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

The commit 7197fb4058bcb68986bae2bb2c04d6370f3e7218 ("util/mmap-alloc:
fix hugetlb support on ppc64") fixed Huge TLB mappings on ppc64.

However, we still need to consider the underlying huge page size
during munmap() because it requires that both address and length be a
multiple of the underlying huge page size for Huge TLB mappings.
Quote from "Huge page (Huge TLB) mappings" paragraph under NOTES
section of the munmap(2) manual:

  "For munmap(), addr and length must both be a multiple of the
  underlying huge page size."

On ppc64, the munmap() in qemu_ram_munmap() does not work for Huge TLB
mappings because the mapped segment can be aligned with the underlying
huge page size, not aligned with the native system page size, as
returned by getpagesize().

This has the side effect of not releasing huge pages back to the pool
after a hugetlbfs file-backed memory device is hot-unplugged.

This patch fixes the situation in qemu_ram_mmap() and
qemu_ram_munmap() by considering the underlying page size on ppc64.

After this patch, memory hot-unplug releases huge pages back to the
pool.

Fixes: 7197fb4058bcb68986bae2bb2c04d6370f3e7218
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 exec.c                    |  4 ++--
 include/qemu/mmap-alloc.h |  2 +-
 util/mmap-alloc.c         | 22 ++++++++++++++++------
 util/oslib-posix.c        |  2 +-
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 25f3938a27..03dd673d36 100644
--- a/exec.c
+++ b/exec.c
@@ -1873,7 +1873,7 @@ static void *file_ram_alloc(RAMBlock *block,
     if (mem_prealloc) {
         os_mem_prealloc(fd, area, memory, smp_cpus, errp);
         if (errp && *errp) {
-            qemu_ram_munmap(area, memory);
+            qemu_ram_munmap(fd, area, memory);
             return NULL;
         }
     }
@@ -2394,7 +2394,7 @@ static void reclaim_ramblock(RAMBlock *block)
         xen_invalidate_map_cache_entry(block->host);
 #ifndef _WIN32
     } else if (block->fd >=3D 0) {
-        qemu_ram_munmap(block->host, block->max_length);
+        qemu_ram_munmap(block->fd, block->host, block->max_length);
         close(block->fd);
 #endif
     } else {
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index 50385e3f81..ef04f0ed5b 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -9,6 +9,6 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
=20
 void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
=20
-void qemu_ram_munmap(void *ptr, size_t size);
+void qemu_ram_munmap(int fd, void *ptr, size_t size);
=20
 #endif
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index f71ea038c8..8565885420 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -80,6 +80,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, =
bool shared)
     int flags;
     int guardfd;
     size_t offset;
+    size_t pagesize;
     size_t total;
     void *guardptr;
     void *ptr;
@@ -100,7 +101,8 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align=
, bool shared)
      * anonymous memory is OK.
      */
     flags =3D MAP_PRIVATE;
-    if (fd =3D=3D -1 || qemu_fd_getpagesize(fd) =3D=3D getpagesize()) {
+    pagesize =3D qemu_fd_getpagesize(fd);
+    if (fd =3D=3D -1 || pagesize =3D=3D getpagesize()) {
         guardfd =3D -1;
         flags |=3D MAP_ANONYMOUS;
     } else {
@@ -109,6 +111,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align=
, bool shared)
     }
 #else
     guardfd =3D -1;
+    pagesize =3D getpagesize();
     flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
=20
@@ -120,7 +123,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align=
, bool shared)
=20
     assert(is_power_of_2(align));
     /* Always align to host page size */
-    assert(align >=3D getpagesize());
+    assert(align >=3D pagesize);
=20
     flags =3D MAP_FIXED;
     flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
@@ -143,17 +146,24 @@ void *qemu_ram_mmap(int fd, size_t size, size_t ali=
gn, bool shared)
      * a guard page guarding against potential buffer overflows.
      */
     total -=3D offset;
-    if (total > size + getpagesize()) {
-        munmap(ptr + size + getpagesize(), total - size - getpagesize())=
;
+    if (total > size + pagesize) {
+        munmap(ptr + size + pagesize, total - size - pagesize);
     }
=20
     return ptr;
 }
=20
-void qemu_ram_munmap(void *ptr, size_t size)
+void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
+    size_t pagesize;
+
     if (ptr) {
         /* Unmap both the RAM block and the guard page */
-        munmap(ptr, size + getpagesize());
+#if defined(__powerpc64__) && defined(__linux__)
+        pagesize =3D qemu_fd_getpagesize(fd);
+#else
+        pagesize =3D getpagesize();
+#endif
+        munmap(ptr, size + pagesize);
     }
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ce1ba9ca4..37c5854b9c 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -226,7 +226,7 @@ void qemu_vfree(void *ptr)
 void qemu_anon_ram_free(void *ptr, size_t size)
 {
     trace_qemu_anon_ram_free(ptr, size);
-    qemu_ram_munmap(ptr, size);
+    qemu_ram_munmap(-1, ptr, size);
 }
=20
 void qemu_set_block(int fd)
--=20
2.20.1
