Received: from eggs.gnu.org ([2001:4830:134:3::10]:54363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9l-0007Fw-GC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9i-0003qv-BR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp9i-0003qY-59
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdMQN134021
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:33 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qyr0y92a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:33 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:41:32 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:41:24 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760168489.31154.7921066936280376884.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 16/29] 9pfs: local: truncate: don't follow
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

The local_truncate() callback is vulnerable to symlink attacks because
it calls truncate() which follows symbolic links in all path elements.

This patch converts local_truncate() to rely on open_nofollow() and
ftruncate() instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ebc12f3c0691..da233198d032 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -888,13 +888,14 @@ err_out:
 
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
 
