Received: from eggs.gnu.org ([2001:4830:134:3::10]:37544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3d-0001An-Ib
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3a-0007v3-8k
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53458
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3Z-0007up-Q3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SASjRY043833
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:57 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vn6ar6dq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:56 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:30:55 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:16 +0100
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
Message-Id: <1488277840-18608-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 04/28] 9pfs: introduce
 relative_openat_nofollow() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

When using the passthrough security mode, symbolic links created by the
guest are actual symbolic links on the host file system.

Since the resolution of symbolic links during path walk is supposed to
occur on the client side. The server should hence never receive any path
pointing to an actual symbolic link. This isn't guaranteed by the protocol
though, and malicious code in the guest can trick the server to issue
various syscalls on paths whose one or more elements are symbolic links.
In the case of the "local" backend using the "passthrough" or "none"
security modes, the guest can directly create symbolic links to arbitrary
locations on the host (as per spec). The "mapped-xattr" and "mapped-file"
security modes are also affected to a lesser extent as they require some
help from an external entity to create actual symbolic links on the host,
i.e. another guest using "passthrough" mode for example.

The current code hence relies on O_NOFOLLOW and "l*()" variants of system
calls. Unfortunately, this only applies to the rightmost path component.
A guest could maliciously replace any component in a trusted path with a
symbolic link. This could allow any guest to escape a virtfs shared folder.

This patch introduces a variant of the openat() syscall that successively
opens each path element with O_NOFOLLOW. When passing a file descriptor
pointing to a trusted directory, one is guaranteed to be returned a
file descriptor pointing to a path which is beneath the trusted directory.
This will be used by subsequent patches to implement symlink-safe path walk
for any access to the backend.

Symbolic links aren't the only threats actually: a malicious guest could
change a path element to point to other types of file with undesirable
effects:
- a named pipe or any other thing that would cause openat() to block
- a terminal device which would become QEMU's controlling terminal

These issues can be addressed with O_NONBLOCK and O_NOCTTY.

Two helpers are introduced: one to open intermediate path elements and one
to open the rightmost path element.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(renamed openat_nofollow() to relative_openat_nofollow(),
 assert path is relative and doesn't contain '//',
 fixed side-effect in assert, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.c     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h     | 50 ++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/Makefile.objs |  2 +-
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
new file mode 100644
index 000000000000..54134b0bb424
--- /dev/null
+++ b/hw/9pfs/9p-util.c
@@ -0,0 +1,57 @@
+/*
+ * 9p utilities
+ *
+ * Copyright IBM, Corp. 2017
+ *
+ * Authors:
+ *  Greg Kurz <groug@kaod.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "9p-util.h"
+
+int relative_openat_nofollow(int dirfd, const char *path, int flags,
+                             mode_t mode)
+{
+    int fd;
+
+    fd = dup(dirfd);
+    if (fd == -1) {
+        return -1;
+    }
+
+    while (*path) {
+        const char *c;
+        int next_fd;
+        char *head;
+
+        /* Only relative paths without consecutive slashes */
+        assert(path[0] != '/');
+
+        head = g_strdup(path);
+        c = strchr(path, '/');
+        if (c) {
+            head[c - path] = 0;
+            next_fd = openat_dir(fd, head);
+        } else {
+            next_fd = openat_file(fd, head, flags, mode);
+        }
+        g_free(head);
+        if (next_fd == -1) {
+            close_preserve_errno(fd);
+            return -1;
+        }
+        close(fd);
+        fd = next_fd;
+
+        if (!c) {
+            break;
+        }
+        path = c + 1;
+    }
+
+    return fd;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
new file mode 100644
index 000000000000..e80b5a551d0a
--- /dev/null
+++ b/hw/9pfs/9p-util.h
@@ -0,0 +1,50 @@
+/*
+ * 9p utilities
+ *
+ * Copyright IBM, Corp. 2017
+ *
+ * Authors:
+ *  Greg Kurz <groug@kaod.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_9P_UTIL_H
+#define QEMU_9P_UTIL_H
+
+static inline void close_preserve_errno(int fd)
+{
+    int serrno = errno;
+    close(fd);
+    errno = serrno;
+}
+
+static inline int openat_dir(int dirfd, const char *name)
+{
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+}
+
+static inline int openat_file(int dirfd, const char *name, int flags,
+                              mode_t mode)
+{
+    int fd, serrno, ret;
+
+    fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
+                mode);
+    if (fd == -1) {
+        return -1;
+    }
+
+    serrno = errno;
+    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
+    ret = fcntl(fd, F_SETFL, flags);
+    assert(!ret);
+    errno = serrno;
+    return fd;
+}
+
+int relative_openat_nofollow(int dirfd, const char *path, int flags,
+                             mode_t mode);
+
+#endif
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index da0ae0cfdbae..32197e6671dd 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y  = 9p.o
+common-obj-y  = 9p.o 9p-util.o
 common-obj-y += 9p-local.o 9p-xattr.o
 common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
 common-obj-y += coth.o cofs.o codir.o cofile.o
-- 
2.7.4
