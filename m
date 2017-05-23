Received: from eggs.gnu.org ([2001:4830:134:3::10]:46429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArf-0002sd-PP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArb-0008Ie-Ma
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDArb-0008H3-Cy
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NEUQCC006252
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:42 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2am9af3k9b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:41 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 23 May 2017 10:32:40 -0400
From: Greg Kurz <groug@kaod.org>
Date: Tue, 23 May 2017 16:32:36 +0200
In-Reply-To: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/4] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

The logic to open a path currently sits between local_open_nofollow() and
the relative_openat_nofollow() helper, which has no other user.

For the sake of clarity, this patch moves all the code of the helper into
its unique caller. While here we also:
- drop the code to skip leading "/" because the backend isn't supposed to
  pass anything but relative paths without consecutive slashes. The assert()
  is kept because we really don't want a buggy backend to pass   an absolute
  path to openat().
- use strchrnul() to get a simpler code. This is ok since virtfs if for
  linux+glibc hosts only.
- don't dup() the initial directory and add an assert() to ensure we don't
  return the global mountfd to the caller. BTW, this would mean that the
  caller passed an empty path, which isn't supposed to happen either.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - rewrite logic directly in local_open_nofollow()
---
 hw/9pfs/9p-local.c |   34 +++++++++++++++++++++++++++++-----
 hw/9pfs/9p-util.c  |   43 -------------------------------------------
 hw/9pfs/9p-util.h  |    2 --
 3 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4da77ef1bc35..b30f68f91026 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -53,13 +53,37 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
                         mode_t mode)
 {
     LocalData *data = fs_ctx->private;
-
-    /* All paths are relative to the path data->mountfd points to */
-    while (*path == '/') {
-        path++;
+    int fd = data->mountfd;
+
+    while (*path && fd != -1) {
+        const char *c;
+        int next_fd;
+        char *head;
+
+        /* Only relative paths without consecutive slashes */
+        assert(*path != '/');
+
+        head = g_strdup(path);
+        c = strchrnul(path, '/');
+        if (*c) {
+            /* Intermediate path element */
+            head[c - path] = 0;
+            path = c + 1;
+            next_fd = openat_dir(fd, head);
+        } else {
+            /* Rightmost path element */
+            next_fd = openat_file(fd, head, flags, mode);
+            path = c;
+        }
+        g_free(head);
+        if (fd != data->mountfd) {
+            close_preserve_errno(fd);
+        }
+        fd = next_fd;
     }
 
-    return relative_openat_nofollow(data->mountfd, path, flags, mode);
+    assert(fd != data->mountfd);
+    return fd;
 }
 
 int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index fdb4d5737635..f709c27a1fbd 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -14,49 +14,6 @@
 #include "qemu/xattr.h"
 #include "9p-util.h"
 
-int relative_openat_nofollow(int dirfd, const char *path, int flags,
-                             mode_t mode)
-{
-    int fd;
-
-    fd = dup(dirfd);
-    if (fd == -1) {
-        return -1;
-    }
-
-    while (*path) {
-        const char *c;
-        int next_fd;
-        char *head;
-
-        /* Only relative paths without consecutive slashes */
-        assert(path[0] != '/');
-
-        head = g_strdup(path);
-        c = strchr(path, '/');
-        if (c) {
-            head[c - path] = 0;
-            next_fd = openat_dir(fd, head);
-        } else {
-            next_fd = openat_file(fd, head, flags, mode);
-        }
-        g_free(head);
-        if (next_fd == -1) {
-            close_preserve_errno(fd);
-            return -1;
-        }
-        close(fd);
-        fd = next_fd;
-
-        if (!c) {
-            break;
-        }
-        path = c + 1;
-    }
-
-    return fd;
-}
-
 ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
                              void *value, size_t size)
 {
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 517027c52032..91299a24b8af 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -50,8 +50,6 @@ static inline int openat_file(int dirfd, const char *name, int flags,
     return fd;
 }
 
-int relative_openat_nofollow(int dirfd, const char *path, int flags,
-                             mode_t mode);
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
 int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
