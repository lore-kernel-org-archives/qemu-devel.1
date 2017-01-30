Received: from eggs.gnu.org ([2001:4830:134:3::10]:46045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAp1-00076R-LU
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoy-0000RK-IQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47749
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoy-0000Qm-BW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8eWH067034
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:31 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a55t8a1a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:31 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:30 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:24 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577834437.10533.5012543630937224810.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 22/36] 9pfs: local: statfs: don't follow
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

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4377aa6524c2..dbc56b16979c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1452,15 +1452,14 @@ static int local_fsync(FsContext *ctx, int fid_type,
     }
 }
 
-static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
+static int local_statfs(FsContext *fs_ctx, V9fsPath *fs_path,
+                        struct statfs *stbuf)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    int fd, ret;
 
-    buffer = rpath(s, path);
-    ret = statfs(buffer, stbuf);
-    g_free(buffer);
+    fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
+    ret = fstatfs(fd, stbuf);
+    close_preserve_errno(fd);
     return ret;
 }
 
