Received: from eggs.gnu.org ([2001:4830:134:3::10]:45633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnY-0005Cs-EV
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnV-00009l-BK
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAnV-00009W-1i
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8fEH003566
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:00 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a2r8xgrv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:59 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:10:58 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:52 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577825207.10533.10471571079961535708.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 10/36] v9fs: local: improve error handling
 in rename op
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

When using the mapped-file security model, we also have to rename the
metadata file if it exists. In case of failure, we should rollback.

To achieve that, this patch moves the renaming of the main file before
the renaming of the metadata file.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ebc3e208efa0..df453414c902 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1192,26 +1192,39 @@ static int local_rename(FsContext *ctx, const char *oldpath,
 {
     int err;
     char *buffer, *buffer1;
+    int serrno;
+
+    buffer = rpath(ctx, oldpath);
+    buffer1 = rpath(ctx, newpath);
+    err = rename(buffer, buffer1);
+    if (err < 0) {
+        goto out;
+    }
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        char *vbuffer, *vbuffer1;
+
         err = local_create_mapped_attr_dir(ctx, newpath);
         if (err < 0) {
-            return err;
+            goto out_err;
         }
         /* rename the .virtfs_metadata files */
-        buffer = local_mapped_attr_path(ctx, oldpath);
-        buffer1 = local_mapped_attr_path(ctx, newpath);
-        err = rename(buffer, buffer1);
-        g_free(buffer);
-        g_free(buffer1);
+        vbuffer = local_mapped_attr_path(ctx, oldpath);
+        vbuffer1 = local_mapped_attr_path(ctx, newpath);
+        err = rename(vbuffer, vbuffer1);
+        g_free(vbuffer);
+        g_free(vbuffer1);
         if (err < 0 && errno != ENOENT) {
-            return err;
+            goto err_out;
         }
     }
+    goto out;
 
-    buffer = rpath(ctx, oldpath);
-    buffer1 = rpath(ctx, newpath);
-    err = rename(buffer, buffer1);
+err_out:
+    serrno = errno;
+    rename(buffer1, buffer);
+    errno = serrno;
+out:
     g_free(buffer);
     g_free(buffer1);
     return err;
