Received: from eggs.gnu.org ([2001:4830:134:3::10]:43214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmL-0006Pn-J4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmK-0000ig-Du
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:29 +0200
Message-Id: <1499447335-6125-75-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 074/100] block: refactor bdrv_reopen_commit
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add bs local variable to simplify code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-13-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index b9e5114..15a4e75 100644
--- a/block.c
+++ b/block.c
@@ -2982,9 +2982,11 @@ error:
 void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
+    BlockDriverState *bs;
 
     assert(reopen_state != NULL);
-    drv = reopen_state->bs->drv;
+    bs = reopen_state->bs;
+    drv = bs->drv;
     assert(drv != NULL);
 
     /* If there are any driver level actions to take */
@@ -2993,13 +2995,13 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     }
 
     /* set BDS specific flags now */
-    QDECREF(reopen_state->bs->explicit_options);
+    QDECREF(bs->explicit_options);
 
-    reopen_state->bs->explicit_options   = reopen_state->explicit_options;
-    reopen_state->bs->open_flags         = reopen_state->flags;
-    reopen_state->bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
+    bs->explicit_options   = reopen_state->explicit_options;
+    bs->open_flags         = reopen_state->flags;
+    bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
 
-    bdrv_refresh_limits(reopen_state->bs, NULL);
+    bdrv_refresh_limits(bs, NULL);
 }
 
 /*
-- 
1.8.3.1
