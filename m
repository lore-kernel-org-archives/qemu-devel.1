Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKl-0004Xh-8s
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKh-0007lM-CF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYtKh-0007hi-3o
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5TDIkSA027862
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:21:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jwms2jfud-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:21:01 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 29 Jun 2018 14:20:59 +0100
From: Greg Kurz <groug@kaod.org>
Date: Fri, 29 Jun 2018 15:20:45 +0200
In-Reply-To: <20180629132045.429006-1-groug@kaod.org>
References: <20180629132045.429006-1-groug@kaod.org>
Message-Id: <20180629132045.429006-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/2] 9p: darwin: Explicitly cast comparisons of
 mode_t with -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

Comparisons of mode_t with -1 require an explicit cast, since mode_t
is unsigned on Darwin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 828e8d6e5638..c30f4f26bd68 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -308,7 +308,7 @@ update_map_file:
     if (credp->fc_gid != -1) {
         gid = credp->fc_gid;
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         mode = credp->fc_mode;
     }
     if (credp->fc_rdev != -1) {
@@ -414,7 +414,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
             return err;
         }
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
         err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
                                    sizeof(mode_t), 0);
-- 
2.14.4
