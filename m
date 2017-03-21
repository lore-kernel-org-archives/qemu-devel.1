Received: from eggs.gnu.org ([2001:4830:134:3::10]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAKc-0003H0-9n
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAKb-0001Ow-EY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:31 +0800
Message-Id: <20170321031635.22123-13-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 12/16] blk: fix aio context loss on media
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we have separate iothread for cdrom, we lose connection to it on
qmp_blockdev_change_medium, as aio_context is on bds which is dropped
and switched with new one.

As an example result, after such media change we have crash on
virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) == s->ctx' failed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5d17404..ec8747f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -65,6 +65,8 @@ struct BlockBackend {
     bool allow_write_beyond_eof;
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+
+    AioContext *aio_context;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -559,6 +561,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     }
     bdrv_ref(bs);
 
+    if (blk->aio_context != NULL) {
+        bdrv_set_aio_context(bs, blk->aio_context);
+    }
+
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
         throttle_timers_attach_aio_context(
@@ -1619,6 +1625,7 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
 
+    blk->aio_context = new_context;
     if (bs) {
         if (blk->public.throttle_state) {
             throttle_timers_detach_aio_context(&blk->public.throttle_timers);
-- 
2.9.3
