Received: from eggs.gnu.org ([2001:4830:134:3::10]:40404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0001RZ-NK
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QU-0004kW-NH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39575
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QU-0004jq-Fg
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8ahG119484
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:22 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfe8nhn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:21 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:21 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:43 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-20-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 19/81] 9pfs: local: rename: use renameat
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

The local_rename() callback is vulnerable to symlink attacks because it
uses rename() which follows symbolic links in all path elements but the
rightmost one.

This patch simply transforms local_rename() into a wrapper around
local_renameat() which is symlink-attack safe.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit d2767edec582558f1e6c52e1dd9370d62e2b30fc)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 57 ++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f2adf25..8b233b0 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -965,36 +965,6 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
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
@@ -1255,6 +1225,33 @@ out:
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
