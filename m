Received: from eggs.gnu.org ([2001:4830:134:3::10]:46237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApW-0007YA-7e
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApT-0000mt-4a
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48851
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApS-0000ml-Ux
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:03 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8e7Z067052
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:02 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a55t8anq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:02 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:13:01 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:56 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577837661.10533.13840786403158188038.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 26/36] 9pfs: local: chown: don't follow
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
 hw/9pfs/9p-local.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index bbc08184564f..5e320917c484 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1287,13 +1287,21 @@ out:
 static int local_chown_passthrough(FsContext *fs_ctx, V9fsPath *fs_path,
                                    FsCred *credp)
 {
-    char *buffer;
-    int ret = -1;
-    char *path = fs_path->data;
+    char *dirpath = local_dirname(fs_path->data);
+    char *name = local_basename(fs_path->data);
+    int dirfd, ret = -1;
 
-    buffer = rpath(fs_ctx, path);
-    ret = lchown(buffer, credp->fc_uid, credp->fc_gid);
-    g_free(buffer);
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+    ret = fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                   AT_SYMLINK_NOFOLLOW);
+    close_preserve_errno(dirfd);
+
+out:
+    g_free(name);
+    g_free(dirpath);
     return ret;
 }
 
