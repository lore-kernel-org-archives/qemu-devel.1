Received: from eggs.gnu.org ([2001:4830:134:3::10]:45580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnP-00055P-7T
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnM-00008x-2S
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53111
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAnL-00008p-UL
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC9FaK062080
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:51 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a32f5xw5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:51 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:10:50 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:44 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577824407.10533.8056765551994230024.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 09/36] 9pfs: local: post link operation for
 mapped-file security
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

The link operation is really the same for the passthrough and mapped
security models. This patch simply moves the mapped-file bits to a
separate function. This will make future modifications easier.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c0b1907f7901..ebc3e208efa0 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1108,6 +1108,35 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
     g_assert_not_reached();
 }
 
+static int local_post_link_mapped_file(FsContext *ctx, V9fsPath *oldpath,
+                                       V9fsPath *dirpath, const char *name)
+{
+    int ret;
+    V9fsString newpath;
+    char *buffer, *buffer1;
+
+    v9fs_string_init(&newpath);
+    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
+
+    /* Link the .virtfs_metadata files. Create the metada directory */
+    ret = local_create_mapped_attr_dir(ctx, newpath.data);
+    if (ret < 0) {
+        goto out;
+    }
+    buffer = local_mapped_attr_path(ctx, oldpath->data);
+    buffer1 = local_mapped_attr_path(ctx, newpath.data);
+    ret = link(buffer, buffer1);
+    g_free(buffer);
+    g_free(buffer1);
+    if (ret < 0 && errno == ENOENT) {
+        ret = 0;
+    }
+
+out:
+    v9fs_string_free(&newpath);
+    return ret;
+}
+
 static int local_link(FsContext *ctx, V9fsPath *oldpath,
                       V9fsPath *dirpath, const char *name)
 {
@@ -1129,21 +1158,10 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
 
     /* now link the virtfs_metadata files */
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        char *vbuffer, *vbuffer1;
-
-        /* Link the .virtfs_metadata files. Create the metada directory */
-        ret = local_create_mapped_attr_dir(ctx, newpath.data);
+        ret = local_post_link_mapped_file(ctx, oldpath, dirpath, name);
         if (ret < 0) {
             goto err_out;
         }
-        vbuffer = local_mapped_attr_path(ctx, oldpath->data);
-        vbuffer1 = local_mapped_attr_path(ctx, newpath.data);
-        ret = link(vbuffer, vbuffer1);
-        g_free(vbuffer);
-        g_free(vbuffer1);
-        if (ret < 0 && errno != ENOENT) {
-            goto err_out;
-        }
     }
     goto out;
 
