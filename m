Received: from eggs.gnu.org ([2001:4830:134:3::10]:41838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R5-00026J-JR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qv-0005Fx-3G
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47291
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qu-0005Eh-Qq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Wlm084383
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2abbt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:47 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:30 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-7-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 06/81] 9pfs: local: open/opendir: don't follow
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 996a0d76d7e756e4023ef79bc37bfe629b9eaca7)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 37 +++++++++++++++++++++++++++----------
 hw/9pfs/9p-local.h | 20 ++++++++++++++++++++
 2 files changed, 47 insertions(+), 10 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 12fc4fc..3a2b659 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "9p.h"
+#include "9p-local.h"
 #include "9p-xattr.h"
 #include "9p-util.h"
 #include "fsdev/qemu-fsdev.h"   /* local_ops */
@@ -48,6 +49,24 @@ typedef struct {
     int mountfd;
 } LocalData;
 
+int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
+                        mode_t mode)
+{
+    LocalData *data = fs_ctx->private;
+
+    /* All paths are relative to the path data->mountfd points to */
+    while (*path == '/') {
+        path++;
+    }
+
+    return relative_openat_nofollow(data->mountfd, path, flags, mode);
+}
+
+int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
+{
+    return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -359,13 +378,9 @@ static int local_closedir(FsContext *ctx, V9fsFidOpenState *fs)
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
@@ -376,13 +391,15 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path,
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
index 0000000..32c7274
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
-- 
2.7.4
