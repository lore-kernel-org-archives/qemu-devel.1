Received: from eggs.gnu.org ([2001:4830:134:3::10]:50711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqR-0005Qv-W3
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwqO-0005fy-Po
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53161
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwqO-0005ff-9a
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26Hri6F013407
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:47 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2917d3qyx0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:47 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:40 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:08 +0100
In-Reply-To: <1488822850-23070-1-git-send-email-groug@kaod.org>
References: <1488822850-23070-1-git-send-email-groug@kaod.org>
Message-Id: <1488822850-23070-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 4/6] 9pfs: don't use AT_EMPTY_PATH in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The name argument can never be an empty string, and dirfd always point to
the containing directory of the file name. AT_EMPTY_PATH is hence useless
here. Also it breaks build with glibc version 2.13 and older.

It is actually an oversight of a previous tentative patch to implement this
function. We can safely drop it.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6d16c4a06587..0ca4c94ee4a8 100644
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
