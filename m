Received: from eggs.gnu.org ([2001:4830:134:3::10]:52990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAk-0004nS-HC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAj-0005va-Nj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:14 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:53 +0800
Message-Id: <20170419094356.19826-14-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/16] blk: fix aio context loss on media
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we have separate iothread for cdrom, we lose connection to it on
qmp_blockdev_change_medium, as aio_context is on bds which is dropped
and switched with new one.

As an example result, after such media change we have crash on
virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) == s->ctx' failed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6bdd9ce..6133917 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -68,6 +68,7 @@ struct BlockBackend {
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
 
     int quiesce_counter;
+    AioContext *aio_context;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -565,6 +566,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     }
     bdrv_ref(bs);
 
+    if (blk->aio_context != NULL) {
+        bdrv_set_aio_context(bs, blk->aio_context);
+    }
+
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
         throttle_timers_attach_aio_context(
@@ -1667,6 +1672,7 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
 
+    blk->aio_context = new_context;
     if (bs) {
         if (blk->public.throttle_state) {
             throttle_timers_detach_aio_context(&blk->public.throttle_timers);
-- 
2.9.3
