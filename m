Received: from eggs.gnu.org ([2001:4830:134:3::10]:54005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8f-0006Kl-W7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8c-0003df-Pf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp8c-0003dK-FM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEd4A0025271
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:25 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qvbyfpdn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:25 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:40:23 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:40:15 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760161575.31154.505252736798591155.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce symlink-attack
 safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

All operations dealing with extended attributes are vulnerable to symlink
attacks because they use path-based syscalls which can traverse symbolic
links while walking through the dirname part of the path.

The solution is to introduce helpers based on opendir_nofollow(). This
calls for "at" versions of the extended attribute syscalls, which don't
exist unfortunately. This patch implement them by simulating the "at"
behavior with fchdir(). Since the current working directory is process
wide, and we don't want to confuse another thread in QEMU, all the work
is done in a separate process.

The extended attributes code spreads over several files: all helpers
are hence declared with external linkage in 9p-xattr.h.

Note that the listxattr-based code is fully contained in 9p-xattr.c: the
flistxattrat_nofollow() helper is added in a subsequent patch.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c |  158 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-xattr.h |   13 ++++
 2 files changed, 171 insertions(+)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 19a2daf02f5c..62993624ff64 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -15,7 +15,165 @@
 #include "9p.h"
 #include "fsdev/file-op-9p.h"
 #include "9p-xattr.h"
+#include "9p-util.h"
 
+enum {
+    XATTRAT_OP_GET = 0,
+    XATTRAT_OP_LIST,
+    XATTRAT_OP_SET,
+    XATTRAT_OP_REMOVE
+};
+
+struct xattrat_data {
+    ssize_t ret;
+    int serrno;
+    char value[0];
+};
+
+static void munmap_preserver_errno(void *addr, size_t length)
+{
+    int serrno = errno;
+    munmap(addr, length);
+    errno = serrno;
+}
+
+static ssize_t do_xattrat_op(int op_type, int dirfd, const char *path,
+                             const char *name, void *value, size_t size,
+                             int flags)
+{
+    struct xattrat_data *data;
+    pid_t pid;
+    ssize_t ret = -1;
+    int wstatus;
+
+    data = mmap(NULL, sizeof(*data) + size, PROT_READ | PROT_WRITE,
+                MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (data == MAP_FAILED) {
+        return -1;
+    }
+    data->ret = -1;
+
+    pid = fork();
+    if (pid < 0) {
+        goto err_out;
+    } else if (pid == 0) {
+        if (fchdir(dirfd) == 0) {
+            switch (op_type) {
+            case XATTRAT_OP_GET:
+                data->ret = lgetxattr(path, name, data->value, size);
+                break;
+            case XATTRAT_OP_LIST:
+                data->ret = llistxattr(path, data->value, size);
+                break;
+            case XATTRAT_OP_SET:
+                data->ret = lsetxattr(path, name, value, size, flags);
+                break;
+            case XATTRAT_OP_REMOVE:
+                data->ret = lremovexattr(path, name);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        data->serrno = errno;
+        _exit(0);
+    }
+    assert(waitpid(pid, &wstatus, 0) == pid && WIFEXITED(wstatus));
+
+    ret = data->ret;
+    if (ret < 0) {
+        errno = data->serrno;
+        goto err_out;
+    }
+    if (value) {
+        memcpy(value, data->value, data->ret);
+    }
+err_out:
+    munmap_preserver_errno(data, sizeof(*data) + size);
+    return ret;
+}
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                             void *value, size_t size)
+{
+    return do_xattrat_op(XATTRAT_OP_GET, dirfd, path, name, value, size, 0);
+}
+
+ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size)
+{
+    char *dirpath = g_path_get_dirname(path);
+    char *filename = g_path_get_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fgetxattrat_nofollow(dirfd, filename, name, value, size);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                         void *value, size_t size, int flags)
+{
+    return do_xattrat_op(XATTRAT_OP_SET, dirfd, path, name, value, size, flags);
+}
+
+ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size,
+                                int flags)
+{
+    char *dirpath = g_path_get_dirname(path);
+    char *filename = g_path_get_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fsetxattrat_nofollow(dirfd, filename, name, value, size, flags);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
+
+static ssize_t fremovexattrat_nofollow(int dirfd, const char *path,
+                                       const char *name)
+{
+    return do_xattrat_op(XATTRAT_OP_GET, dirfd, path, name, NULL, 0, 0);
+}
+
+ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
+                                   const char *name)
+{
+    char *dirpath = g_path_get_dirname(path);
+    char *filename = g_path_get_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fremovexattrat_nofollow(dirfd, filename, name);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
 
 static XattrOperations *get_xattr_operations(XattrOperations **h,
                                              const char *name)
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 3f43f5153f3c..986cb59b67f2 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -15,6 +15,7 @@
 #define QEMU_9P_XATTR_H
 
 #include "qemu/xattr.h"
+#include "9p-local.h"
 
 typedef struct xattr_operations
 {
@@ -29,6 +30,18 @@ typedef struct xattr_operations
                        const char *path, const char *name);
 } XattrOperations;
 
+ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                             void *value, size_t size);
+int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                         void *value, size_t size, int flags);
+
+ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size);
+ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size,
+                                int flags);
+ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
+                                   const char *name);
 
 extern XattrOperations mapped_user_xattr;
 extern XattrOperations passthrough_user_xattr;
