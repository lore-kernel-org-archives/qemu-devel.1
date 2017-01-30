Received: from eggs.gnu.org ([2001:4830:134:3::10]:46766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYArZ-00010P-Dw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYArW-0001EU-9e
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:15:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41021
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYArW-0001E1-45
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:15:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCDpiS027919
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:15:09 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a1ah1qhv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:15:09 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:13:38 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:33 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577841334.10533.5674961039110977977.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 31/36] 9pfs: local: introduce
 symlink-attack safe xattr helpers
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

There are no "at" variants for xattr syscalls. This patch implement them
using a separate process.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c |  156 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-xattr.h |   11 ++++
 2 files changed, 167 insertions(+)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 19a2daf02f5c..ea0695f37242 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -15,7 +15,163 @@
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
+                data->ret = lsetxattr(path, name, data->value, size, flags);
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
+    memcpy(value, data->value, data->ret);
+
+err_out:
+    munmap_preserver_errno(data, sizeof(*data) + size);
+    return ret;
+}
+
+ssize_t fgetxattrat(int dirfd, const char *path, const char *name, void *value,
+                    size_t size)
+{
+    return do_xattrat_op(XATTRAT_OP_GET, dirfd, path, name, value, size, 0);
+}
+
+ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size)
+{
+    char *dirpath = local_dirname(path);
+    char *filename = local_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fgetxattrat(dirfd, filename, name, value, size);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
+
+static ssize_t fsetxattrat(int dirfd, const char *path, const char *name,
+                           void *value, size_t size, int flags)
+{
+    return do_xattrat_op(XATTRAT_OP_SET, dirfd, path, name, value, size, flags);
+}
+
+ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
+                                const char *name, void *value, size_t size,
+                                int flags)
+{
+    char *dirpath = local_dirname(path);
+    char *filename = local_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fsetxattrat(dirfd, filename, name, value, size, flags);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
+
+static ssize_t fremovexattrat(int dirfd, const char *path, const char *name)
+{
+    return do_xattrat_op(XATTRAT_OP_GET, dirfd, path, name, NULL, 0, 0);
+}
+
+ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
+                                   const char *name)
+{
+    char *dirpath = local_dirname(path);
+    char *filename = local_basename(path);
+    int dirfd;
+    ssize_t ret = -1;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = fremovexattrat(dirfd, filename, name);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(filename);
+    return ret;
+}
 
 static XattrOperations *get_xattr_operations(XattrOperations **h,
                                              const char *name)
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 3f43f5153f3c..d95ccc26a18d 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -15,6 +15,7 @@
 #define QEMU_9P_XATTR_H
 
 #include "qemu/xattr.h"
+#include "9p-local.h"
 
 typedef struct xattr_operations
 {
@@ -29,6 +30,16 @@ typedef struct xattr_operations
                        const char *path, const char *name);
 } XattrOperations;
 
+ssize_t fgetxattrat(int dirfd, const char *path, const char *name, void *value,
+                    size_t size);
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
