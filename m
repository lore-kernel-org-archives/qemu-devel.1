Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Ql-0001j4-B7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qf-0004xl-M3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qf-0004xC-Ey
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8ord008075
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:33 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a83d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:32 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:27 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-4-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 03/81] 9pfs: remove side-effects in
 local_open() and local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

If these functions fail, they should not change *fs. Let's use local
variables to fix this.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 21328e1e57f526e3f0c2fcd00f10c8aa6e7bc07f)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c88158f..5bb65eb 100644
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
