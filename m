Received: from eggs.gnu.org ([2001:4830:134:3::10]:51482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1e6qit-0005KZ-Ou
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 00:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1e6qis-0001aK-Sb
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 00:21:51 -0400
From: sochin jiang <sochin.jiang@huawei.com>
Date: Tue, 24 Oct 2017 11:33:51 +0800
Message-ID: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] throttle: fix a qemu crash problem when
 calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berto@igalia.com, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

commit 7ca7f0 moves the throttling related part of the BDS life cycle
management to BlockBackend, adds call to
throttle_timers_detach_aio_context in blk_remove_bs.  commit 1606e
remove a block device from its throttle group in blk_delete by calling
blk_io_limits_disable, this fix an easily reproducible qemu crash. But
delete a BB without a BDS inserted could easily cause a qemu crash too
by calling bdrv_drained_begin in blk_io_limits_disable. Say, a simply
drive_add and then a drive_del command.

This patch removes draining BDS by calling throttle_group_unregister_tgm
directly instead of blk_io_limits_disable, leaves draining operation to
blk_remove_bs in case that there is no BDS inserted. Futhermore, make sure
throttle timers are initialized or attached before throttle_timers_destroy
is called in throttle_group_unregister_tgm.

Signed-off-by: sochin jiang <sochin.jiang@huawei.com>
---
 block/block-backend.c   | 2 +-
 block/throttle-groups.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101..39c7cca 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -341,7 +341,7 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->name);
     assert(!blk->dev);
     if (blk->public.throttle_group_member.throttle_state) {
-        blk_io_limits_disable(blk);
+        throttle_group_unregister_tgm(&blk->public.throttle_group_member);
     }
     if (blk->root) {
         blk_remove_bs(blk);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index b291a88..c5f9af3 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -576,7 +576,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
 
     /* remove the current tgm from the list */
     QLIST_REMOVE(tgm, round_robin);
-    throttle_timers_destroy(&tgm->throttle_timers);
+    if (throttle_timers_are_initialized(&tgm->throttle_timers)) {
+        throttle_timers_destroy(&tgm->throttle_timers);
+    }
     qemu_mutex_unlock(&tg->lock);
 
     throttle_group_unref(&tg->ts);
-- 
1.8.3.1
