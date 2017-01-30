Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAou-00070r-Jw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAor-0000MK-FS
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAor-0000MB-5g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8hOO108532
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:24 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a119ja4b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:23 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:22 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:16 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577833622.10533.8966272817310574456.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 21/36] 9pfs: local: truncate: don't follow
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

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1f9239de07e5..4377aa6524c2 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1231,15 +1231,16 @@ out:
     return ret;
 }
 
-static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
+static int local_truncate(FsContext *fs_ctx, V9fsPath *fs_path, off_t size)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    int fd, ret;
 
-    buffer = rpath(ctx, path);
-    ret = truncate(buffer, size);
-    g_free(buffer);
+    fd = local_open_nofollow(fs_ctx, fs_path->data, O_WRONLY, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = ftruncate(fd, size);
+    close_preserve_errno(fd);
     return ret;
 }
 
