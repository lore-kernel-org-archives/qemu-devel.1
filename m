Received: from eggs.gnu.org ([2001:4830:134:3::10]:45049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSd-0004rX-VO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSd-00059u-1f
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:51 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSc-00059e-RH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:50 -0500
Received: by mail-wr0-x244.google.com with SMTP id w50so30854520wrc.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:52 +0100
Message-Id: <1517858941-5538-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/47] memfd: add hugetlbsize argument
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

Learn to specificy hugetlb size as qemu_memfd_create() argument.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/memfd.h |  2 +-
 util/memfd.c         | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 1d3ecc7..de10198 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -17,7 +17,7 @@
 #endif
 
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
-                      unsigned int seals, Error **errp);
+                      uint64_t hugetlbsize, unsigned int seals, Error **errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 7594af7..07d579e 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -29,6 +29,7 @@
 
 #include "qapi/error.h"
 #include "qemu/memfd.h"
+#include "qemu/host-utils.h"
 
 #if defined CONFIG_LINUX && !defined CONFIG_MEMFD
 #include <sys/syscall.h>
@@ -56,9 +57,22 @@ static int memfd_create(const char *name, unsigned int flags)
 #define MFD_HUGETLB 0x0004U
 #endif
 
+#ifndef MFD_HUGE_SHIFT
+#define MFD_HUGE_SHIFT 26
+#endif
+
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
-                      unsigned int seals, Error **errp)
+                      uint64_t hugetlbsize, unsigned int seals, Error **errp)
 {
+    int htsize = hugetlbsize ? ctz64(hugetlbsize) : 0;
+
+    if (htsize && 1 << htsize != hugetlbsize) {
+        error_setg(errp, "Hugepage size must be a power of 2");
+        return -1;
+    }
+
+    htsize = htsize << MFD_HUGE_SHIFT;
+
 #ifdef CONFIG_LINUX
     int mfd = -1;
     unsigned int flags = MFD_CLOEXEC;
@@ -68,8 +82,8 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
     }
     if (hugetlb) {
         flags |= MFD_HUGETLB;
+        flags |= htsize;
     }
-
     mfd = memfd_create(name, flags);
     if (mfd < 0) {
         goto err;
@@ -104,11 +118,11 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp)
 {
     void *ptr;
-    int mfd = qemu_memfd_create(name, size, false, seals, NULL);
+    int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);
 
     /* some systems have memfd without sealing */
     if (mfd == -1) {
-        mfd = qemu_memfd_create(name, size, false, 0, NULL);
+        mfd = qemu_memfd_create(name, size, false, 0, 0, NULL);
     }
 
     if (mfd == -1) {
-- 
1.8.3.1
