Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp85-0005nD-TY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp82-0003TR-NY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33085
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp82-0003T3-HH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:50 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcrAm039743
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:49 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qv468be5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:49 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:39:48 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:39:42 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760158296.31154.15839087799468303034.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 03/29] 9pfs: remove side-effects in
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

If these functions fail, they should not change *fs. Let's use local
variables to fix this.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 55903e5d7745..c2239bfafce4 100644
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
 
