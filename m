Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApH-0007KO-B6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApE-0000YI-6y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47168
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApE-0000YB-1v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCBt1X049159
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:47 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289ywycf46-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:47 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:46 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:40 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577836031.10533.8928961441761633594.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 24/36] 9pfs: local: chmod: don't follow
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

This fixes CVE-2016-9602 for the "passthrough" security model.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 48d46b6abd28..9dfa3e306245 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -551,13 +551,14 @@ static int local_chmod_mapped(FsContext *fs_ctx, V9fsPath *fs_path,
 static int local_chmod_passthrough(FsContext *fs_ctx, V9fsPath *fs_path,
                                    FsCred *credp)
 {
-    char *buffer;
-    int ret = -1;
-    char *path = fs_path->data;
+    int fd, ret;
 
-    buffer = rpath(fs_ctx, path);
-    ret = chmod(buffer, credp->fc_mode);
-    g_free(buffer);
+    fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = fchmod(fd, credp->fc_mode);
+    close_preserve_errno(fd);
 
     return ret;
 }
