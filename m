Received: from eggs.gnu.org ([2001:4830:134:3::10]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHl-0000Ye-PD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHk-0003zr-Po
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHk-0003yr-IV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMrbx0010739
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:51 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vp2342ev-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:51 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:06 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-17-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 16/31] 9pfs: local: utimensat: don't follow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 53a2fd50edbb..bab095353da7 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -959,13 +959,20 @@ static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
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
 
-- 
2.7.4
