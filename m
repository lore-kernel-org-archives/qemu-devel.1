Received: from eggs.gnu.org ([2001:4830:134:3::10]:53930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8V-0006CA-TE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8S-0003bZ-NQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54739
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp8S-0003bL-Gm
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdOos134137
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:15 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qyr0y72n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:15 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:40:14 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:40:07 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760160738.31154.14112432972227976652.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 06/29] 9pfs: local: open/opendir: don't follow
 symlinks
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

The local_open() and local_opendir() callbacks are vulnerable to symlink
attacks because they call:

(1) open(O_NOFOLLOW) which follows symbolic links in all path elements but
    the rightmost one
(2) opendir() which follows symbolic links in all path elements

This patch converts both callbacks to use new helpers based on
openat_nofollow() to only open files and directories if they are
below the virtfs shared folder

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   31 +++++++++++++++++++++----------
 hw/9pfs/9p-local.h |   20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 8aee7f2516ed..26ea72c66306 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "9p.h"
+#include "9p-local.h"
 #include "9p-xattr.h"
 #include "9p-util.h"
 #include "fsdev/qemu-fsdev.h"   /* local_ops */
@@ -48,6 +49,18 @@ struct local_data {
     int mountfd;
 };
 
+int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
+                        mode_t mode)
+{
+    struct local_data *data = fs_ctx->private;
+    return openat_nofollow(data->mountfd, path, flags, mode);
+}
+
+int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
+{
+    return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -359,13 +372,9 @@ static int local_closedir(FsContext *ctx, V9fsFidOpenState *fs)
 static int local_open(FsContext *ctx, V9fsPath *fs_path,
                       int flags, V9fsFidOpenState *fs)
 {
-    char *buffer;
-    char *path = fs_path->data;
     int fd;
 
-    buffer = rpath(ctx, path);
-    fd = open(buffer, flags | O_NOFOLLOW);
-    g_free(buffer);
+    fd = local_open_nofollow(ctx, fs_path->data, flags, 0);
     if (fd == -1) {
         return -1;
     }
@@ -376,13 +385,15 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path,
 static int local_opendir(FsContext *ctx,
                          V9fsPath *fs_path, V9fsFidOpenState *fs)
 {
-    char *buffer;
-    char *path = fs_path->data;
+    int dirfd;
     DIR *stream;
 
-    buffer = rpath(ctx, path);
-    stream = opendir(buffer);
-    g_free(buffer);
+    dirfd = local_opendir_nofollow(ctx, fs_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
+
+    stream = fdopendir(dirfd);
     if (!stream) {
         return -1;
     }
diff --git a/hw/9pfs/9p-local.h b/hw/9pfs/9p-local.h
new file mode 100644
index 000000000000..32c72749d9df
--- /dev/null
+++ b/hw/9pfs/9p-local.h
@@ -0,0 +1,20 @@
+/*
+ * 9p local backend utilities
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
+#ifndef QEMU_9P_LOCAL_H
+#define QEMU_9P_LOCAL_H
+
+int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
+                        mode_t mode);
+int local_opendir_nofollow(FsContext *fs_ctx, const char *path);
+
+#endif
