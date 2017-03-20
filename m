Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qh-0001eG-IN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qc-0004ts-J7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qc-0004sd-9U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Wf9025468
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:29 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak1xpm8t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:29 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:28 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:56 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-33-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 32/81] 9pfs: don't use AT_EMPTY_PATH in
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

The name argument can never be an empty string, and dirfd always point to
the containing directory of the file name. AT_EMPTY_PATH is hence useless
here. Also it breaks build with glibc version 2.13 and older.

It is actually an oversight of a previous tentative patch to implement this
function. We can safely drop it.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit b314f6a077a1dbc0463a5dc41162f64950048e72)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 09b9b57..f282bb7 100644
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
-- 
2.7.4
