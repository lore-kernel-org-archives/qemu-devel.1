Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp7r-0005b5-AT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp7o-0003PA-4k
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp7n-0003P1-RK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcrWT128178
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:34 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6mtf7e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:33 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:39:33 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:39:26 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760156667.31154.17134759490866240142.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 01/29] 9pfs: local: move xattr security ops to
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

These functions are always called indirectly. It really doesn't make sense
for them to sit in a header file.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c |   61 ++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-xattr.h |   80 +++++++++-------------------------------------------
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
