Received: from eggs.gnu.org ([2001:4830:134:3::10]:57119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrYc-0002A7-Bf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrYX-0003mT-CJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:03:58 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:44423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjrYX-0003mC-77
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:03:53 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 3E9E82A166
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:03:51 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 03 Mar 2017 19:03:47 +0100
Message-ID: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fail local_statfs() earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

If we cannot open the given path, we can return right away instead of
passing -1 to fstatfs() and close(). This will make Coverity happy.

(Coverity issue CID1371729)

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index fe930300445a..ea9a1ced0394 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1053,6 +1053,9 @@ static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
     int fd, ret;
 
     fd = local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
+    if (fd == -1) {
+        return -1;
+    }
     ret = fstatfs(fd, stbuf);
     close_preserve_errno(fd);
     return ret;
