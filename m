Received: from eggs.gnu.org ([2001:4830:134:3::10]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e5avY-0003gz-Qm
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e5avV-0004qo-Dt
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:44 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:36177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e5avV-0004q2-7a
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:41 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E72A2147080
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 19:17:39 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 20 Oct 2017 19:17:38 +0200
Message-ID: <150851985854.6309.16575977719112120440.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix v9fs_mark_fids_unreclaim() return
 value
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

The return value of v9fs_mark_fids_unreclaim() is then propagated to
pdu_complete(). It should be a negative errno, not -1.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f8bbac251dc9..52d46632fe15 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -512,7 +512,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             /* reopen the file/dir if already closed */
             err = v9fs_reopen_fid(pdu, fidp);
             if (err < 0) {
-                return -1;
+                return err;
             }
             /*
              * Go back to head of fid list because
