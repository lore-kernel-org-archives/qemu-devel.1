Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjptw-0007Q5-Mf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjptt-0006Kd-GV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:17:52 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:42919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjptt-0006Ju-9o
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:17:49 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id DABD02A4D0
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 17:17:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 03 Mar 2017 17:17:40 +0100
Message-ID: <148855786023.23661.6584039229850547004.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix bogus fd check in local_remove()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

This was spotted by Coverity as a fd leak. This is certainly true, but also
local_remove() would always return without doing anything, unless the fd is
zero, which is very unlikely.

(Coverity issue CID1371732)

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f22a3c3654db..5db7104334d6 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1008,7 +1008,7 @@ static int local_remove(FsContext *ctx, const char *path)
     int err = -1;
 
     dirfd = local_opendir_nofollow(ctx, dirpath);
-    if (dirfd) {
+    if (dirfd == -1) {
         goto out;
     }
 
