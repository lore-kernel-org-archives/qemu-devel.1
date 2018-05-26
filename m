Received: from eggs.gnu.org ([2001:4830:134:3::10]:35767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgZ-0006JN-Nf
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgW-0004Xj-Oj
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgW-0004XT-KG
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id m9-v6so9187948qtb.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:08 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:09 -0400
Message-Id: <cd4661a5e122b1dcd848ff5cdf202e728a0359a8.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 07/13] 9p: darwin: Properly translate
 AT_REMOVEDIR flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

This code relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR having the same
numerical value, but on Darwin, they do not.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6e0b2e8..c55ea25 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1376,7 +1376,17 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
         return -1;
     }
 
-    ret = local_unlinkat_common(ctx, dirfd, name, flags);
+    if ((flags & ~P9_DOTL_AT_REMOVEDIR) != 0) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    size_t rflags = 0;
+    if (flags & P9_DOTL_AT_REMOVEDIR) {
+        rflags |= AT_REMOVEDIR;
+    }
+
+    ret = local_unlinkat_common(ctx, dirfd, name, rflags);
     close_preserve_errno(dirfd);
     return ret;
 }
-- 
2.8.1
