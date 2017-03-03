Received: from eggs.gnu.org ([2001:4830:134:3::10]:53642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrNq-0007Ly-Eq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjrNn-0007Dk-Bf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:52:50 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:36287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjrNn-0007D5-5i
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:52:47 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0E48D2941D
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:52:45 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 03 Mar 2017 18:52:42 +0100
Message-ID: <148856356236.7604.4296371092878661257.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix fd leak in local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

Coverity issue CID1371731

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e31309a29c58..fe930300445a 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -435,6 +435,7 @@ static int local_opendir(FsContext *ctx,
 
     stream = fdopendir(dirfd);
     if (!stream) {
+        close(dirfd);
         return -1;
     }
     fs->dir.stream = stream;
