Received: from eggs.gnu.org ([2001:4830:134:3::10]:54275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9U-000705-RU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9R-0003oG-MI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54283
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp9R-0003o9-Fl
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdxJX036405
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:16 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pk560wf1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:16 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:41:15 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:41:08 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760166871.31154.9803071784073980223.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 14/29] 9pfs: local: utimensat: don't follow
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

The local_utimensat() callback is vulnerable to symlink attacks because it
calls qemu_utimens()->utimensat(AT_SYMLINK_NOFOLLOW) which follows symbolic
links in all path elements but the rightmost one or qemu_utimens()->utimes()
which follows symbolic links for all path elements.

This patch converts local_utimensat() to rely on opendir_nofollow() and
utimensat(AT_SYMLINK_NOFOLLOW) directly instead of using qemu_utimens().
It is hence assumed that the OS supports utimensat(), i.e. has glibc 2.6
or higher and linux 2.6.22 or higher, which seems reasonable nowadays.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c6f4c8d95442..7f3d9dd9a499 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -953,13 +953,20 @@ static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 static int local_utimensat(FsContext *s, V9fsPath *fs_path,
                            const struct timespec *buf)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    char *dirpath = g_path_get_dirname(fs_path->data);
+    char *name = g_path_get_basename(fs_path->data);
+    int dirfd, ret = -1;
 
-    buffer = rpath(s, path);
-    ret = qemu_utimens(buffer, buf);
-    g_free(buffer);
+    dirfd = local_opendir_nofollow(s, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = utimensat(dirfd, name, buf, AT_SYMLINK_NOFOLLOW);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(name);
     return ret;
 }
 
