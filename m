Received: from eggs.gnu.org ([209.51.188.92]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9v-0001av-1f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9n-0000jE-VI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:18 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:23 +1100
Message-Id: <20190204090124.26191-37-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/37] mmap-alloc: unfold qemu_ram_mmap()
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

Unfold parts of qemu_ram_mmap() for the sake of understanding, moving
declarations to the top, and keeping architecture-specifics in the
ifdef-else blocks.  No changes in the function behaviour.

Give ptr and ptr1 meaningful names:
  ptr  -> guardptr : pointer to the PROT_NONE guard region
  ptr1 -> ptr      : pointer to the mapped memory returned to caller

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 util/mmap-alloc.c | 53 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index fd329eccd8..f71ea038c8 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -77,11 +77,19 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
=20
 void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
 {
+    int flags;
+    int guardfd;
+    size_t offset;
+    size_t total;
+    void *guardptr;
+    void *ptr;
+
     /*
      * Note: this always allocates at least one extra page of virtual ad=
dress
      * space, even if size is already aligned.
      */
-    size_t total =3D size + align;
+    total =3D size + align;
+
 #if defined(__powerpc64__) && defined(__linux__)
     /* On ppc64 mappings in the same segment (aka slice) must share the =
same
      * page size. Since we will be re-allocating part of this segment
@@ -91,16 +99,22 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align=
, bool shared)
      * We do this unless we are using the system page size, in which cas=
e
      * anonymous memory is OK.
      */
-    int anonfd =3D fd =3D=3D -1 || qemu_fd_getpagesize(fd) =3D=3D getpag=
esize() ? -1 : fd;
-    int flags =3D anonfd =3D=3D -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
-    void *ptr =3D mmap(0, total, PROT_NONE, flags | MAP_PRIVATE, anonfd,=
 0);
+    flags =3D MAP_PRIVATE;
+    if (fd =3D=3D -1 || qemu_fd_getpagesize(fd) =3D=3D getpagesize()) {
+        guardfd =3D -1;
+        flags |=3D MAP_ANONYMOUS;
+    } else {
+        guardfd =3D fd;
+        flags |=3D MAP_NORESERVE;
+    }
 #else
-    void *ptr =3D mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE,=
 -1, 0);
+    guardfd =3D -1;
+    flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
-    size_t offset;
-    void *ptr1;
=20
-    if (ptr =3D=3D MAP_FAILED) {
+    guardptr =3D mmap(0, total, PROT_NONE, flags, guardfd, 0);
+
+    if (guardptr =3D=3D MAP_FAILED) {
         return MAP_FAILED;
     }
=20
@@ -108,19 +122,20 @@ void *qemu_ram_mmap(int fd, size_t size, size_t ali=
gn, bool shared)
     /* Always align to host page size */
     assert(align >=3D getpagesize());
=20
-    offset =3D QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
-    ptr1 =3D mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
-                MAP_FIXED |
-                (fd =3D=3D -1 ? MAP_ANONYMOUS : 0) |
-                (shared ? MAP_SHARED : MAP_PRIVATE),
-                fd, 0);
-    if (ptr1 =3D=3D MAP_FAILED) {
-        munmap(ptr, total);
+    flags =3D MAP_FIXED;
+    flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
+    flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
+    offset =3D QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)gu=
ardptr;
+
+    ptr =3D mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags,=
 fd, 0);
+
+    if (ptr =3D=3D MAP_FAILED) {
+        munmap(guardptr, total);
         return MAP_FAILED;
     }
=20
     if (offset > 0) {
-        munmap(ptr, offset);
+        munmap(guardptr, offset);
     }
=20
     /*
@@ -129,10 +144,10 @@ void *qemu_ram_mmap(int fd, size_t size, size_t ali=
gn, bool shared)
      */
     total -=3D offset;
     if (total > size + getpagesize()) {
-        munmap(ptr1 + size + getpagesize(), total - size - getpagesize()=
);
+        munmap(ptr + size + getpagesize(), total - size - getpagesize())=
;
     }
=20
-    return ptr1;
+    return ptr;
 }
=20
 void qemu_ram_munmap(void *ptr, size_t size)
--=20
2.20.1
