Received: from eggs.gnu.org ([2001:4830:134:3::10]:46906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHm-0000ZH-5z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHj-0003xa-3k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45953
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHi-0003wi-Ry
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMraYf126105
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vs23tg5q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:49 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:07 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-18-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 17/31] 9pfs: local: statfs: don't follow symlinks
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

The local_statfs() callback is vulnerable to symlink attacks because it
calls statfs() which follows symbolic links in all path elements.

This patch converts local_statfs() to rely on open_nofollow() and fstatfs()
instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index bab095353da7..ae5d26821791 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1077,13 +1077,11 @@ static int local_fsync(FsContext *ctx, int fid_type,
 
 static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    int fd, ret;
 
-    buffer = rpath(s, path);
-    ret = statfs(buffer, stbuf);
-    g_free(buffer);
+    fd = local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
+    ret = fstatfs(fd, stbuf);
+    close_preserve_errno(fd);
     return ret;
 }
 
-- 
2.7.4
