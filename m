Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHg-0000TS-PF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHd-0003pz-L3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHd-0003p0-BD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMxc06038657
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:44 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vnahedjj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:43 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:41 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Feb 2017 23:59:57 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-8-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 07/31] 9pfs: introduce
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
 assert path is relative, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.c     | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h     | 49 ++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/Makefile.objs |  2 +-
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
new file mode 100644
index 000000000000..4329a638cded
--- /dev/null
+++ b/hw/9pfs/9p-util.c
@@ -0,0 +1,56 @@
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
+    assert(path[0] != '/');
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
index 000000000000..e3d5b66a15bc
--- /dev/null
+++ b/hw/9pfs/9p-util.h
@@ -0,0 +1,49 @@
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
+    int fd, serrno;
+
+    fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
+                mode);
+    if (fd == -1) {
+        return -1;
+    }
+
+    serrno = errno;
+    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
+    assert(!fcntl(fd, F_SETFL, flags));
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
