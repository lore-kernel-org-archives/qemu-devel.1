Received: from eggs.gnu.org ([2001:4830:134:3::10]:33392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr4-00035d-Lk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr3-00037r-SG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:46 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYr3-00037N-NF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id h5-v6so22286473qtm.13
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:45 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:07 -0400
Message-Id: <dc7a7959808593c941fbf73f9f426f92632c0029.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 12/20] 9p: darwin: Explicitly cast
 comparisons of mode_t with -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Comparisons of mode_t with -1 require an explicit cast, since mode_t
is unsigned on Darwin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes from v1: Split from strchrnul change

 hw/9pfs/9p-local.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6222891..1f0b1b0 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -310,7 +310,7 @@ update_map_file:
     if (credp->fc_gid != -1) {
         gid = credp->fc_gid;
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         mode = credp->fc_mode;
     }
     if (credp->fc_rdev != -1) {
@@ -416,7 +416,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
             return err;
         }
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
         err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
                                    sizeof(mode_t), 0);
-- 
2.8.1
