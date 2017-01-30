Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoI-0006SY-RW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoF-0000IR-MQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoF-0000IF-D6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8rWp054304
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:46 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a37q5gef-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:46 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:11:45 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:39 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577829917.10533.8072749557307357453.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 16/36] 9pfs: introduce openat_nofollow()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

When using the passthrough security mode, symbolic links created by the
guest are actual symbolic links on the host file system.

Since the resolution of symbolic links during path walk is supposed to
occur on the client side. The server should never have to follow them.
The current code hence relies on O_NOFOLLOW and "l*()" variants of system
calls. Unfortunately, this only applies to the rightmost path component.
A guest could maliciously replace any component in a trusted path with a
symbolic link. This could allow any guest to escape a virtfs shared folder.

This patch introduces a variant of the openat() syscall that successively
opens each path element with O_NOFOLLOW. It will be used by subsequent
patches to implement symlink-safe path walk for any access to the backend.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.c     |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h     |   25 ++++++++++++++++++
 hw/9pfs/Makefile.objs |    2 +
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
new file mode 100644
index 000000000000..48292d948401
--- /dev/null
+++ b/hw/9pfs/9p-util.c
@@ -0,0 +1,69 @@
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
+int openat_nofollow(int dirfd, const char *path, int flags, mode_t mode)
+{
+    const char *tail = path;
+    const char *c;
+    int fd;
+
+    fd = dup(dirfd);
+    if (fd == -1) {
+        return -1;
+    }
+
+    while (*tail) {
+        int next_fd;
+        char *head;
+
+        while (*tail == '/') {
+            tail++;
+        }
+
+        if (!*tail) {
+            break;
+        }
+
+        head = g_strdup(tail);
+        c = strchr(tail, '/');
+        if (c) {
+            head[c - tail] = 0;
+            next_fd = openat(fd, head, O_DIRECTORY | O_RDONLY | O_NOFOLLOW);
+        } else {
+            /* We don't want bad things to happen like opening a file that
+             * sits outside the virtfs export, or hanging on a named pipe,
+             * or changing the controlling process of a terminal.
+             */
+            flags |= O_NOFOLLOW | O_NONBLOCK | O_NOCTTY;
+            next_fd = openat(fd, head, flags, mode);
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
+        tail = c + 1;
+    }
+    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
+    assert(!fcntl(fd, F_SETFL, flags));
+
+    return fd;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
new file mode 100644
index 000000000000..e19673d85222
--- /dev/null
+++ b/hw/9pfs/9p-util.h
@@ -0,0 +1,25 @@
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
+int openat_nofollow(int dirfd, const char *path, int flags, mode_t mode);
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
