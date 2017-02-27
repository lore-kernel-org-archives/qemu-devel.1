Received: from eggs.gnu.org ([2001:4830:134:3::10]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHi-0000Uc-1e
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHe-0003ra-TO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHe-0003qP-KT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMra3c107556
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:45 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vm1w2u7c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:45 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:42 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Feb 2017 23:59:56 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-7-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 06/31] 9pfs: remove side-effects in local_open()
 and local_opendir()
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

If these functions fail, they should not change *fs. Let's use local
variables to fix this.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1ede63f57772..6b2ebbc631bd 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -356,10 +356,15 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path,
 {
     char *buffer;
     char *path = fs_path->data;
+    int fd;
 
     buffer = rpath(ctx, path);
-    fs->fd = open(buffer, flags | O_NOFOLLOW);
+    fd = open(buffer, flags | O_NOFOLLOW);
     g_free(buffer);
+    if (fd == -1) {
+        return -1;
+    }
+    fs->fd = fd;
     return fs->fd;
 }
 
@@ -368,13 +373,15 @@ static int local_opendir(FsContext *ctx,
 {
     char *buffer;
     char *path = fs_path->data;
+    DIR *stream;
 
     buffer = rpath(ctx, path);
-    fs->dir.stream = opendir(buffer);
+    stream = opendir(buffer);
     g_free(buffer);
-    if (!fs->dir.stream) {
+    if (!stream) {
         return -1;
     }
+    fs->dir.stream = stream;
     return 0;
 }
 
-- 
2.7.4
