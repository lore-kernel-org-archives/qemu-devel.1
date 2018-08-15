Received: from eggs.gnu.org ([2001:4830:134:3::10]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLk-0004kV-DZ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0001Lj-6h
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:34 +0200
Message-Id: <20180815125537.10651-19-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/21] block: Simplify bdrv_reopen_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

If a bdrv_reopen_multiple() call fails, then the explicit_options
QDict has to be deleted for every entry in the reopen queue. This must
happen regardless of whether that entry's bdrv_reopen_prepare() call
succeeded or not.

This patch simplifies the cleanup code a bit.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index a8fbab396d..e82cfa6fe2 100644
--- a/block.c
+++ b/block.c
@@ -3050,9 +3050,10 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **er
 
 cleanup:
     QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
-        if (ret && bs_entry->prepared) {
-            bdrv_reopen_abort(&bs_entry->state);
-        } else if (ret) {
+        if (ret) {
+            if (bs_entry->prepared) {
+                bdrv_reopen_abort(&bs_entry->state);
+            }
             qobject_unref(bs_entry->state.explicit_options);
         }
         qobject_unref(bs_entry->state.options);
@@ -3341,8 +3342,6 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
         drv->bdrv_reopen_abort(reopen_state);
     }
 
-    qobject_unref(reopen_state->explicit_options);
-
     bdrv_abort_perm_update(reopen_state->bs);
 }
 
-- 
2.13.6
