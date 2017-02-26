Received: from eggs.gnu.org ([2001:4830:134:3::10]:50727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Xa-000697-UC
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7XX-0002z4-RR
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58977
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7XX-0002yv-Kj
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:43:39 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMcQep123786
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:43:38 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28uqvksrgn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:43:38 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 17:43:38 -0500
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:43:32 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814901272.28146.1801619285977185367.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 15/28] 9pfs: local: truncate: don't follow
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
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

The local_truncate() callback is vulnerable to symlink attacks because
it calls truncate() which follows symbolic links in all path elements.

This patch converts local_truncate() to rely on open_nofollow() and
ftruncate() instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e88426dfebe5..1d460a35aa7f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -894,13 +894,14 @@ err_out:
 
 static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    int fd, ret;
 
-    buffer = rpath(ctx, path);
-    ret = truncate(buffer, size);
-    g_free(buffer);
+    fd = local_open_nofollow(ctx, fs_path->data, O_WRONLY, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = ftruncate(fd, size);
+    close_preserve_errno(fd);
     return ret;
 }
 
