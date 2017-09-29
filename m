Received: from eggs.gnu.org ([2001:4830:134:3::10]:53582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFH-00069G-T9
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFE-0007qb-4n
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:15 -0400
Received: from mifritscher.de ([188.40.170.105]:33052
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtFD-0007qB-Ub
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:12 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:18 +0200
Message-Id: <20170929111323.6308-14-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 13/18] fsetxattrat_nofollow doesn't seem to be
 defined on Windows - disable it.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p-local.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index fdc0a5bc76..bf6fb70b81 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -397,6 +397,9 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
 
 static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
 {
+#ifdef _WIN32
+    return 0;
+#else
     int err;
 
     if (credp->fc_uid != -1) {
@@ -432,6 +435,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
         }
     }
     return 0;
+#endif
 }
 
 static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
-- 
2.13.2.windows.1
