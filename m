Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7Kv-0000Zf-T4
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7Ks-000863-QM
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:54:53 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:33040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ck7Ks-000823-Ji
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:54:50 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 537EE27987
	for <qemu-devel@nongnu.org>; Sat,  4 Mar 2017 11:54:41 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 04 Mar 2017 11:54:36 +0100
Message-ID: <148862487677.5452.160308730808722965.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: don't use AT_EMPTY_PATH in
 local_set_cred_passthrough()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>

The name argument can never be an empty string, and dirfd always point to
the containing directory of the file name. AT_EMPTY_PATH is hence useless
here. Also it breaks build with glibc version 2.13 and older.

It is actually an oversight of a previous tentative patch to implement this
function. We can safely drop it.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ea9a1ced0394..45e9a1f9b0ca 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -349,7 +349,7 @@ static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
                                       const char *name, FsCred *credp)
 {
     if (fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
-                 AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) < 0) {
+                 AT_SYMLINK_NOFOLLOW) < 0) {
         /*
          * If we fail to change ownership and if we are
          * using security model none. Ignore the error
