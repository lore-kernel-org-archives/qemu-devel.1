Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESO-0000m7-Si
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESK-0001t1-Vg
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 10 Nov 2017 20:54:47 +0200
Message-Id: <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
In-Reply-To: <cover.1510339534.git.berto@igalia.com>
References: <cover.1510339534.git.berto@igalia.com>
In-Reply-To: <cover.1510339534.git.berto@igalia.com>
References: <cover.1510339534.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/3] block: Leave valid throttle timers when
 removing a BDS from a backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

If a BlockBackend has I/O limits set then its ThrottleGroupMember
structure uses the AioContext from its attached BlockDriverState.
Those two contexts must be kept in sync manually. This is not
ideal and will be fixed in the future by removing the throttling
configuration from the BlockBackend and storing it in an implicit
filter node instead, but for now we have to live with this.

When you remove the BlockDriverState from the backend then the
throttle timers are destroyed. If a new BlockDriverState is later
inserted then they are created again using the new AioContext.

There'a a couple of problems with this:

   a) The code manipulates the timers directly, leaving the
      ThrottleGroupMember.aio_context field in an inconsisent state.

   b) If you remove the I/O limits (e.g by destroying the backend)
      when the timers are gone then throttle_group_unregister_tgm()
      will attempt to destroy them again, crashing QEMU.

While b) could be fixed easily by allowing the timers to be freed
twice, this would result in a situation in which we can no longer
guarantee that a valid ThrottleState has a valid AioContext and
timers.

This patch ensures that the timers and AioContext are always valid
when I/O limits are set, regardless of whether the BlockBackend has a
BlockDriverState inserted or not.

Reported-by: sochin jiang <sochin.jiang@huawei.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/block-backend.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 193a080096..38db6e639b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -655,15 +655,15 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
  */
 void blk_remove_bs(BlockBackend *blk)
 {
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     BlockDriverState *bs;
-    ThrottleTimers *tt;
 
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
-    if (blk->public.throttle_group_member.throttle_state) {
-        tt = &blk->public.throttle_group_member.throttle_timers;
+    if (tgm->throttle_state) {
         bs = blk_bs(blk);
         bdrv_drained_begin(bs);
-        throttle_timers_detach_aio_context(tt);
+        throttle_group_detach_aio_context(tgm);
+        throttle_group_attach_aio_context(tgm, qemu_get_aio_context());
         bdrv_drained_end(bs);
     }
 
@@ -678,6 +678,7 @@ void blk_remove_bs(BlockBackend *blk)
  */
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
+    ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        blk->perm, blk->shared_perm, blk, errp);
     if (blk->root == NULL) {
@@ -686,10 +687,9 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
-    if (blk->public.throttle_group_member.throttle_state) {
-        throttle_timers_attach_aio_context(
-            &blk->public.throttle_group_member.throttle_timers,
-            bdrv_get_aio_context(bs));
+    if (tgm->throttle_state) {
+        throttle_group_detach_aio_context(tgm);
+        throttle_group_attach_aio_context(tgm, bdrv_get_aio_context(bs));
     }
 
     return 0;
-- 
2.11.0
