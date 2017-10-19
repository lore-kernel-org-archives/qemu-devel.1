Received: from eggs.gnu.org ([2001:4830:134:3::10]:35151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1e5AgX-0001Ed-KU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1e5AgW-0004fH-Od
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:16:29 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <1385265352-40801-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] throttle: fix a qemu crash problem when
 calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Thu, 19 Oct 2017 13:16:33 -0000
To: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

commit 7ca7f0 moves the throttling related part of the BDS life cycle management
to BlockBackend, adds call to throttle_timers_detach_aio_context in blk_remove_bs.
commit 1606e remove a block device from its throttle group in blk_delete by calling
blk_io_limits_disable, this fix an easily reproducible qemu crash. But delete a
BB without a BDS inserted could easily cause a qemu crash too by calling
bdrv_drained_begin in blk_io_limits_disable. Say, a simply drive_add and then a
drive_del command.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 block/io.c      | 8 ++++++++
 util/throttle.c | 6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 0854e0f..c411a87 100644
--- a/block/io.c
+++ b/block/io.c
@@ -269,6 +269,10 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
 
 void bdrv_drained_begin(BlockDriverState *bs)
 {
+    if (!bs) {
+        return;
+    }
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, true);
         return;
@@ -284,6 +288,10 @@ void bdrv_drained_begin(BlockDriverState *bs)
 
 void bdrv_drained_end(BlockDriverState *bs)
 {
+    if (!bs) {
+        return;
+    }
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false);
         return;
diff --git a/util/throttle.c b/util/throttle.c
index b38e742..35a21fc 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -245,8 +245,6 @@ void throttle_timers_init(ThrottleTimers *tt,
 /* destroy a timer */
 static void throttle_timer_destroy(QEMUTimer **timer)
 {
-    assert(*timer != NULL);
-
     timer_del(*timer);
     timer_free(*timer);
     *timer = NULL;
@@ -258,7 +256,9 @@ void throttle_timers_detach_aio_context(ThrottleTimers *tt)
     int i;
 
     for (i = 0; i < 2; i++) {
-        throttle_timer_destroy(&tt->timers[i]);
+        if (tt->timers[i]) {
+            throttle_timer_destroy(&tt->timers[i]);
+        }
     }
 }
 
-- 
1.8.3.1
