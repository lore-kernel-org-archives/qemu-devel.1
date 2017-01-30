Received: from eggs.gnu.org ([2001:4830:134:3::10]:45867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoB-00069W-PN
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAo8-0000Hd-LA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34295
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAo8-0000HZ-Fu
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8f6E014092
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:40 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a1ah1kcj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:39 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:11:38 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:31 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577829194.10533.6479531204742447036.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 15/36] 9pfs: remove side-effects in
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
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

If these functions fail, they should not change *fs. Let's use local
variables to fix this. While here, let's also do some cosmetic fixes
on the function args.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 443197841780..d3c6ccf30b53 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -351,30 +351,37 @@ static int local_closedir(FsContext *ctx, V9fsFidOpenState *fs)
     return closedir(fs->dir.stream);
 }
 
-static int local_open(FsContext *ctx, V9fsPath *fs_path,
-                      int flags, V9fsFidOpenState *fs)
+static int local_open(FsContext *ctx, V9fsPath *fs_path, int flags,
+                      V9fsFidOpenState *fs)
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
 
-static int local_opendir(FsContext *ctx,
-                         V9fsPath *fs_path, V9fsFidOpenState *fs)
+static int local_opendir(FsContext *ctx, V9fsPath *fs_path,
+                         V9fsFidOpenState *fs)
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
 
