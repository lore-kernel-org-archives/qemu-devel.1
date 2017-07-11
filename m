Received: from eggs.gnu.org ([2001:4830:134:3::10]:45640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkP-0000Bi-RF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkP-0006OF-22
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:23 +0200
Message-Id: <20170711160814.20941-35-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 34/85] block: refactor bdrv_reopen_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

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
2.9.4
