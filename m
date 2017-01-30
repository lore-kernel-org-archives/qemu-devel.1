Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAq2-00080s-Mw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApz-0000u8-IR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApz-0000ts-8g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCDXED124107
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:34 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a119jbet-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:33 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:13:23 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:18 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577839886.10533.10574862245427162909.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 29/36] 9pfs: local: remove: don't follow
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
 hw/9pfs/9p-local.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 364da435350b..573852a55a00 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1432,8 +1432,17 @@ err_out:
 
 static int local_remove(FsContext *ctx, const char *path)
 {
-    int err;
-    char *buffer;
+    char *dirpath = local_dirname(path);
+    char *name = local_basename(path);
+    struct stat stbuf;
+    int flags = 0;
+    int err = -1;
+    int dirfd;
+
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd) {
+        goto out;
+    }
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         err =  local_pre_remove_mapped_file(ctx, path);
@@ -1442,10 +1451,19 @@ static int local_remove(FsContext *ctx, const char *path)
         }
     }
 
-    buffer = rpath(ctx, path);
-    err = remove(buffer);
-    g_free(buffer);
+    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+        goto err_out;
+    }
+    if (S_ISDIR(stbuf.st_mode)) {
+        flags |= AT_REMOVEDIR;
+    }
+
+    err = unlinkat(dirfd, name, flags);
 err_out:
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
     return err;
 }
 
