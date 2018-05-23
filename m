Received: from eggs.gnu.org ([2001:4830:134:3::10]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYw-0001lw-DH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYt-0006tY-K9
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:13 +0200
Message-Id: <20180523131155.12359-5-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/46] sheepdog: Remove unnecessary NULL check
 in sd_prealloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In commit 8b9ad56e9cbfd852a, we removed the code that could result
in our getting to sd_prealloc()'s out_with_err_set label with a
NULL blk pointer. That makes the NULL check in the error-handling
path unnecessary, and Coverity gripes about it (CID 1390636).
Delete the redundant check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6
