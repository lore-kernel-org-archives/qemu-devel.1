Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHr-0000fQ-TS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHq-00047T-OI
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:01:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHq-00046Y-FD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMrjeG004766
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vpur1hp4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:56 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:53 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:12 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-23-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 22/31] 9pfs: local: rename: use renameat
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

The local_rename() callback is vulnerable to symlink attacks because it
uses rename() which follows symbolic links in all path elements but the
rightmost one.

This patch simply transforms local_rename() into a wrapper around
local_renameat() which is symlink-attack safe.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 57 ++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index cf9e03d8e64f..e7a7468a565b 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -964,36 +964,6 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
     return ret;
 }
 
-static int local_rename(FsContext *ctx, const char *oldpath,
-                        const char *newpath)
-{
-    int err;
-    char *buffer, *buffer1;
-
-    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = local_create_mapped_attr_dir(ctx, newpath);
-        if (err < 0) {
-            return err;
-        }
-        /* rename the .virtfs_metadata files */
-        buffer = local_mapped_attr_path(ctx, oldpath);
-        buffer1 = local_mapped_attr_path(ctx, newpath);
-        err = rename(buffer, buffer1);
-        g_free(buffer);
-        g_free(buffer1);
-        if (err < 0 && errno != ENOENT) {
-            return err;
-        }
-    }
-
-    buffer = rpath(ctx, oldpath);
-    buffer1 = rpath(ctx, newpath);
-    err = rename(buffer, buffer1);
-    g_free(buffer);
-    g_free(buffer1);
-    return err;
-}
-
 static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
     char *buffer;
@@ -1254,6 +1224,33 @@ out:
     return ret;
 }
 
+static void v9fs_path_init_dirname(V9fsPath *path, const char *str)
+{
+    path->data = g_path_get_dirname(str);
+    path->size = strlen(path->data) + 1;
+}
+
+static int local_rename(FsContext *ctx, const char *oldpath,
+                        const char *newpath)
+{
+    int err;
+    char *oname = g_path_get_basename(oldpath);
+    char *nname = g_path_get_basename(newpath);
+    V9fsPath olddir, newdir;
+
+    v9fs_path_init_dirname(&olddir, oldpath);
+    v9fs_path_init_dirname(&newdir, newpath);
+
+    err = local_renameat(ctx, &olddir, oname, &newdir, nname);
+
+    v9fs_path_free(&newdir);
+    v9fs_path_free(&olddir);
+    g_free(nname);
+    g_free(oname);
+
+    return err;
+}
+
 static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
                           const char *name, int flags)
 {
-- 
2.7.4
