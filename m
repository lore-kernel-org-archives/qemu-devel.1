Received: from eggs.gnu.org ([2001:4830:134:3::10]:56708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNLxt-0006K2-E2
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eNLxs-0000BX-I3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:57:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eNLxs-0000An-B1
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:57:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Dec 2017 16:57:28 +0000
Message-Id: <1512752248-17857-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] sparc: Make sure we mmap at SHMLBA alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

SPARC Linux has an oddity that it insists that mmap()
of MAP_FIXED memory must be at an alignment defined by
SHMLBA, which is more aligned than the page size
(typically, SHMLBA alignment is to 16K, and pages are 8K).
This is a relic of ancient hardware that had cache
aliasing constraints, but even on modern hardware the
kernel still insists on the alignment.

To ensure that we get mmap() alignment sufficient to
make the kernel happy, change QEMU_VMALLOC_ALIGN,
qemu_fd_getpagesize() and qemu_mempath_getpagesize()
to use the maximum of getpagesize() and SHMLBA.

In particular, this allows 'make check' to pass on Sparc:
we were previously failing the ivshmem tests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/osdep.h | 3 +++
 util/mmap-alloc.c    | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index e8568a0..adb3758 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -365,6 +365,9 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #elif defined(__linux__) && defined(__s390x__)
    /* Use 1 MiB (segment size) alignment so gmap can be used by KVM. */
 #  define QEMU_VMALLOC_ALIGN (256 * 4096)
+#elif defined(__linux__) && defined(__sparc__)
+#include <sys/shm.h>
+#  define QEMU_VMALLOC_ALIGN MAX(getpagesize(), SHMLBA)
 #else
 #  define QEMU_VMALLOC_ALIGN getpagesize()
 #endif
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 3ec029a..2fd8cbc 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -35,6 +35,10 @@ size_t qemu_fd_getpagesize(int fd)
             return fs.f_bsize;
         }
     }
+#ifdef __sparc__
+    /* SPARC Linux needs greater alignment than the pagesize */
+    return QEMU_VMALLOC_ALIGN;
+#endif
 #endif
 
     return getpagesize();
@@ -60,6 +64,10 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
         /* It's hugepage, return the huge page size */
         return fs.f_bsize;
     }
+#ifdef __sparc__
+    /* SPARC Linux needs greater alignment than the pagesize */
+    return QEMU_VMALLOC_ALIGN;
+#endif
 #endif
 
     return getpagesize();
-- 
2.7.4
