Received: from eggs.gnu.org ([2001:4830:134:3::10]:57028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk4-00022T-PL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk0-0000RR-NC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwk0-0000Mg-Du
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJd1N050105
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5fmx3p9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:11 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:09 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:15 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-4-groug@kaod.org>
Subject: [Qemu-devel] [PULL 3/7] 9p: Move a couple xattr functions to 9p-util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

These functions will need custom implementations on Darwin. Since the
implementation is very similar among all of them, and 9p-util already
has the _nofollow version of fgetxattrat, let's move them all there.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.c  | 33 +++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h  |  4 ++++
 hw/9pfs/9p-xattr.c | 33 ---------------------------------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index f709c27a1fbd..614b7fc34d54 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -24,3 +24,36 @@ ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
     g_free(proc_path);
     return ret;
 }
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = llistxattr(proc_path, list, size);
+    g_free(proc_path);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lremovexattr(proc_path, name);
+    g_free(proc_path);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lsetxattr(proc_path, name, value, size, flags);
+    g_free(proc_path);
+    return ret;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index dc0d2e29aa3b..79ed6b233e58 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -60,5 +60,9 @@ ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
 int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
                          void *value, size_t size, int flags);
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size);
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name);
 
 #endif
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index d05c1a1c1df5..c696d8f8460f 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -60,17 +60,6 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
     return name_size;
 }
 
-static ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
-                                     char *list, size_t size)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = llistxattr(proc_path, list, size);
-    g_free(proc_path);
-    return ret;
-}
-
 /*
  * Get the list and pass to each layer to find out whether
  * to send the data or not
@@ -196,17 +185,6 @@ ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
     return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
-int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
-                         void *value, size_t size, int flags)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lsetxattr(proc_path, name, value, size, flags);
-    g_free(proc_path);
-    return ret;
-}
-
 ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size,
                                 int flags)
@@ -235,17 +213,6 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
     return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
-static ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
-                                       const char *name)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lremovexattr(proc_path, name);
-    g_free(proc_path);
-    return ret;
-}
-
 ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
                                    const char *name)
 {
-- 
2.14.4
