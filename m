Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAq2-00080c-Ej
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApz-0000u1-B3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApz-0000tq-1C
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCDT2w070476
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:34 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a37q5jp7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:33 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:13:32 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:26 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577840610.10533.2634768103867614069.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 30/36] 9pfs: local: unlinkat: don't follow
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
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for the "passthrough" and "mapped" security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 573852a55a00..60edfb25f8a5 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1609,25 +1609,23 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir, const char *name,
                           int flags)
 {
     int ret;
-    V9fsString fullname;
-    char *buffer;
+    int dirfd;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir->data, name);
+    dirfd = local_opendir_nofollow(ctx, dir->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         ret = local_pre_unlinkat_mapped_file(ctx, dir, name, flags);
-        if (ret < 0) {
+        if (ret) {
             goto err_out;
         }
     }
-    /* Remove the name finally */
-    buffer = rpath(ctx, fullname.data);
-    ret = remove(buffer);
-    g_free(buffer);
 
+    ret = unlinkat(dirfd, name, flags);
 err_out:
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return ret;
 }
 
