Received: from eggs.gnu.org ([2001:4830:134:3::10]:54573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAP-000831-Na
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAM-0003yb-GK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59900
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpAM-0003yT-9H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEf2Zc143657
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:13 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r16cbesg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:13 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:42:10 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:04 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760172434.31154.8839343303639823770.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 21/29] 9pfs: local: improve error handling in
 link op
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

When using the mapped-file security model, we also have to create a link
for the metadata file if it exists. In case of failure, we should rollback.

That's what this patch does.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 15e746ede86a..9b9c39ee42ee 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -915,6 +915,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     int ret;
     V9fsString newpath;
     char *buffer, *buffer1;
+    int serrno;
 
     v9fs_string_init(&newpath);
     v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
@@ -923,25 +924,36 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     buffer1 = rpath(ctx, newpath.data);
     ret = link(buffer, buffer1);
     g_free(buffer);
-    g_free(buffer1);
+    if (ret < 0) {
+        goto out;
+    }
 
     /* now link the virtfs_metadata files */
-    if (!ret && (ctx->export_flags & V9FS_SM_MAPPED_FILE)) {
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        char *vbuffer, *vbuffer1;
+
         /* Link the .virtfs_metadata files. Create the metada directory */
         ret = local_create_mapped_attr_dir(ctx, newpath.data);
         if (ret < 0) {
             goto err_out;
         }
-        buffer = local_mapped_attr_path(ctx, oldpath->data);
-        buffer1 = local_mapped_attr_path(ctx, newpath.data);
-        ret = link(buffer, buffer1);
-        g_free(buffer);
-        g_free(buffer1);
+        vbuffer = local_mapped_attr_path(ctx, oldpath->data);
+        vbuffer1 = local_mapped_attr_path(ctx, newpath.data);
+        ret = link(vbuffer, vbuffer1);
+        g_free(vbuffer);
+        g_free(vbuffer1);
         if (ret < 0 && errno != ENOENT) {
             goto err_out;
         }
     }
+    goto out;
+
 err_out:
+    serrno = errno;
+    remove(buffer1);
+    errno = serrno;
+out:
+    g_free(buffer1);
     v9fs_string_free(&newpath);
     return ret;
 }
