Received: from eggs.gnu.org ([2001:4830:134:3::10]:47398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJjwX-0007CG-2e
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJjwW-0000sY-7V
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:17:29 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:17:17 +0100
Message-Id: <20180518181717.6700-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] sheepdog: Remove unnecessary NULL check in
 sd_prealloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, sheepdog@lists.wpkg.org

In commit 8b9ad56e9cbfd852a, we removed the code that could result
in our getting to sd_prealloc()'s out_with_err_set label with a
NULL blk pointer. That makes the NULL check in the error-handling
path unnecessary, and Coverity gripes about it (CID 1390636).
Delete the redundant check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/sheepdog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 4237132419..2a5bc0a59a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1859,9 +1859,7 @@ out:
         error_setg_errno(errp, -ret, "Can't pre-allocate");
     }
 out_with_err_set:
-    if (blk) {
-        blk_unref(blk);
-    }
+    blk_unref(blk);
     g_free(buf);
 
     return ret;
-- 
2.17.0
