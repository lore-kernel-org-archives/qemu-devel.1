Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoW-0006ej-Q0
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoT-0000Ji-MF
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoT-0000Ja-CX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8ftk030932
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:00 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289sqx6d3s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:59 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:11:58 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:53 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577831373.10533.9110148699067276025.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 18/36] 9pfs: local: open/opendir: don't
 follow symlinks
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

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   31 +++++++++++++++++++++----------
 hw/9pfs/9p-local.h |   20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 8a1d52cd6c2a..783b4006ffd4 100644
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
 static int local_open(FsContext *ctx, V9fsPath *fs_path, int flags,
                       V9fsFidOpenState *fs)
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
@@ -376,13 +385,15 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path, int flags,
 static int local_opendir(FsContext *ctx, V9fsPath *fs_path,
                          V9fsFidOpenState *fs)
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
