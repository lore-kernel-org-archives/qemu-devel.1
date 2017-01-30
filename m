Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnh-0005MB-6J
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnd-0000CH-2Q
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAnc-0000Bo-QZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8gqb034301
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:07 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289td6wc4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:07 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:11:06 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:00 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577826039.10533.18022406834362954949.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 11/36] 9pfs: local: post rename operation
 for mapped-file security
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

The rename operation is really the same for the passthrough and mapped
security models. This patch simply moves the mapped-file bits to a
separate function. This will make future modifications easier.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index df453414c902..74953e4dbfe0 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1187,6 +1187,29 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
     return ret;
 }
 
+static int local_post_rename_mapped_file(FsContext *ctx, const char *oldpath,
+                                         const char *newpath)
+{
+    int err;
+    char *buffer, *buffer1;
+
+    err = local_create_mapped_attr_dir(ctx, newpath);
+    if (err < 0) {
+        return err;
+    }
+    /* rename the .virtfs_metadata files */
+    buffer = local_mapped_attr_path(ctx, oldpath);
+    buffer1 = local_mapped_attr_path(ctx, newpath);
+    err = rename(buffer, buffer1);
+    g_free(buffer);
+    g_free(buffer1);
+    if (err < 0 && errno != ENOENT) {
+        return err;
+    }
+
+    return 0;
+}
+
 static int local_rename(FsContext *ctx, const char *oldpath,
                         const char *newpath)
 {
@@ -1202,19 +1225,8 @@ static int local_rename(FsContext *ctx, const char *oldpath,
     }
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        char *vbuffer, *vbuffer1;
-
-        err = local_create_mapped_attr_dir(ctx, newpath);
+        err = local_post_rename_mapped_file(ctx, oldpath, newpath);
         if (err < 0) {
-            goto out_err;
-        }
-        /* rename the .virtfs_metadata files */
-        vbuffer = local_mapped_attr_path(ctx, oldpath);
-        vbuffer1 = local_mapped_attr_path(ctx, newpath);
-        err = rename(vbuffer, vbuffer1);
-        g_free(vbuffer);
-        g_free(vbuffer1);
-        if (err < 0 && errno != ENOENT) {
             goto err_out;
         }
     }
