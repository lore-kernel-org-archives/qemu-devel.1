Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr9-0003B1-9X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr8-0003D3-8a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:51 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYr8-0003Cl-4K
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:50 -0400
Received: by mail-qt0-x235.google.com with SMTP id i18-v6so19637972qtp.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:50 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:10 -0400
Message-Id: <5d222847166f7f3f2b05e7e8a0a0ab3d7520b49d.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 15/20] 9p: darwin: *xattr_nofollow
 implementations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

This implements the darwin equivalent of the functions that were
moved to 9p-util(-linux) earlier in this series in the new
9p-util-darwin file.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes from v1:
 * New 9p-util-darwin.c rather than ifdefs in 9p-util.c
 * Drop incorrect AT_NOFOLLOW from the actual call

 hw/9pfs/9p-util-darwin.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/Makefile.objs    |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 hw/9pfs/9p-util-darwin.c

diff --git a/hw/9pfs/9p-util-darwin.c b/hw/9pfs/9p-util-darwin.c
new file mode 100644
index 0000000..cdb4c9e
--- /dev/null
+++ b/hw/9pfs/9p-util-darwin.c
@@ -0,0 +1,64 @@
+/*
+ * 9p utilities (Darwin Implementation)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/xattr.h"
+#include "9p-util.h"
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                             void *value, size_t size)
+{
+    int ret;
+    int fd = openat_file(dirfd, filename,
+                         O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = fgetxattr(fd, name, value, size, 0, 0);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    int ret;
+    int fd = openat_file(dirfd, filename,
+                         O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = flistxattr(fd, list, size, 0);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    int ret;
+    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = fremovexattr(fd, name, 0);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    int ret;
+    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = fsetxattr(fd, name, value, size, 0, flags);
+    close_preserve_errno(fd);
+    return ret;
+}
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index 083508f..24a8695 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -1,5 +1,6 @@
 common-obj-y  = 9p.o
 common-obj-$(CONFIG_LINUX) += 9p-util-linux.o
+common-obj-$(CONFIG_DARWIN) += 9p-util-darwin.o
 common-obj-y += 9p-local.o 9p-xattr.o
 common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
 common-obj-y += coth.o cofs.o codir.o cofile.o
-- 
2.8.1
