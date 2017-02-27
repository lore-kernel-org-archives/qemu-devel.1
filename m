Received: from eggs.gnu.org ([2001:4830:134:3::10]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHk-0000Wt-2o
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHh-0003uy-3g
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32871
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHg-0003na-TQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:49 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMra7K121509
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:42 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vn69xxk8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:41 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:40 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Feb 2017 23:59:54 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 04/31] 9pfs: local: move xattr security ops to
 9p-xattr.c
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

These functions are always called indirectly. It really doesn't make sense
for them to sit in a header file.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-xattr.c | 61 +++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-xattr.h | 80 ++++++++++--------------------------------------------
 2 files changed, 75 insertions(+), 66 deletions(-)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 5d8595ed932a..19a2daf02f5c 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -143,6 +143,67 @@ int v9fs_remove_xattr(FsContext *ctx,
 
 }
 
+ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
+                    void *value, size_t size)
+{
+    char *buffer;
+    ssize_t ret;
+
+    buffer = rpath(ctx, path);
+    ret = lgetxattr(buffer, name, value, size);
+    g_free(buffer);
+    return ret;
+}
+
+int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
+                size_t size, int flags)
+{
+    char *buffer;
+    int ret;
+
+    buffer = rpath(ctx, path);
+    ret = lsetxattr(buffer, name, value, size, flags);
+    g_free(buffer);
+    return ret;
+}
+
+int pt_removexattr(FsContext *ctx, const char *path, const char *name)
+{
+    char *buffer;
+    int ret;
+
+    buffer = rpath(ctx, path);
+    ret = lremovexattr(path, name);
+    g_free(buffer);
+    return ret;
+}
+
+ssize_t notsup_getxattr(FsContext *ctx, const char *path, const char *name,
+                        void *value, size_t size)
+{
+    errno = ENOTSUP;
+    return -1;
+}
+
+int notsup_setxattr(FsContext *ctx, const char *path, const char *name,
+                    void *value, size_t size, int flags)
+{
+    errno = ENOTSUP;
+    return -1;
+}
+
+ssize_t notsup_listxattr(FsContext *ctx, const char *path, char *name,
+                         void *value, size_t size)
+{
+    return 0;
+}
+
+int notsup_removexattr(FsContext *ctx, const char *path, const char *name)
+{
+    errno = ENOTSUP;
+    return -1;
+}
+
 XattrOperations *mapped_xattr_ops[] = {
     &mapped_user_xattr,
     &mapped_pacl_xattr,
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index a853ea641c0b..3f43f5153f3c 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -49,73 +49,21 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path, void *value,
 int v9fs_set_xattr(FsContext *ctx, const char *path, const char *name,
                           void *value, size_t size, int flags);
 int v9fs_remove_xattr(FsContext *ctx, const char *path, const char *name);
+
 ssize_t pt_listxattr(FsContext *ctx, const char *path, char *name, void *value,
                      size_t size);
-
-static inline ssize_t pt_getxattr(FsContext *ctx, const char *path,
-                                  const char *name, void *value, size_t size)
-{
-    char *buffer;
-    ssize_t ret;
-
-    buffer = rpath(ctx, path);
-    ret = lgetxattr(buffer, name, value, size);
-    g_free(buffer);
-    return ret;
-}
-
-static inline int pt_setxattr(FsContext *ctx, const char *path,
-                              const char *name, void *value,
-                              size_t size, int flags)
-{
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lsetxattr(buffer, name, value, size, flags);
-    g_free(buffer);
-    return ret;
-}
-
-static inline int pt_removexattr(FsContext *ctx,
-                                 const char *path, const char *name)
-{
-    char *buffer;
-    int ret;
-
-    buffer = rpath(ctx, path);
-    ret = lremovexattr(path, name);
-    g_free(buffer);
-    return ret;
-}
-
-static inline ssize_t notsup_getxattr(FsContext *ctx, const char *path,
-                                      const char *name, void *value,
-                                      size_t size)
-{
-    errno = ENOTSUP;
-    return -1;
-}
-
-static inline int notsup_setxattr(FsContext *ctx, const char *path,
-                                  const char *name, void *value,
-                                  size_t size, int flags)
-{
-    errno = ENOTSUP;
-    return -1;
-}
-
-static inline ssize_t notsup_listxattr(FsContext *ctx, const char *path,
-                                       char *name, void *value, size_t size)
-{
-    return 0;
-}
-
-static inline int notsup_removexattr(FsContext *ctx,
-                                     const char *path, const char *name)
-{
-    errno = ENOTSUP;
-    return -1;
-}
+ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
+                    void *value, size_t size);
+int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
+                size_t size, int flags);
+int pt_removexattr(FsContext *ctx, const char *path, const char *name);
+
+ssize_t notsup_getxattr(FsContext *ctx, const char *path, const char *name,
+                        void *value, size_t size);
+int notsup_setxattr(FsContext *ctx, const char *path, const char *name,
+                    void *value, size_t size, int flags);
+ssize_t notsup_listxattr(FsContext *ctx, const char *path, char *name,
+                         void *value, size_t size);
+int notsup_removexattr(FsContext *ctx, const char *path, const char *name);
 
 #endif
-- 
2.7.4
